class MakeCelebrationIdNullableInLectionaryReadings < ActiveRecord::Migration[8.1]
  def change
    change_column_null :lectionary_readings, :celebration_id, true
  end
end
