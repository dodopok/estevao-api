class CreateLiturgicalTexts < ActiveRecord::Migration[8.1]
  def change
    create_table :liturgical_texts do |t|
      t.string :slug, null: false
      t.string :category, null: false
      t.text :content, null: false
      t.string :version, default: 'loc_2015'
      t.string :language, default: 'pt-BR'
      t.string :reference
      t.string :audio_url

      t.timestamps
    end
    add_index :liturgical_texts, :slug
    add_index :liturgical_texts, :category
    add_index :liturgical_texts, [:slug, :version], unique: true
  end
end
