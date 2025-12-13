# frozen_string_literal: true

module DailyOffice
  module Builders
    module Loc2015
      # Base class for all LOC 2015 (IEAB) office builders
      # Inherits common functionality from LocBase and adds LOC 2015-specific behavior
      class Base < LocBase
        # Returns the complete office structure with metadata
        # Subclasses implement call method that calls their assemble_* private methods
        # This wrapper adds the metadata structure
        def call
          # Get the modules array from the subclass
          modules = assemble_office

          {
            date: date.strftime("%Y-%m-%d"),
            office_type: office_type.to_s,
            season: day_info[:liturgical_season],
            color: day_info[:liturgical_color],
            celebration: day_info[:celebration],
            saint: day_info[:saint],
            modules: modules,
            metadata: {
              prayer_book_code: preferences[:prayer_book_code],
              prayer_book_name: prayer_book&.name,
              bible_version: preferences[:bible_version],
              language: preferences[:language],
              seed: preferences[:seed]
            }
          }
        end

        private

        # Subclasses must implement this method to return their modules array
        def assemble_office
          raise NotImplementedError, "Subclass must implement assemble_office"
        end
      end
    end
  end
end
