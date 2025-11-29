class ChangeReadingTypeNullableInLectionaryReadings < ActiveRecord::Migration[8.1]
  def up
    change_column :lectionary_readings, :reading_type, :string, null: true, default: nil
  end

  def down
    change_column :lectionary_readings, :reading_type, :string, null: false, default: "semicontinuous"
  end
end
