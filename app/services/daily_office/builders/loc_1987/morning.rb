# frozen_string_literal: true

module DailyOffice
  module Builders
    module Loc1987
      class Morning < LocBase
        def assemble_office
          assemble_morning_prayer
        end

        def assemble_morning_prayer
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

          # Fallback to morning specific if no seasonal or random choice
          unless minister_sentence
            minister_sentence = fetch_liturgical_text("morning_opening_sentence_minister")
            people_sentence = fetch_liturgical_text("morning_opening_sentence_people")
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

          # Invitation
          invitation_opt = resolve_preference(:morning_confession_type, %w[1 2 3])
          invitation_slug = invitation_opt == "2" ? "confession_invitation_2" : "confession_invitation_1"

          if invitation_opt == "2"
            rubric_short = fetch_liturgical_text("rubric_confession_short")
            lines << line_item(rubric_short.content, type: "rubric", slug: rubric_short.slug) if rubric_short
          end

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

          # Confession Prayer
          conf_opt = resolve_preference(:morning_confession_type, %w[1 2 3]) || "1"

          if conf_opt != "1"
            rubric_opts = fetch_liturgical_text("rubric_confession_options")
            lines << line_item(rubric_opts.content, type: "rubric", slug: rubric_opts.slug) if rubric_opts
          end

          confession = fetch_liturgical_text("confession_prayer_#{conf_opt}")
          if confession
            lines << line_item(confession.content, type: "congregation", slug: confession.slug)
            lines << line_item("", type: "spacer")
          end

          # Absolution
          rubric_abs_intro = fetch_liturgical_text("rubric_absolution_intro")
          lines << line_item(rubric_abs_intro.content, type: "rubric", slug: rubric_abs_intro.slug) if rubric_abs_intro

          abs_type = resolve_preference(:morning_abs_type, %w[1 2]) || "1"

          if abs_type == "1"
            absolution = fetch_liturgical_text("absolution_prayer_deacon")
            if absolution
              lines << line_item(absolution.content, type: "congregation", slug: absolution.slug)
              lines << line_item("", type: "spacer")
            end
          elsif abs_type == "2"
            absolution_minister = fetch_liturgical_text("absolution_prayer_deacon_2_minister")
            if absolution_minister
              lines << line_item(absolution_minister.content, type: "leader", slug: absolution_minister.slug)
            end
            absolution_people = fetch_liturgical_text("absolution_prayer_deacon_2_people")
            if absolution_people
              lines << line_item(absolution_people.content, type: "congregation", slug: absolution_people.slug)
            end
            lines << line_item("", type: "spacer")
          end

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

          # Opening Lips
          lines << line_item("Abre, ó Senhor, os nossos lábios.", type: "leader")
          lines << line_item("E a nossa boca proclamará o teu louvor.", type: "congregation")
          lines << line_item("Glória a Deus nas alturas!", type: "leader")
          lines << line_item("E na terra paz, boa-vontade entre os homens.", type: "congregation")
          lines << line_item("Louvemos ao Senhor.", type: "leader")
          lines << line_item("Aleluia!", type: "congregation")
          lines << line_item("", type: "spacer")

          # Seasonal Antiphon
          rubric_ant = fetch_liturgical_text("rubric_antiphons")
          lines << line_item(rubric_ant.content, type: "rubric", slug: rubric_ant.slug) if rubric_ant

          antiphon_slug = season_antiphon_slug
          antiphon = fetch_liturgical_text(antiphon_slug)
          if antiphon
            lines << line_item(antiphon.content, type: "leader", slug: antiphon.slug)
            lines << line_item("", type: "spacer")
          end

          # Venite / Jubilate / Pascha Nostrum
          rubric_venite = fetch_liturgical_text("rubric_venite")
          lines << line_item(rubric_venite.content, type: "rubric", slug: rubric_venite.slug) if rubric_venite

          season = day_info[:liturgical_season]&.downcase
          invitatory_opt = if season == "páscoa"
            "pascha_nostrum"
          else
            resolve_preference(:morning_invitatory_psalm, %w[venite jubilate pascha_nostrum]) || "venite"
          end

          invitatory_text = fetch_liturgical_text(invitatory_opt)
          if invitatory_text
            lines << line_item(invitatory_text.content, slug: invitatory_text.slug)
            lines << line_item("", type: "spacer")
          end

          # Gloria Patri after Invitatory
          gloria_minister = fetch_liturgical_text("gloria_patri_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end
          gloria_people = fetch_liturgical_text("gloria_patri_people")
          if gloria_people
            lines << line_item(gloria_people.content, type: "congregation", slug: gloria_people.slug)
          end
          lines << line_item("", type: "spacer")

          {
            name: "Invitatório",
            slug: "invitatory",
            lines: lines
          }
        end

        def season_antiphon_slug
          season = day_info[:liturgical_season]&.downcase
          case season
          when "advento" then "invitatory_antiphon_advent"
          when "natal" then "invitatory_antiphon_christmas"
          when "epifania" then "invitatory_antiphon_epiphany"
          when "quaresma" then "invitatory_antiphon_lent"
          when "páscoa" then "invitatory_antiphon_easter"
          when "ascensão" then "invitatory_antiphon_ascension"
          when "pentecostes" then "invitatory_antiphon_pentecost"
          else nil
          end
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

          # Gloria Patri after Psalms
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
          lines << line_item(rubric_announce.content, type: "rubric", slug: rubric_announce.slug) if rubric_announce

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

          # Canticle
          rubric_silence = fetch_liturgical_text("rubric_readings_silence")
          lines << line_item(rubric_silence.content, type: "rubric", slug: rubric_silence.slug) if rubric_silence

          canticle_slug = resolve_preference(:morning_canticle, %w[te_deum benedictus_es benedictus]) || "te_deum"
          canticle = fetch_liturgical_text(canticle_slug)
          if canticle
            lines << line_item(canticle.content, slug: canticle.slug)
            lines << line_item("", type: "spacer")
          end

          # Second Reading (Optional in text but standard in Office)
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

          if canticle_slug != "benedictus"
            rubric_silence = fetch_liturgical_text("rubric_readings_silence")
            lines << line_item(rubric_silence.content, type: "rubric", slug: rubric_silence.slug) if rubric_silence

            benedictus = fetch_liturgical_text("benedictus")
            if benedictus
              lines << line_item(benedictus.content, slug: benedictus.slug)
            end
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

          # I'll default to Apostles Creed
          creed = fetch_liturgical_text("apostles_creed")
          if creed
            lines << line_item(creed.content, type: "congregation", slug: creed.slug)
          end

          rubric_para = fetch_liturgical_text("rubric_creed_paraphrase")
          lines << line_item(rubric_para.content, type: "rubric", slug: rubric_para.slug) if rubric_para

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
          rubric_suff = fetch_liturgical_text("rubric_suffages_intro")
          lines << line_item(rubric_suff.content, type: "rubric", slug: rubric_suff.slug) if rubric_suff

          suff_opt = resolve_preference(:morning_suffrages, %w[1 2]) || "1"
          # There are 7 verses in V1, 5 in V2.
          if suff_opt == "1"
            7.times do |i|
              v = fetch_liturgical_text("suffrages_1_v#{i + 1}")
              r = fetch_liturgical_text("suffrages_1_r#{i + 1}")
              lines << line_item(v.content, type: "leader") if v
              lines << line_item(r.content, type: "congregation") if r
            end
          else
            if suff_opt == "2"
              rubric_short = fetch_liturgical_text("rubric_confession_short")
              lines << line_item(rubric_short.content, type: "rubric", slug: rubric_short.slug) if rubric_short
            end

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

          if @collects
            lines << line_item(@collects)
            lines << line_item("", type: "spacer")
          end

          # Fixed Collects for Morning
          rubric_gen = fetch_liturgical_text("rubric_prayers_general")
          lines << line_item(rubric_gen.content, type: "rubric", slug: rubric_gen.slug) if rubric_gen

          rubric_bridge = fetch_liturgical_text("rubric_communion_bridge")
          lines << line_item(rubric_bridge.content, type: "rubric", slug: rubric_bridge.slug) if rubric_bridge

          collect_peace = fetch_liturgical_text("collect_peace")
          lines << line_item(collect_peace.content, type: "leader") if collect_peace

          collect_grace = fetch_liturgical_text("collect_grace")
          lines << line_item(collect_grace.content, type: "leader") if collect_grace

          prayer_auth = fetch_liturgical_text("prayer_authorities")
          lines << line_item(prayer_auth.content, type: "leader") if prayer_auth

          prayer_clergy = fetch_liturgical_text("prayer_clergy_people")
          lines << line_item(prayer_clergy.content, type: "leader") if prayer_clergy

          rubric_joint = fetch_liturgical_text("rubric_thanksgiving_joint")
          lines << line_item(rubric_joint.content, type: "rubric", slug: rubric_joint.slug) if rubric_joint

          thanksgiving = fetch_liturgical_text("general_thanksgiving_1")
          lines << line_item(thanksgiving.content, type: "congregation") if thanksgiving

          rubric_opts = fetch_liturgical_text("rubric_confession_options")
          lines << line_item(rubric_opts.content, type: "rubric", slug: rubric_opts.slug) if rubric_opts

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

          conc_opt = resolve_preference(:morning_conclusion, %w[1 2 3]) || "1"

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
