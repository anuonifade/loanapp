class CreateBankDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :bank_details do |t|
      t.string :bank_name
      t.string :account_number
      t.string :sort_code
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
