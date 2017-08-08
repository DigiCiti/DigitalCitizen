class FriendshipsController < ApplicationController

  def create
    # consider... if already created and rejected or unanswered, reroute it to
      # update route for update of timestamp reordering or alteration of
      # status from rejected to unanswered
    if friend?(params[:add_id])
      flash[:notice] = "You've already sent a request to this user"
      redirect_back(fallback_location: root_path)
    else
      @friendship = current_user.friendships.new(user_id: current_user.id, friended_user: params[:add_id])
      if @friendship.save
        flash[:notice] = "Friend request sent."
        redirect_back(fallback_location: root_path)
      else
        flash[:error] = "Unable to friend."
        redirect_back(fallback_location: root_path)
      end
    end
  end

  def update
    @friendship = Friendship.find_by(id: params[:id])
    @friendship.update_attributes(status: params[:status])
    if @friendship.status == "approved"
      flash[:notice] = "Friend request accepted"
    elsif @friendship.status == "rejected"
      flash[:notice] = "Friend request not accepted"
    end
    if @friendship.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

# might never need this route still deciding on friend removal process
# might so far going to just use update and change status to rejected
  # def destroy
  #   p '*' * 80
  #   p params
  # end

end

# class FriendshipsController < ApplicationController
#   def create
#     if friends?
#       flash[:notice] = "You've already sent a request to this user"
#       redirect_back(fallback_location: root_path)
#     else
#       @friendship = current_user.friendships.new(user_id: params[:user_id], friend_id: params[:friend_id])
#       if @friendship.save
#         flash[:notice] = "Friend request sent."
#         redirect_back(fallback_location: root_path)
#       else
#         flash[:error] = "Unable to friend."
#         redirect_back(fallback_location: root_path)
#       end
#     end
#   end
#
#   def update
#     @friendship = Friendship.find_by(id: params[:id])
#     @friendship.update_attributes(accepted: true)
#     if @friendship.save
#       flash[:notice] = "Friend request accepted"
#       redirect_back(fallback_location: root_path)
#     else
#       flash[:notice] = "Friend request not accepted"
#       redirect_back(fallback_location: root_path)
#     end
#   end
#
#   def destroy
#     @friendship = Friendship.find_by(id: params[:id])
#     @friendship.destroy
#     flash[:notice] = "Declined friend request"
#     redirect_back(fallback_location: root_path)
#   end
#
#   private
#
#     def friends?
#       Friendship.find_by(user: current_user, friend_id: params[:friend_id]) || Friendship.find_by(user_id: params[:friend_id], friend: current_user).where(accepted: true)
#     end
#
# end
