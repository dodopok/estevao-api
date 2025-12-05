class AddDescriptionYearToCelebrations < ActiveRecord::Migration[8.1]
  def change
    add_column :celebrations, :description_year, :string
  end
end
