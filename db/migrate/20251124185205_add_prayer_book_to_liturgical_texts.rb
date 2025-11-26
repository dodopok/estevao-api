class AddPrayerBookToLiturgicalTexts < ActiveRecord::Migration[8.1]
  def up
    # Delete all existing liturgical texts (will be recreated by seed with prayer_book_id)
    execute "DELETE FROM liturgical_texts"

    # Add prayer_book_id column (not null from the start)
    add_reference :liturgical_texts, :prayer_book, null: false, foreign_key: { on_delete: :restrict }

    # Remove old version column
    remove_column :liturgical_texts, :version if column_exists?(:liturgical_texts, :version)

    # Add unique index on slug and prayer_book_id
    remove_index :liturgical_texts, :slug if index_exists?(:liturgical_texts, :slug)
    add_index :liturgical_texts, [ :slug, :prayer_book_id ], unique: true unless index_exists?(:liturgical_texts, [ :slug, :prayer_book_id ])
  end

  def down
    # Reverse the migration
    remove_index :liturgical_texts, [ :slug, :prayer_book_id ] if index_exists?(:liturgical_texts, [ :slug, :prayer_book_id ])
    add_column :liturgical_texts, :version, :string unless column_exists?(:liturgical_texts, :version)
    remove_reference :liturgical_texts, :prayer_book if column_exists?(:liturgical_texts, :prayer_book_id)
    add_index :liturgical_texts, :slug, unique: true unless index_exists?(:liturgical_texts, :slug)
  end
end
