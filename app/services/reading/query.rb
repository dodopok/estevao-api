# frozen_string_literal: true

module Reading
  # Query object for LectionaryReading lookups
  # Centralizes common query patterns for readings
  class Query
    def initialize(prayer_book_id:, cycle:, date: Date.current, reading_type: nil, service_type: nil)
      @prayer_book_id = prayer_book_id
      @cycle = cycle
      @date = date
      @reading_type = reading_type
      @service_type = service_type
    end

    # Find reading by date reference for eucharist service
    def find_by_reference(reference)
      return nil unless reference

      query = LectionaryReading.where(
                date_reference: reference,
                cycle: cycles,
                prayer_book_id: prayer_book_id,
                service_type: service_type || "eucharist"
              )

      query = apply_reading_type_filter(query) if reading_type.present?
      query.first
    end

    # Find reading by celebration ID for eucharist service
    def find_by_celebration_id(celebration_id)
      return nil unless celebration_id

      query = LectionaryReading.where(
                celebration_id: celebration_id,
                cycle: cycles,
                prayer_book_id: prayer_book_id,
                service_type: service_type || "eucharist"
              )

      query = apply_reading_type_filter(query) if reading_type.present?
      query.first
    end

    # Find reading from multiple references (returns first match)
    def find_by_references(references)
      references.each do |ref|
        reading = find_by_reference(ref)
        return reading if reading
      end
      nil
    end

    # Find weekly reading by reference
    def find_weekly(reference)
      return nil unless reference

      query = LectionaryReading.where(
                date_reference: reference,
                cycle: weekly_cycles,
                prayer_book_id: prayer_book_id,
                service_type: service_type || [ "weekly", "daily_office", "morning_prayer", "evening_prayer" ]
              )

      query = apply_reading_type_filter(query) if reading_type.present?
      query.first
    end

    # Find weekly reading from multiple references
    def find_weekly_by_references(references)
      references.each do |ref|
        reading = find_weekly(ref)
        return reading if reading
      end
      nil
    end

    private

    attr_reader :prayer_book_id, :cycle, :date, :reading_type, :service_type

    def cycles
      [ cycle, "all" ]
    end

    def weekly_cycles
      # Some prayer books use A/B/C (triennial cycle)
      # Others use odd/even (biennial cycle based on civil year)
      odd_even = date.year.odd? ? "odd" : "even"
      [ cycle, "A", "B", "C", odd_even, "all" ]
    end

    # Apply reading_type filter with OR NULL logic
    def apply_reading_type_filter(query)
      query.where("reading_type = ? OR reading_type IS NULL", reading_type)
    end
  end
end
