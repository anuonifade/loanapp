class AddProfileImageUrl < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :passport_url, :string
  end
end
