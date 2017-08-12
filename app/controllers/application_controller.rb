class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate
  after_action :clear_xhr_flash
  
  protected
  
  def authenticate
    if cookies["jwt"]
      begin
        token = cookies["jwt"]
        hmac_secret = Figaro.env.jwt_secret
        decoded_token = JWT.decode token, hmac_secret, true, { :algorithm => 'HS256' }
        authorize decoded_token
      rescue JWT::ExpiredSignature
        reset_session
        redirect_to login_url
      end
    else
      redirect_to login_url, notice: "You are not authorised"
    end
  end

  def authorize(decoded_token)
    session[:current_user_info] = decoded_token
    redirect_to dashboard_url
  end

  def clear_xhr_flash
    if request.xhr?
      flash.discard
    end
  end
end
