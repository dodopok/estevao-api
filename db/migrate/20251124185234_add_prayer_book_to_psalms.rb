class AddPrayerBookToPsalms < ActiveRecord::Migration[8.1]
  def change
    # Add prayer_book_id column
    add_reference :psalms, :prayer_book, null: false, foreign_key: { on_delete: :restrict }

    # Backfill existing records with LOC 2015
    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE psalms p
          SET prayer_book_id = (SELECT id FROM prayer_books pb WHERE pb.code = COALESCE(p.translation, 'loc_2015'))
        SQL
      end
    end

    # Remove old translation column
    remove_column :psalms, :translation, :string

    # Add unique index on number and prayer_book_id
    remove_index :psalms, :number, if_exists: true
    add_index :psalms, [ :number, :prayer_book_id ], unique: true
  end
end
