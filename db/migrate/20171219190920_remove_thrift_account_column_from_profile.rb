class RemoveThriftAccountColumnFromProfile < ActiveRecord::Migration[5.1]
  def change
    remove_column :profiles, :thrift_account
  end
end
