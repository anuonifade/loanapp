class Notification < ApplicationRecord
  belongs_to :recipient, class_name: 'Profile'
  belongs_to :actor, class_name: 'Profile'
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(read_at: nil) }
end
