# frozen_string_literal: true

module DailyOffice
  # Main builder that routes to the appropriate LOC-specific builder
  class Builder
    def self.call(date:, office_type:, preferences: {})
      new(date: date, office_type: office_type, preferences: preferences).call
    end

    def initialize(date:, office_type:, preferences: {})
      @date = date
      @office_type = office_type
      @preferences = default_preferences.merge(preferences)
    end

    def call
      loc_builder_class.call(
        date: @date,
        office_type: @office_type,
        preferences: @preferences
      )
    end

    private

    def default_preferences
      {
        prayer_book_code: "loc_2015",
        bible_version: "nvi",
        language: "pt-BR"
      }
    end

    def loc_builder_class
      case @preferences[:prayer_book_code]
      when "loc_2015"
        Builders::Loc2015Builder
      # Future LOCs can be added here:
      # when "bcp_1979"
      #   Builders::Bcp1979Builder
      # when "loc_2025"
      #   Builders::Loc2025Builder
      else
        raise ArgumentError, "Unknown prayer book code: #{@preferences[:prayer_book_code]}"
      end
    end
  end
end
