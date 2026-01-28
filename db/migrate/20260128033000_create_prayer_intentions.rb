class CreatePrayerIntentions < ActiveRecord::Migration[8.0]
  def change
    create_table :prayer_intentions do |t|
      # Core fields
      t.references :user, null: false, foreign_key: true, index: true
      t.string :title, null: false
      t.text :description
      
      # Status and categorization
      t.integer :status, default: 0, null: false
      t.string :category
      
      # Answer tracking
      t.datetime :answered_at
      t.text :answer_notes
      
      # AI-enriched fields (Perplexity API)
      t.text :spiritual_context
      t.json :related_scriptures, default: []
      t.json :suggested_prayers, default: []
      t.text :theological_insights
      t.json :reflection_prompts, default: []
      
      # Privacy and sharing
      t.boolean :is_private, default: true, null: false
      t.boolean :allow_community_prayer, default: false, null: false
      
      # Prayer tracking metadata
      t.integer :prayer_count, default: 0, null: false
      t.datetime :last_prayed_at
      
      # AI enrichment metadata
      t.datetime :ai_enriched_at
      t.string :ai_model_version
      
      t.timestamps
    end
    
    # Indexes for performance
    add_index :prayer_intentions, [:user_id, :status]
    add_index :prayer_intentions, [:user_id, :created_at]
    add_index :prayer_intentions, :status
    add_index :prayer_intentions, :category
    add_index :prayer_intentions, :answered_at
    add_index :prayer_intentions, :is_private
    add_index :prayer_intentions, :allow_community_prayer
  end
end
