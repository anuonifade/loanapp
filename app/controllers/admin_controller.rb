class AdminController < ApplicationController
  include DashboardsHelper
  before_action :authorize_admin
  before_action :set_users
  before_action :set_all_loan_app, only: [:total_loans]
  before_action :set_all_total_loan
  before_action :set_inactive_users, only: [:application_details]

  def month_details
  end

  def all_users
  end

  def approve_loan
    loan = Loan.find(params[:loan_id])
    approved_by = User.find(@user_id)
    loan_updated = loan.update_columns(status: 2, approved_date: Time.now, approved_by: approved_by)
    redirect_to :action => "total_loans" if loan_updated
  end

  def loan_details
  end

  def decline_loan
    loan = Loan.find(params[:loan_id])
    approved_by = User.find(@user_id)
    loan_updated = loan.update_columns(status: 3, approved_date: Time.now, approved_by: approved_by)
    redirect_to :action => "total_loans" if loan_updated
  end

  def upload_users_csv
    User.import(params[:file])
    redirect_to :action => 'application_details', notice: 'Users uploaded Successfully'
  end

  def add_users
  end

  def download_users_csv
    @users = User.all
    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv, filename: "users-#{Time.now}.csv"}
    end
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

    def set_all_loan_app
      @all_loan_app = Loan.all
    end

    def set_inactive_users
      @inactive_users = User.where('role_id > 2').all
    end

    def set_all_total_loan
      @total_pending_loan = Loan.where(status: 'pending').sum(:amount)
      @total_approved_loan = Loan.where(status: 'approved').sum(:amount)
      @total_declined_loan = Loan.where(status: 'rejected').sum(:amount)
    end

    def set_admin_users
      @all_admin_users = User.joins(:profile).where(role_id: 2).all
    end

    def authorize_admin
      unless admin?
        redirect dashboard_url, notice: 'You are not authorized to view the page'
      end
    end
end
