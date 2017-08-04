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
    p '*' * 80
    p params
    @user = User.find(current_user.id)
    render 'users/hub'
  end

  def show
    @user = User.find(current_user.id)
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
