class AddForeignKeysToGuarantor < ActiveRecord::Migration[5.1]
  def change
    remove_column :guarantors, :guarantor_one_id
    remove_column :guarantors, :guarantor_two_id
    add_reference :guarantors, :guarantor_one, foreign_key: { to_table: :profiles }
    add_reference :guarantors, :guarantor_two, foreign_key: { to_table: :profiles }
  end
end
