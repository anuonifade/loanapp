class Loan < ApplicationRecord
  belongs_to :profile
  belongs_to :loan_type
  has_many :loan_repayments, dependent: :destroy
  accepts_nested_attributes_for :loan_repayments
end
