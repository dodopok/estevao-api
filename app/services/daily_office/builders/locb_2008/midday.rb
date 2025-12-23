# frozen_string_literal: true

module DailyOffice
  module Builders
    module Locb2008
      # LOCB 2008 Midday Prayer (Oração do Meio-Dia)
      #
      # This builder follows the structure from the
      # Livro de Oração Comum Brasileiro 2008, pages 65-67.
      #
      # Structure:
      # 1. Abertura (Opening)
      # 2. Glória ao Pai (Gloria Patri)
      # 3. Salmo (Psalm - 119, 121, or 126)
      # 4. Leitura das Escrituras (Scripture Reading)
      # 5. Meditação (Meditation - optional)
      # 6. Orações (Prayers - Kyrie, Lord's Prayer)
      # 7. Coleta (Collect)
      # 8. Coleta do Dia (Collect of the Day)
      # 9. Intercessões (Intercessions - optional)
      # 10. Conclusão (Dismissal)
      #
      class Midday < Base
        private

        def assemble_office
          assemble_midday_prayer
        end

        def assemble_midday_prayer
          [
            build_opening,
            build_psalm,
            build_reading
          ].flatten.compact
        end

        # ============================================================================
        # SECTION: Opening
        # ============================================================================

        def build_opening
          lines = []

          # Opening versicle
          opening_minister = fetch_liturgical_text("midday_opening_minister")
          if opening_minister
            lines << line_item(opening_minister.content, type: "leader", slug: opening_minister.slug)
          end

          opening_all = fetch_liturgical_text("midday_opening_all")
          if opening_all
            lines << line_item(opening_all.content, type: "congregation", slug: opening_all.slug)
            lines << line_item("", type: "spacer")
          end

          # Gloria Patri
          gloria_minister = fetch_liturgical_text("midday_gloria_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("midday_gloria_all")
          if gloria_all
            lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
          end

          # Alleluia (omit during Advent and Lent)
          unless is_advent? || is_lent?
            alleluia = fetch_liturgical_text("midday_alleluia")
            if alleluia
              lines << line_item(alleluia.content, type: "congregation", slug: alleluia.slug)
            end
          end

          lines << line_item("", type: "spacer")

          # Rubric about psalm selection
          rubric = fetch_liturgical_text("midday_rubric_alleluia")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
          end

          {
            name: "Abertura",
            slug: "opening",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Psalm
        # ============================================================================

        def build_psalm
          sections = []

          psalm_mapping = {
            "psalm_119" => "midday_psalm_119",
            "psalm_121" => "midday_psalm_121",
            "psalm_126" => "midday_psalm_126"
          }

          # Resolve psalm preference
          selected_psalm = resolve_preference(:midday_psalm, psalm_mapping.keys)

          Array(selected_psalm).each do |psalm_key|
            psalm_slug = psalm_mapping[psalm_key]
            next unless psalm_slug

            psalm = fetch_liturgical_text(psalm_slug)
            next unless psalm

            lines = []
            lines << line_item(psalm.content, type: "responsive", slug: psalm.slug)
            lines << line_item("", type: "spacer")

            # Gloria Patri after psalm
            gloria_minister = fetch_liturgical_text("#{psalm_slug}_gloria_minister")
            if gloria_minister
              lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
            end

            gloria_all = fetch_liturgical_text("#{psalm_slug}_gloria_all")
            if gloria_all
              lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
            end

            sections << {
              name: psalm.title || "Salmo",
              type: "canticle",
              slug: psalm_slug,
              reference: psalm.reference,
              lines: lines
            }
          end

          sections
        end

        # ============================================================================
        # SECTION: Scripture Reading
        # ============================================================================

        def build_reading
          lines = []

          # Rubric
          rubric = fetch_liturgical_text("midday_readings_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Select a reading (random between 1-3, or all)
          reading_num = resolve_preference(:midday_reading, 1..3) || 1

          Array(reading_num).each do |num|
            reading = fetch_liturgical_text("midday_reading_#{num}")
            if reading
              lines << line_item(reading.content + " " + reading.reference, type: "leader", slug: reading.slug)

              response = fetch_liturgical_text("midday_reading_#{num}_response_all")
              if response
                lines << line_item(response.content, type: "congregation", slug: response.slug)
              end
              lines << line_item("", type: "spacer")
            end
          end

          # Meditation rubric
          meditation_rubric = fetch_liturgical_text("midday_meditation_rubric")
          if meditation_rubric
            lines << line_item(meditation_rubric.content, type: "rubric", slug: meditation_rubric.slug)
          end

          # Rubric
          rubric = fetch_liturgical_text("midday_prayers_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Kyrie
          kyrie1 = fetch_liturgical_text("midday_kyrie_minister")
          if kyrie1
            lines << line_item(kyrie1.content, type: "leader", slug: kyrie1.slug)
          end

          kyrie2 = fetch_liturgical_text("midday_kyrie_all")
          if kyrie2
            lines << line_item(kyrie2.content, type: "congregation", slug: kyrie2.slug)
          end

          kyrie3 = fetch_liturgical_text("midday_kyrie_minister_2")
          if kyrie3
            lines << line_item(kyrie3.content, type: "leader", slug: kyrie3.slug)
          end

          lords_prayer = fetch_liturgical_text("midday_lords_prayer_all")
          if lords_prayer
            lines << line_item(lords_prayer.content, type: "congregation", slug: lords_prayer.slug)
            lines << line_item("", type: "spacer")
          end

          # Versicle
          versicle_minister = fetch_liturgical_text("midday_versicle_minister")
          if versicle_minister
            lines << line_item(versicle_minister.content, type: "leader", slug: versicle_minister.slug)
          end

          versicle_all = fetch_liturgical_text("midday_versicle_all")
          if versicle_all
            lines << line_item(versicle_all.content, type: "congregation", slug: versicle_all.slug)
          end

          # Oremos
          oremos = fetch_liturgical_text("midday_oremos")
          if oremos
            lines << line_item("", type: "spacer")
            lines << line_item(oremos.content, type: "leader", slug: oremos.slug)
          end

          # Rubric
          rubric = fetch_liturgical_text("midday_collects_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Resolve collect preference
          collect_num = resolve_preference(:midday_collect, 1..4) || 1

          Array(collect_num).each do |num|
            collect = fetch_liturgical_text("midday_collect_#{num}")
            if collect
              lines << line_item(collect.content, type: "leader", slug: collect.slug)
              lines << line_item("", type: "spacer")
            end
          end

          @collects.each do |collect|
            if collect[:preface].present?
              lines << line_item(collect[:preface], type: "leader")
            end
            lines << line_item(collect[:text], type: "leader")
            lines << line_item("", type: "spacer")
          end

          rubric = fetch_liturgical_text("midday_intercessions_rubric_1")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
          end

          rubric = fetch_liturgical_text("midday_intercessions_rubric_2")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
          end

          dismissal_minister = fetch_liturgical_text("midday_dismissal_minister")
          if dismissal_minister
            lines << line_item(dismissal_minister.content, type: "leader", slug: dismissal_minister.slug)
          end

          dismissal_all = fetch_liturgical_text("midday_dismissal_all")
          if dismissal_all
            lines << line_item(dismissal_all.content, type: "congregation", slug: dismissal_all.slug)
          end

          {
            name: "Leitura das Escrituras",
            slug: "reading",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Helper Methods
        # ============================================================================

        def is_advent?
          day_info[:liturgical_season]&.downcase == "advento"
        end

        def is_lent?
          day_info[:liturgical_season]&.downcase == "quaresma"
        end
      end
    end
  end
end
