class AddPrayerBookToLiturgicalTexts < ActiveRecord::Migration[8.1]
  def up
    # Add prayer_book_id column (nullable first)
    add_reference :liturgical_texts, :prayer_book, null: true, foreign_key: { on_delete: :restrict }

    # Backfill existing records with LOC 2015
    execute <<-SQL
      UPDATE liturgical_texts lt
      SET prayer_book_id = (SELECT id FROM prayer_books pb WHERE pb.code = COALESCE(lt.version, 'loc_2015'))
    SQL

    # Make prayer_book_id not null
    change_column_null :liturgical_texts, :prayer_book_id, false

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
