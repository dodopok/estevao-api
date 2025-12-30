# frozen_string_literal: true

module DailyOffice
  module Builders
    module Loc2019En
      class Evening < Base
        def assemble_office
          [
            build_opening_sentence,
            build_confession,
            build_invitatory,
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
          num = resolve_preference(:evening_opening_sentence, 1..3) || 1
          season_slug = season_to_opening_sentence_slug(day_info[:liturgical_season])
          text = fetch_liturgical_text("evening_opening_sentence_#{season_slug}") if season_slug
          text ||= fetch_liturgical_text("evening_opening_sentence_#{num}")

          rubric = fetch_liturgical_text("evening_opening_rubric")

          lines = []
          lines << line_item(rubric.content, type: "rubric", slug: rubric.slug) if rubric
          if text
            lines << line_item(text.content, slug: text.slug)
            lines << line_item(text.reference, type: "citation") if text.reference
          end

          {
            name: "Opening Sentence",
            slug: "opening_sentence",
            lines: lines
          }
        end

        def build_confession
          lines = []

          rubric = fetch_liturgical_text("evening_confession_rubric")
          lines << line_item(rubric.content, type: "rubric", slug: rubric.slug) if rubric

          if preferences[:evening_confession_type] == "long"
            exhortation = fetch_liturgical_text("morning_confession_exhortation") # Shared with morning
            lines << line_item(exhortation.content, slug: exhortation.slug) if exhortation
          else
            invitation = fetch_liturgical_text("morning_confession_invitation_short") # Shared
            lines << line_item(invitation.content, slug: invitation.slug) if invitation
          end

          lines << line_item("", type: "spacer")
          lines << line_item("Silence is kept. All kneeling.", type: "rubric")
          lines << line_item("", type: "spacer")

          confession = fetch_liturgical_text("morning_confession_body") # Shared
          lines << line_item(confession.content, slug: confession.slug) if confession

          lay_prayer_rubric = fetch_liturgical_text("prayer_for_pardon_lay_rubric") # Shared
          lines << line_item(lay_prayer_rubric.content, type: "rubric", slug: lay_prayer_rubric.slug) if lay_prayer_rubric

          lay_prayer = fetch_liturgical_text("prayer_for_pardon_lay") # Shared
          lines << line_item(lay_prayer.content, slug: lay_prayer.slug) if lay_prayer

          {
            name: "Confession of Sin",
            slug: "confession",
            lines: lines
          }
        end

        def build_invitatory
          lines = []
          lines << line_item("All stand.", type: "rubric")
          (1..4).each do |i|
            v = fetch_liturgical_text("morning_inv_v#{i}") # Shared
            r = fetch_liturgical_text("morning_inv_r#{i}") # Shared
            lines << line_item(v.content, type: "leader", slug: v.slug) if v
            lines << line_item(r.content, type: "congregation", slug: r.slug) if r
          end

          lines << line_item("", type: "spacer")
          ph_rubric = fetch_liturgical_text("evening_phos_hilaron_rubric")
          lines << line_item(ph_rubric.content, type: "rubric", slug: ph_rubric.slug) if ph_rubric

          ph = fetch_liturgical_text("phos_hilaron")
          if ph
            lines << line_item(ph.title, type: "heading")
            lines << line_item(ph.content, slug: ph.slug)
          end

          {
            name: "Invitatory",
            slug: "invitatory",
            lines: lines
          }
        end

        def build_psalms
          psalm_ref = readings[:psalm]
          return nil unless psalm_ref&.dig(:reference)

          lines = [
            line_item("THE PSALM OR PSALMS APPOINTED", type: "heading"),
            line_item(psalm_ref[:reference], type: "subtitle"),
            line_item("", type: "spacer")
          ]

          lines.concat(format_bible_content(psalm_ref[:content])) if psalm_ref[:content]

          lines << line_item("", type: "spacer")
          gloria_rubric = fetch_liturgical_text("midday_gloria_patri_rubric") # Reuse this rubric
          lines << line_item(gloria_rubric.content, type: "rubric", slug: gloria_rubric.slug) if gloria_rubric
          gloria = fetch_liturgical_text("gloria_patri")
          lines << line_item(gloria.content, slug: gloria.slug) if gloria

          {
            name: "Psalms Appointed",
            slug: "psalms",
            lines: lines
          }
        end

        def build_lessons_and_canticles
          modules = []

          first_rubric = fetch_liturgical_text("evening_reading_first_rubric")
          citation_rubric = fetch_liturgical_text("evening_reading_citation_rubric")
          after_rubric = fetch_liturgical_text("evening_reading_after_rubric")
          end_rubric = fetch_liturgical_text("evening_reading_end_rubric")
          cant_rubric = fetch_liturgical_text("evening_canticle_rubric")

          # First Lesson
          if readings[:first_reading]
            reading = readings[:first_reading]
            lines = []
            lines << line_item(first_rubric.content, type: "rubric", slug: first_rubric.slug) if first_rubric
            lines << line_item("A Reading from #{reading[:reference]}.", type: "leader")
            lines << line_item(citation_rubric.content, type: "rubric", slug: citation_rubric.slug) if citation_rubric
            lines << line_item("", type: "spacer")
            lines.concat(format_bible_content(reading[:content])) if reading[:content]
            lines << line_item("", type: "spacer")
            lines << line_item(after_rubric.content, type: "rubric", slug: after_rubric.slug) if after_rubric
            lines << line_item("The Word of the Lord.", type: "leader")
            lines << line_item("Thanks be to God.", type: "congregation")
            lines << line_item(end_rubric.content, type: "rubric", slug: end_rubric.slug) if end_rubric
            lines << line_item("Here ends the Reading.", type: "leader")

            modules << { name: "First Lesson", slug: "first_lesson", lines: lines, reference: reading[:reference] }

            cant = fetch_liturgical_text("magnificat")
            c_lines = []
            c_lines << line_item(cant_rubric.content, type: "rubric", slug: cant_rubric.slug) if cant_rubric
            c_lines << line_item(cant.content, slug: cant.slug) if cant

            modules << { name: cant&.title || "Magnificat", slug: "magnificat", lines: c_lines }
          end

          # Second Lesson
          if readings[:second_reading]
            reading = readings[:second_reading]
            lines = []
            lines << line_item("A Reading from #{reading[:reference]}.", type: "leader")
            lines << line_item("", type: "spacer")
            lines.concat(format_bible_content(reading[:content])) if reading[:content]
            lines << line_item("", type: "spacer")
            lines << line_item("The Word of the Lord.", type: "leader")
            lines << line_item("Thanks be to God.", type: "congregation")
            lines << line_item("Here ends the Reading.", type: "leader")

            modules << { name: "Second Lesson", slug: "second_lesson", lines: lines, reference: reading[:reference] }

            cant = fetch_liturgical_text("nunc_dimittis")
            modules << { name: cant&.title || "Nunc Dimittis", slug: "nunc_dimittis", lines: [ line_item(cant.content, slug: cant.slug) ] }
          end

          modules
        end

        def build_creed
          creed = fetch_liturgical_text("apostles_creed")
          {
            name: "The Apostles' Creed",
            slug: "creed",
            lines: [
              line_item("Officiant and People together, all standing", type: "rubric"),
              line_item(creed.content, slug: creed.slug)
            ]
          }
        end

        def build_prayers
          lines = []
          lines << line_item("The Lord be with you.", type: "leader")
          lines << line_item("And with your spirit.", type: "congregation")
          lines << line_item("Let us pray.", type: "leader")
          lines << line_item("The People kneel or stand.", type: "rubric")
          lines << line_item("", type: "spacer")

          %w[v r v2].each do |suffix|
            k = fetch_liturgical_text("kyrie_#{suffix}")
            lines << line_item(k.content, type: (suffix == "r" ? "congregation" : "leader"), slug: k.slug) if k
          end
          lines << line_item("", type: "spacer")

          lines << line_item("Officiant and People", type: "rubric")
          lp_slug = preferences[:lords_prayer_version] == "traditional" ? "our_father_traditional" : "our_father_contemporary"
          lp = fetch_liturgical_text(lp_slug)
          lines << line_item(lp.content, slug: lp.slug) if lp
          lines << line_item("", type: "spacer")

          suff_type = preferences[:evening_suffrages_type] || "a"
          if suff_type == "b"
            rubric = fetch_liturgical_text("evening_suff_b_rubric")
            resp = fetch_liturgical_text("evening_suff_b_response")
            lines << line_item(rubric.content, type: "leader", slug: rubric.slug) if rubric
            lines << line_item(resp.content, type: "congregation", slug: resp.slug) if resp
            lines << line_item("", type: "spacer")
            (1..5).each do |i|
              s = fetch_liturgical_text("evening_suff_b_#{i}")
              lines << line_item(s.content, type: "leader", slug: s.slug) if s
              lines << line_item(resp.content, type: "congregation") if resp
            end
          else
            (1..7).each do |i|
              v = fetch_liturgical_text("suff_v#{i}")
              r = fetch_liturgical_text("suff_r#{i}")
              lines << line_item(v.content, type: "leader", slug: v.slug) if v
              lines << line_item(r.content, type: "congregation", slug: r.slug) if r
            end
          end

          {
            name: "The Prayers",
            slug: "prayers",
            lines: lines
          }
        end

        def build_collects
          rubric = fetch_liturgical_text("evening_collects_rubric")
          lines = []
          lines << line_item(rubric.content, type: "rubric", slug: rubric.slug) if rubric

          lines.concat(build_collect_lines(@collects))

          {
            name: "The Collects",
            slug: "collects",
            lines: lines
          }
        end

        def build_mission_prayer
          num = preferences[:evening_prayer_for_mission] || "1"
          miss = fetch_liturgical_text("evening_prayer_for_mission_#{num}")
          rubric = fetch_liturgical_text("evening_mission_rubric")

          lines = []
          lines << line_item(rubric.content, type: "rubric", slug: rubric.slug) if rubric
          lines << line_item(miss.content, slug: miss.slug) if miss

          {
            name: "Prayer for Mission",
            slug: "mission_prayer",
            lines: lines
          }
        end

        def build_thanksgiving
          gt = fetch_liturgical_text("general_thanksgiving")
          rubric = fetch_liturgical_text("evening_thanksgiving_rubric")
          lines = []
          lines << line_item(rubric.content, type: "rubric", slug: rubric.slug) if rubric
          lines << line_item("Officiant and People", type: "rubric")
          lines << line_item(gt.content, slug: gt.slug) if gt

          {
            name: "The General Thanksgiving",
            slug: "thanksgiving",
            lines: lines
          }
        end

        def build_chrysostom_prayer
          chry = fetch_liturgical_text("chrysostom_prayer")
          {
            name: "A Prayer of St. John Chrysostom",
            slug: "chrysostom",
            lines: [ line_item(chry.content, slug: chry.slug) ]
          }
        end

        def build_dismissal
          v = fetch_liturgical_text("dismissal_v")
          r = fetch_liturgical_text("dismissal_r")

          num = preferences[:evening_concluding_sentence] || "1"
          sent = fetch_liturgical_text("concluding_sentence_#{num}")

          rubric = fetch_liturgical_text("evening_conclusion_rubric")

          lines = []
          lines << line_item(v.content, type: "leader", slug: v.slug) if v
          lines << line_item(r.content, type: "congregation", slug: r.slug) if r
          if is_easter_to_pentecost?
            lines << line_item("Alleluia, alleluia.", type: "congregation")
          end

          lines << line_item("", type: "spacer")
          lines << line_item(rubric.content, type: "rubric", slug: rubric.slug) if rubric
          if sent
            lines << line_item(sent.content, slug: sent.slug)
            lines << line_item(sent.reference, type: "citation") if sent.reference
          end

          {
            name: "The Conclusion",
            slug: "dismissal",
            lines: lines
          }
        end

        def is_easter_to_pentecost?
          season = day_info[:liturgical_season]&.downcase
          season == "páscoa" || season == "pentecostes"
        end
      end
    end
  end
end
