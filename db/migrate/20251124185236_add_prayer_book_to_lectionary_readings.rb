class AddPrayerBookToLectionaryReadings < ActiveRecord::Migration[8.1]
  def up
    # Add prayer_book_id column
    add_reference :lectionary_readings, :prayer_book, foreign_key: true, null: true

    # Backfill prayer_book_id with default LOC 2015 IEAB
    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE lectionary_readings lr
          SET prayer_book_id = (
            SELECT id FROM prayer_books WHERE code = 'loc_2015'
          )
        SQL
      end
    end

    # Make prayer_book_id NOT NULL after backfill
    change_column_null :lectionary_readings, :prayer_book_id, false

    # Add new composite index
    add_index :lectionary_readings, [ :date_reference, :service_type, :prayer_book_id ],
              name: 'index_lectionary_readings_on_date_service_prayer_book'
  end

  def down
    # Remove composite index
    remove_index :lectionary_readings,
                 name: 'index_lectionary_readings_on_date_service_prayer_book',
                 if_exists: true

    # Remove prayer_book_id
    remove_reference :lectionary_readings, :prayer_book, foreign_key: true
  end
end
