class AddFeaturesToPrayerBooks < ActiveRecord::Migration[8.1]
  def change
    add_column :prayer_books, :features, :jsonb, default: {}, null: false
    add_index :prayer_books, :features, using: :gin
  end
end
