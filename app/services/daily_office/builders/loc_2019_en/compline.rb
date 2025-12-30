# frozen_string_literal: true

module DailyOffice
  module Builders
    module Loc2019En
      class Compline < Base
        def assemble_office
          [
            build_opening,
            build_confession,
            build_invitatory,
            build_psalms,
            build_reading,
            build_responsory,
            build_prayers,
            build_collects,
            build_mission_prayer,
            build_thanksgiving,
            build_nunc_dimittis,
            build_dismissal
          ].flatten.compact
        end

        private

        def build_opening
          lines = []
          rubric = fetch_liturgical_text("compline_opening_rubric")
          lines << line_item(rubric.content, type: "rubric", slug: rubric.slug) if rubric

          text = fetch_liturgical_text("compline_opening_sentence")
          lines << line_item(text.content, slug: text.slug) if text

          v1 = fetch_liturgical_text("compline_inv_v1")
          r1 = fetch_liturgical_text("compline_inv_r1")
          lines << line_item(v1.content, type: "leader", slug: v1.slug) if v1
          lines << line_item(r1.content, type: "congregation", slug: r1.slug) if r1

          {
            name: "Opening",
            slug: "opening",
            lines: lines
          }
        end

        def build_confession
          lines = []
          rubric = fetch_liturgical_text("compline_confession_rubric")
          lines << line_item(rubric.content, type: "rubric", slug: rubric.slug) if rubric

          inv = fetch_liturgical_text("compline_confession_invitation")
          lines << line_item(inv.content, slug: inv.slug) if inv

          silence = fetch_liturgical_text("compline_silence_rubric")
          lines << line_item(silence.content, type: "rubric", slug: silence.slug) if silence

          conf = fetch_liturgical_text("compline_confession_body")
          lines << line_item(conf.content, slug: conf.slug) if conf

          abs_rubric = fetch_liturgical_text("compline_absolution_rubric")
          lines << line_item(abs_rubric.content, type: "rubric", slug: abs_rubric.slug) if abs_rubric

          abs = fetch_liturgical_text("compline_absolution")
          lines << line_item(abs.content, slug: abs.slug) if abs

          {
            name: "Confession of Sin",
            slug: "confession",
            lines: lines
          }
        end

        def build_invitatory
          lines = []
          v2 = fetch_liturgical_text("compline_inv_v2")
          r2 = fetch_liturgical_text("compline_inv_r2")
          lines << line_item(v2.content, type: "leader", slug: v2.slug) if v2
          lines << line_item(r2.content, type: "congregation", slug: r2.slug) if r2

          v3 = fetch_liturgical_text("compline_inv_v3")
          r3 = fetch_liturgical_text("compline_inv_r3")
          lines << line_item(v3.content, type: "leader", slug: v3.slug) if v3

          r3_text = r3&.content
          r3_text += " Alleluia." if r3_text && !is_lent?
          lines << line_item(r3_text, type: "congregation", slug: r3&.slug) if r3

          rubric = fetch_liturgical_text("midday_opening_lent_rubric") # Reuse "Except in Lent..."
          lines << line_item(rubric.content, type: "rubric", slug: rubric.slug) if rubric

          {
            name: "Invitatory",
            slug: "invitatory",
            lines: lines
          }
        end

        def build_psalms
          rubric = fetch_liturgical_text("compline_psalms_rubric")
          lines = []
          lines << line_item(rubric.content, type: "rubric", slug: rubric.slug) if rubric

          all_psalm_slugs = %w[compline_psalm_4 compline_psalm_31 compline_psalm_91 compline_psalm_134]
          selected = resolve_preference(:compline_psalm_selection, all_psalm_slugs)
          selected_slugs = Array(selected)

          selected_slugs.each do |slug|
            p = fetch_liturgical_text(slug)
            if p
              lines << line_item(p.title, type: "heading")
              lines << line_item(p.reference, type: "rubric")
              lines << line_item(p.content, slug: p.slug)
              lines << line_item("", type: "spacer")
            end
          end

          gloria_rubric = fetch_liturgical_text("midday_gloria_patri_rubric")
          lines << line_item(gloria_rubric.content, type: "rubric", slug: gloria_rubric.slug) if gloria_rubric
          gloria = fetch_liturgical_text("gloria_patri")
          lines << line_item(gloria.content, slug: gloria.slug) if gloria

          {
            name: "Psalms Appointed",
            slug: "psalms",
            lines: lines
          }
        end

        def build_reading
          rubric = fetch_liturgical_text("compline_reading_rubric")
          num = resolve_preference(:compline_reading_selection, 1..4) || 1
          read = fetch_liturgical_text("compline_reading_#{num}")

          lines = []
          lines << line_item(rubric.content, type: "rubric", slug: rubric.slug) if rubric
          if read
            lines << line_item(read.content, slug: read.slug)
            lines << line_item(read.reference, type: "citation")
          end

          lines << line_item("", type: "spacer")
          lines << line_item("At the end of the reading is said", type: "rubric")
          lines << line_item("The Word of the Lord.", type: "leader")
          lines << line_item("Thanks be to God.", type: "congregation")

          lines << line_item("", type: "spacer")
          med_rubric = fetch_liturgical_text("compline_meditation_rubric")
          lines << line_item(med_rubric.content, type: "rubric", slug: med_rubric.slug) if med_rubric

          {
            name: "Reading",
            slug: "reading",
            lines: lines
          }
        end

        def build_responsory
          lines = []
          (1..2).each do |i|
            v = fetch_liturgical_text("compline_resp_v#{i}")
            r = fetch_liturgical_text("compline_resp_r#{i}")
            lines << line_item(v.content, type: "leader", slug: v.slug) if v
            lines << line_item(r.content, type: "congregation", slug: r.slug) if r
          end

          {
            name: "Responsory",
            slug: "responsory",
            lines: lines
          }
        end

        def build_prayers
          lines = []
          version = preferences[:midday_kyrie_version] == "short" ? "short_" : ""

          if version == "short_"
            v1 = fetch_liturgical_text("midday_kyrie_short_v1")
            r1 = fetch_liturgical_text("midday_kyrie_short_r1")
            v2 = fetch_liturgical_text("midday_kyrie_short_v2")
            lines << line_item(v1.content, type: "leader", slug: v1.slug) if v1
            lines << line_item(r1.content, type: "congregation", slug: r1.slug) if r1
            lines << line_item(v2.content, type: "leader", slug: v2.slug) if v2
          else
            v1 = fetch_liturgical_text("midday_kyrie_v1")
            r1 = fetch_liturgical_text("midday_kyrie_r1")
            v2 = fetch_liturgical_text("midday_kyrie_v2")
            lines << line_item(v1.content, type: "leader", slug: v1.slug) if v1
            lines << line_item(r1.content, type: "congregation", slug: r1.slug) if r1
            lines << line_item(v2.content, type: "leader", slug: v2.slug) if v2
          end

          lines << line_item("", type: "spacer")
          lines << line_item("Officiant and People", type: "rubric")
          lp_slug = preferences[:lords_prayer_version] == "traditional" ? "our_father_traditional" : "our_father_contemporary"
          lp = fetch_liturgical_text(lp_slug)
          lines << line_item(lp.content, slug: lp.slug) if lp
          lines << line_item("", type: "spacer")

          v_post = fetch_liturgical_text("midday_post_v")
          r_post = fetch_liturgical_text("midday_post_r")
          lines << line_item(v_post.content, type: "leader", slug: v_post.slug) if v_post
          lines << line_item(r_post.content, type: "congregation", slug: r_post.slug) if r_post
          lines << line_item("Let us pray.", type: "leader")

          {
            name: "Prayers",
            slug: "prayers",
            lines: lines
          }
        end

        def build_collects
          lines = []
          rubric = fetch_liturgical_text("compline_collects_rubric")
          lines << line_item(rubric.content, type: "rubric", slug: rubric.slug) if rubric

          (1..4).each do |i|
            c = fetch_liturgical_text("compline_collect_#{i}")
            if c
              lines << line_item(c.content, slug: c.slug)
              lines << line_item("", type: "spacer")
            end
          end

          if is_saturday?
            sat = fetch_liturgical_text("compline_collect_saturday")
            if sat
              lines << line_item(sat.title, type: "heading")
              lines << line_item(sat.content, slug: sat.slug)
              lines << line_item("", type: "spacer")
            end
          end

          {
            name: "The Collects",
            slug: "collects",
            lines: lines
          }
        end

        def build_mission_prayer
          num = resolve_preference(:compline_mission_selection, 1..2) || 1
          miss = fetch_liturgical_text("compline_mission_#{num}")
          rubric = fetch_liturgical_text("compline_mission_rubric")

          lines = []
          lines << line_item(rubric.content, type: "rubric", slug: rubric.slug) if rubric
          lines << line_item(miss.content, slug: miss.slug) if miss

          lines << line_item("", type: "spacer")
          inter_rubric = fetch_liturgical_text("compline_intercessions_rubric")
          lines << line_item(inter_rubric.content, type: "rubric", slug: inter_rubric.slug) if inter_rubric

          {
            name: "Prayer for Mission",
            slug: "mission_prayer",
            lines: lines
          }
        end

        def build_thanksgiving
          # Optional General Thanksgiving
          # Rubric from Evening Prayer but adapted or shared
          # For Compline, it's before the close
          gt = fetch_liturgical_text("general_thanksgiving")
          lines = []
          lines << line_item("Before the close of the Office one or both of the following prayers may be used.", type: "rubric")
          lines << line_item("THE GENERAL THANKSGIVING", type: "heading")
          lines << line_item("Officiant and People", type: "rubric")
          lines << line_item(gt.content, slug: gt.slug) if gt

          {
            name: "Thanksgiving",
            slug: "thanksgiving",
            lines: lines
          }
        end

        def build_nunc_dimittis
          lines = []
          rubric = fetch_liturgical_text("compline_nunc_rubric")
          lines << line_item(rubric.content, type: "rubric", slug: rubric.slug) if rubric

          ant_slug = is_easter? ? "compline_nunc_antiphon_easter" : "compline_nunc_antiphon"
          ant = fetch_liturgical_text(ant_slug)
          lines << line_item(ant.content, type: "text", slug: ant.slug) if ant

          easter_rubric = fetch_liturgical_text("compline_nunc_easter_rubric")
          lines << line_item(easter_rubric.content, type: "rubric", slug: easter_rubric.slug) if easter_rubric && is_easter?

          lines << line_item("", type: "spacer")
          nunc = fetch_liturgical_text("nunc_dimittis")
          if nunc
            lines << line_item(nunc.title, type: "heading")
            lines << line_item(nunc.content, slug: nunc.slug)
          end

          lines << line_item("", type: "spacer")
          lines << line_item(ant.content, type: "text") if ant

          {
            name: "Song of Simeon",
            slug: "nunc_dimittis",
            lines: lines
          }
        end

        def build_dismissal
          lines = []
          lines << line_item("Let us bless the Lord.", type: "leader")
          lines << line_item("Thanks be to God.", type: "congregation")

          lines << line_item("", type: "spacer")
          rubric = fetch_liturgical_text("compline_conclusion_rubric")
          lines << line_item(rubric.content, type: "rubric", slug: rubric.slug) if rubric

          text = fetch_liturgical_text("compline_conclusion")
          lines << line_item(text.content, slug: text.slug) if text

          {
            name: "The Conclusion",
            slug: "dismissal",
            lines: lines
          }
        end

        def is_lent?
          lent_season?(day_info[:liturgical_season])
        end

        def is_easter?
          day_info[:liturgical_season]&.downcase == "páscoa"
        end

        def is_saturday?
          date.saturday?
        end
      end
    end
  end
end
