# frozen_string_literal: true

class AddPerformanceIndexesForDailyOffice < ActiveRecord::Migration[8.1]
  def change
    # Optimize LectionaryReading queries - most common lookup pattern
    # This index supports the Reading::Query.find_by_reference method
    add_index :lectionary_readings, 
              [:cycle, :service_type, :prayer_book_id, :date_reference],
              name: 'index_lectionary_readings_on_common_lookup',
              if_not_exists: true

    # Optimize Celebration queries by calculation_rule (for movable feasts)
    add_index :celebrations, 
              :calculation_rule,
              name: 'index_celebrations_on_calculation_rule',
              if_not_exists: true

    # Optimize Celebration queries - combined prayer_book and movable lookup
    add_index :celebrations,
              [:prayer_book_id, :movable],
              name: 'index_celebrations_on_prayer_book_and_movable',
              if_not_exists: true

    # Optimize Celebration queries - combined prayer_book and can_be_transferred lookup
    add_index :celebrations,
              [:prayer_book_id, :can_be_transferred],
              name: 'index_celebrations_on_prayer_book_and_transferable',
              if_not_exists: true

    # Optimize PrayerBook lookups by code (if not already indexed)
    # Verify this doesn't conflict with existing unique index
    unless index_exists?(:prayer_books, :code)
      add_index :prayer_books, :code, name: 'index_prayer_books_on_code'
    end
  end
end
