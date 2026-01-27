# frozen_string_literal: true

module DailyOffice
  module Builders
    module Loc1987
      class Evening < LocBase
        def assemble_office
          assemble_evening_prayer
        end

        def assemble_evening_prayer
          [
            build_introductory_sentences,
            build_confession,
            build_invitatory,
            build_psalms,
            build_readings_and_canticles,
            build_creed,
            build_offertory,
            build_prayers,
            build_conclusion
          ].flatten.compact
        end

        private

        # ============================================================================
        # 1. SENTENÇAS INTRODUTÓRIAS
        # ============================================================================
        def build_introductory_sentences
          lines = []

          # Try seasonal sentence first
          season_slug = season_sentence_slug
          minister_sentence = fetch_liturgical_text(season_slug + "_minister")
          people_sentence = fetch_liturgical_text(season_slug + "_people")

          # Fallback to evening specific
          unless minister_sentence
            minister_sentence = fetch_liturgical_text("evening_opening_sentence_minister")
            people_sentence = fetch_liturgical_text("evening_opening_sentence_people")
          end

          if minister_sentence
            lines << line_item(minister_sentence.content, type: "leader", slug: minister_sentence.slug)
          end
          if people_sentence
            lines << line_item(people_sentence.content, type: "congregation", slug: people_sentence.slug)
          end

          {
            name: "Sentenças Introdutórias",
            slug: "introductory_sentences",
            lines: lines
          }
        end

        def season_sentence_slug
          season = day_info[:liturgical_season]&.downcase
          case season
          when "advento" then "opening_sentence_advent"
          when "natal" then "opening_sentence_christmas"
          when "epifania" then "opening_sentence_epiphany"
          when "quaresma" then "opening_sentence_lent"
          when "semana santa" then "opening_sentence_holy_week"
          when "paixão" then "opening_sentence_passion"
          when "páscoa" then "opening_sentence_easter"
          when "ascensão" then "opening_sentence_ascension"
          when "pentecostes" then "opening_sentence_pentecost"
          else "opening_sentence_general_1"
          end
        end

        # ============================================================================
        # 2. CONFISSÃO E ABSOLVIÇÃO
        # ============================================================================
        def build_confession
          lines = []

          rubric_intro = fetch_liturgical_text("rubric_confession_intro")
          lines << line_item(rubric_intro.content, type: "rubric", slug: rubric_intro.slug) if rubric_intro

          invitation_opt = resolve_preference(:evening_confession_type, %w[1 2 3])
          invitation_slug = invitation_opt == "2" ? "confession_invitation_2" : "confession_invitation_1"

          invitation = fetch_liturgical_text(invitation_slug)
          if invitation
            lines << line_item(invitation.content, type: "leader", slug: invitation.slug)
            lines << line_item("", type: "spacer")
          end

          rubric_silence = fetch_liturgical_text("rubric_confession_silence")
          if rubric_silence
            lines << line_item(rubric_silence.content, type: "rubric", slug: rubric_silence.slug)
            lines << line_item("", type: "spacer")
          end

          conf_opt = resolve_preference(:evening_confession_type, %w[1 2 3]) || "1"

          confession = fetch_liturgical_text("confession_prayer_#{conf_opt}")
          if confession
            lines << line_item(confession.content, type: "congregation", slug: confession.slug)
            lines << line_item("", type: "spacer")
          end

          # Absolution
          rubric_abs_intro = fetch_liturgical_text("rubric_absolution_intro")
          lines << line_item(rubric_abs_intro.content, type: "rubric", slug: rubric_abs_intro.slug) if rubric_abs_intro

          rubric_abs_priest = fetch_liturgical_text("rubric_absolution_priest")
          lines << line_item(rubric_abs_priest.content, type: "rubric", slug: rubric_abs_priest.slug) if rubric_abs_priest

          absolution = fetch_liturgical_text("absolution_priest")
          if absolution
            lines << line_item(absolution.content, type: "leader", slug: absolution.slug)
          end

          {
            name: "Confissão e Absolvição",
            slug: "confession",
            lines: lines
          }
        end

        # ============================================================================
        # 3. INVITATÓRIO E SALMO
        # ============================================================================
        def build_invitatory
          lines = []

          rubric_stand = fetch_liturgical_text("rubric_invitatory_stand")
          lines << line_item(rubric_stand.content, type: "rubric", slug: rubric_stand.slug) if rubric_stand

          # Opening Lips (Used for Evening too in this text?)
          lines << line_item("Abre, ó Senhor, os nossos lábios.", type: "leader")
          lines << line_item("E a nossa boca proclamará o teu louvor.", type: "congregation")
          lines << line_item("Glória a Deus nas alturas!", type: "leader")
          lines << line_item("E na terra paz, boa-vontade entre os homens.", type: "congregation")
          lines << line_item("Louvemos ao Senhor.", type: "leader")
          lines << line_item("Aleluia!", type: "congregation")
          lines << line_item("", type: "spacer")

          # No Venite for Evening typically.

          {
            name: "Invitatório",
            slug: "invitatory",
            lines: lines
          }
        end

        # ============================================================================
        # 4. SALMOS
        # ============================================================================
        def build_psalms
          psalm_ref = readings[:psalm]
          return nil unless psalm_ref

          lines = []
          rubric_psalms = fetch_liturgical_text("rubric_psalms")
          lines << line_item(rubric_psalms.content, type: "rubric", slug: rubric_psalms.slug) if rubric_psalms

          lines << line_item(psalm_ref[:reference], type: "heading")
          lines << line_item("", type: "spacer")

          if psalm_ref[:content]
            lines.concat(format_bible_content(psalm_ref[:content]))
            lines << line_item("", type: "spacer")
          end

          lines << line_item("Glória ao Pai e ao Filho, * e ao Espírito Santo;", type: "leader")
          lines << line_item("Como era no princípio, é agora e será sempre, * por todos os séculos. Amém.", type: "congregation")

          {
            name: "Salmos",
            slug: "psalms",
            lines: lines
          }
        end

        # ============================================================================
        # 5. LEITURAS E CÂNTICOS
        # ============================================================================
        def build_readings_and_canticles
          lines = []

          rubric_sit = fetch_liturgical_text("rubric_readings_sit")
          lines << line_item(rubric_sit.content, type: "rubric", slug: rubric_sit.slug) if rubric_sit

          rubric_announce = fetch_liturgical_text("rubric_readings_announcement")
          if rubric_announce
            # Substitute placeholders with first reading data
            rubric_content = substitute_reading_placeholders(rubric_announce.content, readings[:first_reading])
            lines << line_item(rubric_content, type: "rubric", slug: rubric_announce.slug)
          end

          # First Reading
          if readings[:first_reading]
            lines << line_item(readings[:first_reading][:reference], type: "heading")
            lines << line_item("", type: "spacer")
            lines.concat(format_bible_content(readings[:first_reading][:content])) if readings[:first_reading][:content]

            rubric_end = fetch_liturgical_text("rubric_readings_end")
            lines << line_item(rubric_end.content, type: "rubric", slug: rubric_end.slug) if rubric_end

            lines << line_item("Palavra do Senhor.", type: "leader")
            lines << line_item("Demos graças a Deus.", type: "congregation")
            lines << line_item("", type: "spacer")
          end

          # Canticle 1
          rubric_silence = fetch_liturgical_text("rubric_readings_silence")
          lines << line_item(rubric_silence.content, type: "rubric", slug: rubric_silence.slug) if rubric_silence

          canticle_slug = resolve_preference(:evening_canticle_1, %w[magnificat cantate_domino bonum_est]) || "magnificat"
          canticle = fetch_liturgical_text(canticle_slug)
          if canticle
            lines << line_item(canticle.content, slug: canticle.slug)
            lines << line_item("", type: "spacer")
          end

          # Second Reading
          if readings[:second_reading]
            lines << line_item(readings[:second_reading][:reference], type: "heading")
            lines << line_item("", type: "spacer")
            lines.concat(format_bible_content(readings[:second_reading][:content])) if readings[:second_reading][:content]

            rubric_end = fetch_liturgical_text("rubric_readings_end")
            lines << line_item(rubric_end.content, type: "rubric", slug: rubric_end.slug) if rubric_end

            lines << line_item("Palavra do Senhor.", type: "leader")
            lines << line_item("Demos graças a Deus.", type: "congregation")
            lines << line_item("", type: "spacer")
          end

          # Canticle 2
          if rubric_silence
            lines << line_item(rubric_silence.content, type: "rubric", slug: rubric_silence.slug)
          end

          canticle2_slug = resolve_preference(:evening_canticle_2, %w[nunc_dimittis deus_misereatur benedic_anima_mea]) || "nunc_dimittis"
          canticle2 = fetch_liturgical_text(canticle2_slug)
          if canticle2
            lines << line_item(canticle2.content, slug: canticle2.slug)
          end

          rubric_sermon = fetch_liturgical_text("rubric_sermon")
          lines << line_item(rubric_sermon.content, type: "rubric", slug: rubric_sermon.slug) if rubric_sermon

          {
            name: "Leitura da Palavra de Deus",
            slug: "readings",
            lines: lines
          }
        end

        # ============================================================================
        # 6. CREDO
        # ============================================================================
        def build_creed
          lines = []

          rubric_stand = fetch_liturgical_text("rubric_creed_stand")
          lines << line_item(rubric_stand.content, type: "rubric", slug: rubric_stand.slug) if rubric_stand

          creed = fetch_liturgical_text("apostles_creed")
          if creed
            lines << line_item(creed.content, type: "congregation", slug: creed.slug)
          end

          {
            name: "Credo",
            slug: "creed",
            lines: lines
          }
        end

        # ============================================================================
        # 7. OFERTÓRIO
        # ============================================================================
        def build_offertory
          offertory = fetch_liturgical_text("offertory_sentence")
          return nil unless offertory

          lines = []
          rubric_off = fetch_liturgical_text("rubric_offertory")
          lines << line_item(rubric_off.content, type: "rubric", slug: rubric_off.slug) if rubric_off

          lines << line_item(offertory.content, type: "leader", slug: offertory.slug)

          {
            name: "Ofertório",
            slug: "offertory",
            lines: lines
          }
        end

        # ============================================================================
        # 8. ORAÇÕES
        # ============================================================================
        def build_prayers
          lines = []

          rubric_prayers = fetch_liturgical_text("rubric_prayers_intro")
          lines << line_item(rubric_prayers.content, type: "rubric", slug: rubric_prayers.slug) if rubric_prayers

          lines << line_item("O Senhor seja convosco", type: "leader")
          lines << line_item("Seja também contigo", type: "congregation")
          lines << line_item("Oremos", type: "leader")
          lines << line_item("", type: "spacer")

          lords_prayer = fetch_liturgical_text("lords_prayer_traditional")
          lines << line_item(lords_prayer.content, type: "congregation", slug: lords_prayer.slug) if lords_prayer
          lines << line_item("", type: "spacer")

          # Suffrages
          rubric_suff = fetch_liturgical_text("rubric_suffrages_intro")
          lines << line_item(rubric_suff.content, type: "rubric", slug: rubric_suff.slug) if rubric_suff

          suff_opt = resolve_preference(:evening_suffrages, %w[1 2]) || "1"
          if suff_opt == "1"
            7.times do |i|
              v = fetch_liturgical_text("suffrages_1_v#{i + 1}")
              r = fetch_liturgical_text("suffrages_1_r#{i + 1}")
              lines << line_item(v.content, type: "leader") if v
              lines << line_item(r.content, type: "congregation") if r
            end
          else
            5.times do |i|
              v = fetch_liturgical_text("suffrages_2_v#{i + 1}")
              r = fetch_liturgical_text("suffrages_2_r#{i + 1}")
              lines << line_item(v.content, type: "leader") if v
              lines << line_item(r.content, type: "congregation") if r
            end
          end
          lines << line_item("", type: "spacer")

          # Collect of the Day
          rubric_coll = fetch_liturgical_text("rubric_collects_intro")
          lines << line_item(rubric_coll.content, type: "rubric", slug: rubric_coll.slug) if rubric_coll

          lines.concat(build_collect_lines(@collects))

          # Fixed Collects for Evening
          rubric_gen = fetch_liturgical_text("rubric_prayers_general")
          lines << line_item(rubric_gen.content, type: "rubric", slug: rubric_gen.slug) if rubric_gen

          rubric_bridge = fetch_liturgical_text("rubric_communion_bridge")
          lines << line_item(rubric_bridge.content, type: "rubric", slug: rubric_bridge.slug) if rubric_bridge

          # "Pela Paz" (Evening version)
          collect_peace = fetch_liturgical_text("collect_peace_2")
          lines << line_item(collect_peace.content, type: "leader") if collect_peace

          # No specialized Evening Grace in text (except "Pela graça" which is Morning).
          # I'll add "Prayer for all humanity" or others as evening prayers.

          prayer_all = fetch_liturgical_text("prayer_all_humanity")

          chrysostom = fetch_liturgical_text("prayer_chrysostom")
          lines << line_item(chrysostom.content, type: "leader") if chrysostom

          {
            name: "Orações",
            slug: "prayers",
            lines: lines
          }
        end

        # ============================================================================
        # 9. CONCLUSÃO
        # ============================================================================
        def build_conclusion
          lines = []

          conc_opt = resolve_preference(:evening_conclusion, %w[1 2 3]) || "1"

          if conc_opt != "1"
            rubric_conc = fetch_liturgical_text("rubric_conclusion_options")
            lines << line_item(rubric_conc.content, type: "rubric", slug: rubric_conc.slug) if rubric_conc
          end

          case conc_opt
          when "1"
            grace = fetch_liturgical_text("conclusion_grace")
            lines << line_item(grace.content, type: "leader", slug: grace.slug) if grace
          when "2"
            bless = fetch_liturgical_text("conclusion_blessing")
            lines << line_item(bless.content, type: "leader", slug: bless.slug) if bless
          when "3"
            prot = fetch_liturgical_text("conclusion_protection_minister")
            lines << line_item(prot.content, type: "leader") if prot
            prot_p = fetch_liturgical_text("conclusion_protection_people")
            lines << line_item(prot_p.content, type: "congregation") if prot_p
          end

          rubric_end = fetch_liturgical_text("rubric_sermon_end")
          lines << line_item(rubric_end.content, type: "rubric", slug: rubric_end.slug) if rubric_end

          {
            name: "Conclusão",
            slug: "conclusion",
            lines: lines
          }
        end
      end
    end
  end
end
