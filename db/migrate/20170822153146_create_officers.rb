class CreateOfficers < ActiveRecord::Migration[5.1]
  def change
    create_table :officers do |t|
      t.string :position
      t.text :description
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
