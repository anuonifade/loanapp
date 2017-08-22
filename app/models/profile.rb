class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :loan_type
end
