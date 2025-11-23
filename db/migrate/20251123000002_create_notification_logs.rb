# frozen_string_literal: true

class CreateNotificationLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :notification_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :notification_type # 'streak_reminder', 'announcement', 'new_feature', etc
      t.string :title
      t.text :body
      t.jsonb :data, default: {}
      t.boolean :sent, default: false
      t.text :error_message

      t.timestamps
    end

    add_index :notification_logs, :notification_type
    add_index :notification_logs, :sent
    add_index :notification_logs, :created_at
  end
end
