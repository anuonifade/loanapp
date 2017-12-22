class LoansController < ApplicationController

  def load_initial
    @loan_types = LoanType.all
    user_id = session[:current_user_info]['id']
    # Get profile of regular users only excluding the current user
    @profile = Profile.joins(:user).where("user_id != " + user_id.to_s + " and users.role_id = 3")
    @total_contributions = Contribution.where(id: user_id).sum(:amount)
  end

  def index
    load_initial
    @loan = Loan.new
  end

  def create
    # Set available loan_type to a hash
    loan_type = { savings: '1', housing: '2', cooperative: '3'}
    @loan = Loan.new(loan_params)

    # Set the user_profile from the session
    @loan[:profile_id] = @user_profile['id']
    
    # Get selected loan type
    selected_loan_type = @loan[:loan_type_id].to_s

    # set interest to default to 0
    interest = 0
    amount = @loan[:amount]
    duration = @loan[:duration]
    @loan[:guarantor_one_approved] = 0
    @loan[:guarantor_two_approved] = 0

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
      @loan[:yearly_deduction] = (@loan[:expected_amount] / duration).ceil
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

  def loan_params
    params.require(:loan).permit(
      :amount, :yearly_deduction, :loan_type_id, :duration, :guarantor_one_id, :guarantor_two_id
    )
  end

end
