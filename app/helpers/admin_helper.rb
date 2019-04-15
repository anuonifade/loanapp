module AdminHelper
  def user_fullname(profile_id)
    profile = Profile.find_by(id: profile_id)
    if profile
      profile.firstname + ' ' + profile.lastname
    else
      ''
    end
  end

  def loan_approved?(status, guarantor_one_status, guarantor_two_status)
    if status == 'pending' && guarantor_one_status == 'approved' && guarantor_two_status == 'approved'
      return true
    end
    false
  end
end
