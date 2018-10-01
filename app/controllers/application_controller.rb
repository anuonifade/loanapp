class ApplicationController < ActionController::Base
  before_action :authenticate
  before_action :redirect_non_activated_user
  after_action :clear_xhr_flash

  protected

  def authenticate
    if cookies[:user_info]
      user_info = cookies.encrypted[:user_info]
      authorize user_info
    else
      reset_session
      redirect_to login_url, notice: "You are not authorised"
    end
  end

  def authorize(user_info)
    session[:current_user_info] = user_info
    set_user
  end

  def clear_xhr_flash
    flash.discard if request.xhr?
  end

  def activated?
    @is_user_activated ? true : false
  end

  def redirect_non_activated_user
    redirect_to login_url, alert: "Account is not activated" unless activated?
  end

  private
  def set_user
    @user_id ||= session[:current_user_info]['id']
    @staff_id ||= session[:current_user_info]['username']
    @user_email ||= session[:current_user_info]['email']
    @user = session[:current_user_info] 
    @is_user_activated = session[:current_user_info]['activated'] ? true : false
    @user_profile ||= Profile.find_by(user_id: @user_id)
  end
end
