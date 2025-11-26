class AddPrayerBookToLectionaryReadings < ActiveRecord::Migration[8.1]
  def up
    # Delete all existing lectionary readings (will be recreated by seed with prayer_book_id)
    execute "DELETE FROM lectionary_readings"

    # Add prayer_book_id column
    add_reference :lectionary_readings, :prayer_book, foreign_key: true, null: false

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
