class DashboardsController < ApplicationController
  include DashboardHelper
  before_action :total_contribution, :monthly_contribution, :total_loan, :monthly_loan_repayment, only: [:index]
  
  def index
    if profile_presence?
      unless admin?
        render :index
      end
      redirect_to controller: 'admin', action: 'index' if admin?
    else
      redirect_to controller: 'profiles', action: 'edit', id: @user_id
    end
  end

  def total_contribution
    @total_contribution = (@user_profile.monthly_contributions.all.count >= 1) ? @user_profile.monthly_contributions.all.sum(:amount) : 0.00
  end

  def monthly_contribution
    @monthly_contribution = @user_profile.monthly_contributions.all.sort_by(&:created_at).reverse.first(6)
  end

  def total_loan
    @total_loan = (@user_profile.loans.all.count >= 1) ? @user_profile.loans.all.sum(:amount) : 0.00
  end

  def monthly_loan_repayment
    all_loans = (@user_profile.loans.all.count >= 1) ? @user_profile.loans.all.sort_by(&:created_at).reverse : []
    @total_loan_repayment = 0.00
    @monthly_loan_repayment = []
    unless all_loans.empty?
      @total_loan_repayment = (all_loans.first.loan_repayments.all.count >= 1) ? all_loans.first.loan_repayments.all.sum(:amount) : 0.00
      @monthly_loan_repayment = all_loans.first.loan_repayments.all.sort_by(&:created_at).reverse.first(6)
    end

  end

  def profile_presence?
    profile = Profile.find_by(user_id: @user_id)
    true if profile
  end

end
