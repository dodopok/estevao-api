# frozen_string_literal: true

module Reading
  # Query object for LectionaryReading lookups
  # Centralizes common query patterns for readings
  class Query
    def initialize(prayer_book_id:, cycle:)
      @prayer_book_id = prayer_book_id
      @cycle = cycle
    end

    # Find reading by date reference for eucharist service
    def find_by_reference(reference)
      return nil unless reference

      LectionaryReading.for_date_reference(reference)
                       .where(cycle: cycles)
                       .for_prayer_book_id(prayer_book_id)
                       .service_type_eucharist
                       .first
    end

    # Find reading by celebration ID for eucharist service
    def find_by_celebration_id(celebration_id)
      return nil unless celebration_id

      LectionaryReading.where(celebration_id: celebration_id, cycle: cycles)
                       .for_prayer_book_id(prayer_book_id)
                       .service_type_eucharist
                       .first
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

      LectionaryReading.for_date_reference(reference)
                       .where(cycle: weekly_cycles)
                       .for_prayer_book_id(prayer_book_id)
                       .weekly
                       .first
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

    attr_reader :prayer_book_id, :cycle

    def cycles
      [ cycle, "all" ]
    end

    def weekly_cycles
      # Some prayer books use A/B/C (triennial cycle)
      # Others use odd/even (biennial cycle based on civil year)
      odd_even = Date.current.year.odd? ? "odd" : "even"
      [ cycle, "A", "B", "C", odd_even, "all" ]
    end
  end
end
