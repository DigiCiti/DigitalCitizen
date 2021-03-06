class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      redirect_to "/users/hub/#{user.id}"
    else
    # If user's login doesn't work, send them back to the login form.
      redirect_to '/sessions/new', flash: { error: 'No account exists with the email and password entered. Please try again.' }
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/sessions/new'
  end

end
