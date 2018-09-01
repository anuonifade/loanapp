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

  def update_profile
    if @profile
      @profile = Profile.find_by(user_id: @user_id)
      if @profile.update(profile_params)
        @profile.save
        redirect_to controller: 'profiles', action: 'show', id: @user_id
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
      @profile = Profile.find_by(user_id: @user_id) || nil
    end

    def profile_params
      params.require(:profile).permit(
        Profile.new.attributes.keys.map(&:to_sym),
        bank_detail_attributes: [:account_name, :account_number, :bank_name, :sort_code],
        next_of_kin_attributes: [:first_name, :last_name, :email, :phone, :relationship, :address1, :address2, :city, :state, :nationality]
      )
    end

end
