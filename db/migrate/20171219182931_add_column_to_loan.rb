class AddColumnToLoan < ActiveRecord::Migration[5.1]
  def change
    add_column :loans, :start_month, :string
    add_column :loans, :start_year, :integer
  end
end
