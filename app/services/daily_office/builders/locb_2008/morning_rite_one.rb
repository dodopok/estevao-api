# frozen_string_literal: true

module DailyOffice
  module Builders
    module Locb2008
      # LOCB 2008 Morning Prayer Rite One (Oração Matutina I)
      #
      # This builder follows the traditional structure from the
      # Livro de Oração Comum Brasileiro 2008, pages 25-33.
      #
      # Structure:
      # 1. Preparação (Preparation/Greeting)
      # 2. Acolhida (Welcome)
      # 3. Confissão de Pecados (Confession)
      # 4. Ação de Graças (Thanksgiving)
      # 5. Breve Reflexão (Brief Reflection)
      # 6. Salmodia (Psalms)
      # 7. Cântico do Antigo Testamento (OT Canticle - seasonal)
      # 8. Leituras das Escrituras (Scripture Readings)
      # 9. Responso (Response)
      # 10. Cântico Evangélico - Benedictus (Gospel Canticle)
      # 11. O Credo (Creed)
      # 12. Orações/Intercessões (Prayers/Intercessions)
      # 13. A Coleta do Dia (Collect of the Day)
      # 14. A Oração do Senhor (Lord's Prayer)
      # 15. Conclusão (Conclusion/Blessing)
      #
      class MorningRiteOne < Base
        private

        def assemble_office
          assemble_morning_prayer
        end

        def assemble_morning_prayer
          [
            build_preparation,
            build_welcome,
            build_confession,
            build_thanksgiving,
            build_reflection,
            build_word_of_god,
            build_psalms,
            build_ot_canticle,
            build_readings,
            build_hymn,
            build_response,
            build_benedictus,
            build_sermon,
            build_creed,
            build_prayers,
            build_intercessions,
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
          option = resolve_preference(:morning_1_preparation, 1..2) || 1

          greeting_minister = fetch_liturgical_text("morning_1_preparation_#{option}_greeting_minister")
          if greeting_minister
            lines << line_item(greeting_minister.content, type: "leader", slug: greeting_minister.slug)
          end

          greeting_all = fetch_liturgical_text("morning_1_preparation_#{option}_greeting_all")
          if greeting_all
            lines << line_item(greeting_all.content, type: "congregation", slug: greeting_all.slug)
            lines << line_item("", type: "spacer")
          end

          opening_minister = fetch_liturgical_text("morning_1_preparation_#{option}_opening_minister")
          if opening_minister
            lines << line_item(opening_minister.content, type: "leader", slug: opening_minister.slug)
          end

          opening_all = fetch_liturgical_text("morning_1_preparation_#{option}_opening_all")
          if opening_all
            lines << line_item(opening_all.content, type: "congregation", slug: opening_all.slug)
          end

          {
            name: "Preparação",
            type: "main_part",
            slug: "preparation",
            lines: lines
          }
        end

        # ACOLHIDA - Welcome
        def build_welcome
          welcome = fetch_liturgical_text("morning_1_welcome_minister")
          return nil unless welcome

          {
            name: "Acolhida",
            slug: "welcome",
            lines: [
              line_item(welcome.content, type: "leader", slug: welcome.slug)
            ]
          }
        end

        # CONFISSÃO DE PECADOS - Confession
        def build_confession
          lines = []

          # Invitation to confession
          invitation = fetch_liturgical_text("morning_1_confession_invitation_minister")
          if invitation
            lines << line_item(invitation.content, type: "leader", slug: invitation.slug)
            lines << line_item("", type: "spacer")
          end

          # Silence rubric
          silence = fetch_liturgical_text("morning_1_confession_silence")
          if silence
            lines << line_item(silence.content, type: "rubric", slug: silence.slug)
            lines << line_item("", type: "spacer")
          end

          # Confession prayer
          confession = fetch_liturgical_text("morning_1_confession_prayer_all")
          if confession
            lines << line_item(confession.content, type: "congregation", slug: confession.slug)
            lines << line_item("", type: "spacer")
          end

          # Absolution/Declaration of Pardon
          absolution = fetch_liturgical_text("morning_1_confession_absolution_minister")
          if absolution
            lines << line_item(absolution.content, type: "leader", slug: absolution.slug)
          end

          absolution_all = fetch_liturgical_text("morning_1_confession_absolution_all")
          if absolution_all
            lines << line_item(absolution_all.content, type: "congregation", slug: absolution_all.slug)
          end

          # Blessed be the Lord
          blessed_minister = fetch_liturgical_text("morning_1_thanksgiving_blessed_minister")
          if blessed_minister
            lines << line_item(blessed_minister.content, type: "leader", slug: blessed_minister.slug)
          end

          blessed_all = fetch_liturgical_text("morning_1_thanksgiving_blessed_all")
          if blessed_all
            lines << line_item(blessed_all.content, type: "congregation", slug: blessed_all.slug)
          end

          # Hearts full of joy
          hearts_minister = fetch_liturgical_text("morning_1_thanksgiving_hearts_minister")
          if hearts_minister
            lines << line_item(hearts_minister.content, type: "leader", slug: hearts_minister.slug)
          end

          hearts_all = fetch_liturgical_text("morning_1_thanksgiving_hearts_all")
          if hearts_all
            lines << line_item(hearts_all.content, type: "congregation", slug: hearts_all.slug)
            lines << line_item("", type: "spacer")
          end

          {
            name: "Confissão de Pecados",
            slug: "confession",
            lines: lines
          }
        end

        # AÇÃO DE GRAÇAS - Thanksgiving
        def build_thanksgiving
          lines = []

          # Optional thanksgiving prayer (rubric)
          rubric = fetch_liturgical_text("morning_1_thanksgiving_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Thanksgiving prayer (optional)
          prayer = fetch_liturgical_text("morning_1_thanksgiving_prayer_minister")
          if prayer
            lines << line_item(prayer.content, type: "leader", slug: prayer.slug)
          end

          prayer_all = fetch_liturgical_text("morning_1_thanksgiving_prayer_all")
          if prayer_all
            lines << line_item(prayer_all.content, type: "congregation", slug: prayer_all.slug)
          end

          {
            name: "Oração de Ação de Graças",
            slug: "thanksgiving",
            lines: lines
          }
        end

        # BREVE REFLEXÃO - Brief Reflection
        def build_reflection
          lines = []

          reflection = fetch_liturgical_text("morning_1_reflection_minister")
          if reflection
            lines << line_item(reflection.content, type: "leader", slug: reflection.slug)
            lines << line_item("", type: "spacer")
          end

          silence = fetch_liturgical_text("morning_1_reflection_silence")
          if silence
            lines << line_item(silence.content, type: "rubric", slug: silence.slug)
            lines << line_item("", type: "spacer")
          end

          prayer = fetch_liturgical_text("morning_1_reflection_prayer_minister")
          if prayer
            lines << line_item(prayer.content, type: "leader", slug: prayer.slug)
          end

          prayer_all = fetch_liturgical_text("morning_1_reflection_prayer_all")
          if prayer_all
            lines << line_item(prayer_all.content, type: "congregation", slug: prayer_all.slug)
          end

          {
            name: "Breve Reflexão",
            slug: "reflection",
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
          rubric = fetch_liturgical_text("morning_1_psalms_rubric")
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
          gloria_minister = fetch_liturgical_text("morning_1_psalms_gloria_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("morning_1_psalms_gloria_all")
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
        # SECTION: Old Testament Canticle (Seasonal)
        # ============================================================================

        # CÂNTICO DO ANTIGO TESTAMENTO - Old Testament Canticle (seasonal)
        def build_ot_canticle
          canticle_slug = season_specific_ot_canticle_slug
          canticle = fetch_liturgical_text(canticle_slug)
          return nil unless canticle

          lines = []

          lines << line_item(canticle.content, slug: canticle.slug)
          lines << line_item("", type: "spacer")

          # Gloria Patri after canticle
          gloria_minister = fetch_liturgical_text("morning_1_psalms_gloria_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("morning_1_psalms_gloria_all")
          if gloria_all
            lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
          end

          {
            name: "Cântico do Antigo Testamento",
            slug: "ot_canticle",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Scripture Readings
        # ============================================================================

        # LEITURAS DAS ESCRITURAS - Scripture Readings
        def build_readings
          lines = []

          # Readings rubric
          rubric = fetch_liturgical_text("morning_1_readings_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # First reading
          if readings[:first_reading]
            lines << line_item(readings[:first_reading][:reference], type: "heading")
            lines << line_item("", type: "spacer")

            if readings[:first_reading][:content]
              lines.concat(format_bible_content(readings[:first_reading][:content]))
              lines << line_item("", type: "spacer")
            end

            # Response after reading
            response_reader = fetch_liturgical_text("morning_1_readings_response_reader")
            if response_reader
              lines << line_item(response_reader.content, type: "reader", slug: response_reader.slug)
            end

            response_all = fetch_liturgical_text("morning_1_readings_response_all")
            if response_all
              lines << line_item(response_all.content, type: "congregation", slug: response_all.slug)
              lines << line_item("", type: "spacer")
            end
          end

          {
            name: "Leituras das Escrituras",
            slug: "readings",
            lines: lines
          }
        end

        def build_hymn
          {
            name: "Hino",
            slug: "hymn",
            lines: []
          }
        end

        # ============================================================================
        # SECTION: Response
        # ============================================================================

        # RESPONSO - Response
        def build_response
          lines = []

          # Awake response
          awake_minister = fetch_liturgical_text("morning_1_response_awake_minister")
          if awake_minister
            lines << line_item(awake_minister.content, type: "leader", slug: awake_minister.slug)
          end

          awake_all = fetch_liturgical_text("morning_1_response_awake_all")
          if awake_all
            lines << line_item(awake_all.content, type: "congregation", slug: awake_all.slug)
          end

          # Dead response
          dead_minister = fetch_liturgical_text("morning_1_response_dead_minister")
          if dead_minister
            lines << line_item(dead_minister.content, type: "leader", slug: dead_minister.slug)
          end

          dead_all = fetch_liturgical_text("morning_1_response_dead_all")
          if dead_all
            lines << line_item(dead_all.content, type: "congregation", slug: dead_all.slug)
          end

          # Above response
          above_minister = fetch_liturgical_text("morning_1_response_above_minister")
          if above_minister
            lines << line_item(above_minister.content, type: "leader", slug: above_minister.slug)
          end

          above_all = fetch_liturgical_text("morning_1_response_above_all")
          if above_all
            lines << line_item(above_all.content, type: "congregation", slug: above_all.slug)
          end

          # Manifest response
          manifest_minister = fetch_liturgical_text("morning_1_response_manifest_minister")
          if manifest_minister
            lines << line_item(manifest_minister.content, type: "leader", slug: manifest_minister.slug)
          end

          manifest_all = fetch_liturgical_text("morning_1_response_manifest_all")
          if manifest_all
            lines << line_item(manifest_all.content, type: "congregation", slug: manifest_all.slug)
          end

          {
            name: "Responso",
            slug: "response",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Gospel Canticle - Benedictus
        # ============================================================================

        # CÂNTICO EVANGÉLICO - Benedictus
        def build_benedictus
          lines = []

          # Title/rubric
          title = fetch_liturgical_text("morning_1_benedictus_title")
          if title
            lines << line_item(title.content, type: "rubric", slug: title.slug)
            lines << line_item("", type: "spacer")
          end

          # Benedictus text
          benedictus = fetch_liturgical_text("morning_1_benedictus")
          if benedictus
            lines << line_item(benedictus.content, slug: benedictus.slug)
            lines << line_item("", type: "spacer")
          end

          # Gloria at end
          gloria_rubric = fetch_liturgical_text("morning_1_benedictus_gloria")
          if gloria_rubric
            lines << line_item(gloria_rubric.content, type: "rubric", slug: gloria_rubric.slug)
          end

          # Full Gloria Patri
          gloria_minister = fetch_liturgical_text("morning_1_psalms_gloria_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("morning_1_psalms_gloria_all")
          if gloria_all
            lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
          end

          {
            name: "Cântico Evangélico",
            slug: "benedictus",
            lines: lines
          }
        end

        def build_sermon
          {
            name: "Sermão",
            slug: "sermon",
            lines: []
          }
        end

        # ============================================================================
        # SECTION: Creed
        # ============================================================================

        # O CREDO - Creed
        def build_creed
          lines = []

          # Rubric
          rubric = fetch_liturgical_text("morning_1_creed_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Apostles' Creed
          creed = fetch_liturgical_text("morning_1_creed_all")
          return nil unless creed

          lines << line_item(creed.content, type: "congregation", slug: creed.slug)

          {
            name: "O Credo",
            slug: "creed",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Prayers
        # ============================================================================

        # Orações
        def build_prayers
          {
            name: "Orações",
            slug: "prayers",
            lines: []
          }
        end

        # Intercessões
        def build_intercessions
          lines = []

          {
            name: "Intercessões",
            slug: "intercessions",
            lines: []
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

        # CONCLUSÃO - Conclusion (Blessing/Grace/Peace/Dismissal)
        def build_conclusion
          lines = []

          # Determine which conclusion type to use (based on preference or default to blessing)
          conclusion_type = resolve_conclusion_type

          case conclusion_type
          when :blessing
            build_blessing_conclusion(lines)
          when :grace
            build_grace_conclusion(lines)
          when :peace
            build_peace_conclusion(lines)
          when :dismissal
            build_dismissal_conclusion(lines)
          else
            build_blessing_conclusion(lines)
          end

          {
            name: "Conclusão",
            slug: "conclusion",
            lines: lines
          }
        end

        private

        # ============================================================================
        # SECTION: Helper Methods
        # ============================================================================

        # Determine the season-specific OT canticle slug
        def season_specific_ot_canticle_slug
          season = day_info[:liturgical_season]

          case season&.downcase
          when "advento"
            "morning_1_ot_canticle_advent"
          when "natal"
            "morning_1_ot_canticle_christmas"
          when "epifania"
            "morning_1_ot_canticle_epiphany"
          when "quaresma", "semana santa"
            "morning_1_ot_canticle_lent"
          when "páscoa"
            "morning_1_ot_canticle_easter"
          when "pentecostes"
            "morning_1_ot_canticle_pentecost"
          else
            "morning_1_ot_canticle_ordinary"
          end
        end

        # Resolve conclusion type from preferences
        def resolve_conclusion_type
          pref_value = preferences[:morning_1_conclusion_type]

          case pref_value&.to_s
          when "grace" then :grace
          when "peace" then :peace
          when "dismissal" then :dismissal
          else :blessing
          end
        end

        # Build blessing conclusion
        def build_blessing_conclusion(lines)
          blessing = fetch_liturgical_text("morning_1_conclusion_blessing_minister")
          if blessing
            lines << line_item(blessing.content, type: "leader", slug: blessing.slug)
          end

          blessing_all = fetch_liturgical_text("morning_1_conclusion_blessing_all")
          if blessing_all
            lines << line_item(blessing_all.content, type: "congregation", slug: blessing_all.slug)
            lines << line_item("", type: "spacer")
          end

          praise_minister = fetch_liturgical_text("morning_1_conclusion_blessing_praise_minister")
          if praise_minister
            lines << line_item(praise_minister.content, type: "leader", slug: praise_minister.slug)
          end

          praise_all = fetch_liturgical_text("morning_1_conclusion_blessing_praise_all")
          if praise_all
            lines << line_item(praise_all.content, type: "congregation", slug: praise_all.slug)
          end
        end

        # Build grace conclusion
        def build_grace_conclusion(lines)
          grace = fetch_liturgical_text("morning_1_conclusion_grace_minister")
          if grace
            lines << line_item(grace.content, type: "leader", slug: grace.slug)
          end

          grace_all = fetch_liturgical_text("morning_1_conclusion_grace_all")
          if grace_all
            lines << line_item(grace_all.content, type: "congregation", slug: grace_all.slug)
          end
        end

        # Build peace conclusion
        def build_peace_conclusion(lines)
          peace = fetch_liturgical_text("morning_1_conclusion_peace_minister")
          if peace
            lines << line_item(peace.content, type: "leader", slug: peace.slug)
          end

          peace_all = fetch_liturgical_text("morning_1_conclusion_peace_all")
          if peace_all
            lines << line_item(peace_all.content, type: "congregation", slug: peace_all.slug)
            lines << line_item("", type: "spacer")
          end

          exchange_minister = fetch_liturgical_text("morning_1_conclusion_peace_exchange_minister")
          if exchange_minister
            lines << line_item(exchange_minister.content, type: "leader", slug: exchange_minister.slug)
          end

          exchange_all = fetch_liturgical_text("morning_1_conclusion_peace_exchange_all")
          if exchange_all
            lines << line_item(exchange_all.content, type: "congregation", slug: exchange_all.slug)
            lines << line_item("", type: "spacer")
          end

          exchange_2 = fetch_liturgical_text("morning_1_conclusion_peace_exchange_minister_2")
          if exchange_2
            lines << line_item(exchange_2.content, type: "leader", slug: exchange_2.slug)
          end
        end

        # Build dismissal conclusion
        def build_dismissal_conclusion(lines)
          dismissal = fetch_liturgical_text("morning_1_conclusion_dismissal_minister")
          if dismissal
            lines << line_item(dismissal.content, type: "leader", slug: dismissal.slug)
          end

          dismissal_people = fetch_liturgical_text("morning_1_conclusion_dismissal_people")
          if dismissal_people
            lines << line_item(dismissal_people.content, type: "congregation", slug: dismissal_people.slug)
          end

          dismissal_all = fetch_liturgical_text("morning_1_conclusion_dismissal_all")
          if dismissal_all
            lines << line_item(dismissal_all.content, type: "congregation", slug: dismissal_all.slug)
          end
        end
      end
    end
  end
end
