# frozen_string_literal: true

module DailyOffice
  module Components
    class ReadingBuilder
      attr_reader :date, :preferences, :readings

      def initialize(date:, preferences: {}, readings: {})
        @date = date
        @preferences = preferences
        @readings = readings
      end

      def build_first_reading
        return nil unless readings
        reading_ref = readings[:first_reading]
        return nil unless reading_ref

        {
          name: "Primeira Leitura",
          slug: "first_reading",
          lines: [
            line_item("Primeira Leitura", type: "heading"),
            line_item(reading_ref, type: "subheading"),
            line_item("", type: "spacer"),
            line_item("Leitura de #{reading_ref}", type: "reader"),
            line_item(fetch_bible_text(reading_ref), type: "html"),
            line_item("", type: "spacer"),
            line_item("Palavra do Senhor.", type: "reader"),
            line_item("Graças a Deus.", type: "congregation")
          ]
        }
      end

      def build_second_reading
        return nil unless readings
        reading_ref = readings[:second_reading]
        return nil unless reading_ref

        {
          name: "Segunda Leitura",
          slug: "second_reading",
          lines: [
            line_item("Segunda Leitura", type: "heading"),
            line_item(reading_ref, type: "subheading"),
            line_item("", type: "spacer"),
            line_item("Leitura de #{reading_ref}", type: "reader"),
            line_item(fetch_bible_text(reading_ref), type: "html"),
            line_item("", type: "spacer"),
            line_item("Palavra do Senhor.", type: "reader"),
            line_item("Graças a Deus.", type: "congregation")
          ]
        }
      end

      def build_short_reading
        text = fetch_liturgical_text("short_reading")
        return nil unless text

        {
          name: "Leitura Breve",
          slug: "short_reading",
          lines: [
            line_item(text.reference, type: "subheading"),
            line_item(text.content, type: "reader")
          ]
        }
      end

      private

      def fetch_bible_text(reference)
        BibleText.format_passage_html(reference, translation: bible_version)
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

      def bible_version
        preferences[:bible_version] || "nvi"
      end
    end
  end
end
