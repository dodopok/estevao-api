# frozen_string_literal: true

module DailyOffice
  module Builders
    module Locb2008
      # LOCB 2008 Morning Prayer Rite Two (Oração Matutina II)
      #
      # This builder follows the traditional structure from the
      # Livro de Oração Comum Brasileiro 2008, pages 35-42.
      #
      # Structure:
      # 1. Acolhida (Welcome)
      # 2. Convite à Adoração (Invitation to Worship - seasonal)
      # 3. Convite à Confissão (Invitation to Confession)
      # 4. Confissão (Confession)
      # 5. Declaração de Perdão (Absolution)
      # 6. Oração do Senhor (Lord's Prayer - first occurrence)
      # 7. Responso (Response)
      # 8. Venite (Psalm 95)
      # 9. Salmodia (Psalms)
      # 10. Leitura do Antigo Testamento (OT Reading)
      # 11. Te Deum Laudamus
      # 12. Leitura do Novo Testamento (NT Reading)
      # 13. Sermão (Sermon)
      # 14. Benedictus ou Jubilate Deo (Gospel Canticle)
      # 15. O Credo dos Apóstolos (Creed)
      # 16. Orações e Kyrie (Prayers)
      # 17. Pai Nosso (Lord's Prayer - second occurrence)
      # 18. Sufrágio (Suffrage)
      # 19. A Coleta do Dia (Collect of the Day)
      # 20. A Coleta pela Paz (Collect for Peace)
      # 21. A Coleta pela Graça (Collect for Grace)
      # 22. Hino (Hymn)
      # 23. Outras Orações (Other Prayers - optional)
      # 24. Conclusão (Conclusion)
      #
      class MorningRiteTwo < Base
        private

        def assemble_office
          assemble_morning_prayer
        end

        def assemble_morning_prayer
          [
            build_welcome,
            build_invitation,
            build_confession,
            build_absolution,
            build_morning_prayer_section,
            build_response,
            build_venite,
            build_psalms,
            build_ot_reading,
            build_te_deum,
            build_nt_reading,
            build_sermon,
            build_canticle_post_reading,
            build_creed,
            build_prayers,
            build_collect_of_the_day,
            build_collect_peace,
            build_collect_grace,
            build_hymn,
            build_other_prayers,
            build_conclusion
          ].flatten.compact
        end

        # ============================================================================
        # SECTION: Opening Components
        # ============================================================================

        # ACOLHIDA - Welcome
        def build_welcome
          {
            name: "Acolhida",
            slug: "welcome",
            lines: []
          }
        end

        # CONVITE À ADORAÇÃO - Invitation to Worship (seasonal)
        def build_invitation
          lines = []

          # Rubric
          rubric = fetch_liturgical_text("morning_2_invitation_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Get season-specific invitation
          invitation = fetch_liturgical_text(season_specific_invitation_slug)
          if invitation
            lines << line_item(invitation.content, type: "leader", slug: invitation.slug)
            lines << line_item("", type: "spacer")
          end

          {
            name: "Convite à Adoração",
            slug: "invitation",
            lines: lines
          }
        end

        # CONVITE À CONFISSÃO E CONFISSÃO - Invitation to Confession and Confession
        def build_confession
          lines = []

          # Resolve confession invitation option (1, 2, or random)
          option = resolve_preference(:morning_2_confession_invitation, 1..2) || 1

          invitation = fetch_liturgical_text("morning_2_confession_invitation_#{option}_minister")
          if invitation
            lines << line_item(invitation.content, type: "leader", slug: invitation.slug)
            lines << line_item("", type: "spacer")
          end

          # Silence rubric
          silence = fetch_liturgical_text("morning_2_confession_silence")
          if silence
            lines << line_item(silence.content, type: "rubric", slug: silence.slug)
            lines << line_item("", type: "spacer")
          end

          # Confession prayer
          confession = fetch_liturgical_text("morning_2_confession_prayer_all")
          if confession
            lines << line_item(confession.content, type: "congregation", slug: confession.slug)
            lines << line_item("", type: "spacer")
          end

          {
            name: "Confissão de Pecados",
            slug: "confession",
            lines: lines
          }
        end

        # DECLARAÇÃO DE PERDÃO - Absolution
        def build_absolution
          lines = []

          absolution = fetch_liturgical_text("morning_2_absolution_minister")
          if absolution
            lines << line_item(absolution.content, type: "leader", slug: absolution.slug)
          end

          absolution_all = fetch_liturgical_text("morning_2_absolution_all")
          if absolution_all
            lines << line_item(absolution_all.content, type: "congregation", slug: absolution_all.slug)
            lines << line_item("", type: "spacer")
          end

          # Alternative for local ministers (rubric)
          local_rubric = fetch_liturgical_text("morning_2_absolution_local_rubric")
          if local_rubric
            lines << line_item(local_rubric.content, type: "rubric", slug: local_rubric.slug)
            lines << line_item("", type: "spacer")
          end

          local_absolution = fetch_liturgical_text("morning_2_absolution_local_minister")
          if local_absolution
            lines << line_item(local_absolution.content, type: "leader", slug: local_absolution.slug)
          end

          local_all = fetch_liturgical_text("morning_2_absolution_local_all")
          if local_all
            lines << line_item(local_all.content, type: "congregation", slug: local_all.slug)
          end

          {
            name: "Declaração de Perdão",
            slug: "absolution",
            lines: lines
          }
        end

        # ORAÇÃO MATUTINA - Morning Prayer Section Header
        def build_morning_prayer_section
          lines = []

          rubric = fetch_liturgical_text("morning_2_morning_prayer_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
          end

          {
            name: "Oração Matutina",
            type: "main_part",
            slug: "morning_prayer_section",
            lines: lines
          }
        end

        # RESPONSO - Response
        def build_response
          lines = []

          # Response 1: Ó Senhor, abre os meus lábios...
          response_1_minister = fetch_liturgical_text("morning_2_response_1_minister")
          if response_1_minister
            lines << line_item(response_1_minister.content, type: "leader", slug: response_1_minister.slug)
          end

          response_1_all = fetch_liturgical_text("morning_2_response_1_all")
          if response_1_all
            lines << line_item(response_1_all.content, type: "congregation", slug: response_1_all.slug)
          end

          # Response 2: Ó Deus, apressa-te em nos salvar...
          response_2_minister = fetch_liturgical_text("morning_2_response_2_minister")
          if response_2_minister
            lines << line_item(response_2_minister.content, type: "leader", slug: response_2_minister.slug)
          end

          response_2_all = fetch_liturgical_text("morning_2_response_2_all")
          if response_2_all
            lines << line_item(response_2_all.content, type: "congregation", slug: response_2_all.slug)
          end

          # Response 3: Glória ao Pai...
          response_3_minister = fetch_liturgical_text("morning_2_response_3_minister")
          if response_3_minister
            lines << line_item(response_3_minister.content, type: "leader", slug: response_3_minister.slug)
          end

          response_3_all = fetch_liturgical_text("morning_2_response_3_all")
          if response_3_all
            lines << line_item(response_3_all.content, type: "congregation", slug: response_3_all.slug)
          end

          # Response 4: Louvemos ao Senhor...
          response_4_minister = fetch_liturgical_text("morning_2_response_4_minister")
          if response_4_minister
            lines << line_item(response_4_minister.content, type: "leader", slug: response_4_minister.slug)
          end

          response_4_all = fetch_liturgical_text("morning_2_response_4_all")
          if response_4_all
            lines << line_item(response_4_all.content, type: "congregation", slug: response_4_all.slug)
          end

          {
            name: "Responso",
            slug: "response",
            lines: lines
          }
        end

        # VENITE - Psalm 95
        def build_venite
          lines = []

          # Title
          title = fetch_liturgical_text("morning_2_venite_title")
          if title
            lines << line_item(title.title, slug: title.slug)
            lines << line_item("", type: "spacer")
          end

          # Venite text
          venite = fetch_liturgical_text("morning_2_venite")
          if venite
            lines << line_item(venite.content, slug: venite.slug)
            lines << line_item("", type: "spacer")
          end

          # Gloria Patri
          gloria_minister = fetch_liturgical_text("morning_2_venite_gloria_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("morning_2_venite_gloria_all")
          if gloria_all
            lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
          end

          {
            name: "Venite",
            slug: "venite",
            lines: lines
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
          rubric = fetch_liturgical_text("morning_2_psalms_rubric")
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
          gloria_minister = fetch_liturgical_text("morning_2_psalms_gloria_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("morning_2_psalms_gloria_all")
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

        # LEITURA DO ANTIGO TESTAMENTO - Old Testament Reading
        def build_ot_reading
          lines = []

          if readings[:first_reading]
            lines << line_item(readings[:first_reading][:reference])
            lines << line_item("", type: "spacer")

            if readings[:first_reading][:content]
              lines.concat(format_bible_content(readings[:first_reading][:content]))
              lines << line_item("", type: "spacer")
            end
          end

          {
            name: "Leitura do Antigo Testamento",
            slug: "ot_reading",
            lines: lines
          }
        end

        # TE DEUM LAUDAMUS
        def build_te_deum
          lines = []

          # Rubric
          rubric = fetch_liturgical_text("morning_2_te_deum_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Te Deum text
          te_deum = fetch_liturgical_text("morning_2_te_deum")
          if te_deum
            lines << line_item(te_deum.content, slug: te_deum.slug)
          end

          {
            name: "Te Deum Laudamus",
            slug: "te_deum",
            lines: lines
          }
        end

        # LEITURA DO NOVO TESTAMENTO - New Testament Reading
        def build_nt_reading
          lines = []

          if readings[:second_reading]
            lines << line_item(readings[:second_reading][:reference])
            lines << line_item("", type: "spacer")

            if readings[:second_reading][:content]
              lines.concat(format_bible_content(readings[:second_reading][:content]))
              lines << line_item("", type: "spacer")
            end
          end

          {
            name: "Leitura do Novo Testamento",
            slug: "nt_reading",
            lines: lines
          }
        end

        # SERMÃO - Sermon
        def build_sermon
          {
            name: "Sermão",
            slug: "sermon",
            lines: []
          }
        end

        # ============================================================================
        # SECTION: Gospel Canticle - Benedictus or Jubilate Deo
        # ============================================================================

        # CÂNTICO EVANGÉLICO - Benedictus or Jubilate Deo (based on preference)
        def build_canticle_post_reading
          lines = []

          # Resolve canticle preference (benedictus, jubilate_deo, random, or all)
          canticle_type = resolve_canticle_post_reading

          case canticle_type
          when :benedictus
            build_benedictus_canticle(lines)
          when :jubilate_deo
            build_jubilate_canticle(lines)
          when :all
            build_benedictus_canticle(lines)
            lines << line_item("", type: "spacer")
            build_jubilate_canticle(lines)
          else
            build_benedictus_canticle(lines)
          end

          {
            name: "Cântico Evangélico",
            slug: "canticle_post_reading",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Creed
        # ============================================================================

        # O CREDO DOS APÓSTOLOS - Creed
        def build_creed
          lines = []

          creed = fetch_liturgical_text("morning_2_creed_all")
          return nil unless creed

          lines << line_item(creed.content, type: "congregation", slug: creed.slug)

          {
            name: "O Credo dos Apóstolos",
            slug: "creed",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Prayers
        # ============================================================================

        # ORAÇÕES - Prayers
        def build_prayers
          lines = []

          # The Lord be with you
          prayers_1_minister = fetch_liturgical_text("morning_2_prayers_1_minister")
          if prayers_1_minister
            lines << line_item(prayers_1_minister.content, type: "leader", slug: prayers_1_minister.slug)
          end

          prayers_1_all = fetch_liturgical_text("morning_2_prayers_1_all")
          if prayers_1_all
            lines << line_item(prayers_1_all.content, type: "congregation", slug: prayers_1_all.slug)
            lines << line_item("", type: "spacer")
          end

          # Kyrie 1
          prayers_2_minister = fetch_liturgical_text("morning_2_prayers_2_minister")
          if prayers_2_minister
            lines << line_item(prayers_2_minister.content, type: "leader", slug: prayers_2_minister.slug)
          end

          prayers_2_all = fetch_liturgical_text("morning_2_prayers_2_all")
          if prayers_2_all
            lines << line_item(prayers_2_all.content, type: "congregation", slug: prayers_2_all.slug)
          end

          # Kyrie 2
          prayers_3_minister = fetch_liturgical_text("morning_2_prayers_3_minister")
          if prayers_3_minister
            lines << line_item(prayers_3_minister.content, type: "leader", slug: prayers_3_minister.slug)
            lines << line_item("", type: "spacer")
          end

          lords_prayer = fetch_liturgical_text("morning_2_lords_prayer_all")
          if lords_prayer
            lines << line_item(lords_prayer.content, type: "congregation", slug: lords_prayer.slug)
            lines << line_item("", type: "spacer")
          end

          # Post Lord's Prayer
          prayers_4_minister = fetch_liturgical_text("morning_2_prayers_4_minister")
          if prayers_4_minister
            lines << line_item(prayers_4_minister.content, type: "leader", slug: prayers_4_minister.slug)
          end

          prayers_4_all = fetch_liturgical_text("morning_2_prayers_4_all")
          if prayers_4_all
            lines << line_item(prayers_4_all.content, type: "congregation", slug: prayers_4_all.slug)
          end

          (1..5).each do |i|
            minister = fetch_liturgical_text("morning_2_suffrage_#{i}_minister")
            if minister
              lines << line_item(minister.content, type: "leader", slug: minister.slug)
            end

            all = fetch_liturgical_text("morning_2_suffrage_#{i}_all")
            if all
              lines << line_item(all.content, type: "congregation", slug: all.slug)
            end
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

          # Rubric for collect
          rubric = fetch_liturgical_text("morning_2_collect_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Collect of the Day (from CollectService)
          if @collects
            lines << line_item(@collects)
            lines << line_item("", type: "spacer")
          end

          {
            name: "A Coleta do Dia",
            slug: "collect_of_the_day",
            lines: lines
          }
        end

        # A COLETA PELA PAZ - Collect for Peace
        def build_collect_peace
          lines = []

          collect = fetch_liturgical_text("morning_2_collect_peace")
          if collect
            lines << line_item(collect.content, type: "leader", slug: collect.slug)
          end

          {
            name: "A Coleta pela Paz",
            slug: "collect_peace",
            lines: lines
          }
        end

        # A COLETA PELA GRAÇA - Collect for Grace
        def build_collect_grace
          lines = []

          collect = fetch_liturgical_text("morning_2_collect_grace")
          if collect
            lines << line_item(collect.content, type: "leader", slug: collect.slug)
          end

          {
            name: "A Coleta pela Graça",
            slug: "collect_grace",
            lines: lines
          }
        end

        # HINO - Hymn
        def build_hymn
          {
            name: "Hino",
            slug: "hymn",
            lines: []
          }
        end

        # OUTRAS ORAÇÕES - Other Prayers (optional)
        def build_other_prayers
          lines = []

          rubric = fetch_liturgical_text("morning_2_other_prayers_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
          end

          {
            name: "Outras Orações",
            slug: "other_prayers",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Conclusion
        # ============================================================================

        # CONCLUSÃO - Conclusion (Grace or Dismissal)
        def build_conclusion
          lines = []

          # Determine which conclusion type to use (based on preference or default to grace)
          conclusion_type = resolve_conclusion_type

          case conclusion_type
          when :grace
            build_grace_conclusion(lines)
          when :dismissal
            build_dismissal_conclusion(lines)
          else
            build_grace_conclusion(lines)
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

        # Determine the season-specific invitation slug
        def season_specific_invitation_slug
          season = day_info[:liturgical_season]
          celebration = day_info[:celebration]

          # Check for specific celebrations first
          if celebration&.downcase&.include?("sexta-feira santa")
            return "morning_2_invitation_good_friday"
          elsif celebration&.downcase&.include?("vigília pascal")
            return "morning_2_invitation_easter_vigil"
          elsif celebration&.downcase&.include?("ascensão")
            return "morning_2_invitation_ascension"
          elsif celebration&.downcase&.include?("trindade")
            return "morning_2_invitation_trinity"
          end

          case season&.downcase
          when "advento"
            "morning_2_invitation_advent"
          when "natal"
            "morning_2_invitation_christmas"
          when "epifania"
            "morning_2_invitation_epiphany"
          when "quaresma"
            select_penitential_invitation
          when "semana santa"
            "morning_2_invitation_holy_week"
          when "páscoa"
            "morning_2_invitation_easter"
          when "pentecostes"
            "morning_2_invitation_pentecost"
          else
            # General - pick one of the two general invitations using seeded random
            general_options = [ "morning_2_invitation_general_1", "morning_2_invitation_general_2" ]
            general_options[seeded_random(0...general_options.length, key: :morning_2_invitation_general)]
          end
        end

        # Select a penitential invitation using seeded random
        def select_penitential_invitation
          penitential_options = (1..10).map { |i| "morning_2_invitation_penitential_#{i}" }
          penitential_options[seeded_random(0...penitential_options.length, key: :morning_2_invitation_penitential)]
        end

        # Resolve canticle post reading from preferences
        def resolve_canticle_post_reading
          result = resolve_preference(:morning_2_canticle_post_reading, [ "benedictus", "jubilate_deo" ])
          result&.to_sym || :benedictus
        end

        # Build Benedictus canticle
        def build_benedictus_canticle(lines)
          # Rubric
          rubric = fetch_liturgical_text("morning_2_benedictus_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Benedictus text
          benedictus = fetch_liturgical_text("morning_2_benedictus")
          if benedictus
            lines << line_item(benedictus.content, slug: benedictus.slug)
            lines << line_item("", type: "spacer")
          end

          # Gloria Patri
          gloria_minister = fetch_liturgical_text("morning_2_benedictus_gloria_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("morning_2_benedictus_gloria_all")
          if gloria_all
            lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
          end
        end

        # Build Jubilate Deo canticle
        def build_jubilate_canticle(lines)
          # Rubric
          rubric = fetch_liturgical_text("morning_2_jubilate_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Jubilate text
          jubilate = fetch_liturgical_text("morning_2_jubilate")
          if jubilate
            lines << line_item(jubilate.content, slug: jubilate.slug)
            lines << line_item("", type: "spacer")
          end

          # Gloria Patri (using psalms gloria)
          gloria_minister = fetch_liturgical_text("morning_2_psalms_gloria_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("morning_2_psalms_gloria_all")
          if gloria_all
            lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
          end
        end

        # Resolve conclusion type from preferences
        def resolve_conclusion_type
          result = resolve_preference(:morning_2_conclusion, [ "grace", "dismissal" ])
          result&.to_sym || :grace
        end

        # Build grace conclusion
        def build_grace_conclusion(lines)
          grace = fetch_liturgical_text("morning_2_conclusion_grace_minister")
          if grace
            lines << line_item(grace.content, type: "leader", slug: grace.slug)
          end

          grace_all = fetch_liturgical_text("morning_2_conclusion_grace_all")
          if grace_all
            lines << line_item(grace_all.content, type: "congregation", slug: grace_all.slug)
          end
        end

        # Build dismissal conclusion
        def build_dismissal_conclusion(lines)
          dismissal = fetch_liturgical_text("morning_2_conclusion_dismissal_minister")
          if dismissal
            lines << line_item(dismissal.content, type: "leader", slug: dismissal.slug)
          end

          dismissal_people = fetch_liturgical_text("morning_2_conclusion_dismissal_people")
          if dismissal_people
            lines << line_item(dismissal_people.content, type: "congregation", slug: dismissal_people.slug)
          end

          dismissal_all = fetch_liturgical_text("morning_2_conclusion_dismissal_all")
          if dismissal_all
            lines << line_item(dismissal_all.content, type: "congregation", slug: dismissal_all.slug)
          end
        end
      end
    end
  end
end
