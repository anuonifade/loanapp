class RemoveRelationColumnFromProfile < ActiveRecord::Migration[5.1]
  def change
    remove_column :profiles, :relationship
  end
end
