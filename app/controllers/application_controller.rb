class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?, :require_user
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
  end
  
   def require_user
    redirect_to login_path unless current_user
   end
  
  def logged_in?
    !!current_user
  end  
end
