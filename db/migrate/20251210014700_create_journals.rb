# frozen_string_literal: true

class CreateJournals < ActiveRecord::Migration[8.1]
  def change
    create_table :journals do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date_reference, null: false
      t.string :entry_type, null: false
      t.string :office_type
      t.text :content, null: false

      t.timestamps
    end

    add_index :journals, %i[user_id date_reference entry_type office_type], 
              name: 'index_journals_on_user_date_type_office'
    add_index :journals, %i[user_id date_reference]
  end
end
