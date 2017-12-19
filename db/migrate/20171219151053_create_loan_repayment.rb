class CreateLoanRepayment < ActiveRecord::Migration[5.1]
  def change
    create_table :loan_repayments do |t|
      t.decimal :amount, precision: 10, scale: 2
      t.string :month
      t.integer :year
      t.references :loan, foreign_key: true

      t.timestamps
    end
  end
end
