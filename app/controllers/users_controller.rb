class UsersController < ApplicationController

  def new
  end

  def create
    user = User.new(user_params)
    p user
    if user.save
      session[:user_id] = user.id
      redirect_to '/quiz#new'
    else
      p user.errors.full_messages
      redirect_to '/'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
