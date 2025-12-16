# frozen_string_literal: true

class AddPerformanceIndexesForDailyOffice < ActiveRecord::Migration[8.1]
  def change
    # Optimize LectionaryReading queries - most common lookup pattern
    # This index supports the Reading::Query.find_by_reference method
    unless index_exists?(:lectionary_readings, [ :cycle, :service_type, :prayer_book_id, :date_reference ])
      add_index :lectionary_readings,
                [ :cycle, :service_type, :prayer_book_id, :date_reference ],
                name: 'index_lectionary_readings_on_common_lookup'
    end

    # Optimize Celebration queries by calculation_rule (for movable feasts)
    unless index_exists?(:celebrations, :calculation_rule)
      add_index :celebrations,
                :calculation_rule,
                name: 'index_celebrations_on_calculation_rule'
    end

    # Optimize Celebration queries - combined prayer_book and movable lookup
    unless index_exists?(:celebrations, [ :prayer_book_id, :movable ])
      add_index :celebrations,
                [ :prayer_book_id, :movable ],
                name: 'index_celebrations_on_prayer_book_and_movable'
    end

    # Optimize Celebration queries - combined prayer_book and can_be_transferred lookup
    unless index_exists?(:celebrations, [ :prayer_book_id, :can_be_transferred ])
      add_index :celebrations,
                [ :prayer_book_id, :can_be_transferred ],
                name: 'index_celebrations_on_prayer_book_and_transferable'
    end
  end
end
