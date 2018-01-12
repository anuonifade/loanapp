class RemoveStaffIdFromProfile < ActiveRecord::Migration[5.1]
  def change
    remove_column :profiles, :staff_id
  end
end
