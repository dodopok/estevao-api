class CreateCelebrations < ActiveRecord::Migration[8.1]
  def change
    create_table :celebrations do |t|
      t.string :name, null: false
      t.integer :celebration_type, null: false
      t.integer :rank, null: false
      t.integer :fixed_month
      t.integer :fixed_day
      t.boolean :movable, default: false, null: false
      t.string :calculation_rule
      t.string :liturgical_color
      t.boolean :can_be_transferred, default: true, null: false
      t.jsonb :transfer_rules, default: {}
      t.text :description
      t.string :latin_name

      t.timestamps
    end

    add_index :celebrations, :celebration_type
    add_index :celebrations, :rank
    add_index :celebrations, [ :fixed_month, :fixed_day ]
    add_index :celebrations, :movable
    add_index :celebrations, :name
  end
end
