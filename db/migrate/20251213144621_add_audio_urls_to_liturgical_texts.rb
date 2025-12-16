class AddAudioUrlsToLiturgicalTexts < ActiveRecord::Migration[8.1]
  def change
    add_column :liturgical_texts, :audio_urls, :jsonb, default: {}, null: false
    add_column :liturgical_texts, :audio_generation_status, :string, default: "pending"
    add_index :liturgical_texts, :audio_urls, using: :gin
    add_index :liturgical_texts, :audio_generation_status
  end
end
