# frozen_string_literal: true

module DailyOffice
  module Builders
    module Loc1662
      class Evening < LocBase
        private

        def assemble_office
          [
            build_opening_sentence,
            build_exhortation,
            build_confession,
            build_absolution,
            build_lords_prayer,
            build_versicles,
            build_psalms,
            build_first_reading,
            build_first_canticle,
            build_second_reading,
            build_second_canticle,
            build_creed,
            build_prayers,
            build_lords_prayer_repeated,
            build_suffrages,
            build_collect_of_the_day,
            build_fixed_collects,
            build_additional_prayers,
            build_the_grace
          ].flatten.compact
        end

        def build_opening_sentence
          lines = []
          rubric = fetch_liturgical_text("evening_opening_sentence_rubric")
          lines << line_item(rubric.content, type: "rubric") if rubric

          sentence_key = resolve_preference(:evening_opening_sentence, 1..11) || 1
          sentence = fetch_liturgical_text("evening_opening_sentence_#{sentence_key}")
          if sentence
            lines << line_item(sentence.content, type: "leader")
            lines << line_item(sentence.reference, type: "citation") if sentence.reference
          end

          { name: "Sentenças Iniciais", slug: "opening_sentence", lines: lines }
        end

        def build_exhortation
          text = fetch_liturgical_text("evening_exhortation")
          return nil unless text
          { name: "Exortação", slug: "exhortation", lines: [line_item(text.content, type: "leader")] }
        end

        def build_confession
          lines = []
          rubric = fetch_liturgical_text("evening_confession_rubric")
          lines << line_item(rubric.content, type: "rubric") if rubric
          text = fetch_liturgical_text("evening_confession")
          lines << line_item(text.content, type: "congregation") if text
          { name: "Confissão", slug: "confession", lines: lines }
        end

        def build_absolution
          lines = []
          rubric = fetch_liturgical_text("evening_absolution_rubric")
          lines << line_item(rubric.content, type: "rubric") if rubric
          text = fetch_liturgical_text("evening_absolution")
          lines << line_item(text.content, type: "leader") if text
          res_rubric = fetch_liturgical_text("evening_absolution_response_rubric")
          lines << line_item(res_rubric.content, type: "rubric") if res_rubric
          { name: "Absolvição", slug: "absolution", lines: lines }
        end

        def build_lords_prayer
          lines = []
          rubric = fetch_liturgical_text("evening_lords_prayer_rubric")
          lines << line_item(rubric.content, type: "rubric") if rubric
          text = fetch_liturgical_text("evening_lords_prayer")
          lines << line_item(text.content, type: "congregation") if text
          { name: "Oração do Senhor", slug: "lords_prayer", lines: lines }
        end

        def build_versicles
          lines = []
          rubric = fetch_liturgical_text("evening_versicles_rubric")
          lines << line_item(rubric.content, type: "rubric") if rubric
          lines << line_item(fetch_liturgical_text("evening_inv_v1")&.content, type: "leader")
          lines << line_item(fetch_liturgical_text("evening_inv_r1")&.content, type: "congregation")
          lines << line_item(fetch_liturgical_text("evening_inv_v2")&.content, type: "leader")
          lines << line_item(fetch_liturgical_text("evening_inv_r2")&.content, type: "congregation")
          
          lines << line_item(fetch_liturgical_text("evening_gloria_patri_rubric")&.content, type: "rubric")
          lines << line_item(fetch_liturgical_text("evening_gloria_patri_v")&.content, type: "leader")
          lines << line_item(fetch_liturgical_text("evening_gloria_patri_r")&.content, type: "congregation")
          
          lines << line_item(fetch_liturgical_text("evening_inv_v3")&.content, type: "leader")
          lines << line_item(fetch_liturgical_text("evening_inv_r3")&.content, type: "congregation")
          
          { name: "Versículos", slug: "versicles", lines: lines.compact }
        end

        def build_psalms
          psalm_ref = readings[:psalm]
          return nil unless psalm_ref&.dig(:reference)

          lines = []
          lines << line_item(psalm_ref[:reference], type: "heading")
          if psalm_ref[:content]
            lines.concat(format_bible_content(psalm_ref[:content]))
          end

          # Use same Gloria Patri slugs as Morning for consistency if available, 
          # or we could define evening-specific ones. 
          # The book p19 mentions Gloria Patri too.
          v = fetch_liturgical_text("evening_gloria_patri_v")
          r = fetch_liturgical_text("evening_gloria_patri_r")
          lines << line_item(v.content, type: "leader") if v
          lines << line_item(r.content, type: "congregation") if r

          { name: "Salmos", slug: "psalms", lines: lines }
        end

        def build_first_reading
          build_reading_module(
            type: :first,
            announcement_slug: "morning_reading_announcement_rubric", # announcement rubric is shared
            reading_key: :first_reading,
            module_name: "Primeira Leitura"
          )
        end

        def build_first_canticle
          canticle = fetch_liturgical_text("evening_magnificat")
          return nil unless canticle
          { name: canticle.title, slug: "first_canticle", lines: [line_item(canticle.content, type: "congregation")] }
        end

        def build_second_reading
          build_reading_module(
            type: :second,
            announcement_slug: "morning_reading_announcement_rubric",
            reading_key: :second_reading,
            module_name: "Segunda Leitura"
          )
        end

        def build_second_canticle
          canticle = fetch_liturgical_text("evening_nunc_dimittis")
          return nil unless canticle
          { name: canticle.title, slug: "second_canticle", lines: [line_item(canticle.content, type: "congregation")] }
        end

        def build_creed
          lines = []
          rubric = fetch_liturgical_text("evening_creed_rubric")
          lines << line_item(rubric.content, type: "rubric") if rubric
          text = fetch_liturgical_text("apostles_creed")
          lines << line_item(text.content, type: "congregation") if text
          { name: "Credo Apostólico", slug: "creed", lines: lines }
        end

        def build_prayers
          lines = []
          rubric = fetch_liturgical_text("evening_prayers_rubric")
          lines << line_item(rubric.content, type: "rubric") if rubric
          lines << line_item(fetch_liturgical_text("evening_salutation_v")&.content, type: "leader")
          lines << line_item(fetch_liturgical_text("evening_salutation_r")&.content, type: "congregation")
          lines << line_item(fetch_liturgical_text("evening_lesser_litany_rubric")&.content, type: "rubric")
          lines << line_item(fetch_liturgical_text("kyrie")&.content, type: "responsive")
          { name: "Orações", slug: "prayers", lines: lines.compact }
        end

        def build_lords_prayer_repeated
          lines = []
          rubric = fetch_liturgical_text("evening_lords_prayer_repeated_rubric")
          lines << line_item(rubric.content, type: "rubric") if rubric
          text = fetch_liturgical_text("evening_lords_prayer")
          lines << line_item(text.content, type: "congregation") if text
          { name: "Oração do Senhor", slug: "lords_prayer_repeated", lines: lines }
        end

        def build_suffrages
          lines = []
          rubric = fetch_liturgical_text("evening_suffrages_rubric")
          lines << line_item(rubric.content, type: "rubric") if rubric
          (1..6).each do |i|
            lines << line_item(fetch_liturgical_text("evening_suff_v#{i}")&.content, type: "leader")
            lines << line_item(fetch_liturgical_text("evening_suff_r#{i}")&.content, type: "congregation")
          end
          { name: "Sufrágios", slug: "suffrages", lines: lines.compact }
        end

        def build_collect_of_the_day
          lines = []
          rubric = fetch_liturgical_text("evening_collects_rubric")
          lines << line_item(rubric.content, type: "rubric") if rubric
          lines.concat(build_collect_lines(@collects))
          { name: "Coleta do Dia", slug: "collect_of_the_day", lines: lines }
        end

        def build_fixed_collects
          lines = []
          peace = fetch_liturgical_text("evening_collect_peace")
          lines << line_item(peace.title, type: "heading") if peace
          lines << line_item(peace.content, type: "leader") if peace
          
          perils = fetch_liturgical_text("evening_collect_perils")
          lines << line_item(perils.title, type: "heading") if perils
          lines << line_item(perils.content, type: "leader") if perils
          
          { name: "Coletas Fixas", slug: "fixed_collects", lines: lines.compact }
        end

        def build_additional_prayers
          # For 1662, it repeats the same structure as Morning for additional prayers
          lines = []
          auth = fetch_liturgical_text("morning_prayer_civil_authority_1")
          lines << line_item(auth.title, type: "heading") if auth
          lines << line_item(auth.content, type: "leader") if auth
          
          clerg = fetch_liturgical_text("morning_prayer_clergy_people")
          lines << line_item(clerg.title, type: "heading") if clerg
          lines << line_item(clerg.content, type: "leader") if clerg
          
          chrys = fetch_liturgical_text("prayer_st_chrysostom")
          lines << line_item(chrys.title, type: "heading") if chrys
          lines << line_item(chrys.content, type: "leader") if chrys
          
          { name: "Orações Adicionais", slug: "additional_prayers", lines: lines.compact }
        end

        def build_the_grace
          text = fetch_liturgical_text("the_grace")
          return nil unless text
          { name: text.title, slug: "the_grace", lines: [line_item(text.content, type: "leader")] }
        end
      end
    end
  end
end
