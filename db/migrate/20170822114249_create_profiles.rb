class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :firstname
      t.string :string
      t.string :lastname
      t.string :gender
      t.date :dob
      t.date :date_of_employment
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :nationality
      t.string :job_title
      t.references :user, foreign_key: true
      t.references :loan_type, foreign_key: true

      t.timestamps
    end
  end
end
