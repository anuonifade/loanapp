class UpdateLoansTable < ActiveRecord::Migration[5.1]
  def change
    add_column :loans, :duration, :integer
    add_column :loans, :yearly_deduction, :decimal
    add_column :loans, :finished_payment, :boolean, default: false
    add_column :loans, :finished_payment_date, :datetime
    add_column :loans, :approved, :boolean, default: false
    add_column :loans, :approved_by, :integer
    add_column :loans, :approved_date, :datetime
    add_column :loans, :guarantor_one_approved_date, :datetime
    add_column :loans, :guarantor_two_approved_date, :datetime
  end
end
