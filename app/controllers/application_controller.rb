class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # call the configured params
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
   
  private 
  def userparams
  params.require(:user).permit(:provider, :uid, :name, :oauthtoken, :oauthexpiresat)
  end

  # protect the database while allowing these fields to be updated
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:username, :password, :email, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) {|u| u.permit(:username, :password, :email, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:password, :email, :password_confirmation, :remember_me) }
  end
end
