class CreateAudioGenerationSessions < ActiveRecord::Migration[8.1]
  def change
    create_table :audio_generation_sessions do |t|
      t.string :prayer_book_code, null: false
      t.string :voice_keys, array: true, default: []
      t.string :current_voice_key
      t.bigint :current_text_id
      t.string :status, default: "running", null: false
      t.integer :total_texts, default: 0
      t.integer :processed_count, default: 0
      t.integer :failed_count, default: 0
      t.datetime :started_at
      t.datetime :completed_at
      t.text :error_log

      t.timestamps
    end

    add_index :audio_generation_sessions, :prayer_book_code
    add_index :audio_generation_sessions, :status
    add_index :audio_generation_sessions, [ :prayer_book_code, :status ]
  end
end
