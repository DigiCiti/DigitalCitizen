class CongressMembersController < ApplicationController

  def show
    @single_member = CongressMember.new(endpoint: "find_member", member_id: params[:member_id])
    @member = @single_member.single_member_details
    @member_vote_positions = CongressMember.new(endpoint: "member_positions", member_id: @member["member_id"])
    @member_vote_positions = @member_vote_positions.single_member_details
  end

end
