class AddPrayerBookToCelebrations < ActiveRecord::Migration[8.1]
  def up
    # Add prayer_book_id column (nullable first)
    add_reference :celebrations, :prayer_book, null: true, foreign_key: { on_delete: :restrict }

    # Backfill existing records with LOC 2015
    execute <<-SQL
      UPDATE celebrations
      SET prayer_book_id = (SELECT id FROM prayer_books WHERE code = 'loc_2015')
      WHERE prayer_book_id IS NULL
    SQL

    # Make prayer_book_id not null
    change_column_null :celebrations, :prayer_book_id, false
  end

  def down
    # Reverse the migration
    remove_index :celebrations, :prayer_book_id if index_exists?(:celebrations, :prayer_book_id)
    remove_reference :celebrations, :prayer_book if column_exists?(:celebrations, :prayer_book_id)
  end
end
