# frozen_string_literal: true

class CreateLifeRules < ActiveRecord::Migration[8.1]
  def change
    create_table :life_rules do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.references :original_life_rule, null: true, foreign_key: { to_table: :life_rules }
      t.string :icon, null: false
      t.string :title, null: false
      t.text :description
      t.boolean :is_public, default: false, null: false
      t.boolean :approved, default: false, null: false
      t.integer :adoption_count, default: 0, null: false

      t.timestamps
    end

    add_index :life_rules, :is_public
    add_index :life_rules, :approved
    add_index :life_rules, :adoption_count
  end
end
