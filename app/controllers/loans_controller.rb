class LoansController < ApplicationController
  include DashboardsHelper
  before_action :get_loan_applications, only: [:index]
  before_action :set_cloudinary_config, only: [:create]
  before_action :profile

  def load_initial
    @loan_types = LoanType.all
    user_id = session[:current_user_info]['id']
    # Get profile of regular users only excluding the current user
    @profile = Profile.joins(:user).where("user_id != " + user_id.to_s + " and users.role_id = 3")
    @total_contributions = Contribution.where(id: user_id).sum(:amount)
  end

  def all_loans
  end

  def index
    load_initial
    @loan = Loan.new
  end

  def show
    @loan_detail = Loan.find(params[:id])
    @loan_repayment = LoanRepayment.find_by(loan_id: params[:id])
  end

  def create
    # Set available loan_type to a hash
    loan_type = { savings: '1', housing: '2', cooperative: '3'}
    @loan = Loan.new(loan_params)

    @loan[:payslip] = Cloudinary::Uploader.upload(loan_params[:payslip], set_cloudinary_config)["url"]
    @loan[:id_card] = Cloudinary::Uploader.upload(loan_params[:id_card], set_cloudinary_config)["url"]
    # Set the user_profile from the session
    @loan[:profile_id] = @user_profile['id']

    # Get selected loan type
    selected_loan_type = @loan[:loan_type_id].to_s

    # set interest to default to 0
    interest = 0
    amount = @loan[:amount]
    duration = @loan[:duration]
    @loan[:guarantor_one_status] = 0
    @loan[:guarantor_two_status] = 0

    # verify selected interest
    if selected_loan_type == loan_type[:savings]
      interest = 10
    elsif selected_loan_type == loan_type[:housing]
      interest = 17
      duration = @loan[:yearly_deduction]
    elsif selected_loan_type == loan_type[:cooperative]
      interest = 6.5
    end

    # Calculate the total payment
    @loan[:expected_amount] = amount + (amount * interest / 100.0).ceil

    errors = false

    # Ensure that the duration is valid
    if duration <= 0
      errors = true
      flash.now[:alert] = "Kindly select a valid duration"
    else
      @loan[:duration] = duration
    end

    # Calculate monthly deductions and yearly_deduction
    if selected_loan_type == loan_type[:housing]
      @loan[:monthly_deduction] = ((@loan[:expected_amount] - amount) / duration).ceil
      @loan[:yearly_deduction] = ((@loan[:expected_amount] / duration) * 12).ceil
    else
      @loan[:monthly_deduction] = (@loan[:expected_amount] / duration).ceil
      @loan[:yearly_deduction] = 0
    end

    # Ensure that the guarantors are valid
    if @loan[:guarantor_one_id] == @loan[:guarantor_two_id]
      errors = true
      flash.now[:alert] = "You cannot select the same guarantor twice"
    end

    if errors
      load_initial
      render :index
    else
      @loan.save
      redirect_to root_path, :notice => "Loan application is successful"
    end
  end

  private
    def set_cloudinary_config
      {
        cloud_name: 'dzwafstu3',
        api_key: '951584143551435',
        api_secret: 'v46DLhkmQqanSNPMg6Fm1Q5diPQ',
        secure: true,
        cdn_subdomain: true
      }
    end

    def profile
      @user_profile.loans
    end

    def loan_params
      params.require(:loan).permit(
        :amount,
        :yearly_deduction,
        :loan_type_id,
        :duration,
        :guarantor_one_id,
        :guarantor_two_id,
        :payslip,
        :id_card
      )
    end

    def get_loan_applications
      @all_loan_applications = Loan.where("profile_id = ?", @user_profile.id).all
    end
end
