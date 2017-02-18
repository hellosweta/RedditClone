class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def log_in(user)
  user.reset_session_token
  session[:session_token] = user.session_token
  end

  def logged_in?
    if current_user.nil?
      flash[:errors] = ["Not logged in"]
      redirect_to new_session_url
    else
      return true
    end

  end

  def log_out
    current_user.session_token = generate_session_token
    session[:session_token] = nil
  end

  def check_owner?
    sub1 = Sub.find(params[:id])
    if current_user.id != sub1.moderator.id
      flash[:errors] = ["Only Moderators Can Update"]
      redirect_to subs_url
    else
      return true
    end
  end

  def check_poster?
    post1 = Post.find(params[:id])
    if current_user.id != post1.author.id
      flash[:errors] = ["Only Post Authors Can Update"]
      redirect_to sub_url(post1.sub_id)
    else
      return true
    end
  end
end
