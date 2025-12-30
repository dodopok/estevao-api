# frozen_string_literal: true

module DailyOffice
  module Builders
    module Loc2019
      class Morning < Base
        def assemble_office
          [
            build_opening_sentence,
            build_confession,
            # build_absolution,
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
          season_slug = season_to_opening_sentence_slug(day_info[:liturgical_season])
          text = fetch_liturgical_text("morning_opening_sentence_#{season_slug}") if season_slug
          text ||= fetch_liturgical_text("morning_opening_sentence_#{num}")

          return nil unless text

          {
            name: "Sentença de Abertura",
            slug: "opening_sentence",
            lines: [
              line_item(text.content, slug: text.slug),
              line_item(text.reference, type: "citation")
            ].compact
          }
        end

        def build_confession
          lines = []

          rubric = fetch_liturgical_text("morning_confession_rubric")
          lines << line_item(rubric.content, type: "rubric", slug: rubric.slug) if rubric

          if preferences[:morning_confession_type] == "long"
            exhortation = fetch_liturgical_text("morning_confession_exhortation")
            lines << line_item(exhortation.content, slug: exhortation.slug) if exhortation
          else
            invitation = fetch_liturgical_text("morning_confession_invitation_short")
            lines << line_item(invitation.content, slug: invitation.slug) if invitation
          end

          lines << line_item("", type: "spacer")
          lines << line_item("Guarda-se silêncio. Todos ajoelhados.", type: "rubric")
          lines << line_item("", type: "spacer")

          confession = fetch_liturgical_text("morning_confession_body")
          lines << line_item(confession.content, slug: confession.slug) if confession

          lay_prayer_rubric = fetch_liturgical_text("prayer_for_pardon_lay_rubric")
          lines << line_item(lay_prayer_rubric.content, type: "rubric", slug: lay_prayer_rubric.slug) if lay_prayer_rubric

          lay_prayer = fetch_liturgical_text("prayer_for_pardon_lay")
          lines << line_item(lay_prayer.content, slug: lay_prayer.slug) if lay_prayer

          {
            name: "Confissão de Pecados",
            slug: "confession",
            lines: lines
          }
        end

        def build_invitatory
          lines = []
          (1..4).each do |i|
            v = fetch_liturgical_text("morning_inv_v#{i}")
            r = fetch_liturgical_text("morning_inv_r#{i}")
            lines << line_item(v.content, type: "leader", slug: v.slug) if v
            lines << line_item(r.content, type: "congregation", slug: r.slug) if r
          end

          season_slug = season_to_antiphon_slug(day_info[:liturgical_season])
          antiphon = fetch_liturgical_text("morning_antiphon_#{season_slug}") if season_slug
          if antiphon
            lines << line_item("", type: "spacer")
            lines << line_item(antiphon.content, type: "leader", slug: antiphon.slug)
          end

          {
            name: "Invitatório",
            slug: "invitatory",
            lines: lines
          }
        end

        def build_invitatory_canticle
          slug = is_easter? ? "pascha_nostrum" : (preferences[:morning_invitatory_canticle] || "venite")

          lines = []
          if slug == "venite"
            body = fetch_liturgical_text("venite_body")
            lines << line_item(body.content, slug: body.slug) if body
            if is_lent?
              lent = fetch_liturgical_text("venite_lent_addition")
              lines << line_item(lent.content, slug: lent.slug) if lent
            end
          else
            canticle = fetch_liturgical_text(slug)
            lines << line_item(canticle.content, slug: canticle.slug) if canticle
          end

          cant = fetch_liturgical_text(slug == "venite" ? "venite_body" : slug)
          {
            name: cant&.title || "Salmo Invitatório",
            slug: "invitatory_canticle",
            lines: lines
          }
        end

        def build_psalms
          psalm_ref = readings[:psalm]
          return nil unless psalm_ref&.dig(:reference)

          lines = [
            line_item(psalm_ref[:reference], type: "heading"),
            line_item("", type: "spacer")
          ]

          lines.concat(format_bible_content(psalm_ref[:content])) if psalm_ref[:content]

          lines << line_item("", type: "spacer")
          gloria = fetch_liturgical_text("gloria_patri")
          lines << line_item(gloria.content, slug: gloria.slug) if gloria

          {
            name: "Salmos Designados",
            slug: "psalms",
            lines: lines
          }
        end

        def build_lessons_and_canticles
          modules = []

          # Primeira Leitura
          if readings[:first_reading]
            reading = readings[:first_reading]
            lines = [
              line_item("Uma Leitura de #{reading[:reference]}.", type: "leader"),
              line_item("", type: "spacer")
            ]
            lines.concat(format_bible_content(reading[:content])) if reading[:content]
            lines << line_item("", type: "spacer")
            lines << line_item("Palavra do Senhor.", type: "leader")
            lines << line_item("Graças a Deus.", type: "congregation")

            modules << { name: "Primeira Leitura", slug: "first_lesson", lines: lines, reference: reading[:reference] }

            c_slug = (is_lent? || is_advent?) ? "benedictus_es_domine" : "te_deum_part_1"
            cant = fetch_liturgical_text(c_slug)
            c_lines = [ line_item(cant.content, slug: cant.slug) ]

            if c_slug == "te_deum_part_1"
              opt = fetch_liturgical_text("te_deum_part_2_optional")
              c_lines << line_item(opt.content, slug: opt.slug) if opt
            end

            modules << { name: cant.title || "Cântico", slug: c_slug, lines: c_lines }
          end

          # Segunda Leitura
          if readings[:second_reading]
            reading = readings[:second_reading]
            lines = [
              line_item("Uma Leitura de #{reading[:reference]}.", type: "leader"),
              line_item("", type: "spacer")
            ]
            lines.concat(format_bible_content(reading[:content])) if reading[:content]
            lines << line_item("", type: "spacer")
            lines << line_item("Palavra do Senhor.", type: "leader")
            lines << line_item("Graças a Deus.", type: "congregation")

            modules << { name: "Segunda Leitura", slug: "second_lesson", lines: lines, reference: reading[:reference] }

            cant = fetch_liturgical_text("benedictus")
            modules << { name: cant.title, slug: "benedictus", lines: [ line_item(cant.content, slug: cant.slug) ] }
          end

          modules
        end

        def build_creed
          creed = fetch_liturgical_text("apostles_creed")
          {
            name: "O Credo Apostólico",
            slug: "creed",
            lines: [
              line_item("Oficiante e Povo juntos, todos em pé", type: "rubric"),
              line_item(creed.content, slug: creed.slug)
            ]
          }
        end

        def build_prayers
          lines = []
          lines << line_item("O Senhor seja convosco.", type: "leader")
          lines << line_item("E com o teu espírito.", type: "congregation")
          lines << line_item("Oremos.", type: "leader")
          lines << line_item("", type: "spacer")

          %w[v r v2].each do |suffix|
            k = fetch_liturgical_text("kyrie_#{suffix}")
            lines << line_item(k.content, type: (suffix == "r" ? "congregation" : "leader"), slug: k.slug) if k
          end
          lines << line_item("", type: "spacer")

          lp_slug = preferences[:lords_prayer_version] == "traditional" ? "our_father_traditional" : "our_father_contemporary"
          lp = fetch_liturgical_text(lp_slug)
          lines << line_item(lp.content, slug: lp.slug) if lp
          lines << line_item("", type: "spacer")

          (1..7).each do |i|
            v = fetch_liturgical_text("suff_v#{i}")
            r = fetch_liturgical_text("suff_r#{i}")
            lines << line_item(v.content, type: "leader", slug: v.slug) if v
            lines << line_item(r.content, type: "congregation", slug: r.slug) if r
          end

          {
            name: "As Orações",
            slug: "prayers",
            lines: lines
          }
        end

        def build_collects
          {
            name: "As Coletas",
            slug: "collects",
            lines: build_collect_lines(@collects)
          }
        end

        def build_mission_prayer
          num = preferences[:morning_prayer_for_mission] || "1"
          miss = fetch_liturgical_text("prayer_for_mission_#{num}")
          {
            name: "Oração pela Missão",
            slug: "mission_prayer",
            lines: [ line_item(miss.content, slug: miss.slug) ]
          }
        end

        def build_thanksgiving
          gt = fetch_liturgical_text("general_thanksgiving")
          {
            name: "A Ação de Graças Geral",
            slug: "thanksgiving",
            lines: [
              line_item("Oficiante e Povo", type: "rubric"),
              line_item(gt.content, slug: gt.slug)
            ]
          }
        end

        def build_chrysostom_prayer
          chry = fetch_liturgical_text("chrysostom_prayer")
          {
            name: "Oração de São João Crisóstomo",
            slug: "chrysostom",
            lines: [ line_item(chry.content, slug: chry.slug) ]
          }
        end

        def build_dismissal
          v = fetch_liturgical_text("dismissal_v")
          r = fetch_liturgical_text("dismissal_r")

          num = preferences[:morning_concluding_sentence] || "1"
          sent = fetch_liturgical_text("concluding_sentence_#{num}")

          lines = []
          lines << line_item(v.content, type: "leader", slug: v.slug) if v
          lines << line_item(r.content, type: "congregation", slug: r.slug) if r
          lines << line_item("", type: "spacer")
          if sent
            lines << line_item(sent.content, slug: sent.slug)
            lines << line_item(sent.reference, type: "citation") if sent.reference
          end

          {
            name: "A Conclusão",
            slug: "dismissal",
            lines: lines
          }
        end

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
