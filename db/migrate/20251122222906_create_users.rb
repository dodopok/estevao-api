# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :email, null: false, index: { unique: true }
      t.string :provider_uid, index: true # ID único do Firebase/Google
      t.string :name
      t.string :photo_url

      # Preferências (JSONB é perfeito para configurações flexíveis)
      # Ex: { "bible_version": "nvi", "language": "pt-BR", "notifications": true }
      t.jsonb :preferences, default: {}, null: false

      # Gamificação (Cache)
      t.integer :current_streak, default: 0
      t.integer :longest_streak, default: 0
      t.datetime :last_completed_office_at

      t.timestamps
    end
  end
end
