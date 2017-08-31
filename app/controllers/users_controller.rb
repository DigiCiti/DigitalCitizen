require 'uri'
require 'net/http'
require 'openssl'

class UsersController < ApplicationController

  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to "/users/hub/#{user.id}"
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
    @house_members = CongressMember.new(endpoint: "member_list", branch: "house")
    @house_members = @house_members.members_basic_details
    @senate_members = CongressMember.new(endpoint: "member_list", branch: "senate")
    @senate_members = @senate_members.members_basic_details

    render 'users/hub'
  end

  def show
    @user = User.find(params[:id])
    @posts = Entry.where("user_id = '#{@user.id}' and entry_type = 'profile_post'")
    @posts = @posts.sort_by &:created_at
    @posts = @posts.reverse
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
