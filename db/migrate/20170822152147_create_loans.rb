class CreateLoans < ActiveRecord::Migration[5.1]
  def change
    create_table :loans do |t|
      t.decimal :amount
      t.decimal :monthly_deduction
      t.references :profile, foreign_key: true
      t.references :loan_type, foreign_key: true

      t.timestamps
    end
  end
end
