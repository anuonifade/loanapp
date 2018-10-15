class SessionsController < ApplicationController
  skip_before_action :authenticate, :redirect_non_activated_user
  before_action :password_reset_params, only: [:password_reset_email]

  def new
    redirect_to root_url if session[:current_user_info] && activated?
  end

  def password_reset
  end

  def change_password
    if params[:password] != params[:confirm_password]
      flash[:notice] = 'Password does not match'
    else
      password_reset = User.where(email: params[:email]).first
      password_reset.update(password: params[:password])
      flash[:notice] = 'Password successfully updated'
      reset_session
      cookies.delete :user_info
      redirect_to login_url, notice: 'Password successfully changed, Login'
    end
  end

  def authenticate_token
    @password_reset = PasswordReset.where(token: params[:token]).first
    if @password_reset && ((Time.current - @password_reset.created_at) / 3600).round > 24.hours
      flash[:notice] = 'User verified, but link is expired'
      @token_exist = true
      @token_expired = true
    elsif @password_reset && ((Time.current - @password_reset.created_at) / 3600).round < 24.hours
      flash[:notice] = 'User verified, please enter new password'
      @token_exist = true
      @token_expired = false
    else
      @token_exist = false
    end
  end

  def password_reset_email 
    @user = User.select(:id, :email).where(email: password_reset_params[:email]).first.to_json 
    if @user
      token = generate_activation_code
      url = ENV['URL']
      @user = ActiveSupport::JSON.decode(@user)
      @user['url'] = "#{url}/password-reset/#{token}"

      saved_token = PasswordReset.new(token: token, email: password_reset_params[:email])
      flash[:notice] = 'Password Reset email has been to your email'
      PasswordResetMailer.with(user: @user).password_reset_email.deliver_later if saved_token.save
    else
      flash[:notice] = 'Email does not exist, please contact the admin'
    end
  end

  def create
    user_param = params[:email]
    user = User.find_by(['email = ? or username = ?', user_param, user_param])
    if user && user.authenticate(params[:password])
      if user.activated
        cookies.encrypted[:user_info] = user
        flash[:notice] = 'Login Successful'
        redirect_to root_url
      else
        flash[:notice] = 'Account is not activated'
        redirect_to login_url
      end
    else
      reset_session
      flash[:notice] = 'Invalid Username or Password'
      redirect_to login_url
    end
  end

  def destroy
    reset_session
    cookies.delete :user_info
    redirect_to login_url, alert: 'Successfully logged out'
  end

  private

  def password_reset_params
    params.permit(:email)
  end

  def permitted_token
    params.permit(:token)
  end

  def generate_activation_code(size = 20)
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z a b c k p w x y}
    (0...size).map { charset.to_a[rand(charset.size)] }.join
  end
end
