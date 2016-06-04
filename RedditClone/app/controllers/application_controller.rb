class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  helper_method :login!, :logout!, :current_user, :require_login, :logged_in?


  def login!(user)
    session[:session_token] = user.reset_session_token!
  end

  def logout!
    @current_user.reset_session_token!
    @current_user = nil
    session[:session_token] = nil
  end

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  # def logged_in?
  #   !!current_user
  # end

  def require_login
    redirect_to new_session_url if current_user.nil?
  end

end
