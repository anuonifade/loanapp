class CreateNextOfKin < ActiveRecord::Migration[5.1]
  def change
    create_table :next_of_kins do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :nationality
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
