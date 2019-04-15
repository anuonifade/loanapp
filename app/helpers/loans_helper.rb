module LoansHelper
  def loan_type(id)
    loan_type = LoanType.find_by(id: id)
    if loan_type
      loan_type.name
    else
      ''
    end
  end

  def amount_paid(loan_id)
    LoanRepayment.where(loan_id: loan_id).sum(:amount)
  end

  def guarantor_fullname(profile_id)
    profile = Profile.find_by(id: profile_id)
    if profile
      profile.firstname + ' ' + profile.lastname
    else
      ''
    end
  end
end
