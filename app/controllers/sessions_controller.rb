class SessionsController < ApplicationController
  skip_before_action :authenticate, :redirect_non_activated_user

  def new
    redirect_to root_url if session[:current_user_info] && activated?
  end

  def create
    user_param = params[:email]
    user = User.find_by(["email = ? or username = ?", user_param, user_param])
    if user && user.authenticate(params[:password])
      if user.activated
        cookies.encrypted[:user_info] = user
        flash[:notice] = "Login Successful"
        redirect_to root_url
      else
        flash[:notice] = "Account is not activated"
        redirect_to login_url
      end
    else
      reset_session
      flash[:notice] = "Invalid Username or Password"
      redirect_to login_url
    end
  end

  def destroy
    reset_session
    cookies.delete :user_info
    redirect_to login_url, alert: "Successfully logged out"
  end
end
