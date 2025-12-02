# frozen_string_literal: true

class CreateUserOnboardings < ActiveRecord::Migration[8.1]
  def change
    create_table :user_onboardings do |t|
      t.references :user, null: false, foreign_key: true, index: false
      t.references :prayer_book, null: false, foreign_key: true
      t.references :bible_version, null: false, foreign_key: true
      t.string :mode, null: false, default: "basic" # basic, advanced
      t.jsonb :preferences, null: false, default: {}
      t.boolean :onboarding_completed, default: true
      t.datetime :completed_at

      t.timestamps
    end

    add_index :user_onboardings, :user_id, unique: true
    add_index :user_onboardings, :onboarding_completed
    add_index :user_onboardings, :preferences, using: :gin
  end
end
