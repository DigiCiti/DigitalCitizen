module FriendshipsHelper

  def friend?(possible_friend)
    # found_frienship = Friendship.find_by (user_id: params[:id] || friended_user: params[:id]) && (friended_user:)
    @friendships = Friendship.where("(user_id = '#{current_user.id}'
      or friended_user = '#{current_user.id}')
      and status = 'approved'")
    # @friendships = @friendships.where("status = 'approved'")

    # @found_frienship = []
    @friendships.each do |friendship|
      if friendship.user_id == possible_friend || friendship.friended_user == possible_friend
        return true
      end
    end
    false
  end

end
