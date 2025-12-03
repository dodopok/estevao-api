class CreateSharedOffices < ActiveRecord::Migration[8.1]
  def change
    create_table :shared_offices do |t|
      t.string :short_code, null: false
      t.references :user, null: true, foreign_key: true
      t.string :prayer_book_code, null: false
      t.string :office_type, null: false
      t.date :date, null: false
      t.bigint :seed, null: false
      t.jsonb :preferences, default: {}
      t.datetime :expires_at, null: false

      t.timestamps
    end

    add_index :shared_offices, :short_code, unique: true
    add_index :shared_offices, :expires_at
    add_index :shared_offices, [:date, :office_type, :prayer_book_code]
  end
end
