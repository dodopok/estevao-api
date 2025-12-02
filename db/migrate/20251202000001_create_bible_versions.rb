# frozen_string_literal: true

class CreateBibleVersions < ActiveRecord::Migration[8.1]
  def change
    create_table :bible_versions do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.string :full_name
      t.string :language, default: "pt-BR"
      t.text :description
      t.string :publisher
      t.integer :year
      t.boolean :is_recommended, default: false
      t.string :license
      t.boolean :is_active, default: true

      t.timestamps
    end

    add_index :bible_versions, :code, unique: true
    add_index :bible_versions, [ :is_active, :is_recommended ]
    add_index :bible_versions, :language
  end
end
