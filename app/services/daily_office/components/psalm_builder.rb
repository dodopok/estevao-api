# frozen_string_literal: true

module DailyOffice
  module Components
    class PsalmBuilder
      attr_reader :date, :preferences

      def initialize(date:, preferences: {})
        @date = date
        @preferences = preferences
      end

      def build_psalms(office_type)
        cycle = PsalmCycle.find_for_date_and_office(date, office_type.to_s)
        return nil unless cycle

        {
          name: "Saltério",
          slug: "psalms",
          lines: build_psalm_lines(cycle)
        }
      end

      def build_single_psalm(office_type)
        cycle = PsalmCycle.find_for_date_and_office(date, office_type.to_s)
        return nil unless cycle

        first_psalm_number = cycle.psalm_numbers.first
        return nil unless first_psalm_number

        {
          name: "Salmo",
          slug: "psalm",
          lines: build_single_psalm_lines(first_psalm_number)
        }
      end

      def build_compline_psalms
        {
          name: "Salmos",
          slug: "compline_psalms",
          lines: [
            line_item("Salmos 4, 31, 91, 134", type: "heading"),
            line_item("Todos sentados", type: "rubric"),
            *build_multiple_psalms_lines([ 4, 31, 91, 134 ])
          ]
        }
      end

      def build_midday_psalms
        cycle = PsalmCycle.find_for_date_and_office(date, "midday")
        return build_fixed_psalm(119) unless cycle

        {
          name: "Salmo",
          slug: "psalms",
          lines: build_psalm_lines(cycle)
        }
      end

      private

      def build_psalm_lines(cycle)
        lines = [
          line_item("Salmo(s): #{cycle.psalm_numbers.join(', ')}", type: "heading"),
          line_item("Todos sentados", type: "rubric"),
          line_item("", type: "spacer")
        ]

        cycle.psalm_numbers.each_with_index do |psalm_number, index|
          psalm = Psalm.find_psalm(psalm_number, prayer_book_code: prayer_book_code)
          next unless psalm

          lines << line_item("", type: "spacer") if index.positive?
          lines << line_item("Salmo #{psalm_number}", type: "heading")

          psalm.responsive_format.each do |verse|
            lines << line_item(verse[:text], type: verse[:type])
          end
        end

        lines << line_item("", type: "spacer")
        lines << line_item("Glória ao Pai, e ao Filho, e ao Espírito Santo;", type: "all")
        lines << line_item("Como era no princípio, é agora e será para sempre. Amém.", type: "all")

        lines
      end

      def build_single_psalm_lines(psalm_number)
        psalm = Psalm.find_psalm(psalm_number, prayer_book_code: prayer_book_code)
        return [] unless psalm

        lines = [
          line_item("Salmo #{psalm_number}", type: "heading"),
          line_item("Todos sentados", type: "rubric"),
          line_item("", type: "spacer")
        ]

        psalm.responsive_format.each do |verse|
          lines << line_item(verse[:text], type: verse[:type])
        end

        lines << line_item("", type: "spacer")
        lines << line_item("Glória ao Pai, e ao Filho, e ao Espírito Santo;", type: "all")
        lines << line_item("Como era no princípio, é agora e será para sempre. Amém.", type: "all")

        lines
      end

      def build_multiple_psalms_lines(psalm_numbers)
        lines = []
        psalm_numbers.each_with_index do |psalm_number, index|
          psalm = Psalm.find_psalm(psalm_number, prayer_book_code: prayer_book_code)
          next unless psalm

          lines << line_item("", type: "spacer") if index.positive?
          lines << line_item("Salmo #{psalm_number}", type: "heading")

          psalm.responsive_format.each do |verse|
            lines << line_item(verse[:text], type: verse[:type])
          end

          lines << line_item("", type: "spacer")
          lines << line_item("Glória ao Pai, e ao Filho, e ao Espírito Santo;", type: "all")
          lines << line_item("Como era no princípio, é agora e será para sempre. Amém.", type: "all")
        end

        lines
      end

      def build_fixed_psalm(psalm_number)
        {
          name: "Salmo",
          slug: "psalm",
          lines: build_single_psalm_lines(psalm_number)
        }
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
