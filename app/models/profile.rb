class Profile < ApplicationRecord
  belongs_to :user
  has_many :loans, dependent: :destroy
  has_one :bank_detail, dependent: :destroy
  has_one :next_of_kin, dependent: :destroy
  has_one :contribution, dependent: :destroy
  has_many :monthly_contributions, dependent: :destroy
  has_many :notifications, foreign_key: :recipient_id

  accepts_nested_attributes_for :bank_detail, :next_of_kin, :contribution
  accepts_nested_attributes_for :monthly_contributions
end
