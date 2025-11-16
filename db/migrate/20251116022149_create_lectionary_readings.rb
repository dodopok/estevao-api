class CreateLectionaryReadings < ActiveRecord::Migration[8.1]
  def change
    create_table :lectionary_readings do |t|
      t.string :date_reference
      t.string :cycle
      t.string :service_type
      t.string :first_reading
      t.string :psalm
      t.string :second_reading
      t.string :gospel
      t.references :celebration, null: false, foreign_key: true
      t.text :notes

      t.timestamps
    end
  end
end
