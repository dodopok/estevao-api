# frozen_string_literal: true

module DailyOffice
  module Builders
    module Loc2019
      class Midday < Base
        def assemble_office
          [
            build_opening,
            build_psalms,
            build_reading,
            build_prayers,
            build_collects,
            build_dismissal
          ].flatten.compact
        end

        private

        def build_opening
          lines = []
          v1 = fetch_liturgical_text("midday_inv_v1")
          r1 = fetch_liturgical_text("midday_inv_r1")
          lines << line_item(v1.content, type: "leader", slug: v1.slug) if v1
          lines << line_item(r1.content, type: "congregation", slug: r1.slug) if r1

          v2 = fetch_liturgical_text("midday_inv_v2")
          r2 = fetch_liturgical_text("midday_inv_r2")
          lines << line_item(v2.content, type: "leader", slug: v2.slug) if v2

          r2_text = r2&.content
          r2_text += " Aleluia." if r2_text && !is_lent?
          lines << line_item(r2_text, type: "congregation", slug: r2&.slug) if r2

          rubric = fetch_liturgical_text("midday_opening_lent_rubric")
          lines << line_item(rubric.content, type: "rubric", slug: rubric.slug) if rubric

          rubric = fetch_liturgical_text("midday_hymn_rubric")
          lines << line_item(rubric.content, type: "rubric", slug: rubric.slug) if rubric

          {
            name: "Abertura",
            slug: "opening",
            lines: lines
          }
        end

        def build_psalms
          rubric = fetch_liturgical_text("midday_psalms_rubric")
          lines = [
            line_item(rubric.content, type: "rubric", slug: rubric.slug)
          ]

          all_psalm_slugs = %w[midday_psalm_119 midday_psalm_121 midday_psalm_124 midday_psalm_126]
          selected = resolve_preference(:midday_psalm_selection, all_psalm_slugs)
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
            name: "",
            slug: "psalms",
            lines: lines
          }
        end

        def build_reading
          rubric = fetch_liturgical_text("midday_reading_rubric")
          num = resolve_preference(:midday_reading, 1..3) || 1
          read = fetch_liturgical_text("midday_reading_#{num}")

          end_rubric = fetch_liturgical_text("midday_reading_end_rubric")
          meditation_rubric = fetch_liturgical_text("midday_meditation_rubric")

          lines = []
          lines << line_item(rubric.content, type: "rubric", slug: rubric.slug) if rubric
          lines << line_item(read.content, slug: read.slug) if read
          lines << line_item(read.reference, type: "citation") if read&.reference
          lines << line_item("", type: "spacer")
          lines << line_item(end_rubric.content, type: "rubric", slug: end_rubric.slug) if end_rubric
          lines << line_item("Palavra do Senhor.", type: "leader")
          lines << line_item("Graças a Deus.", type: "congregation")
          lines << line_item("", type: "spacer")
          lines << line_item(meditation_rubric.content, type: "rubric", slug: meditation_rubric.slug) if meditation_rubric

          {
            name: "",
            slug: "reading",
            lines: lines
          }
        end

        def build_prayers
          lines = []
          rubric = fetch_liturgical_text("midday_prayers_rubric")
          lines << line_item(rubric.content, type: "rubric", slug: rubric.slug) if rubric
          v_pre = fetch_liturgical_text("midday_pre_v")
          r_pre = fetch_liturgical_text("midday_pre_r")
          lines << line_item(v_pre.content, type: "leader", slug: v_pre.slug) if v_pre
          lines << line_item(r_pre.content, type: "congregation", slug: r_pre.slug) if r_pre
          lines << line_item("", type: "spacer")

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
          people_rubric = fetch_liturgical_text("midday_officiant_people_rubric")
          lines << line_item(people_rubric.content, type: "rubric", slug: people_rubric.slug) if people_rubric
          lp_slug = preferences[:lords_prayer_version] == "traditional" ? "our_father_traditional" : "our_father_contemporary"
          lp = fetch_liturgical_text(lp_slug)
          lines << line_item(lp.content, slug: lp.slug) if lp
          lines << line_item("", type: "spacer")

          v_post = fetch_liturgical_text("midday_post_v")
          r_post = fetch_liturgical_text("midday_post_r")
          lines << line_item(v_post.content, type: "leader", slug: v_post.slug) if v_post
          lines << line_item(r_post.content, type: "congregation", slug: r_post.slug) if r_post
          lines << line_item("Oremos.", type: "leader")

          {
            name: "",
            slug: "prayers",
            lines: lines
          }
        end

        def build_collects
          rubric = fetch_liturgical_text("midday_collects_rubric")
          lines = [
            line_item(rubric.content, type: "rubric", slug: rubric.slug)
          ] if rubric

          lines ||= []

          (1..4).each do |i|
            c = fetch_liturgical_text("midday_collect_#{i}")
            if c
              lines << line_item(c.content, slug: c.slug)
              lines << line_item("", type: "spacer")
            end
          end

          inter_rubric = fetch_liturgical_text("midday_intercessions_rubric")
          lines << line_item(inter_rubric.content, type: "rubric", slug: inter_rubric.slug) if inter_rubric

          {
            name: "",
            slug: "collects",
            lines: lines
          }
        end

        def build_dismissal
          lines = []
          lines << line_item("Bendigamos ao Senhor.", type: "leader")
          resp = "Demos graças a Deus."
          if is_easter_to_pentecost?
            resp += " Aleluia, aleluia."
          end
          lines << line_item(resp, type: "congregation")

          diss_rubric = fetch_liturgical_text("midday_dismissal_alleluia")
          lines << line_item(diss_rubric.content, type: "rubric", slug: diss_rubric.slug) if diss_rubric

          lines << line_item("", type: "spacer")
          concl_rubric = fetch_liturgical_text("midday_conclusion_rubric")
          lines << line_item(concl_rubric.content, type: "rubric", slug: concl_rubric.slug) if concl_rubric

          num = preferences[:midday_concluding_sentence] || "1"
          sent = fetch_liturgical_text("concluding_sentence_#{num}")
          if sent
            lines << line_item(sent.content, slug: sent.slug)
            lines << line_item(sent.reference, type: "citation") if sent.reference
          end

          {
            name: "",
            slug: "dismissal",
            lines: lines
          }
        end

        def is_lent?
          lent_season?(day_info[:liturgical_season])
        end

        def is_easter_to_pentecost?
          season = day_info[:liturgical_season]&.downcase
          season == "páscoa" || season == "pentecostes"
        end
      end
    end
  end
end
