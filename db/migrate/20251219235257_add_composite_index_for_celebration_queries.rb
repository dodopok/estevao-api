# frozen_string_literal: true

class AddCompositeIndexForCelebrationQueries < ActiveRecord::Migration[8.0]
  def change
    # Optimize queries that filter by prayer_book_id, fixed_month, and fixed_day together
    # Common in CelebrationResolver when looking up fixed feasts
    add_index :celebrations, [ :prayer_book_id, :fixed_month, :fixed_day ],
              name: "index_celebrations_on_prayer_book_date",
              where: "movable = false"
  end
end
