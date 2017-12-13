class Profile < ApplicationRecord
  belongs_to :user
  has_many :loans
  has_one :bank_detail, dependent: :destroy
  has_one :next_of_kin, dependent: :destroy
  accepts_nested_attributes_for :bank_detail, :next_of_kin
end
