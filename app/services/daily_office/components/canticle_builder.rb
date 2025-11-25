# frozen_string_literal: true

module DailyOffice
  module Components
    class CanticleBuilder
      attr_reader :date, :preferences, :day_info

      def initialize(date:, preferences: {}, day_info: {})
        @date = date
        @preferences = preferences
        @day_info = day_info
      end

      def build_invitatory
        canticle_slug = should_use_jubilate? ? "jubilate" : "venite"
        text = fetch_liturgical_text(canticle_slug)
        return nil unless text

        canticle_name = canticle_slug == "venite" ? "Venite (Salmo 95)" : "Jubilate (Salmo 100)"

        {
          name: canticle_name,
          slug: "invitatory",
          lines: [
            line_item("Todos de pé", type: "rubric"),
            line_item(text.content, type: "congregation")
          ]
        }
      end

      def build_first_canticle
        slug = should_use_te_deum? ? "te_deum" : "benedictus_es_domine"
        text = fetch_liturgical_text(slug)
        return nil unless text

        name = slug == "te_deum" ? "Te Deum" : "Benedictus es Domine"

        {
          name: name,
          slug: "first_canticle",
          lines: [
            line_item("Todos de pé", type: "rubric"),
            line_item(text.content, type: "congregation")
          ]
        }
      end

      def build_second_canticle
        text = fetch_liturgical_text("benedictus")
        return nil unless text

        {
          name: "Benedictus (Cântico de Zacarias)",
          slug: "benedictus",
          lines: [
            line_item("Todos de pé", type: "rubric"),
            line_item(text.content, type: "congregation")
          ]
        }
      end

      def build_magnificat
        text = fetch_liturgical_text("magnificat")
        return nil unless text

        {
          name: "Magnificat (Cântico de Maria)",
          slug: "magnificat",
          lines: [
            line_item("Todos de pé", type: "rubric"),
            line_item(text.content, type: "congregation")
          ]
        }
      end

      def build_nunc_dimittis
        text = fetch_liturgical_text("nunc_dimittis")
        return nil unless text

        {
          name: "Nunc Dimittis (Cântico de Simeão)",
          slug: "nunc_dimittis",
          lines: [
            line_item("Todos de pé", type: "rubric"),
            line_item(text.content, type: "congregation")
          ]
        }
      end

      def build_compline_hymn
        text = fetch_liturgical_text("compline_hymn")
        return nil unless text

        {
          name: "Hino",
          slug: "hymn",
          lines: [
            line_item(text.content, type: "congregation")
          ]
        }
      end

      private

      def should_use_jubilate?
        # Use Jubilate during Easter season, Venite otherwise
        day_info[:liturgical_season] == "Easter"
      end

      def should_use_te_deum?
        # Use Te Deum on Sundays and Major Feasts, Benedictus es Domine on weekdays
        day_info[:is_sunday] || day_info[:celebration_rank] == "principal_feast"
      end

      def fetch_liturgical_text(slug)
        prayer_book = PrayerBook.find_by(code: prayer_book_code)
        return nil unless prayer_book

        LiturgicalText.find_by(
          slug: slug,
          prayer_book_id: prayer_book.id
        )
      end

      def line_item(text, type: "text")
        { text: text, type: type }
      end

      def prayer_book_code
        preferences[:prayer_book_code] || "loc_2015"
      end
    end
  end
end
