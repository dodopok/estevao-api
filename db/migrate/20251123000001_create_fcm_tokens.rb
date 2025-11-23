# frozen_string_literal: true

class CreateFcmTokens < ActiveRecord::Migration[8.1]
  def change
    create_table :fcm_tokens do |t|
      t.references :user, null: false, foreign_key: true
      t.string :token, null: false
      t.string :platform # 'android', 'ios', 'web'

      t.timestamps
    end

    add_index :fcm_tokens, [ :user_id, :token ], unique: true
  end
end
