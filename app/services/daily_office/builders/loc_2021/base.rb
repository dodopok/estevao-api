# frozen_string_literal: true

module DailyOffice
  module Builders
    module Loc2021
      class Base < LocBase
        protected

        def build_welcome
          m = fetch_liturgical_text("opening_welcome_m")
          return nil unless m

          {
            name: "ACOLHIDA",
            slug: "welcome",
            lines: [
              line_item(m.content, type: "leader", slug: m.slug)
            ].compact
          }
        end

        def build_confession
          lines = []

          # Invitation
          m1 = fetch_liturgical_text("confession_invitation_m1")
          lines << line_item(m1.content, type: "leader", slug: m1.slug) if m1

          m2 = fetch_liturgical_text("confession_invitation_m2")
          lines << line_item(m2.content, type: "leader", slug: m2.slug) if m2

          lines << line_item("", type: "spacer")
          lines << line_item("", type: "spacer")

          # Confession body
          confession = fetch_liturgical_text("confession_body")
          lines << line_item(confession.content, type: "congregation", slug: confession.slug) if confession

          {
            name: "CONVITE À CONFISSÃO",
            slug: "confession",
            lines: lines
          }
        end

        def build_absolution
          m = fetch_liturgical_text("absolution_m")
          r = fetch_liturgical_text("absolution_r")
          return nil unless m

          {
            name: "DECLARAÇÃO DE PERDÃO",
            slug: "absolution",
            lines: [
              line_item(m.content, type: "leader", slug: m.slug),
              line_item(r&.content, type: "congregation", slug: r&.slug)
            ].compact
          }
        end

        def build_thanksgiving
          m = fetch_liturgical_text("thanksgiving_m")
          r = fetch_liturgical_text("thanksgiving_r")
          return nil unless m

          {
            name: "ORAÇÃO DE AÇÃO DE GRAÇAS",
            slug: "thanksgiving",
            lines: [
              line_item(m.content, type: "leader", slug: m.slug),
              line_item(r&.content, type: "congregation", slug: r&.slug)
            ].compact
          }
        end

        def build_lessons
          modules = []

          [ :first_reading, :second_reading, :gospel ].each do |reading_key|
            reading = readings[reading_key]
            next unless reading

            lines = [
              line_item("Uma Leitura de #{reading[:reference]}.", type: "leader"),
              line_item("", type: "spacer")
            ]
            lines.concat(format_bible_content(reading[:content])) if reading[:content]
            lines << line_item("", type: "spacer")

            intro = fetch_liturgical_text("reading_introduction")
            lines << line_item(intro.content, type: "rubric", slug: intro.slug) if intro

            v = fetch_liturgical_text("reading_v")
            r = fetch_liturgical_text("reading_r")
            lines << line_item(v.content, type: "leader", slug: v.slug) if v
            lines << line_item(r.content, type: "congregation", slug: r.slug) if r

            modules << {
              name: "LEITURA DAS ESCRITURAS",
              slug: reading_key.to_s,
              lines: lines,
              reference: reading[:reference]
            }
          end

          modules
        end

        def build_creed
          slug = preferences["#{office_type}_creed_type"] == "nicene" ? "credo_niceno" : "credo_apostolico"
          creed = fetch_liturgical_text(slug)
          return nil unless creed

          {
            name: "O CREDO",
            slug: "creed",
            lines: [ line_item(creed.content, type: "congregation", slug: creed.slug) ]
          }
        end

        def build_lords_prayer
          lp = fetch_liturgical_text("lords_prayer_contemporary")
          return nil unless lp

          {
            name: "A ORAÇÃO DO SENHOR",
            slug: "lords_prayer",
            lines: [ line_item(lp.content, type: "congregation", slug: lp.slug) ]
          }
        end

        def build_blessing
          m = fetch_liturgical_text("blessing_m")
          r = fetch_liturgical_text("blessing_r")
          return nil unless m

          {
            name: "A BÊNÇÃO",
            slug: "blessing",
            lines: [
              line_item(m.content, type: "leader", slug: m.slug),
              line_item(r&.content, type: "congregation", slug: r&.slug)
            ].compact
          }
        end

        def build_other_prayers
          rubric = fetch_liturgical_text("other_prayers_rubric")

          {
            name: "ORAÇÃO PASTORAL",
            slug: "other_prayers",
            lines: [ line_item(rubric.content, type: "rubric", slug: rubric.slug) ]
          }
        end

        def build_collect_of_the_day
          {
            name: "ORAÇÃO DO DIA",
            slug: "collect_of_the_day",
            lines: build_collect_lines(@collects)
          }
        end

        # Alternative Office specific methods
        def build_alt_welcome
          m = fetch_liturgical_text("alt_office_welcome_m")
          intro = fetch_liturgical_text("alt_office_intro")
          return nil unless m

          {
            name: "ACOLHIDA",
            slug: "welcome",
            lines: [
              line_item(intro&.content, type: "rubric", slug: intro&.slug),
              line_item(m.content, type: "leader", slug: m.slug)
            ].compact
          }
        end

        def build_alt_confession
          rubric = fetch_liturgical_text("alt_confession_rubric")
          text = fetch_liturgical_text("alt_confession_body")

          m = fetch_liturgical_text("alt_absolution_m")
          r = fetch_liturgical_text("alt_absolution_r")

          {
            name: "CONFISSÃO",
            slug: "confession",
            lines: [
              line_item(text.content, type: "congregation", slug: text.slug),
              line_item(rubric.content, type: "rubric", slug: rubric.slug),
              line_item(m.content, type: "leader", slug: m.slug),
              line_item(r&.content, type: "congregation", slug: r&.slug)
            ]
          }
        end
      end
    end
  end
end
