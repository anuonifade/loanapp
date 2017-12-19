module DashboardsHelper
  
  def admin?
    user = User.find_by(id: @user_id)
    true unless user.role_id > 2
  end

  def super_admin?
    user = User.find_by(id: @user_id)
    true unless user.role_id > 1
  end

  def to_currency(amount)
    number_to_currency amount, precision: 2, unit: ""
  end

end
