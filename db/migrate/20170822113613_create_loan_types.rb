class CreateLoanTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :loan_types do |t|
      t.string :name
      t.string :description
      t.string :text

      t.timestamps
    end
  end
end
