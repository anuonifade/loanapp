class AddRelationColumnToNextOfKins < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :relationship, :string
  end
end
