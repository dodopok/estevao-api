class AddReadingTypeToLectionaryReadings < ActiveRecord::Migration[8.1]
  def change
    add_column :lectionary_readings, :reading_type, :string, default: "semicontinuous", null: false
    add_index :lectionary_readings, :reading_type
  end
end
