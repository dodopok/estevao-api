class CreatePrayerBookUserPreferences < ActiveRecord::Migration[8.1]
  def change
    create_table :prayer_book_user_preferences do |t|
      t.references :user, null: false, foreign_key: true
      t.references :prayer_book, null: false, foreign_key: true
      t.jsonb :options, default: {}, null: false

      t.timestamps
    end

    add_index :prayer_book_user_preferences, [ :user_id, :prayer_book_id ], unique: true, name: "index_pb_user_prefs_on_user_and_prayer_book"
    add_index :prayer_book_user_preferences, :options, using: :gin
  end
end
