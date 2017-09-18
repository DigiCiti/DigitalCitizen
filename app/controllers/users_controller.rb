require 'uri'
require 'net/http'
require 'openssl'

class UsersController < ApplicationController

  def welcome
    render 'users/welcome'
  end

  def index
    @query = params[:q]
    @query_array = @query.split(' ')
    # consider refactor to hash avoiding the nested loop and minimize repitition
    # this solution also lead's to possible duplicates as the search term will insert the record twice if say "elizabeth" and "warren" are found separetly
    if @query_array.count > 1
      @congress_members = []
      @users = []
      @query_array.each do |term|
        @users += User.search(username_cont: term).result
        @members_raw = CongressMember.search(f_name_or_l_name_cont: term).result
        @members_raw.each do |member|
          @congress_members << ProPublicaCongressAdapter.new(endpoint: "find_member", member_id: member.politician_id).single_member_details
        end
      end
    else
      @users = User.search(username_cont: @query).result
      @members_raw = CongressMember.search(f_name_or_l_name_cont: @query).result
      @congress_members = []
      @members_raw.each do |member|
        @congress_members << ProPublicaCongressAdapter.new(endpoint: "find_member", member_id: member.politician_id).single_member_details
      end
    end

    render 'users/search_results'
  end

  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to "/users/#{user.id}/edit", flash: { notice: "You can edit later and choose \"hub\" or \"profile\" to get going." }
    else
      redirect_to '/', flash: { error: user.errors.full_messages }
    end
  end

  def hub
    @user = current_user

    @friendships = Friendship.where("(user_id = '#{@user.id}'
      or friended_user = '#{@user.id}')
      and status = 'approved'")
    @pending_friendship_requests = Friendship.where("friended_user = '#{@user.id}'
      and status = 'unanswered'")
    @sent_pend_friend_req = Friendship.where("user_id = '#{@user.id}'
      and status = 'unanswered'")

    # members are not currently sorted by alpha order beyond their last initial
    @house_members = ProPublicaCongressAdapter.new(endpoint: "member_list", branch: "house")
    @house_members = @house_members.members_basic_details
    @senate_members = ProPublicaCongressAdapter.new(endpoint: "member_list", branch: "senate")
    @senate_members = @senate_members.members_basic_details

    render 'users/hub'
  end

  def show
    @user = User.find(params[:id])
    @posts = Entry.where("user_id = '#{@user.id}' and entry_type = 'profile_post'").last(10)
    # need to setup offset for pagination or additional posts to load on scroll
    @posts = @posts.sort_by &:created_at
    @posts = @posts.reverse
    # started to work through avoidance of User.find call in view but not sure if
    # it would even be less expensive...
    # p '*' * 100
    # @comments = []
    # @posts.each do |post|
    #   @comments = post.comments
    # end
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    user = User.find(current_user.id)
    user.avatar = params[:user][:avatar]
    if user.save
      redirect_to controller: 'users', action: 'show', id: current_user.id
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :avatar)
  end

end
