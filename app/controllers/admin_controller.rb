class AdminController < ApplicationController
  include DashboardsHelper
  before_action :authorize_admin

  def all_users
    @all_users = User.find_by(role_id: 3)
  end

  def month_details
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
  def authorize_admin
    unless admin?
      redirect dashboard_url, notice: 'You are not authorized to view the page'
    end
  end
end
