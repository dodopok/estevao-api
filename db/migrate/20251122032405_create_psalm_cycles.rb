class CreatePsalmCycles < ActiveRecord::Migration[8.1]
  def change
    create_table :psalm_cycles do |t|
      t.string :cycle_type, null: false # 'weekly' or 'monthly'
      t.integer :week_number # 1-4 for weekly, 1-30 for monthly
      t.integer :day_of_week, null: false # 0-6 (Sunday = 0)
      t.string :office_type, null: false # 'morning', 'evening', 'midday', 'compline'
      t.jsonb :psalm_numbers, default: [], null: false # Array of psalm numbers
      t.text :notes

      t.timestamps
    end
    add_index :psalm_cycles, [:cycle_type, :week_number, :day_of_week, :office_type],
              name: 'index_psalm_cycles_on_cycle_lookup', unique: true
  end
end
