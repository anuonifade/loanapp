class AdminController < ApplicationController
  include DashboardsHelper
  before_action :authorize_admin
  before_action :set_users

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

  private
    def set_users
      @all_users = Profile.all
    end

    def set_admin_users
    end

    def authorize_admin
      unless admin?
        redirect dashboard_url, notice: 'You are not authorized to view the page'
      end
    end
end
