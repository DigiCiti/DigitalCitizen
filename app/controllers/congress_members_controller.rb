class CongressMembersController < ApplicationController

  def show
    p '*' * 80
    p params[:member_id]
    @single_member = CongressMember.new(endpoint: "find_member", member_id: params[:member_id])
    p @member = @single_member.single_member_details
  end

end
