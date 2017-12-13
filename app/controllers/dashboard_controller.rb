class DashboardController < ApplicationController
  before_action :validate_profile_presence
  
  def index
  end

  def validate_profile_presence
    if profile_presence?
      render :index
    else
      redirect_to controller: 'profiles', action: 'edit', id: @user_id
    end

  end

  def profile_presence?
    profile = Profile.find_by(user_id: @user_id)
    if profile
      true
    else
      false
    end
  end
end
