class RemoveBorrowerIdFromGuarantor < ActiveRecord::Migration[5.1]
  def change
    remove_column :guarantors, :borrower_id
  end
end
