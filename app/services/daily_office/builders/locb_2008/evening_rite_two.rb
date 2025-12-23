# frozen_string_literal: true

module DailyOffice
  module Builders
    module Locb2008
      # LOCB 2008 Evening Prayer Rite Two (Oração Vespertina II)
      #
      # This builder follows the traditional structure from the
      # Livro de Oração Comum Brasileiro 2008, pages 75-80.
      #
      # Structure:
      # 1. Introdução (Introduction)
      # 2. Convite à Confissão (Invitation to Confession)
      # 3. Confissão (Confession)
      # 4. Declaração de Perdão (Absolution)
      # 5. Oração Vespertina - Responsos (Evening Prayer Response)
      # 6. Salmodia (Psalms)
      # 7. Leitura do Antigo Testamento (OT Reading)
      # 8. Magnificat ou Cantate Domino (Gospel Canticle)
      # 9. Leitura do Novo Testamento (NT Reading)
      # 10. Nunc dimittis ou Deus misereatur (Gospel Canticle)
      # 11. Afirmação de Fé (Creed)
      # 12. Orações e Kyrie (Prayers)
      # 13. Pai Nosso (Lord's Prayer)
      # 14. Sufrágio (Suffrage)
      # 15. A Coleta do Dia (Collect of the Day)
      # 16. A Coleta pela Paz (Collect for Peace)
      # 17. A Coleta contra os Perigos (Collect against Dangers)
      # 18. Hino (Hymn)
      # 19. Sermão (Sermon)
      # 20. Outras Orações (Other Prayers - optional)
      # 21. Conclusão (Conclusion)
      #
      class EveningRiteTwo < Base
        private

        def assemble_office
          assemble_evening_prayer
        end

        def assemble_evening_prayer
          [
            build_introduction,
            build_evening_prayer_section,
            build_response,
            build_psalms,
            build_ot_reading,
            build_canticle_post_first_reading,
            build_nt_reading,
            build_canticle_post_second_reading,
            build_creed,
            build_prayers,
            build_collect_of_the_day,
            build_collect_peace,
            build_collect_dangers,
            build_hymn,
            build_sermon,
            build_other_prayers
          ].flatten.compact
        end

        # ============================================================================
        # SECTION: Opening Components
        # ============================================================================

        # INTRODUÇÃO - Introduction
        def build_introduction
          lines = []

          # Opening rubric
          rubric = fetch_liturgical_text("evening_2_introduction_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Rubric
          rubric = fetch_liturgical_text("evening_2_introduction_rubric_2")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Resolve confession invitation option (1, 2, or random)
          option = resolve_preference(:evening_2_preparation, 1..2) || 1

          invitation = fetch_liturgical_text("evening_2_confession_invitation_#{option}_minister")
          if invitation
            lines << line_item(invitation.content, type: "leader", slug: invitation.slug)
            lines << line_item("", type: "spacer")
          end

          # Confession prayer
          confession = fetch_liturgical_text("evening_2_confession_prayer_all")
          if confession
            lines << line_item(confession.content, type: "congregation", slug: confession.slug)
            lines << line_item("", type: "spacer")
          end

          # Rubric
          rubric = fetch_liturgical_text("evening_2_absolution_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          absolution = fetch_liturgical_text("evening_2_absolution_minister")
          if absolution
            lines << line_item(absolution.content, type: "leader", slug: absolution.slug)
          end

          absolution_all = fetch_liturgical_text("evening_2_absolution_all")
          if absolution_all
            lines << line_item(absolution_all.content, type: "congregation", slug: absolution_all.slug)
            lines << line_item("", type: "spacer")
          end

          # Alternative for local ministers (rubric)
          local_rubric = fetch_liturgical_text("evening_2_absolution_local_rubric")
          if local_rubric
            lines << line_item(local_rubric.content, type: "rubric", slug: local_rubric.slug)
            lines << line_item("", type: "spacer")
          end

          local_absolution = fetch_liturgical_text("evening_2_absolution_local_minister")
          if local_absolution
            lines << line_item(local_absolution.content, type: "leader", slug: local_absolution.slug)
          end

          local_all = fetch_liturgical_text("evening_2_absolution_local_all")
          if local_all
            lines << line_item(local_all.content, type: "congregation", slug: local_all.slug)
          end

          {
            name: "Introdução",
            type: "main_part",
            slug: "introduction",
            lines: lines
          }
        end

        # ORAÇÃO VESPERTINA - Evening Prayer Section Header
        def build_evening_prayer_section
          lines = []

          rubric = fetch_liturgical_text("evening_2_response_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
          end

          {
            name: "Oração Vespertina",
            type: "main_part",
            slug: "evening_prayer_section",
            lines: lines
          }
        end

        # RESPONSO - Response
        def build_response
          lines = []

          # Response 1: Ó Senhor, abre os meus lábios...
          response_1_minister = fetch_liturgical_text("evening_2_response_1_minister")
          if response_1_minister
            lines << line_item(response_1_minister.content, type: "leader", slug: response_1_minister.slug)
          end

          response_1_all = fetch_liturgical_text("evening_2_response_1_all")
          if response_1_all
            lines << line_item(response_1_all.content, type: "congregation", slug: response_1_all.slug)
          end

          # Response 2: Ó Deus, vem depressa salvar-nos...
          response_2_minister = fetch_liturgical_text("evening_2_response_2_minister")
          if response_2_minister
            lines << line_item(response_2_minister.content, type: "leader", slug: response_2_minister.slug)
          end

          response_2_all = fetch_liturgical_text("evening_2_response_2_all")
          if response_2_all
            lines << line_item(response_2_all.content, type: "congregation", slug: response_2_all.slug)
          end

          # Response 3: Glória ao Pai...
          response_3_minister = fetch_liturgical_text("evening_2_response_3_minister")
          if response_3_minister
            lines << line_item(response_3_minister.content, type: "leader", slug: response_3_minister.slug)
          end

          response_3_all = fetch_liturgical_text("evening_2_response_3_all")
          if response_3_all
            lines << line_item(response_3_all.content, type: "congregation", slug: response_3_all.slug)
          end

          # Response 4: Louvado seja nosso Senhor...
          response_4_minister = fetch_liturgical_text("evening_2_response_4_minister")
          if response_4_minister
            lines << line_item(response_4_minister.content, type: "leader", slug: response_4_minister.slug)
          end

          response_4_all = fetch_liturgical_text("evening_2_response_4_all")
          if response_4_all
            lines << line_item(response_4_all.content, type: "congregation", slug: response_4_all.slug)
          end

          {
            name: "Responso",
            slug: "response",
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
          rubric = fetch_liturgical_text("evening_2_psalms_rubric")
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
          gloria_minister = fetch_liturgical_text("evening_2_psalms_gloria_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("evening_2_psalms_gloria_all")
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
            lines << line_item("", type: "spacer")

            if readings[:first_reading][:content]
              lines.concat(format_bible_content(readings[:first_reading][:content]))
              lines << line_item("", type: "spacer")
            end

            # Response after reading
            response_reader = fetch_liturgical_text("evening_2_ot_reading_response_reader")
            if response_reader
              lines << line_item(response_reader.content, type: "reader", slug: response_reader.slug)
            end

            response_all = fetch_liturgical_text("evening_2_ot_reading_response_all")
            if response_all
              lines << line_item(response_all.content, type: "congregation", slug: response_all.slug)
            end
          end

          {
            name: "Leitura do Antigo Testamento",
            slug: "ot_reading",
            lines: lines
          }
        end

        # CÂNTICO PÓS PRIMEIRA LEITURA - Magnificat or Cantate Domino
        def build_canticle_post_first_reading
          lines = []

          # Resolve canticle preference
          canticle_type = resolve_canticle_post_first_reading

          case canticle_type
          when :magnificat
            build_magnificat_canticle(lines)
          when :cantate_domino
            build_cantate_domino_canticle(lines)
          when :all
            build_magnificat_canticle(lines)
            lines << line_item("", type: "spacer")
            build_cantate_domino_canticle(lines)
          else
            build_magnificat_canticle(lines)
          end

          {
            name: "Cântico",
            slug: "canticle_post_first_reading",
            lines: lines
          }
        end

        # LEITURA DO NOVO TESTAMENTO - New Testament Reading
        def build_nt_reading
          lines = []

          if readings[:second_reading]
            lines << line_item("", type: "spacer")

            if readings[:second_reading][:content]
              lines.concat(format_bible_content(readings[:second_reading][:content]))
              lines << line_item("", type: "spacer")
            end

            # Response after reading
            response_reader = fetch_liturgical_text("evening_2_nt_reading_response_reader")
            if response_reader
              lines << line_item(response_reader.content, type: "reader", slug: response_reader.slug)
            end

            response_all = fetch_liturgical_text("evening_2_nt_reading_response_all")
            if response_all
              lines << line_item(response_all.content, type: "congregation", slug: response_all.slug)
            end
          end

          {
            name: "Leitura do Novo Testamento",
            slug: "nt_reading",
            lines: lines
          }
        end

        # CÂNTICO PÓS SEGUNDA LEITURA - Nunc dimittis or Deus misereatur
        def build_canticle_post_second_reading
          lines = []

          # Resolve canticle preference
          canticle_type = resolve_canticle_post_second_reading

          case canticle_type
          when :nunc_dimittis
            build_nunc_dimittis_canticle(lines)
          when :deus_misereatur
            build_deus_misereatur_canticle(lines)
          when :all
            build_nunc_dimittis_canticle(lines)
            lines << line_item("", type: "spacer")
            build_deus_misereatur_canticle(lines)
          else
            build_nunc_dimittis_canticle(lines)
          end

          {
            name: "Cântico",
            slug: "canticle_post_second_reading",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Creed
        # ============================================================================

        # AFIRMAÇÃO DE FÉ - Creed
        def build_creed
          lines = []

          # Rubric
          rubric = fetch_liturgical_text("evening_2_creed_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Resolve creed type (apostolic, nicene, random, or all)
          creed_type = resolve_creed_type

          case creed_type
          when :apostolic
            creed = fetch_liturgical_text("evening_2_creed_apostolic")
            if creed
              lines << line_item(creed.content, type: "congregation", slug: creed.slug)
            end
          when :nicene
            creed = fetch_liturgical_text("evening_2_creed_nicene")
            if creed
              lines << line_item(creed.content, type: "congregation", slug: creed.slug)
            end
          when :all
            apostolic = fetch_liturgical_text("evening_2_creed_apostolic")
            if apostolic
              lines << line_item(apostolic.content, type: "congregation", slug: apostolic.slug)
            end
          else
            creed = fetch_liturgical_text("evening_2_creed_apostolic")
            if creed
              lines << line_item(creed.content, type: "congregation", slug: creed.slug)
            end
          end

          {
            name: "Afirmação de Fé",
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
          prayers_1_minister = fetch_liturgical_text("evening_2_prayers_1_minister")
          if prayers_1_minister
            lines << line_item(prayers_1_minister.content, type: "leader", slug: prayers_1_minister.slug)
          end

          prayers_1_all = fetch_liturgical_text("evening_2_prayers_1_all")
          if prayers_1_all
            lines << line_item(prayers_1_all.content, type: "congregation", slug: prayers_1_all.slug)
            lines << line_item("", type: "spacer")
          end

          # Kyrie 1
          prayers_2_minister = fetch_liturgical_text("evening_2_prayers_2_minister")
          if prayers_2_minister
            lines << line_item(prayers_2_minister.content, type: "leader", slug: prayers_2_minister.slug)
          end

          prayers_2_all = fetch_liturgical_text("evening_2_prayers_2_all")
          if prayers_2_all
            lines << line_item(prayers_2_all.content, type: "congregation", slug: prayers_2_all.slug)
          end

          # Kyrie 2
          prayers_3_minister = fetch_liturgical_text("evening_2_prayers_3_minister")
          if prayers_3_minister
            lines << line_item(prayers_3_minister.content, type: "leader", slug: prayers_3_minister.slug)
            lines << line_item("", type: "spacer")
          end

          # Lord's Prayer
          lords_prayer = fetch_liturgical_text("evening_2_lords_prayer_all")
          if lords_prayer
            lines << line_item(lords_prayer.content, type: "congregation", slug: lords_prayer.slug)
            lines << line_item("", type: "spacer")
          end

          # Post Lord's Prayer
          prayers_4_minister = fetch_liturgical_text("evening_2_prayers_4_minister")
          if prayers_4_minister
            lines << line_item(prayers_4_minister.content, type: "leader", slug: prayers_4_minister.slug)
          end

          prayers_4_all = fetch_liturgical_text("evening_2_prayers_4_all")
          if prayers_4_all
            lines << line_item(prayers_4_all.content, type: "congregation", slug: prayers_4_all.slug)
          end

          # Suffrages
          (1..5).each do |i|
            minister = fetch_liturgical_text("evening_2_suffrage_#{i}_minister")
            if minister
              lines << line_item(minister.content, type: "leader", slug: minister.slug)
            end

            all = fetch_liturgical_text("evening_2_suffrage_#{i}_all")
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
          rubric = fetch_liturgical_text("evening_2_collect_rubric")
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

          collect = fetch_liturgical_text("evening_2_collect_peace")
          if collect
            lines << line_item(collect.content, type: "leader", slug: collect.slug)
          end

          {
            name: "A Coleta pela Paz",
            slug: "collect_peace",
            lines: lines
          }
        end

        # A COLETA CONTRA OS PERIGOS - Collect against Dangers
        def build_collect_dangers
          lines = []

          collect = fetch_liturgical_text("evening_2_collect_dangers")
          if collect
            lines << line_item(collect.content, type: "leader", slug: collect.slug)
          end

          {
            name: "A Coleta Por Ajuda Contra Todos os Perigos",
            slug: "collect_dangers",
            lines: lines
          }
        end

        # HINO - Hymn
        def build_hymn
          lines = []

          rubric = fetch_liturgical_text("evening_2_hymn_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
          end

          {
            name: "Hino",
            slug: "hymn",
            lines: lines
          }
        end

        # SERMÃO - Sermon
        def build_sermon
          lines = []

          rubric = fetch_liturgical_text("evening_2_sermon_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
          end

          {
            name: "Sermão",
            slug: "sermon",
            lines: lines
          }
        end

        # OUTRAS ORAÇÕES - Other Prayers (optional)
        def build_other_prayers
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
            name: "Outras Orações",
            slug: "other_prayers",
            lines: lines
          }
        end

        private

        # ============================================================================
        # SECTION: Helper Methods - Canticles
        # ============================================================================

        # Resolve canticle post first reading from preferences
        def resolve_canticle_post_first_reading
          result = resolve_preference(:evening_2_canticle_post_first_reading, %w[magnificat cantate_domino])
          result&.to_sym || :magnificat
        end

        # Resolve canticle post second reading from preferences
        def resolve_canticle_post_second_reading
          result = resolve_preference(:evening_2_canticle_post_second_reading, %w[nunc_dimittis deus_misereatur])
          result&.to_sym || :nunc_dimittis
        end

        # Build Magnificat canticle
        def build_magnificat_canticle(lines)
          # Rubric
          rubric = fetch_liturgical_text("evening_2_magnificat_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Magnificat text
          magnificat = fetch_liturgical_text("evening_2_magnificat")
          if magnificat
            lines << line_item(magnificat.content, slug: magnificat.slug)
            lines << line_item("", type: "spacer")
          end

          # Gloria Patri
          gloria_minister = fetch_liturgical_text("evening_2_magnificat_gloria_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("evening_2_magnificat_gloria_all")
          if gloria_all
            lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
          end
        end

        # Build Cantate Domino canticle
        def build_cantate_domino_canticle(lines)
          # Rubric
          rubric = fetch_liturgical_text("evening_2_cantate_domino_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Cantate Domino text
          cantate = fetch_liturgical_text("evening_2_cantate_domino")
          if cantate
            lines << line_item(cantate.content, slug: cantate.slug)
            lines << line_item("", type: "spacer")
          end

          # Gloria Patri
          gloria_minister = fetch_liturgical_text("evening_2_cantate_domino_gloria_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("evening_2_cantate_domino_gloria_all")
          if gloria_all
            lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
          end
        end

        # Build Nunc dimittis canticle
        def build_nunc_dimittis_canticle(lines)
          # Rubric
          rubric = fetch_liturgical_text("evening_2_nunc_dimittis_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Nunc dimittis text
          nunc = fetch_liturgical_text("evening_2_nunc_dimittis")
          if nunc
            lines << line_item(nunc.content, slug: nunc.slug)
            lines << line_item("", type: "spacer")
          end

          # Gloria Patri
          gloria_minister = fetch_liturgical_text("evening_2_nunc_dimittis_gloria_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("evening_2_nunc_dimittis_gloria_all")
          if gloria_all
            lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
          end
        end

        # Build Deus misereatur canticle
        def build_deus_misereatur_canticle(lines)
          # Rubric
          rubric = fetch_liturgical_text("evening_2_deus_misereatur_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Deus misereatur text
          deus = fetch_liturgical_text("evening_2_deus_misereatur")
          if deus
            lines << line_item(deus.content, slug: deus.slug)
            lines << line_item("", type: "spacer")
          end

          # Gloria Patri
          gloria_minister = fetch_liturgical_text("evening_2_deus_misereatur_gloria_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("evening_2_deus_misereatur_gloria_all")
          if gloria_all
            lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
          end
        end

        # ============================================================================
        # SECTION: Helper Methods - Creed
        # ============================================================================

        # Resolve creed type from preferences
        def resolve_creed_type
          pref_value = preferences[:evening_2_creed_type]

          case pref_value&.to_s
          when "apostolic" then :apostolic
          when "nicene" then :nicene
          when "random" then %i[apostolic nicene].sample
          when "all" then :all
          else :apostolic
          end
        end

        # ============================================================================
        # SECTION: Helper Methods - Conclusion
        # ============================================================================

        # Resolve conclusion type from preferences
        def resolve_conclusion_type
          result = resolve_preference(:evening_2_conclusion, %w[grace dismissal])
          result&.to_sym || :grace
        end

        # Build grace conclusion
        def build_grace_conclusion(lines)
          grace = fetch_liturgical_text("evening_2_conclusion_grace_minister")
          if grace
            lines << line_item(grace.content, type: "leader", slug: grace.slug)
          end

          grace_all = fetch_liturgical_text("evening_2_conclusion_grace_all")
          if grace_all
            lines << line_item(grace_all.content, type: "congregation", slug: grace_all.slug)
          end
        end

        # Build dismissal conclusion
        def build_dismissal_conclusion(lines)
          rubric = fetch_liturgical_text("evening_2_conclusion_dismissal_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          dismissal = fetch_liturgical_text("evening_2_conclusion_dismissal_minister")
          if dismissal
            lines << line_item(dismissal.content, type: "leader", slug: dismissal.slug)
          end

          dismissal_people = fetch_liturgical_text("evening_2_conclusion_dismissal_people")
          if dismissal_people
            lines << line_item(dismissal_people.content, type: "congregation", slug: dismissal_people.slug)
          end

          dismissal_all = fetch_liturgical_text("evening_2_conclusion_dismissal_all")
          if dismissal_all
            lines << line_item(dismissal_all.content, type: "congregation", slug: dismissal_all.slug)
          end
        end
      end
    end
  end
end
