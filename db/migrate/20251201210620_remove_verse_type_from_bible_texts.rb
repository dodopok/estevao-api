class RemoveVerseTypeFromBibleTexts < ActiveRecord::Migration[8.1]
  def change
    remove_column :bible_texts, :verse_type, :string
  end
end
