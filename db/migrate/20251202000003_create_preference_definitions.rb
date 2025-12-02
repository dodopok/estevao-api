# frozen_string_literal: true

class CreatePreferenceDefinitions < ActiveRecord::Migration[8.1]
  def change
    create_table :preference_definitions do |t|
      t.references :preference_category, null: false, foreign_key: true
      t.string :key, null: false
      t.string :name, null: false
      t.text :description
      t.string :pref_type, null: false # select_one, toggle, time, text, number
      t.boolean :required, default: false
      t.string :default_value
      t.jsonb :options, default: [] # Array of option objects for select_one
      t.jsonb :depends_on # { key: "other_pref", value: true }
      t.jsonb :validation_rules, default: {}
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :preference_definitions, [ :preference_category_id, :key ], unique: true, name: "idx_pref_definitions_on_category_and_key"
    add_index :preference_definitions, [ :preference_category_id, :position ], name: "idx_pref_definitions_on_category_and_position"
    add_index :preference_definitions, :pref_type
  end
end
