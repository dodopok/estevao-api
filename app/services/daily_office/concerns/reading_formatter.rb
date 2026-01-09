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

          # Map category to frontend type
          # "invocation" usually maps to "leader" in our Daily Office response
          type = announcement_template.category == "invocation" ? "leader" : announcement_template.category

          lines << line_item(announcement, type: type, slug: announcement_template.slug)
          lines << line_item("", type: "spacer")
        end

        # Actual reading content - now includes Bible text
        if readings[reading_key]
          # Add Bible text content if available
          if readings[reading_key][:content]
            lines.concat(format_bible_content(readings[reading_key][:content]))
          end

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

        module_hash = {
          name: module_name,
          slug: "#{type}_reading",
          lines: lines,
          reference: readings[reading_key]&.dig(:reference),
          translation: readings[reading_key]&.dig(:translation)
        }

        # Generate audio URL for Bible reading (handled in DailyOfficeService like other texts)
        # Only add if user has audio preference set (premium users only)
        # Audio files must be pre-generated via rake tasks
        if preferences[:preferred_audio_voice].present?
          audio_url = find_bible_audio_url(readings[reading_key])
          module_hash[:audio_url] = audio_url if audio_url.present?
        end

        module_hash
      end

      # Format Bible content into line items
      #
      # @param content [Hash] structured Bible content from BibleTextService
      # @return [Array<Hash>] array of line items
      def format_bible_content(content)
        return [] unless content&.dig(:verses)

        content[:verses].map do |verse|
          {
            text: verse[:text],
            type: "reading_text",
            verse_number: verse[:number]
          }
        end
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

      # Find pre-generated Bible audio URL if available
      # Returns nil if audio file doesn't exist (audio must be pre-generated via rake tasks)
      #
      # @param reading [Hash] reading data with reference
      # @return [String, nil] audio URL or nil if not found
      def find_bible_audio_url(reading, reading_type: nil)
        return nil unless reading&.dig(:reference)

        reference = reading[:reference]
        voice = preferences[:preferred_audio_voice] || "male_1"
        bible_version = preferences[:bible_version] || "nvi"

        # Look for existing audio file (does not generate)
        BibleAudioService.find_audio(
          reference: reference,
          bible_version: bible_version,
          voice: voice,
          reading_type: reading_type
        )
      rescue StandardError => e
        # Silent fallback: log error but don't break the office generation
        Rails.logger.error "Failed to find Bible audio URL: #{e.message}"
        Rails.logger.error "  Reading: #{reading.inspect}"
        nil
      end
    end
  end
end
