class Loan < ApplicationRecord
  belongs_to :profile
  belongs_to :loan_type
end
