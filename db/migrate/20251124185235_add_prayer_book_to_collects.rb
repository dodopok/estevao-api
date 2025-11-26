class AddPrayerBookToCollects < ActiveRecord::Migration[8.1]
  def up
    # Add prayer_book_id column
    add_reference :collects, :prayer_book, foreign_key: true, null: true

    # Backfill prayer_book_id with default LOC 2015 IEAB
    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE collects c
          SET prayer_book_id = (
            SELECT id FROM prayer_books WHERE code = 'loc_2015'
          )
        SQL
      end
    end

    # Make prayer_book_id NOT NULL after backfill
    change_column_null :collects, :prayer_book_id, false

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
