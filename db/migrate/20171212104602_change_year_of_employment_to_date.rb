class ChangeYearOfEmploymentToDate < ActiveRecord::Migration[5.1]
  def change
    remove_column :profiles, :year_of_employment
    add_column :profiles, :year_of_employment, :date
  end
end
