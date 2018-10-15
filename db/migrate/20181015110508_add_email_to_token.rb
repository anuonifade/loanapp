class AddEmailToToken < ActiveRecord::Migration[5.1]
  def change
    add_column :password_resets, :email, :string
  end
end
