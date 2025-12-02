# frozen_string_literal: true

class CreatePreferenceCategories < ActiveRecord::Migration[8.1]
  def change
    create_table :preference_categories do |t|
      t.references :prayer_book, null: false, foreign_key: true
      t.string :key, null: false
      t.string :name, null: false
      t.text :description
      t.string :icon
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :preference_categories, [ :prayer_book_id, :key ], unique: true
    add_index :preference_categories, [ :prayer_book_id, :position ]
  end
end
