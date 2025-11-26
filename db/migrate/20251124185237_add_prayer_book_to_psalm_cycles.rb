class AddPrayerBookToPsalmCycles < ActiveRecord::Migration[8.1]
  def up
    # Add prayer_book_id column
    add_reference :psalm_cycles, :prayer_book, foreign_key: true, null: true

    # Backfill prayer_book_id with default LOC 2015 IEAB
    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE psalm_cycles pc
          SET prayer_book_id = (
            SELECT id FROM prayer_books WHERE code = 'loc_2015'
          )
        SQL
      end
    end

    # Make prayer_book_id NOT NULL after backfill
    change_column_null :psalm_cycles, :prayer_book_id, false

    # Remove old unique index
    remove_index :psalm_cycles, name: 'index_psalm_cycles_on_cycle_lookup', if_exists: true

    # Add new composite unique index with prayer_book_id
    add_index :psalm_cycles,
              [ :cycle_type, :week_number, :day_of_week, :office_type, :prayer_book_id ],
              name: 'index_psalm_cycles_on_cycle_lookup_with_prayer_book',
              unique: true
  end

  def down
    # Remove new composite index
    remove_index :psalm_cycles,
                 name: 'index_psalm_cycles_on_cycle_lookup_with_prayer_book',
                 if_exists: true

    # Re-add old unique index
    add_index :psalm_cycles,
              [ :cycle_type, :week_number, :day_of_week, :office_type ],
              name: 'index_psalm_cycles_on_cycle_lookup',
              unique: true

    # Remove prayer_book_id
    remove_reference :psalm_cycles, :prayer_book, foreign_key: true
  end
end
