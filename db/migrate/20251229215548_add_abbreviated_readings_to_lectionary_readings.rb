class AddAbbreviatedReadingsToLectionaryReadings < ActiveRecord::Migration[8.1]
  def change
    add_column :lectionary_readings, :first_reading_abbreviated, :string
    add_column :lectionary_readings, :second_reading_abbreviated, :string
    add_column :lectionary_readings, :gospel_abbreviated, :string
  end
end
