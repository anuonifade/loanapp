class UsersController < ApplicationController
  skip_before_action :authenticate, only: [:new, :create]

  # GET /users
  # GET /users.json
  def new
    if cookies[:user_info]
      redirect_to root_url
    end
    @user = User.new
  end

  # POST /users
  # POST /users.json
  def create
    existing_user = User.find_by(email: params[:user][:email])

    unless existing_user
      @user = User.new(user_params)

      if @user.save
        cookies.encrypted[:user_info] = user_params[:email]
        flash[:notice] = "Registration Successful"
        redirect_to root_url 
      else
        render :new 
        @user.errors
      end
    else
      flash[:notice] = "Sorry, user with the same email already exist."
      redirect_to new_user_url
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
