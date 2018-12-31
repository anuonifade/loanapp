class AdminController < ApplicationController
  include DashboardsHelper
  before_action :authorize_admin
  before_action :set_users
  before_action :set_all_loan_app, only: [:total_loans]
  before_action :set_all_total_loan
  before_action :set_inactive_users, only: [:application_details]
  before_action :contribution_permitted_params, only: [:new_monthly_contribution]

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

  def upload_contributions_csv
    User.import(params[:file])
    redirect_to :action => 'total_contributions', notice: 'Contributions Uploaded Successfully'
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

  def download_contributions_csv
    @contributions = MonthlyContribution.all
    respond_to do |format|
      format.html
      format.csv { send_data @contributions.to_csv, filename: "users-contributions-#{Time.now}.csv"}
    end
  end

  def download_loans_csv
    @loans = LoanRepayment.all
    respond_to do |format|
      format.html
      format.csv { send_data @loans.to_csv, filename: "users-loans-#{Time.now}.csv"}
    end
  end

  def add_new_monthly_contribution
    user_id = session[:current_user_info]['id']
    # Get profile of regular users only excluding the current user
    @profile = Profile.joins(:user).where("user_id != " + user_id.to_s + " and users.role_id = 3")
    @recent_contributions = MonthlyContribution.all.order(created_at: :DESC).limit(20)
    @monthly_contribution = MonthlyContribution.new
  end

  def add_new_loan
    user_id = session[:current_user_info]['id']
    # Get profile of regular users only excluding the current user
    @profile = Profile.joins(:user).where("user_id != " + user_id.to_s + " and users.role_id = 3")
    @recent_loans_repayment = LoanRepayment.all.order(created_at: :DESC).limit(20)
    @loan = Loan.new
    @loan_types = LoanType.all
  end

  def admin_add_new_loan
    @new_loan = Loan.new(loan_permitted_params)
    @new_loan[:payslip] = Cloudinary::Uploader.upload(loan_permitted_params[:payslip])["url"]
    @new_loan[:id_card] = Cloudinary::Uploader.upload(loan_permitted_params[:id_card])["url"]
    if @new_loan.save
      redirect_to :action => 'total_loans', notice: 'Loan Added Successfully'
    else
      flash.now[:error] = 'Unable to Save Loan'
      redirect_to :action => 'total_loans'
    end
  end

  def new_monthly_contribution

    existing_contribution = MonthlyContribution.find_by(
                              profile_id: contribution_permitted_params[:profile_id],
                              month: contribution_permitted_params[:month],
                              year: contribution_permitted_params[:year]
                            )

    if existing_contribution
      flash.now[:alert] = 'Contribution for this month already exist for Contributor'
    else
      @new_contribution = MonthlyContribution.new(contribution_permitted_params)
      if @new_contribution.save
        redirect_to :action => 'total_contributions', notice: 'Contributions Uploaded Successfully'
      else
        flash.now[:error] = 'Unable to Save Monthly Contribution'
      end
    end
  end

  def application_details
  end

  def total_contributions
    @total_contribution = MonthlyContribution.all.sum(:amount) || 0.00
    @total_month_contribution = MonthlyContribution.where('month = ? and year = ?', Date.today.strftime("%m"), Date.today.strftime("%Y")).sum(:amount) || 0.00

    @recent_contributions = MonthlyContribution.all.order(created_at: :DESC).limit(20)
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

    def contribution_permitted_params
      params.require(:monthly_contribution).permit(:profile_id, :amount, :month, :year)
    end

    def loan_permitted_params
      params.require(:loan).permit(
        :profile_id,
        :amount,
        :loan_type_id,
        :guarantor_one_id,
        :guarantor_two_id,
        :payslip,
        :id_card
      )
    end

    def authorize_admin
      unless admin?
        redirect dashboard_url, notice: 'You are not authorized to view the page'
      end
    end
end
