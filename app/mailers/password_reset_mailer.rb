class PasswordResetMailer < ApplicationMailer
  default from: ENV['DEFAULT_EMAIL']

  def password_reset_email
    @user = params[:user]
    mail(to: @user['email'], subject: 'NNPC Depot Ibadan Cooperative: Password Reset')
  end
end
