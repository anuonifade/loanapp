class ChangeAmountTypeOnContributionAndLoan < ActiveRecord::Migration[5.1]
  def change
    remove_column :loans, :amount, :decimal
    remove_column :loans, :monthly_deduction, :decimal
    add_column :loans, :amount, :decimal, precision: 20, scale: 2
    add_column :loans, :expected_amount, :decimal, precision: 20, scale: 2
    add_column :loans, :monthly_deduction, :decimal, precision: 20, scale: 2
    

    remove_column :contributions, :amount, :decimal
    add_column :contributions, :amount, :decimal, precision: 20, scale: 2
  end
end
