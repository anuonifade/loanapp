class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate
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
  end

  def clear_xhr_flash
    if request.xhr?
      flash.discard
    end
  end
end
