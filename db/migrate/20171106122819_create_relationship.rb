class CreateRelationship < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.string :name
      t.text :description
      t.references :next_of_kin, foreign_key: true

      t.timestamps
    end
  end
end
