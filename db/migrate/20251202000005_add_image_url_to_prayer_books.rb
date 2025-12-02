# frozen_string_literal: true

class AddImageUrlToPrayerBooks < ActiveRecord::Migration[8.1]
  def change
    add_column :prayer_books, :image_url, :string
    rename_column :prayer_books, :is_default, :is_recommended
  end
end
