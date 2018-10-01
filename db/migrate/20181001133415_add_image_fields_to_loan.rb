class AddImageFieldsToLoan < ActiveRecord::Migration[5.1]
  def change
    add_column :loans, :payslip, :string
    add_column :loans, :id_card, :string
  end
end
