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
      
      # AI-generated prayer (simplified from multiple fields)
      t.text :generated_prayer
      t.datetime :ai_enriched_at
      t.string :ai_model_version
      
      # Prayer tracking metadata
      t.integer :prayer_count, default: 0, null: false
      t.datetime :last_prayed_at
      
      t.timestamps
    end
    
    # Indexes for performance
    add_index :prayer_intentions, [:user_id, :status]
    add_index :prayer_intentions, [:user_id, :created_at]
    add_index :prayer_intentions, :status
    add_index :prayer_intentions, :category
    add_index :prayer_intentions, :answered_at
  end
end
