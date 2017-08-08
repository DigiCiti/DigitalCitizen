class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include FriendshipsHelper
  include SessionsHelper

end
