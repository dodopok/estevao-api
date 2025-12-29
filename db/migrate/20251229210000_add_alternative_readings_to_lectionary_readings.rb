class AddAlternativeReadingsToLectionaryReadings < ActiveRecord::Migration[8.1]
  def change
    add_column :lectionary_readings, :psalm_alternative, :string
    add_column :lectionary_readings, :first_reading_alternative, :string
    add_column :lectionary_readings, :second_reading_alternative, :string
    add_column :lectionary_readings, :gospel_alternative, :string
  end
end
