class AddUniqueIndexToCelebrationsNamePrayerBook < ActiveRecord::Migration[8.1]
  def change
    # Remove o índice antigo não-único de name (se existir)
    remove_index :celebrations, :name, if_exists: true

    # Adiciona índice único composto por name + prayer_book_id
    add_index :celebrations, [:name, :prayer_book_id], unique: true
  end
end
