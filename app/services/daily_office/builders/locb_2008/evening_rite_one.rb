# frozen_string_literal: true

module DailyOffice
  module Builders
    module Locb2008
      # LOCB 2008 Evening Prayer Rite One (Oração Vespertina I)
      #
      # This builder follows the traditional structure from the
      # Livro de Oração Comum Brasileiro 2008, pages 68-74.
      #
      # Structure:
      # 1. Preparação (Preparation/Greeting)
      # 2. Acolhida (Welcome)
      # 3. Confissão de Pecados (Confession)
      # 4. Ação de Graças (Thanksgiving)
      # 5. Hino (Hymn)
      # 6. Cântico de Abertura - Salmo 104 ou 141 (Opening Canticle)
      # 7. Breve Reflexão (Brief Reflection)
      # 8. Salmodia (Psalms)
      # 9. Leituras das Escrituras (Scripture Readings)
      # 10. Hino ou Cântico (Hymn or Canticle)
      # 11. Responso (Response)
      # 12. Cântico Evangélico - Magnificat (Gospel Canticle)
      # 13. Sermão (Sermon)
      # 14. Afirmação de Fé (Creed)
      # 15. Orações/Intercessões (Prayers/Intercessions)
      # 16. A Coleta do Dia (Collect of the Day)
      # 17. A Oração do Senhor (Lord's Prayer)
      # 18. Conclusão (Conclusion/Blessing)
      #
      class EveningRiteOne < Base
        private

        def assemble_office
          assemble_evening_prayer
        end

        def assemble_evening_prayer
          [
            build_preparation,
            build_hymn_opening,
            build_opening_canticle,
            build_word_of_god,
            build_psalms,
            build_hymn,
            build_readings,
            build_magnificat,
            build_sermon,
            build_creed,
            build_prayers,
            build_collect_of_the_day,
            build_lords_prayer,
            build_conclusion
          ].flatten.compact
        end

        # ============================================================================
        # SECTION: Opening Components
        # ============================================================================

        # PREPARAÇÃO - Greeting and Opening
        def build_preparation
          lines = []

          # Resolve preparation option (1, 2, or random)
          option = resolve_preference(:evening_1_preparation, 1..2) || 1

          greeting_minister = fetch_liturgical_text("evening_1_preparation_#{option}_greeting_minister")
          if greeting_minister
            lines << line_item(greeting_minister.content, type: "leader", slug: greeting_minister.slug)
          end

          greeting_all = fetch_liturgical_text("evening_1_preparation_#{option}_greeting_all")
          if greeting_all
            lines << line_item(greeting_all.content, type: "congregation", slug: greeting_all.slug)
            lines << line_item("", type: "spacer")
          end

          opening_minister = fetch_liturgical_text("evening_1_preparation_#{option}_opening_minister")
          if opening_minister
            lines << line_item(opening_minister.content, type: "leader", slug: opening_minister.slug)
          end

          opening_all = fetch_liturgical_text("evening_1_preparation_#{option}_opening_all")
          if opening_all
            lines << line_item(opening_all.content, type: "congregation", slug: opening_all.slug)
          end

          evening_welcome_rubric = fetch_liturgical_text("evening_1_welcome_rubric")
          if evening_welcome_rubric
            lines << line_item(evening_welcome_rubric.content, type: "congregation", slug: evening_welcome_rubric.slug)
          end

          welcome = fetch_liturgical_text("evening_1_welcome_minister")
          if welcome
            lines << line_item(welcome.content, type: "congregation", slug: welcome.slug)
          end

          # Rubric
          rubric = fetch_liturgical_text("evening_1_confession_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Invitation to confession
          invitation = fetch_liturgical_text("evening_1_confession_invitation_minister")
          if invitation
            lines << line_item(invitation.content, type: "leader", slug: invitation.slug)
            lines << line_item("", type: "spacer")
          end

          # Silence rubric
          silence = fetch_liturgical_text("evening_1_confession_silence")
          if silence
            lines << line_item(silence.content, type: "rubric", slug: silence.slug)
            lines << line_item("", type: "spacer")
          end

          # Confession prayer
          confession = fetch_liturgical_text("evening_1_confession_prayer_all")
          if confession
            lines << line_item(confession.content, type: "congregation", slug: confession.slug)
            lines << line_item("", type: "spacer")
          end

          # Absolution/Declaration of Pardon
          absolution = fetch_liturgical_text("evening_1_confession_absolution_minister")
          if absolution
            lines << line_item(absolution.content, type: "leader", slug: absolution.slug)
          end

          absolution_all = fetch_liturgical_text("evening_1_confession_absolution_all")
          if absolution_all
            lines << line_item(absolution_all.content, type: "congregation", slug: absolution_all.slug)
          end

          # Optional thanksgiving prayer (rubric)
          rubric = fetch_liturgical_text("evening_1_thanksgiving_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Thanksgiving prayer (optional)
          prayer = fetch_liturgical_text("evening_1_thanksgiving_prayer_minister")
          if prayer
            lines << line_item(prayer.content, type: "leader", slug: prayer.slug)
          end

          prayer_all = fetch_liturgical_text("evening_1_thanksgiving_prayer_all")
          if prayer_all
            lines << line_item(prayer_all.content, type: "congregation", slug: prayer_all.slug)
          end

          {
            name: "Preparação",
            type: "main_part",
            slug: "preparation",
            lines: lines
          }
        end

        # Hino de Abertura (placeholder)
        def build_hymn_opening
          {
            name: "Hino",
            slug: "hymn_opening",
            lines: []
          }
        end

        # CÂNTICO DE ABERTURA - Salmo 104 ou Salmo 141
        def build_opening_canticle
          lines = []

          # Resolve canticle option from preferences
          canticle_option = resolve_canticle_preference

          canticle_slug = case canticle_option
          when "psalm_104", 1
                            "evening_1_canticle_psalm_104"
          when "psalm_141", 2
                            "evening_1_canticle_psalm_141"
          else
                            "evening_1_canticle_psalm_104"
          end

          canticle = fetch_liturgical_text(canticle_slug)
          if canticle
            lines << line_item(canticle.title, type: "heading") if canticle.title.present?
            lines << line_item(canticle.content, slug: canticle.slug)
            lines << line_item("", type: "spacer")
          end

          # Gloria Patri after canticle
          gloria_minister = fetch_liturgical_text("evening_1_canticle_gloria_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("evening_1_canticle_gloria_all")
          if gloria_all
            lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
          end

          reflection = fetch_liturgical_text("evening_1_reflection_minister")
          if reflection
            lines << line_item(reflection.content, type: "leader", slug: reflection.slug)
            lines << line_item("", type: "spacer")
          end

          silence = fetch_liturgical_text("evening_1_reflection_silence")
          if silence
            lines << line_item(silence.content, type: "rubric", slug: silence.slug)
            lines << line_item("", type: "spacer")
          end

          prayer = fetch_liturgical_text("evening_1_reflection_prayer_minister")
          if prayer
            lines << line_item(prayer.content, type: "leader", slug: prayer.slug)
          end

          prayer_all = fetch_liturgical_text("evening_1_reflection_prayer_all")
          if prayer_all
            lines << line_item(prayer_all.content, type: "congregation", slug: prayer_all.slug)
          end

          {
            name: "Cântico de Abertura",
            slug: "opening_canticle",
            lines: lines
          }
        end

        def build_word_of_god
          {
            name: "A Palavra de Deus",
            type: "main_part",
            slug: "word_of_god",
            lines: []
          }
        end

        # ============================================================================
        # SECTION: Psalms
        # ============================================================================

        # SALMODIA - Psalms
        def build_psalms
          psalm_ref = readings[:psalm]
          return nil unless psalm_ref&.dig(:reference)

          lines = []

          # Psalm rubric
          rubric = fetch_liturgical_text("evening_1_psalms_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Add psalm reference as heading
          lines << line_item(psalm_ref[:reference], type: "heading")
          lines << line_item("", type: "spacer")

          # Add psalm text from Bible (if available in readings)
          if psalm_ref[:content]
            lines.concat(format_bible_content(psalm_ref[:content]))
            lines << line_item("", type: "spacer")
          end

          # Gloria Patri
          gloria_minister = fetch_liturgical_text("evening_1_psalms_gloria_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("evening_1_psalms_gloria_all")
          if gloria_all
            lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
          end

          {
            name: "Salmodia",
            slug: "psalms",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Scripture Readings
        # ============================================================================

        def build_hymn
          {
            name: "Hino ou Cântico",
            slug: "hymn",
            lines: []
          }
        end

        # LEITURAS DAS ESCRITURAS - Scripture Readings
        def build_readings
          lines = []

          # Readings rubric
          rubric = fetch_liturgical_text("evening_1_readings_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # First reading (evening typically uses second reading if available)
          reading = readings[:second_reading] || readings[:first_reading]
          if reading
            lines << line_item(reading[:reference], type: "heading")
            lines << line_item("", type: "spacer")

            if reading[:content]
              lines.concat(format_bible_content(reading[:content]))
              lines << line_item("", type: "spacer")
            end

            # Response after reading
            response_reader = fetch_liturgical_text("evening_1_readings_response_reader")
            if response_reader
              lines << line_item(response_reader.content, type: "reader", slug: response_reader.slug)
            end

            response_all = fetch_liturgical_text("evening_1_readings_response_all")
            if response_all
              lines << line_item(response_all.content, type: "congregation", slug: response_all.slug)
              lines << line_item("", type: "spacer")
            end
          end

          # Rubric
          rubric = fetch_liturgical_text("evening_1_response_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Light response
          light_minister = fetch_liturgical_text("evening_1_response_light_minister")
          if light_minister
            lines << line_item(light_minister.content, type: "leader", slug: light_minister.slug)
          end

          light_all = fetch_liturgical_text("evening_1_response_light_all")
          if light_all
            lines << line_item(light_all.content, type: "congregation", slug: light_all.slug)
          end

          # Darkness response
          darkness_minister = fetch_liturgical_text("evening_1_response_darkness_minister")
          if darkness_minister
            lines << line_item(darkness_minister.content, type: "leader", slug: darkness_minister.slug)
          end

          darkness_all = fetch_liturgical_text("evening_1_response_darkness_all")
          if darkness_all
            lines << line_item(darkness_all.content, type: "congregation", slug: darkness_all.slug)
          end

          # Gloria
          gloria_minister = fetch_liturgical_text("evening_1_response_gloria_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("evening_1_response_gloria_all")
          if gloria_all
            lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
          end

          {
            name: "Leituras Bíblicas",
            slug: "readings",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Gospel Canticle - Magnificat
        # ============================================================================

        # CÂNTICO EVANGÉLICO - Magnificat
        def build_magnificat
          lines = []

          # Title/rubric
          title = fetch_liturgical_text("evening_1_magnificat_title")
          if title
            lines << line_item(title.content, type: "rubric", slug: title.slug)
            lines << line_item("", type: "spacer")
          end

          # Magnificat text
          magnificat = fetch_liturgical_text("evening_1_magnificat")
          if magnificat
            lines << line_item(magnificat.content, slug: magnificat.slug)
            lines << line_item("", type: "spacer")
          end

          # Gloria at end
          gloria_minister = fetch_liturgical_text("evening_1_magnificat_gloria_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("evening_1_magnificat_gloria_all")
          if gloria_all
            lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
          end

          {
            name: "Cântico Evangélico",
            slug: "magnificat",
            lines: lines
          }
        end

        def build_sermon
          # Rubric
          rubric = fetch_liturgical_text("evening_1_sermon_rubric")

          {
            name: "Sermão",
            slug: "sermon",
            lines: rubric ? [ line_item(rubric.content, type: "rubric", slug: rubric.slug) ] : []
          }
        end

        # ============================================================================
        # SECTION: Creed
        # ============================================================================

        # AFIRMAÇÃO DE FÉ - Creed
        def build_creed
          lines = []

          # Rubric
          rubric = fetch_liturgical_text("evening_1_creed_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Apostles' Creed
          creed = fetch_liturgical_text("evening_1_creed_all")
          return nil unless creed

          lines << line_item(creed.content, type: "congregation", slug: creed.slug)

          {
            name: "Afirmação de Fé",
            slug: "creed",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Prayers
        # ============================================================================

        # Orações
        def build_prayers
          lines = []

          rubric = fetch_liturgical_text("evening_1_prayers_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
          end

          {
            name: "Orações",
            slug: "prayers",
            lines: lines
          }
        end

        # A COLETA DO DIA - Collect of the Day
        def build_collect_of_the_day
          lines = []

          # Collect of the Day (from CollectService)
          lines.concat(build_collect_lines(@collects))

          {
            name: "",
            slug: "collect_of_the_day",
            lines: lines
          }
        end

        # A ORAÇÃO DO SENHOR - Lord's Prayer
        def build_lords_prayer
          lines = []

          # Resolve Lord's Prayer opening option
          option = resolve_preference(:evening_1_lords_prayer_opening, 1..2) || 1

          opening = fetch_liturgical_text("evening_1_lords_prayer_opening_#{option}_minister")
          if opening
            lines << line_item(opening.content, type: "leader", slug: opening.slug)
            lines << line_item("", type: "spacer")
          end

          # Use the common Our Father text (should be shared across prayer books)
          lords_prayer = fetch_liturgical_text("lords_prayer_all")
          if lords_prayer
            lines << line_item(lords_prayer.content, type: "congregation", slug: lords_prayer.slug)
          end

          {
            name: "A Oração do Senhor",
            slug: "lords_prayer",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Conclusion
        # ============================================================================

        # CONCLUSÃO - Conclusion (Blessing/Grace/Peace)
        def build_conclusion
          lines = []

          # Determine which conclusion type to use (based on preference or default to blessing)
          conclusion_type = resolve_conclusion_type

          conclusion_name = case conclusion_type
          when :blessing
                              build_blessing_conclusion(lines)
                              "A Bênção"
          when :grace
                              build_grace_conclusion(lines)
                              "A Graça"
          when :peace
                              build_peace_conclusion(lines)
                              "A Paz"
          else
                              build_blessing_conclusion(lines)
                              "A Bênção"
          end

          {
            name: conclusion_name,
            slug: "conclusion",
            lines: lines
          }
        end

        private

        # ============================================================================
        # SECTION: Helper Methods
        # ============================================================================

        # Resolve canticle preference for opening canticle
        def resolve_canticle_preference
          pref_value = preferences[:evening_1_canticle_post_reading]

          case pref_value&.to_s
          when "psalm_104" then "psalm_104"
          when "psalm_141" then "psalm_141"
          when "random" then %w[psalm_104 psalm_141].sample
          when "all" then "psalm_104" # Default to first when "all"
          else "psalm_104"
          end
        end

        # Resolve conclusion type from preferences
        def resolve_conclusion_type
          pref_value = preferences[:evening_1_conclusion]

          case pref_value&.to_s
          when "grace" then :grace
          when "peace" then :peace
          when "blessing" then :blessing
          when "random" then %i[blessing grace peace].sample
          else :blessing
          end
        end

        # Build blessing conclusion
        def build_blessing_conclusion(lines)
          blessing = fetch_liturgical_text("evening_1_conclusion_blessing_minister")
          if blessing
            lines << line_item(blessing.content, type: "leader", slug: blessing.slug)
          end

          blessing_all = fetch_liturgical_text("evening_1_conclusion_blessing_all")
          if blessing_all
            lines << line_item(blessing_all.content, type: "congregation", slug: blessing_all.slug)
            lines << line_item("", type: "spacer")
          end

          praise_minister = fetch_liturgical_text("evening_1_conclusion_blessing_praise_minister")
          if praise_minister
            lines << line_item(praise_minister.content, type: "leader", slug: praise_minister.slug)
          end

          praise_all = fetch_liturgical_text("evening_1_conclusion_blessing_praise_all")
          if praise_all
            lines << line_item(praise_all.content, type: "congregation", slug: praise_all.slug)
          end
        end

        # Build grace conclusion
        def build_grace_conclusion(lines)
          grace = fetch_liturgical_text("evening_1_conclusion_grace_minister")
          if grace
            lines << line_item(grace.content, type: "leader", slug: grace.slug)
          end

          grace_all = fetch_liturgical_text("evening_1_conclusion_grace_all")
          if grace_all
            lines << line_item(grace_all.content, type: "congregation", slug: grace_all.slug)
          end
        end

        # Build peace conclusion
        def build_peace_conclusion(lines)
          peace = fetch_liturgical_text("evening_1_conclusion_peace_minister")
          if peace
            lines << line_item(peace.content, type: "leader", slug: peace.slug)
          end

          peace_all = fetch_liturgical_text("evening_1_conclusion_peace_all")
          if peace_all
            lines << line_item(peace_all.content, type: "congregation", slug: peace_all.slug)
            lines << line_item("", type: "spacer")
          end

          exchange_minister = fetch_liturgical_text("evening_1_conclusion_peace_exchange_minister")
          if exchange_minister
            lines << line_item(exchange_minister.content, type: "leader", slug: exchange_minister.slug)
          end

          exchange_all = fetch_liturgical_text("evening_1_conclusion_peace_exchange_all")
          if exchange_all
            lines << line_item(exchange_all.content, type: "congregation", slug: exchange_all.slug)
          end

          # Optional final words
          final_rubric = fetch_liturgical_text("evening_1_conclusion_final_rubric")
          if final_rubric
            lines << line_item("", type: "spacer")
            lines << line_item(final_rubric.content, type: "rubric", slug: final_rubric.slug)
          end

          final = fetch_liturgical_text("evening_1_conclusion_final_minister")
          if final
            lines << line_item(final.content, type: "leader", slug: final.slug)
          end
        end
      end
    end
  end
end
