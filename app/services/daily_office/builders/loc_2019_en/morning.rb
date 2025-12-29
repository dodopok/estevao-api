# frozen_string_literal: true

module DailyOffice
  module Builders
    module Loc2019En
      class Morning < Base
        def assemble_office
          [
            build_opening_sentence,
            build_confession,
            build_absolution,
            build_invitatory,
            build_invitatory_canticle,
            build_psalms,
            build_lessons_and_canticles,
            build_creed,
            build_prayers,
            build_collects,
            build_mission_prayer,
            build_thanksgiving,
            build_chrysostom_prayer,
            build_dismissal
          ].flatten.compact
        end

        private

        def build_opening_sentence
          num = resolve_preference(:morning_opening_sentence, 1..3) || 1
          # Check for season specific first
          season_slug = season_to_opening_sentence_slug(day_info[:liturgical_season])
          text = fetch_liturgical_text("morning_opening_sentence_#{season_slug}") if season_slug
          text ||= fetch_liturgical_text("morning_opening_sentence_#{num}")

          return nil unless text

          {
            name: "Opening Sentence",
            slug: "opening_sentence",
            lines: [
              line_item(text.content, type: "leader", slug: text.slug),
              line_item(text.reference, type: "citation")
            ].compact
          }
        end

        def build_confession
          lines = []

          # Exhortation or short invitation
          if preferences[:morning_confession_type] == "long"
            exhortation = fetch_liturgical_text("morning_confession_exhortation")
            lines << line_item(exhortation.content, type: "leader", slug: exhortation.slug) if exhortation
          else
            invitation = fetch_liturgical_text("morning_confession_invitation_short")
            lines << line_item(invitation.content, type: "leader", slug: invitation.slug) if invitation
          end

          lines << line_item("", type: "spacer")
          lines << line_item("Silence is kept. All kneeling.", type: "rubric")
          lines << line_item("", type: "spacer")

          confession = fetch_liturgical_text("morning_confession")
          lines << line_item(confession.content, type: "congregation", slug: confession.slug) if confession

          {
            name: "Confession of Sin",
            slug: "confession",
            lines: lines
          }
        end

        def build_absolution
          # If priest present use absolution, else use prayer for pardon
          # For now, providing both as options or just the full one
          abs = fetch_liturgical_text("absolution")

          {
            name: "Absolution",
            slug: "absolution",
            lines: [
              line_item("The Priest alone stands and says", type: "rubric"),
              line_item(abs.content, type: "leader", slug: abs.slug)
            ]
          }
        end

        def build_invitatory
          inv = fetch_liturgical_text("morning_invocation")
          lines = [ line_item(inv.content, type: "responsive", slug: inv.slug) ]

          # Seasonal Antiphon
          season_slug = season_to_antiphon_slug(day_info[:liturgical_season])
          antiphon = fetch_liturgical_text("morning_antiphon_#{season_slug}") if season_slug
          if antiphon
            lines << line_item(antiphon.content, type: "leader", slug: antiphon.slug)
          end

          {
            name: "Invitatory",
            slug: "invitatory",
            lines: lines
          }
        end

        def build_invitatory_canticle
          slug = is_easter? ? "pascha_nostrum" : (preferences[:morning_invitatory_canticle] || "venite")
          canticle = fetch_liturgical_text(slug)

          {
            name: canticle&.title || "Invitatory Psalm",
            slug: "invitatory_canticle",
            lines: [ line_item(canticle.content, type: "congregation", slug: canticle.slug) ]
          }
        end

        def build_psalms
          psalm_ref = readings[:psalm]
          return nil unless psalm_ref&.dig(:reference)

          lines = [
            line_item(psalm_ref[:reference], type: "heading"),
            line_item("", type: "spacer")
          ]

          if psalm_ref[:content]
            lines.concat(format_bible_content(psalm_ref[:content]))
            lines << line_item("", type: "spacer")
          end

          gloria = fetch_liturgical_text("gloria_patri")
          lines << line_item(gloria.content, type: "all", slug: gloria.slug) if gloria

          {
            name: "Psalms Appointed",
            slug: "psalms",
            lines: lines
          }
        end

        def build_lessons_and_canticles
          modules = []

          # First Lesson
          if readings[:first_reading]
            reading = readings[:first_reading]
            content = reading[:content]

            # Allow for abbreviated version if preferred (logic to be refined)
            ref_to_show = reading[:reference]

            lines = [
              line_item("A Reading from #{ref_to_show}.", type: "leader"),
              line_item("", type: "spacer")
            ]

            lines.concat(format_bible_content(content)) if content
            lines << line_item("", type: "spacer")
            lines << line_item("The Word of the Lord. **Thanks be to God.**", type: "responsive")

            modules << {
              name: "First Lesson",
              slug: "first_lesson",
              lines: lines,
              reference: ref_to_show
            }

            # Canticle after first lesson (Te Deum or Benedictus es Domine)
            # Traditionally Te Deum is used except in Lent/Advent
            c_slug = (is_lent? || is_advent?) ? "benedictus_es_domine" : "te_deum_laudamus"
            cant = fetch_liturgical_text(c_slug)
            modules << {
              name: cant.title,
              slug: c_slug,
              lines: [ line_item(cant.content, type: "congregation", slug: cant.slug) ]
            }
          end

          # Second Lesson
          if readings[:second_reading]
            reading = readings[:second_reading]
            content = reading[:content]

            lines = [
              line_item("A Reading from #{reading[:reference]}.", type: "leader"),
              line_item("", type: "spacer")
            ]

            lines.concat(format_bible_content(content)) if content
            lines << line_item("", type: "spacer")
            lines << line_item("The Word of the Lord. **Thanks be to God.**", type: "responsive")

            modules << {
              name: "Second Lesson",
              slug: "second_lesson",
              lines: lines,
              reference: reading[:reference]
            }

            # Canticle after second lesson (Benedictus)
            cant = fetch_liturgical_text("benedictus")
            modules << {
              name: cant.title,
              slug: "benedictus",
              lines: [ line_item(cant.content, type: "congregation", slug: cant.slug) ]
            }
          end

          modules
        end

        def build_creed
          creed = fetch_liturgical_text("apostles_creed")
          {
            name: "The Apostles' Creed",
            slug: "creed",
            lines: [ line_item(creed.content, type: "congregation", slug: creed.slug) ]
          }
        end

        def build_prayers
          lines = []
          lines << line_item("The Lord be with you. **And with your spirit. Let us pray.**", type: "responsive")
          lines << line_item("", type: "spacer")

          kyrie = fetch_liturgical_text("kyrie")
          lines << line_item(kyrie.content, type: "responsive", slug: kyrie.slug)
          lines << line_item("", type: "spacer")

          lp_slug = preferences[:lords_prayer_version] == "traditional" ? "our_father_traditional" : "our_father_contemporary"
          lp = fetch_liturgical_text(lp_slug)
          lines << line_item(lp.content, type: "congregation", slug: lp.slug)
          lines << line_item("", type: "spacer")

          suff = fetch_liturgical_text("suffrages")
          lines << line_item(suff.content, type: "responsive", slug: suff.slug)

          {
            name: "The Prayers",
            slug: "prayers",
            lines: lines
          }
        end

        def build_collects
          lines = []

          # 1. Collect of the Day
          if @collects
            lines << line_item(@collects)
            lines << line_item("", type: "spacer")
          end

          # 2. Fixed Collect for the day of the week
          weekday_name = date.strftime("%A").downcase # sunday, monday...
          collect = fetch_liturgical_text("morning_collect_#{weekday_name}")
          if collect
            lines << line_item(collect.title, type: "heading") if collect.title
            lines << line_item(collect.content, type: "leader", slug: collect.slug)
          end

          {
            name: "The Collects",
            slug: "collects",
            lines: lines
          }
        end

        def build_mission_prayer
          num = preferences[:morning_prayer_for_mission] || "1"
          miss = fetch_liturgical_text("prayer_for_mission_#{num}")

          {
            name: "Prayer for Mission",
            slug: "mission_prayer",
            lines: [ line_item(miss.content, type: "leader", slug: miss.slug) ]
          }
        end

        def build_thanksgiving
          gt = fetch_liturgical_text("general_thanksgiving")
          {
            name: "The General Thanksgiving",
            slug: "thanksgiving",
            lines: [
              line_item("Officiant and People", type: "rubric"),
              line_item(gt.content, type: "congregation", slug: gt.slug)
            ]
          }
        end

        def build_chrysostom_prayer
          chry = fetch_liturgical_text("chrysostom_prayer")
          {
            name: "A Prayer of St. John Chrysostom",
            slug: "chrysostom",
            lines: [ line_item(chry.content, type: "leader", slug: chry.slug) ]
          }
        end

        def build_dismissal
          dis = fetch_liturgical_text("dismissal")

          num = preferences[:morning_concluding_sentence] || "1"
          sent = fetch_liturgical_text("concluding_sentence_#{num}")

          lines = [ line_item(dis.content, type: "responsive", slug: dis.slug) ]
          lines << line_item("", type: "spacer")
          if sent
            lines << line_item(sent.content, type: "leader", slug: sent.slug)
            lines << line_item(sent.reference, type: "citation") if sent.reference
          end

          {
            name: "The Conclusion",
            slug: "dismissal",
            lines: lines
          }
        end

        # Helpers
        def is_easter?
          day_info[:liturgical_season]&.downcase == "páscoa"
        end

        def is_lent?
          day_info[:liturgical_season]&.downcase == "quaresma"
        end

        def is_advent?
          day_info[:liturgical_season]&.downcase == "advento"
        end
      end
    end
  end
end
