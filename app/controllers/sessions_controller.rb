class SessionsController < ApplicationController
  skip_before_action :authenticate

  def new
    if session[:current_user_info]
      redirect_to root_url
    end
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      cookies.encrypted[:user_info] = user
      redirect_to dashboard_url
    else
      redirect_to login_url, alert: "Invalid Email or Password"
    end
  end

  def destroy
    sessions_reset
    redirect_to login_url, alert: "Successfully logged out"
  end
  
end
