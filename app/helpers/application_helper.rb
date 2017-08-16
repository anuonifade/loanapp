module ApplicationHelper

  def admin?
    session[:current_user]
  end
end
