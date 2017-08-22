class CreateContributions < ActiveRecord::Migration[5.1]
  def change
    create_table :contributions do |t|
      t.decimal :amount
      t.string :start_month
      t.string :start_year
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
