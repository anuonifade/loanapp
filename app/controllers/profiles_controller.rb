class ProfilesController < ApplicationController
  before_action :set_profile, only: [:edit, :update_profile, :show]
  before_action :profile_params, only: [:update_profile]

  def show
  end

  def edit
    if @profile
      @profile
    else
      @profile = Profile.new
      @profile.build_bank_detail
      @profile.build_next_of_kin
    end
  end

  def upload_passport
    passport_url = Cloudinary::Uploader.upload(params[:profile_passport])['url']
    user = User.find(params[:thrift_id])
    if user.profile.update(passport_url: passport_url)
      @image_src = passport_url
      redirect_to action: 'show', id: user.id, alert: 'Passport uploaded successfully'
    else
      @image_src = 'https://opennebula.org/wp-content/uploads/2017/01/placeholder.jpg'
      redirect_to action: 'show', id: user.id, alert: 'Unable to upload passport'
    end
  end

  def update_profile
    if @profile
      profile = Profile.find_by(user_id: params[:id])
      if profile.update(profile_params)
        profile.save
        redirect_to action: 'show', id: params[:id]
      else
        render :edit
      end
    else
      add_user_info(profile_params)
    end
  end

  def add_user_info(profile_params)
    @profile = Profile.create(profile_params)
    if @profile.errors.empty?
      redirect_to @profile
    else
      render :edit
    end
  end

  private

  def set_profile
    user_id = @user_id
    user = User.find(@user_id)
    user_id = params[:id] if params[:id] && user.role_id < 3
    @profile = Profile.find_by(user_id: user_id) || nil

    @thrift_account = @staff_id
    @thrift_email = @user_email
    @thrift_id = @user_id
    if @profile && @profile.passport_url
      @image_src = @profile.passport_url
    else
      @image_src = 'https://opennebula.org/wp-content/uploads/2017/01/placeholder.jpg'
    end

    if params[:id] && user.role_id < 3
      user = User.find(params[:id])
      @thrift_account = user.username
      @thrift_email = user.email
      @thrift_id = user.id
    end
  end

  def profile_params
    params.require(:profile).permit(
      Profile.new.attributes.keys.map(&:to_sym),
      bank_detail_attributes: [:account_name, :account_number, :bank_name, :sort_code],
      next_of_kin_attributes: [:first_name, :last_name, :email, :phone, :relationship, :address1, :address2, :city, :state, :nationality]
    )
  end
end
