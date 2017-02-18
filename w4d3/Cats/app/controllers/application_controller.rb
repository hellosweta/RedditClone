class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    # fetches the user we've logged in as
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end



  def login!(user)
    session[:session_token] = user.session_token
  end

  def logout!
    current_user.reset_token!
    session[:session_token] = nil
  end

end
