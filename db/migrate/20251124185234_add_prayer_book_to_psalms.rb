class AddPrayerBookToPsalms < ActiveRecord::Migration[8.1]
  def change
    # Truncate all existing psalms (will be recreated by seed with prayer_book_id)
    reversible do |dir|
      dir.up do
        execute "TRUNCATE TABLE psalms CASCADE"
      end
    end

    # Remove old translation column
    remove_column :psalms, :translation, :string

    # Add prayer_book_id column
    add_reference :psalms, :prayer_book, null: false, foreign_key: { on_delete: :restrict }

    # Add unique index on number and prayer_book_id
    remove_index :psalms, :number, if_exists: true
    add_index :psalms, [ :number, :prayer_book_id ], unique: true
  end
end
