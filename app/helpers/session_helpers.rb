helpers do
  def login(user)
    session[:id] = user.id
  end

 def current_user
    @user ||=User.find(session[:id]) if session[:id]
 end

 def logout
    session[:id] = nil
 end

 def logged_in?
    !!current_user
 end
end
