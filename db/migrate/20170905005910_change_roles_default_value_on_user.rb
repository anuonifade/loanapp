class ChangeRolesDefaultValueOnUser < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :role_id, :bigint ,:default => 3
  end
end
