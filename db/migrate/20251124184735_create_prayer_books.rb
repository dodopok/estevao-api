class CreatePrayerBooks < ActiveRecord::Migration[8.1]
  def change
    create_table :prayer_books do |t|
      t.string :code, null: false
      t.string :name
      t.integer :year
      t.string :jurisdiction
      t.text :description
      t.string :thumbnail_url
      t.string :pdf_url
      t.boolean :is_default

      t.timestamps
    end
    add_index :prayer_books, :code, unique: true
    add_index :prayer_books, :is_default
  end
end
