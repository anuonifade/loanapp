class UpdateApprovedOnLoan < ActiveRecord::Migration[5.1]
  def change
    remove_column :loans, :approved, :boolean
    remove_column :loans, :guarantor_one_approved, :integer
    remove_column :loans, :guarantor_two_approved, :integer

    add_column :loans, :guarantor_one_status, :integer, default: 1
    add_column :loans, :guarantor_two_status, :integer, default: 1
    add_column :loans, :status, :integer, default: 1
  end
end
