class AdminController < ApplicationController
  include DashboardsHelper
  before_action :authorize_admin
  before_action :set_users
  before_action :set_inactive_users, only: [:application_details]

  def month_details
  end

  def all_users
  end

  def application_details
  end

  def total_contributions
  end

  def total_loans
  end

  def admin_users
  end

  def toggle_user
    user = User.find(params[:id])
    user_activated = user.activated == true ? false : true
    user_updated = user.update(activated: user_activated)
    redirect_to :action => "application_details" if user_updated
  end

  private
    def set_users
      @all_users = User.joins(:profile).where(role_id: 3).all
    end

    def set_inactive_users
      @inactive_users = User.all
    end

    def set_admin_users
    end

    def authorize_admin
      unless admin?
        redirect dashboard_url, notice: 'You are not authorized to view the page'
      end
    end
end
