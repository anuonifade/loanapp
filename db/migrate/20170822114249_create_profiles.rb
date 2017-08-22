class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :staff_id
      t.string :firstname
      t.string :middlename
      t.string :lastname
      t.string :gender
      t.string :phone
      t.date :dob
      t.string :year_of_employment
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :nationality
      t.string :designation
      t.string :thrift_account
      t.string :department
      t.string :location

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
