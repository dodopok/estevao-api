# frozen_string_literal: true

class CreateCompletions < ActiveRecord::Migration[8.1]
  def change
    create_table :completions do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date_reference, null: false # 2025-11-22
      t.string :office_type, null: false # morning, midday, evening, compline
      t.integer :duration_seconds # Opcional: tempo orando

      t.timestamps
    end

    # Garante que não duplique o streak pro mesmo ofício no mesmo dia
    add_index :completions, %i[user_id date_reference office_type], unique: true, name: 'index_completions_unique'
  end
end
