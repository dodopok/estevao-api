# frozen_string_literal: true

module DailyOffice
  module Concerns
    # Reading Formatter
    #
    # Provides helper methods to format biblical readings with announcements,
    # rubrics, and responses in a consistent way.
    module ReadingFormatter
      private

      # Build a reading module (first or second reading)
      #
      # @param type [Symbol] :first or :second
      # @param announcement_slug [String] slug for the announcement template
      # @param rubric_slugs [Hash] hash with rubric slugs (pre, post, end)
      # @param reading_key [Symbol] key to access reading in @readings hash
      # @param module_name [String] name of the module
      # @return [Hash] module structure with name, slug, and lines
      def build_reading_module(type:, announcement_slug:, rubric_slugs:, reading_key:, module_name:)
        lines = []

        # Pre-reading rubric
        if rubric_slugs[:pre]
          rubric = fetch_liturgical_text(rubric_slugs[:pre])
          if rubric
            lines << line_item(rubric.content, type: "rubric")
            lines << line_item("", type: "spacer")
          end
        end

        # Reading announcement template
        announcement_template = fetch_liturgical_text(announcement_slug)
        if announcement_template
          announcement = format_reading_announcement(announcement_template, readings[reading_key])
          lines << line_item(announcement, type: "leader")
          lines << line_item("", type: "spacer")
        end

        # Post-reading rubric
        if rubric_slugs[:post]
          post_rubric = fetch_liturgical_text(rubric_slugs[:post])
          if post_rubric
            lines << line_item(post_rubric.content, type: "rubric")
            lines << line_item("", type: "spacer")
          end
        end

        # Actual reading content
        if readings[reading_key]
          lines << line_item(readings[reading_key][:reference], type: "reading")
          lines << line_item("", type: "spacer")
        end

        # Response after reading
        if rubric_slugs[:response]
          response = fetch_liturgical_text(rubric_slugs[:response])
          lines << line_item(response.content, type: "responsive") if response
        end

        # End rubric
        if rubric_slugs[:end]
          end_rubric = fetch_liturgical_text(rubric_slugs[:end])
          if end_rubric
            lines << line_item("", type: "spacer")
            lines << line_item(end_rubric.content, type: "rubric")
          end
        end

        {
          name: module_name,
          slug: "#{type}_reading",
          lines: lines
        }
      end

      # Format reading announcement with book, chapter, and verse
      #
      # @param template [LiturgicalText] template with placeholders
      # @param reading [Hash] reading data with book_name, chapter, verse_start, verse_end
      # @return [String] formatted announcement
      def format_reading_announcement(template, reading)
        if reading
          verse_range = build_verse_range(reading)
          template.content
            .gsub("{{book_name}}", reading[:book_name] || "")
            .gsub("{{chapter}}", reading[:chapter]&.to_s || "")
            .gsub("{{verse}}", verse_range)
        else
          # No reading available, fill placeholders with underscores
          template.content
            .gsub("{{book_name}}", "_______________")
            .gsub("{{chapter}}", "___")
            .gsub("{{verse}}", "___")
        end
      end

      # Build verse range string from reading data
      #
      # @param reading [Hash] reading data with verse_start and verse_end
      # @return [String] verse range (e.g., "1-5" or "1")
      def build_verse_range(reading)
        if reading[:verse_start] && reading[:verse_end]
          "#{reading[:verse_start]}-#{reading[:verse_end]}"
        elsif reading[:verse_start]
          reading[:verse_start].to_s
        else
          ""
        end
      end
    end
  end
end
