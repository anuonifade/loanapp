class CreateGuarantors < ActiveRecord::Migration[5.1]
  def change
    create_table :guarantors do |t|
      t.references :profile, foreign_key: true
      t.references :loan, foreign_key: true
      t.integer :borrower_id
      t.integer :guarantor_one_id
      t.integer :guarantor_two_id
      t.integer :loan_id

      t.timestamps
    end
  end
end
