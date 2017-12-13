class AddColumnRelationshipToTableNextOfKin < ActiveRecord::Migration[5.1]
  def change
    add_column :next_of_kins, :relationship, :string
  end
end
