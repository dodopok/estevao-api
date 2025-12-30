# frozen_string_literal: true

module DailyOffice
  module Builders
    module Loc2019En
      # Base class for all LOC 2019 English (ACNA) office builders
      class Base < LocBase
        def call
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

        def assemble_office
          raise NotImplementedError, "Subclass must implement assemble_office"
        end
      end
    end
  end
end
