class AddColumnGuarantorToTableLoan < ActiveRecord::Migration[5.1]
  def change
    add_column :loans, :guarantor_one_id, :integer
    add_column :loans, :guarantor_two_id, :integer
  end
end
