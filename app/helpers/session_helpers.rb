module SessionHelpers

  # most, if not all of these are handled in session controller and applicatioon controller but keeping them here temporariy because unsure of accesss for views

  # def login(user)
  #   session[:id] = user.id
  # end
  #
  # def current_user
  #   @user ||=User.find(session[:id]) if session[:id]
  # end
  #
  # def logout
  #   session[:id] = nil
  # end

  def logged_in?
    !!current_user
  end

end
