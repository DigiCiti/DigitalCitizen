class CongressMembersController < ApplicationController

  def show
    @single_member = CongressMember.new(endpoint: "find_member", member_id: params[:member_id])
  end

end
