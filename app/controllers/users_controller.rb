class UsersController < ApplicationController
  skip_before_action :authenticate, only: [:new, :create]

  # GET /users
  # GET /users.json
  def new
    @user = User.new
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      secret = Figaro.env.jwt_secret
      token = JWT.encode user_params, secret, "HS256"
      cookies["jwt"] = token
      redirect_to dashboard_url, notice: "Registration Completed. Check your email for the next step"
    else
      render :new 
      @user.errors
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
