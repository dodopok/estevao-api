# frozen_string_literal: true

module DailyOffice
  module Concerns
    # Season Mapper
    #
    # Provides helper methods to map liturgical seasons to slug identifiers
    # used for fetching season-specific liturgical texts.
    module SeasonMapper
      private

      # Map season to opening sentence slug
      def season_to_opening_sentence_slug(season, feast_day: false)
        season_slug = case season&.downcase
        when "advento" then "advent"
        when "natal" then "christmas"
        when "epifania" then "epiphany"
        when "quaresma" then "lent"
        when "semana santa" then "holy_week"
        when "sexta-feira santa" then "good_friday"
        when "páscoa" then "easter"
        when "ascensão" then "ascension"
        when "santo nome" then "holy_name"
        when "pentecostes" then "pentecost"
        when "trindade" then "trinity"
        when "todos os santos" then "all_saints"
        else
          # Check if it's a feast day
          return "common_feast" if feast_day
          # No seasonal sentence for ordinary time
          return nil
        end

        season_slug
      end

      # Map season to invitatory antiphon slug
      def season_to_antiphon_slug(season, feast_day: false)
        season_slug = case season&.downcase
        when "advento" then "advent"
        when "natal" then "christmas"
        when "epifania" then "epiphany"
        when "quaresma" then "lent"
        when "páscoa" then "easter"
        when "ascensão" then "ascension"
        when "pentecostes" then "pentecost"
        when "trindade" then "trinity"
        when "anunciação" then "anunciation"
        else
          return "common_feast" if feast_day
          return nil
        end

        season_slug
      end

      # Check if current season is Lent
      def lent_season?(season)
        season&.downcase == "quaresma" || season&.downcase == "semana santa"
      end
    end
  end
end
