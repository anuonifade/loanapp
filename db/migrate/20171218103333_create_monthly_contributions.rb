class CreateMonthlyContributions < ActiveRecord::Migration[5.1]
  def change
    create_table :monthly_contributions do |t|
      t.decimal :amount, precision: 10, scale: 2
      t.string :month
      t.integer :year
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
