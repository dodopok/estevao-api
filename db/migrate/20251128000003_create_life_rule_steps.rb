# frozen_string_literal: true

class CreateLifeRuleSteps < ActiveRecord::Migration[8.1]
  def change
    create_table :life_rule_steps do |t|
      t.references :life_rule, null: false, foreign_key: true
      t.integer :order, null: false
      t.string :title, null: false
      t.text :description

      t.timestamps
    end

    add_index :life_rule_steps, [ :life_rule_id, :order ], unique: true
  end
end
