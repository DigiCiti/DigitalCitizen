class FriendshipsController < ApplicationController

  def create
  end

  def update
  end

  def destroy
  end

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
