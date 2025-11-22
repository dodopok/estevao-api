class CreateBibleTexts < ActiveRecord::Migration[8.1]
  def change
    create_table :bible_texts do |t|
      t.string :book, null: false
      t.integer :book_number, null: false # 1=Genesis, 2=Exodus, etc
      t.integer :chapter, null: false
      t.integer :verse, null: false
      t.text :text, null: false
      t.string :translation, default: 'nvi'
      t.string :verse_type # 'prose' or 'poetry' for formatting

      t.timestamps
    end
    add_index :bible_texts, [ :book, :chapter, :verse, :translation ],
              name: 'index_bible_texts_on_verse_lookup'
    add_index :bible_texts, [ :book_number, :chapter, :verse, :translation ],
              name: 'index_bible_texts_on_book_number_lookup'
  end
end
