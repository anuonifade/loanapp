class DashboardController < ApplicationController
  before_action :validate_profile_presence
  
  def index
  end

  def validate_profile_presence
    if profile_presence?
      render 'index'
    else
      user_id = session[:current_user_info]["id"]
      redirect_to controller: 'profiles', action: 'edit', id: user_id
    end

  end

  def profile_presence?
    false
  end
end
