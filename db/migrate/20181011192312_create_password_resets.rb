class CreatePasswordResets < ActiveRecord::Migration[5.1]
  def change
    create_table :password_resets do |t|
      t.string :token

      t.timestamps
    end
  end
end
