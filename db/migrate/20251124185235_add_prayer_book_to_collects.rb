class AddPrayerBookToCollects < ActiveRecord::Migration[8.1]
  def up
    # Truncate all existing collects (will be recreated by seed with prayer_book_id)
    execute "TRUNCATE TABLE collects CASCADE"

    # Add prayer_book_id column
    add_reference :collects, :prayer_book, foreign_key: true, null: false

    # Add new composite index
    add_index :collects, [ :celebration_id, :prayer_book_id ]
  end

  def down
    # Remove composite index
    remove_index :collects, column: [ :celebration_id, :prayer_book_id ], if_exists: true

    # Remove prayer_book_id
    remove_reference :collects, :prayer_book, foreign_key: true
  end
end
