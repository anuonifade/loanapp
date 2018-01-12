class AddColumnAccountNameToTableBankDetail < ActiveRecord::Migration[5.1]
  def change
    add_column :bank_details, :account_name, :string
  end
end
