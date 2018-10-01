class NotificationsController < ApplicationController
  before_action :set_notifications

  def index
  end

  private

  def set_notifications
    @notifications = Notification.where(recipient: @user_id)
  end
end
