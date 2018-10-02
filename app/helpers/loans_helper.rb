module LoansHelper
  def loan_type(id)
    LoanType.find(id).name
  end

  def amount_paid(loan_id)
    LoanRepayment.where(loan_id: loan_id).sum(:amount)
  end

  def guarantor_fullname(profile_id)
    profile = Profile.find(profile_id)
    profile.firstname + ' ' + profile.lastname
  end
end
