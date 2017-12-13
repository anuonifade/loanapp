class AddGuarantorApprovedColumnToLoans < ActiveRecord::Migration[5.1]
  def change
    add_column :loans, :guarantor_one_approved, :integer
    add_column :loans, :guarantor_two_approved, :integer
  end
end
