module DailyOffice
  module Builders
    module Loc2015
      class Evening < Base
        # General collects available for evening prayer
        GENERAL_COLLECT_SLUGS = %w[
          for_peace
          for_grace
          for_protection
          for_christ_presence
          evening_for_all_authorities
          evening_for_clergy
          evening_for_parish_family
        ].freeze

        private

        def assemble_office
          assemble_evening_prayer
        end

        def assemble_evening_prayer
          [
            build_welcome,
            build_opening_sentence,
            build_confession,
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
          lines = []
          # Welcome text (traditional or contemporary based on preference)
          welcome_slug = preferences[:prayer_style] == "contemporary" ?
                        "evening_welcome_contemporary" : "evening_welcome_traditional"
          welcome = fetch_liturgical_text(welcome_slug)

          lines << line_item(welcome.content, type: "leader", slug: welcome.slug)

          # Rubric for opening sentence
          rubric = fetch_liturgical_text("opening_sentence_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          {
            name: "Acolhida",
            slug: "welcome",
            lines: lines
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
          gloria_patri = fetch_liturgical_text("gloria_patri")
          if gloria_patri
            lines << line_item(gloria_patri.content, type: "all", slug: gloria_patri.slug)
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

          # General opening sentence (always include one of 1-8)
          general_num = preferences[:opening_sentence_general] || seeded_random(1..8, key: :evening_opening_sentence)
          general = fetch_liturgical_text("evening_opening_sentence_#{general_num}")
          if general
            lines << line_item(general.content, type: "leader", slug: general.slug)
            lines << line_item("", type: "spacer")
          end

          # Post opening sentence rubric
          post_rubric = fetch_liturgical_text("evening_rubric_post_opening_sentence")
          if post_rubric
            lines << line_item(post_rubric.content, type: "rubric", slug: post_rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Season-specific opening sentence (if available)
          seasonal_slug = season_specific_opening_sentence_slug
          seasonal = fetch_liturgical_text(seasonal_slug) if seasonal_slug

          if seasonal
            lines << line_item(seasonal.content, type: "leader", slug: seasonal.slug)
          end

          # Rubric after opening
          after_opening = fetch_liturgical_text("evening_rubric_after_opening")
          if after_opening
            lines << line_item(after_opening.content, type: "rubric", slug: after_opening.slug)
            lines << line_item("", type: "spacer")
          end

          return nil if lines.empty?

          {
            name: "Sentenças Iniciais",
            slug: "opening_sentence",
            lines: lines
          }
        end

        # 2. CONFESSION AND ABSOLUTION
        def build_confession
          lines = []

          # Rubric before confession
          rubric = fetch_liturgical_text("evening_rubric_before_confession")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Opening invitation to confession (long or short)
          invitation_slug = preferences[:evening_confession_type] == "short" ?
                           "evening_confession_short" : "evening_confession_long"
          invitation = fetch_liturgical_text(invitation_slug)
          if invitation
            lines << line_item(invitation.content, type: "leader", slug: invitation.slug)
            lines << line_item("", type: "spacer")
          end

          # Post-opening rubric
          post_opening = fetch_liturgical_text("rubric_post_opening_confession")
          if post_opening
            lines << line_item(post_opening.content, type: "rubric", slug: post_opening.slug)
            lines << line_item("", type: "spacer")
          end

          # Confession prayer (3 options)
          Array(resolve_preference(:evening_confession_prayer_type, 1..3) || 1).each do |confession_num|
            confession = fetch_liturgical_text("evening_after_confession_#{confession_num}")
            next unless confession

            lines << line_item(confession.content, type: "congregation", slug: confession.slug)
            lines << line_item("", type: "spacer")
          end

          # Post-confession rubric
          post_confession = fetch_liturgical_text("rubric_post_confession")
          if post_confession
            lines << line_item(post_confession.content, type: "rubric", slug: post_confession.slug)
            lines << line_item("", type: "spacer")
          end

          # Prayer after confession (if no priest for absolution)
          if preferences[:include_prayer_after_confession]
            prayer_num = preferences[:prayer_after_confession] || 1
            after_prayer = fetch_liturgical_text("prayer_after_confession_#{prayer_num}")
            if after_prayer
              lines << line_item(after_prayer.content, type: "congregation", slug: after_prayer.slug)
            end
          end

          absolution = fetch_liturgical_text("absolution")
          return nil unless absolution

          lines << line_item(absolution.content, type: "leader", slug: absolution.slug)
          lines << line_item("", type: "spacer")

          # Post-absolution rubric
          rubric = fetch_liturgical_text("rubric_post_absolution")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
          end

          {
            name: "Confissão e Absolvição de Pecados",
            slug: "confession",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Invitatory and Psalms
        # ============================================================================

        # 4. INVITATORY (Antiphon)
        def build_invitatory
          invocation = fetch_liturgical_text("evening_invocation")
          return nil unless invocation

          lines = [
            line_item(invocation.content, type: "responsive", slug: invocation.slug),
            line_item("", type: "spacer")
          ]

          # Post-invocation rubric
          rubric = fetch_liturgical_text("evening_rubric_post_invocation")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
          end

          {
            name: "Invitatório e Salmo",
            slug: "invitatory",
            lines: lines
          }
        end

        # 5. INVITATORY CANTICLE
        def build_invitatory_canticle
          lines = []

          # Invitatory canticle (Phos Hilaron, Ecce Nunc, or Pascha Nostrum during Easter)
          canticle_slug = invitatory_canticle_slug
          canticle = fetch_liturgical_text(canticle_slug)

          return nil unless canticle

          lines << line_item(canticle.content, type: "congregation", slug: canticle.slug)

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
          # Choose canticle: magnificat, bonum_est_confiteri, or benedictus
          canticle_slugs = Array(resolve_preference(
            :evening_post_first_reading_canticle,
            %w[magnificat bonum_est_confiteri benedictus]
          ) || "magnificat") # Fallback to magnificat if no preference defined

          # Return array of canticle modules (one per canticle)
          canticle_slugs.map do |canticle_slug|
            canticle = fetch_liturgical_text(canticle_slug)
            next unless canticle

            {
              name: [ canticle.title, canticle.reference&.then { |ref| "(#{ref})" } ].compact.join(" ").presence || "Cântico",
              slug: canticle_slug,
              lines: [
                line_item(canticle.content, type: "congregation", slug: canticle.slug)
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
          # Choose canticle: nunc_dimittis, deus_misereatur, or dignus_es
          canticle_slugs = Array(resolve_preference(
            :evening_post_second_reading_canticle,
            %w[nunc_dimittis deus_misereatur dignus_es]
          ) || "nunc_dimittis") # Fallback to nunc_dimittis if no preference defined

          modules = []

          # Return array of canticle modules (one per canticle)
          canticle_slugs.each do |canticle_slug|
            canticle = fetch_liturgical_text(canticle_slug)
            next unless canticle

            modules << {
              name: [ canticle.title, canticle.reference&.then { |ref| "(#{ref})" } ].compact.join(" ").presence || "Cântico",
              slug: canticle_slug,
              lines: [
                line_item(canticle.content, type: "congregation", slug: canticle.slug)
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
                line_item(end_rubric.content, type: "rubric", slug: end_rubric.slug)
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

          # Choose between Apostles' Creed and Affirmation of Faith
          if preferences[:evening_creed_type] == "faith_affirmation"
            # Rubric for affirmation
            rubric = fetch_liturgical_text("evening_rubric_post_apostles_creed")
            if rubric
              lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
              lines << line_item("", type: "spacer")
            end

            affirmation = fetch_liturgical_text("evening_affirmation_of_faith")
            return nil unless affirmation

            lines << line_item(affirmation.content, type: "congregation", slug: affirmation.slug)

            {
              name: "Afirmação de Fé",
              slug: "creed",
              lines: lines
            }
          else
            # Standard or paraphrase Apostles' Creed
            creed_slug = preferences[:evening_creed_type] == "faith_affirmation" ? "evening_affirmation_of_faith" : "apostles_creed"
            creed = fetch_liturgical_text(creed_slug)
            return nil unless creed

            lines << line_item(creed.content, type: "congregation", slug: creed.slug)

            {
              name: preferences[:evening_creed_type] == "faith_affirmation" ? "Afirmação de Fé" : "Credo Apostólico",
              slug: "creed",
              lines: lines
            }
          end
        end

        def build_offertory
          lines = []

          # Offertory rubric
          end_rubric = fetch_liturgical_text("rubric_offertory")
          if end_rubric
            lines << line_item("", type: "spacer")
            lines << line_item(end_rubric.content, type: "rubric", slug: end_rubric.slug)
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
          rubric = fetch_liturgical_text("rubric_before_prayers")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Invocation (2 options)
          Array(resolve_preference(:evening_post_lords_prayer_prayer, 1..2) || 1).each do |invocation_num|
            invocation = fetch_liturgical_text("invocation_our_father_#{invocation_num}")
            if invocation
              lines << line_item(invocation.content, type: "responsive", slug: invocation.slug)
              lines << line_item("", type: "spacer")
            end
          end

          # Lord's Prayer
          lords_prayer = fetch_liturgical_text("our_father")
          return nil unless lords_prayer

          lines << line_item(lords_prayer.content, type: "congregation", slug: lords_prayer.slug)
          lines << line_item("", type: "spacer")

          # Rubric after Our Father
          after_rubric = fetch_liturgical_text("rubric_after_our_father")
          if after_rubric
            lines << line_item(after_rubric.content, type: "rubric", slug: after_rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Evening closing prayer or mercy prayer
          if preferences[:use_evening_closing_prayer]
            closing_prayer = fetch_liturgical_text("evening_closing_prayer")
            lines << line_item(closing_prayer.content, type: "responsive", slug: closing_prayer.slug) if closing_prayer
          else
            Array(resolve_preference(:evening_post_lords_prayer_prayer, 1..3) || 1).each do |prayer_num|
              suffrages = fetch_liturgical_text("mercy_prayer_#{prayer_num}")
              lines << line_item(suffrages.content, type: "responsive", slug: suffrages.slug) if suffrages
            end
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
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
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
            lines << line_item(general_rubric.content, type: "rubric", slug: general_rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # General collects (can include all or select based on preferences)
          selected_collects = resolve_preference(
            :evening_general_collects,
            GENERAL_COLLECT_SLUGS
          ) || GENERAL_COLLECT_SLUGS

          Array(selected_collects).each do |slug|
            collect = fetch_liturgical_text(slug)
            if collect
              lines << line_item(collect.content, type: "leader", slug: collect.slug)
              lines << line_item("", type: "spacer")
            end
          end

          # Rubric after prayers
          after_prayers = fetch_liturgical_text("evening_rubric_post_prayers")
          lines << line_item(after_prayers.content, type: "rubric", slug: after_prayers.slug) if after_prayers

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
            lines << line_item(opening.content, type: "leader", slug: opening.slug)
            lines << line_item("", type: "spacer")
          end

          # Rubric after opening
          rubric = fetch_liturgical_text("rubric_after_opening_general_thanksgiving")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Thanksgiving prayer (2 options)
          Array(resolve_preference(:evening_general_thanksgivings, 1..2) || 1).each do |thanksgiving_num|
            thanksgiving = fetch_liturgical_text("general_thanksgiving_#{thanksgiving_num}")
            next unless thanksgiving

            lines << line_item(thanksgiving.content, type: "congregation", slug: thanksgiving.slug)
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
              line_item(prayer.content, type: "leader", slug: prayer.slug)
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
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Concluding sentence
          concluding = fetch_liturgical_text("opening_concluding_prayers")
          if concluding
            lines << line_item(concluding.content, type: "responsive", slug: concluding.slug)
            lines << line_item("", type: "spacer")
          end

          # Evening-specific rubric
          evening_rubric = fetch_liturgical_text("evening_rubric_post_concluding_prayers")
          if evening_rubric
            lines << line_item(evening_rubric.content, type: "rubric", slug: evening_rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Dismissal blessing (4 options)
          Array(resolve_preference(:evening_concluding_prayer, 1..4) || 1).each do |dismissal_num|
            dismissal = fetch_liturgical_text("dismissal_#{dismissal_num}")
            next unless dismissal

            lines << line_item(dismissal.content, type: "leader", slug: dismissal.slug)
          end

          # Post-dismissal rubric
          post_rubric = fetch_liturgical_text("rubric_post_dismissal")
          if post_rubric
            lines << line_item("", type: "spacer")
            lines << line_item(post_rubric.content, type: "rubric", slug: post_rubric.slug)
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

          "evening_opening_sentence_#{season_slug}"
        end

        # Choose invitatory canticle based on season
        def invitatory_canticle_slug
          season = day_info[:liturgical_season]

          # Use Pascha Nostrum during Easter season
          return "pascha_nostrum" if season&.downcase == "páscoa"

          # Use resolve_preference for user preference between Ecce Nunc and Phos Hilaron
          resolve_preference(
            :evening_invitatory_canticle,
            %w[phos_hilaron ecce_nunc]
          ) || "phos_hilaron" # Fallback to phos_hilaron if no preference defined
        end
      end
    end
  end
end
