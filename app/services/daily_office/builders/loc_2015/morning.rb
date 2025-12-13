module DailyOffice
  module Builders
    module Loc2015
      class Morning < Base
        # General collects available for morning prayer
        GENERAL_COLLECT_SLUGS = %w[
          for_peace
          for_grace
          for_all_authorities
          for_clergy
          for_parish_family
          for_all_humanity
        ].freeze

        private

        def assemble_office
          assemble_morning_prayer
        end

        def assemble_morning_prayer
          return assemble_morning_prayer_family if preferences[:office_type] == "family"

          [
            build_welcome,
            build_opening_sentence,
            build_confession,
            build_absolution,
            build_invitatory,
            build_invitatory_canticle,
            build_psalms,
            build_first_reading,
            build_first_canticle,
            build_second_reading,
            build_second_canticle,
            build_creed,
            build_offertory,
            build_lords_prayer,
            build_collect_of_the_day,
            build_general_collects,
            build_general_thanksgiving,
            build_chrysostom_prayer,
            build_dismissal
          ].flatten.compact
        end

        # ============================================================================
        # SECTION: Opening Components
        # ============================================================================

        # WELCOME - Separate module for Acolhida
        def build_welcome
          # Welcome text (traditional or contemporary based on preference)
          welcome_slug = preferences[:prayer_style] == "contemporary" ?
                        "morning_welcome_contemporary" : "morning_welcome_traditional"
          welcome = fetch_liturgical_text(welcome_slug)
          return nil unless welcome

          {
            name: "Acolhida",
            slug: "welcome",
            lines: [
              line_item(welcome.content, type: "leader")
            ]
          }
        end

        # PSALMS - Use readings[:psalm] reference to fetch psalm content
        def build_psalms
          psalm_ref = readings[:psalm]
          return nil unless psalm_ref&.dig(:reference)

          lines = []

          # Add LOC-specific rubric about Gloria Patri
          rubric = fetch_liturgical_text("rubric_gloria_patri")
          if rubric
            lines << line_item(rubric.content, type: "rubric")
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
          gloria_patri = fetch_liturgical_text("gloria_patri")
          if gloria_patri
            lines << line_item(gloria_patri.content, type: "all")
          end

          {
            name: "Salmos",
            slug: "psalms",
            lines: lines
          }
        end

        # 1. OPENING SENTENCE (Sentenças Iniciais)
        def build_opening_sentence
          lines = []

          # Rubric for opening sentence
          rubric = fetch_liturgical_text("opening_sentence_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric")
            lines << line_item("", type: "spacer")
          end

          # General opening sentence (always include one of 1-7)
          general_num = resolve_preference(:morning_opening_sentence, 1..7)
          general = fetch_liturgical_text("morning_opening_sentence_#{general_num}")

          if general
            lines << line_item(general.content, type: "leader")
            lines << line_item(general.reference, type: "citation") if general.reference
            lines << line_item("", type: "spacer")
          end

          # Season-specific opening sentence (if available)
          seasonal_slug = season_specific_opening_sentence_slug
          seasonal = fetch_liturgical_text(seasonal_slug) if seasonal_slug

          if seasonal
            lines << line_item(seasonal.content, type: "leader")
            lines << line_item(seasonal.reference, type: "citation") if seasonal.reference
          end

          return nil if lines.empty?

          {
            name: "Sentenças Iniciais",
            slug: "opening_sentence",
            lines: lines
          }
        end

        # 2. CONFESSION
        def build_confession
          lines = []

          # Rubric before confession
          rubric = fetch_liturgical_text("morning_rubric_confession")
          lines << line_item(rubric.content, type: "rubric") if rubric
          lines << line_item("", type: "spacer")

          # Opening invitation to confession
          invitation_num = resolve_preference(:morning_confession_type, 1..2)
          invitation = fetch_liturgical_text("morning_opening_confession_#{invitation_num}")
          if invitation
            lines << line_item(invitation.content, type: "leader")
            lines << line_item("", type: "spacer")
          end

          # Post-opening rubric
          post_opening = fetch_liturgical_text("rubric_post_opening_confession")
          if post_opening
            lines << line_item(post_opening.content, type: "rubric")
            lines << line_item("", type: "spacer")
          end

          # Confession prayer (3 options)
          confession_num = resolve_preference(:morning_confession_prayer_type, 1..3)
          confession = fetch_liturgical_text("morning_confession_#{confession_num}")

          lines << line_item(confession.content, type: "congregation")
          lines << line_item("", type: "spacer")

          # Post-confession rubric
          post_confession = fetch_liturgical_text("rubric_post_confession")
          if post_confession
            lines << line_item(post_confession.content, type: "rubric")
            lines << line_item("", type: "spacer")
          end

          # Post-confession prayer (2 options)
          prayer_num = resolve_preference(:morning_prayer_after_confession, 1..2)
          after_prayer = fetch_liturgical_text("prayer_after_confession_#{prayer_num}")
          if after_prayer
            lines << line_item(after_prayer.content, type: "congregation")
          end

          {
            name: "Confissão de Pecados",
            slug: "confession",
            lines: lines
          }
        end

        # 3. ABSOLUTION
        def build_absolution
          lines = []

          absolution = fetch_liturgical_text("absolution")
          return nil unless absolution

          lines << line_item(absolution.content, type: "leader")
          lines << line_item("", type: "spacer")

          # Post-absolution rubric
          rubric = fetch_liturgical_text("rubric_post_absolution")
          if rubric
            lines << line_item(rubric.content, type: "rubric")
          end

          {
            name: "Absolvição",
            slug: "absolution",
            lines: lines
          }
        end

        def season_specific_antiphon
          season = day_info[:liturgical_season]
          season_slug = season_to_antiphon_slug(season, feast_day: day_info[:feast_day])
          return nil unless season_slug

          "morning_before_invocation_#{season_slug}"
        end

        # ============================================================================
        # SECTION: Invitatory and Psalms
        # ============================================================================

        # 4. INVITATORY (Antiphon)
        def build_invitatory
          # Use Lent-specific invocation (without Alleluia) during Lent
          slug = is_lent? ? "morning_invocation_lent" : "morning_invocation"

          invocation = fetch_liturgical_text(slug)

          lines = [ line_item(invocation.content, type: "responsive") ]

          # Pre-invitatory antiphon (season-specific)
          antiphon_slug = season_specific_antiphon
          antiphon = fetch_liturgical_text(antiphon_slug)
          if antiphon
            lines << line_item(antiphon.content, type: "leader")
            lines << line_item("", type: "spacer")
          end

          {
            name:  "Invitatório e Salmo",
            slug: "invitatory",
            lines: lines
          }
        end

        # 4. INVITATORY (Canticle)
        def build_invitatory_canticle
          lines = []

          # Invitatory canticle (Venite, Jubilate, or Pascha Nostrum)
          canticle_slug = invitatory_canticle_slug
          canticle = fetch_liturgical_text(canticle_slug)

          return nil unless canticle

          lines << line_item(canticle.content, type: "congregation")

          {
            name: [ canticle&.title, canticle&.reference&.then { |ref| "(#{ref})" } ].compact.join(" ").presence || "Cântico",
            slug: "invitatory_canticle",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Readings and Canticles
        # ============================================================================

        # 6. FIRST READING (delegate to reading_builder with LOC-specific rubrics)
        def build_first_reading
          build_reading_module(
            type: :first,
            announcement_slug: "first_reading",
            rubric_slugs: {
              pre: "rubric_first_reading",
              post: "rubric_post_first_reading",
              response: "canticle_post_first_reading",
              end: "rubric_end_first_reading"
            },
            reading_key: :first_reading,
            module_name: "Leituras da Palavra de Deus"
          )
        end

        # 7. FIRST CANTICLE
        def build_first_canticle
          # Choose canticle: benedictus_es_domine, cantate_domino, or benedicite_omnia_opera
          canticle_slugs = Array(resolve_preference(
            :morning_post_first_reading_canticle,
            %w[benedictus_es_domine cantate_domino benedicite_omnia_opera]
          ))

          # Return array of canticle modules (one per canticle)
          canticle_slugs.map do |canticle_slug|
            canticle = fetch_liturgical_text(canticle_slug)
            next unless canticle

            {
              name: [canticle.title, canticle.reference&.then { |ref| "(#{ref})" }].compact.join(" ").presence || "Cântico",
              slug: canticle_slug,
              lines: [
                line_item(canticle.content, type: "congregation")
              ]
            }
          end.compact
        end

        # 8. SECOND READING
        def build_second_reading
          build_reading_module(
            type: :second,
            announcement_slug: "second_reading",
            rubric_slugs: {
              pre: "rubric_second_reading",
              post: "rubric_post_second_reading",
              response: "canticle_post_second_reading",
              end: "rubric_end_second_reading"
            },
            reading_key: :second_reading,
            module_name: "Segunda Leitura"
          )
        end

        # 9. SECOND CANTICLE
        def build_second_canticle
          # Choose canticle: te_deum_laudamus, magna_et_mirabilia, or benedic_anima_mea
          canticle_slugs = Array(resolve_preference(
            :morning_post_second_reading_canticle,
            %w[te_deum_laudamus magna_et_mirabilia benedic_anima_mea]
          ))

          modules = []

          # Return array of canticle modules (one per canticle)
          canticle_slugs.each do |canticle_slug|
            canticle = fetch_liturgical_text(canticle_slug)
            next unless canticle

            modules << {
              name: [canticle.title, canticle.reference&.then { |ref| "(#{ref})" }].compact.join(" ").presence || "Cântico",
              slug: canticle_slug,
              lines: [
                line_item(canticle.content, type: "congregation")
              ]
            }
          end

          # Add end rubric as separate module
          end_rubric = fetch_liturgical_text("rubric_end_second_canticle")
          if end_rubric
            modules << {
              name: "",
              slug: "rubric_end_second_canticle",
              lines: [
                line_item(end_rubric.content, type: "rubric")
              ]
            }
          end

          modules
        end

        # ============================================================================
        # SECTION: Affirmation of Faith and Offering
        # ============================================================================

        # 10. CREED
        def build_creed
          lines = []

          # Choose between standard and paraphrase
          creed_slug = preferences[:morning_creed_type] == "apostolic_paraphrase" ? "apostles_creed_paraphrase" : "apostles_creed"
          creed = fetch_liturgical_text(creed_slug)
          return nil unless creed

          lines << line_item(creed.content, type: "congregation")

          {
            name: preferences[:morning_creed_type] == "apostolic_paraphrase" ? "Paráfrase do Credo Apostólico" : "Credo Apostólico",
            slug: "creed",
            lines: lines
          }
        end

        def build_offertory
          lines = []

          # End rubric (mentions Creed)
          end_rubric = fetch_liturgical_text("rubric_offertory")
          if end_rubric
            lines << line_item("", type: "spacer")
            lines << line_item(end_rubric.content, type: "rubric")
          end

          {
            name: "Ofertório",
            slug: "offertory",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Prayers and Collects
        # ============================================================================

        # 11. LORD'S PRAYER
        def build_lords_prayer
          lines = []

          # Rubric before prayers
          rubric = fetch_liturgical_text("morning_rubric_prayers")
          if rubric
            lines << line_item(rubric.content, type: "rubric")
            lines << line_item("", type: "spacer")
          end

          # Invocation (2 options)
          invocation_slug = preferences[:prayer_style] == "contemporary" ? "invocation_our_father_2" : "invocation_our_father_1"
          invocation = fetch_liturgical_text(invocation_slug)
          if invocation
            lines << line_item(invocation.content, type: "responsive")
            lines << line_item("", type: "spacer")
          end

          # Lord's Prayer
          lords_prayer = fetch_liturgical_text("our_father")
          return nil unless lords_prayer

          lines << line_item(lords_prayer.content, type: "congregation")

          # Rubric before prayers
          rubric = fetch_liturgical_text("rubric_after_our_father")
          if rubric
            lines << line_item(rubric.content, type: "rubric")
            lines << line_item("", type: "spacer")
          end

          prayer_num = resolve_preference(:morning_post_lords_prayer_prayer, 1..2)
          suffrage = fetch_liturgical_text("mercy_prayer_#{prayer_num}")
          if suffrage
            lines << line_item(suffrage.content, type: "responsive")
            lines << line_item("", type: "spacer")
          end

          {
            name: "Orações",
            slug: "lords_prayer",
            lines: lines
          }
        end

        def build_collect_of_the_day
          lines = []

          # Rubric for collect of the day
          rubric = fetch_liturgical_text("rubric_collect_of_the_day")
          if rubric
            lines << line_item(rubric.content, type: "rubric")
            lines << line_item("", type: "spacer")
          end

          # Collect of the Day (from CollectService)
          if @collects
            lines << line_item(@collects)
            lines << line_item("", type: "spacer")
          end

          {
            name: "Coleta do Dia",
            slug: "collect_of_the_day",
            lines: lines
          }
        end

        # 13. COLLECTS
        def build_general_collects
          lines = []

          # Rubric for general collects
          general_rubric = fetch_liturgical_text("rubric_general_collects")
          if general_rubric
            lines << line_item(general_rubric.content, type: "rubric")
            lines << line_item("", type: "spacer")
          end

          # General collects (6 options - can include all or select based on preferences)
          selected_collects = Array(resolve_preference(
            :morning_general_collects,
            GENERAL_COLLECT_SLUGS
          ) || GENERAL_COLLECT_SLUGS)

          selected_collects.each do |slug|
            collect = fetch_liturgical_text(slug)
            if collect
              lines << line_item(collect.content, type: "leader")
              lines << line_item("", type: "spacer")
            end
          end

          # Rubric after prayers
          after_prayers = fetch_liturgical_text("morning_rubric_after_prayers")
          if after_prayers
            lines << line_item(after_prayers.content, type: "rubric")
            lines << line_item("", type: "spacer")
          end

          # Final prayer
          final_prayer = fetch_liturgical_text("morning_final_prayer")
          if final_prayer
            lines << line_item(final_prayer.content, type: "leader")
            lines << line_item("", type: "spacer")
          end

          # Rubric after final prayer
          after_final = fetch_liturgical_text("morning_rubric_after_final_prayer")
          lines << line_item(after_final.content, type: "rubric") if after_final

          {
            name: "Coletas Gerais",
            slug: "general_collects",
            lines: lines
          }
        end

        # 14. GENERAL THANKSGIVING
        def build_general_thanksgiving
          lines = []

          # Opening of general thanksgiving
          opening = fetch_liturgical_text("opening_general_thanksgiving")
          if opening
            lines << line_item(opening.content, type: "leader")
            lines << line_item("", type: "spacer")
          end

          # Rubric after opening
          rubric = fetch_liturgical_text("rubric_after_opening_general_thanksgiving")
          if rubric
            lines << line_item(rubric.content, type: "rubric")
            lines << line_item("", type: "spacer")
          end

          # Thanksgiving prayer (2 options)
          thanksgiving_nums = Array(resolve_preference(:morning_general_thanksgivings, 1..2) || 1)
          thanksgiving_nums.each do |thanksgiving_num|
            thanksgiving = fetch_liturgical_text("general_thanksgiving_#{thanksgiving_num}")
            next unless thanksgiving

            lines << line_item(thanksgiving.content, type: "congregation")
            lines << line_item("", type: "spacer")
          end

          {
            name: "Geral Ação de Graças",
            slug: "thanksgiving",
            lines: lines
          }
        end

        # 15. CHRYSOSTOM PRAYER
        def build_chrysostom_prayer
          prayer = fetch_liturgical_text("chrysostom_prayer")
          return nil unless prayer

          {
            name: "Oração de São João Crisóstomo",
            slug: "chrysostom",
            lines: [
              line_item(prayer.content, type: "leader")
            ]
          }
        end

        # ============================================================================
        # SECTION: Concluding Prayers and Dismissal
        # ============================================================================

        # 16. DISMISSAL
        def build_dismissal
          lines = []

          # Concluding prayers rubric
          rubric = fetch_liturgical_text("rubric_concluding_prayers")
          if rubric
            lines << line_item(rubric.content, type: "rubric")
            lines << line_item("", type: "spacer")
          end

          # Concluding sentence
          concluding = fetch_liturgical_text("opening_concluding_prayers")
          if concluding
            lines << line_item(concluding.content, type: "responsive")
            lines << line_item("", type: "spacer")
          end

          # Dismissal rubric
          dismissal_rubric = fetch_liturgical_text("morning_rubric_dismissal")
          if dismissal_rubric
            lines << line_item(dismissal_rubric.content, type: "rubric")
            lines << line_item("", type: "spacer")
          end

          # Dismissal blessing (4 options)
          dismissal_num = resolve_preference(:morning_concluding_prayer, 1..4)
          dismissal = fetch_liturgical_text("dismissal_#{dismissal_num}")

          lines << line_item(dismissal.content, type: "leader")
          lines << line_item("", type: "spacer")

          # Post-dismissal rubric
          post_rubric = fetch_liturgical_text("rubric_post_dismissal")
          if post_rubric
            lines << line_item("", type: "spacer")
            lines << line_item(post_rubric.content, type: "rubric")
          end

          {
            name: "Orações Conclusivas",
            slug: "dismissal",
            lines: lines
          }
        end

        private

        # Get season-specific opening sentence slug
        def season_specific_opening_sentence_slug
          season = day_info[:liturgical_season]
          season_slug = season_to_opening_sentence_slug(season, feast_day: day_info[:feast_day])
          return nil unless season_slug

          "morning_opening_sentence_#{season_slug}"
        end

        # Choose invitatory canticle based on season
        def invitatory_canticle_slug
          season = day_info[:liturgical_season]

          # Use Pascha Nostrum during Easter season
          return "pascha_nostrum" if season&.downcase == "páscoa"

          # Use resolve_preference for user preference between Jubilate and Venite
          resolve_preference(
            :morning_invitatory_canticle,
            %w[venite jubilate]
          )
        end
      end
    end
  end
end
