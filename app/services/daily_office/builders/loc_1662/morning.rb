# frozen_string_literal: true

module DailyOffice
  module Builders
    module Loc1662
      class Morning < LocBase
        private

        def assemble_office
          [
            build_opening_sentence,
            build_exhortation,
            build_confession,
            build_absolution,
            build_lords_prayer,
            build_versicles,
            build_invitatory_canticle,
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
            build_litany,
            build_additional_prayers,
            build_the_grace
          ].flatten.compact
        end

        def build_opening_sentence
          lines = []
          rubric = fetch_liturgical_text("morning_opening_sentence_rubric")
          lines << line_item(rubric.content, type: "rubric") if rubric

          sentence_key = resolve_preference(:morning_opening_sentence, 1..11) || 1
          sentence = fetch_liturgical_text("morning_opening_sentence_#{sentence_key}")
          if sentence
            lines << line_item(sentence.content)
            lines << line_item(sentence.reference, type: "citation") if sentence.reference
          end

          { name: "", slug: "opening_sentence", lines: lines }
        end

        def build_exhortation
          text = fetch_liturgical_text("morning_exhortation")
          return nil unless text
          { name: "", slug: "exhortation", lines: [ line_item(text.content) ] }
        end

        def build_confession
          lines = []
          rubric = fetch_liturgical_text("morning_confession_rubric")
          lines << line_item(rubric.content, type: "rubric") if rubric
          text = fetch_liturgical_text("morning_confession")
          lines << line_item(text.content) if text
          { name: "", slug: "confession", lines: lines }
        end

        def build_absolution
          lines = []
          rubric = fetch_liturgical_text("morning_absolution_rubric")
          lines << line_item(rubric.content, type: "rubric") if rubric
          text = fetch_liturgical_text("morning_absolution")
          lines << line_item(text.content) if text
          res_rubric = fetch_liturgical_text("morning_absolution_response_rubric")
          lines << line_item(res_rubric.content, type: "rubric") if res_rubric
          { name: "", slug: "absolution", lines: lines }
        end

        def build_lords_prayer
          lines = []
          rubric = fetch_liturgical_text("morning_lords_prayer_rubric")
          lines << line_item(rubric.content, type: "rubric") if rubric
          text = fetch_liturgical_text("morning_lords_prayer")
          lines << line_item(text.content) if text
          { name: "", slug: "lords_prayer", lines: lines }
        end

        def build_versicles
          lines = []
          rubric = fetch_liturgical_text("morning_versicles_rubric")
          lines << line_item(rubric.content, type: "rubric") if rubric
          lines << line_item(fetch_liturgical_text("morning_inv_v1")&.content, type: "leader")
          lines << line_item(fetch_liturgical_text("morning_inv_r1")&.content, type: "congregation")
          lines << line_item(fetch_liturgical_text("morning_inv_v2")&.content, type: "leader")
          lines << line_item(fetch_liturgical_text("morning_inv_r2")&.content, type: "congregation")

          lines << line_item(fetch_liturgical_text("morning_gloria_patri_rubric")&.content, type: "rubric")
          lines << line_item(fetch_liturgical_text("morning_gloria_patri_v")&.content, type: "leader")
          lines << line_item(fetch_liturgical_text("morning_gloria_patri_r")&.content, type: "congregation")

          lines << line_item(fetch_liturgical_text("morning_inv_v3")&.content, type: "leader")
          lines << line_item(fetch_liturgical_text("morning_inv_r3")&.content, type: "congregation")

          { name: "", slug: "versicles", lines: lines.compact }
        end

        def build_invitatory_canticle
          lines = []
          rubric = fetch_liturgical_text("morning_venite_rubric")
          lines << line_item(rubric.content, type: "rubric") if rubric

          # Only Venite supported for now as Jubilate text is not in provided images
          canticle = fetch_liturgical_text("morning_venite")
          return nil unless canticle

          {
            name: canticle.title,
            slug: "invitatory_canticle",
            lines: [ line_item(canticle.content) ]
          }
        end

        def build_psalms
          psalm_ref = readings[:psalm]
          return nil unless psalm_ref&.dig(:reference)

          lines = []
          lines << line_item(psalm_ref[:reference], type: "heading")
          if psalm_ref[:content]
            lines.concat(format_bible_content(psalm_ref[:content]))
          end

          # Gloria Patri after psalms
          v = fetch_liturgical_text("morning_psalms_gloria_patri_v")
          r = fetch_liturgical_text("morning_psalms_gloria_patri_r")
          lines << line_item(v.content, type: "leader") if v
          lines << line_item(r.content, type: "congregation") if r

          { name: "", slug: "psalms", lines: lines }
        end

        def build_first_reading
          build_reading_module(
            type: :first,
            announcement_slug: "morning_reading_announcement_rubric",
            rubric_slugs: { pre: "morning_first_reading_rubric" },
            reading_key: :first_reading,
            module_name: ""
          )
        end

        def build_first_canticle
          # Te Deum or Benedicite (Standard is Te Deum)
          # Benedicite is used when preferred or by rubric (though 1662 rubric is simple)
          canticle_slug = resolve_preference(:morning_post_first_reading_canticle, %w[morning_te_deum morning_benedicite]) || "morning_te_deum"
          canticle = fetch_liturgical_text(canticle_slug)
          return nil unless canticle
          { name: canticle.title, slug: "first_canticle", lines: [ line_item(canticle.content) ] }
        end

        def build_second_reading
          build_reading_module(
            type: :second,
            announcement_slug: "morning_reading_announcement_rubric",
            rubric_slugs: { pre: "morning_second_reading_rubric" },
            reading_key: :second_reading,
            module_name: ""
          )
        end

        def build_second_canticle
          canticle = fetch_liturgical_text("morning_benedictus")
          return nil unless canticle
          { name: canticle.title, slug: "second_canticle", lines: [ line_item(canticle.content) ] }
        end

        def build_creed
          lines = []
          if use_athanasian_creed?
            rubric = fetch_liturgical_text("athanasian_creed_rubric")
            lines << line_item(rubric.content, type: "rubric") if rubric
            text = fetch_liturgical_text("athanasian_creed")
            lines << line_item(text.content) if text
            return { name: "Credo Atanasiano", slug: "athanasian_creed", lines: lines }
          end

          rubric = fetch_liturgical_text("morning_creed_rubric")
          lines << line_item(rubric.content, type: "rubric") if rubric
          text = fetch_liturgical_text("apostles_creed")
          lines << line_item(text.content) if text
          { name: "", slug: "creed", lines: lines }
        end

        def build_prayers
          lines = []
          rubric = fetch_liturgical_text("morning_prayers_rubric")
          lines << line_item(rubric.content, type: "rubric") if rubric
          lines << line_item(fetch_liturgical_text("morning_salutation_v")&.content, type: "leader")
          lines << line_item(fetch_liturgical_text("morning_salutation_r")&.content, type: "congregation")
          lines << line_item(fetch_liturgical_text("morning_lesser_litany_rubric")&.content, type: "rubric")
          lines << line_item(fetch_liturgical_text("kyrie")&.content, type: "responsive")
          { name: "", slug: "prayers", lines: lines.compact }
        end

        def build_lords_prayer_repeated
          lines = []
          rubric = fetch_liturgical_text("morning_lords_prayer_repeated_rubric")
          lines << line_item(rubric.content, type: "rubric") if rubric
          text = fetch_liturgical_text("morning_lords_prayer")
          lines << line_item(text.content) if text
          { name: "", slug: "lords_prayer_repeated", lines: lines }
        end

        def build_suffrages
          lines = []
          rubric = fetch_liturgical_text("morning_suffrages_rubric")
          lines << line_item(rubric.content, type: "rubric") if rubric
          (1..6).each do |i|
            lines << line_item(fetch_liturgical_text("morning_suff_v#{i}")&.content, type: "leader")
            lines << line_item(fetch_liturgical_text("morning_suff_r#{i}")&.content, type: "congregation")
          end
          { name: "", slug: "suffrages", lines: lines.compact }
        end

        def build_collect_of_the_day
          lines = []
          rubric = fetch_liturgical_text("morning_collects_rubric")
          lines << line_item(rubric.content, type: "rubric") if rubric
          lines.concat(build_collect_lines(@collects))
          { name: "Coleta do Dia", slug: "collect_of_the_day", lines: lines }
        end

        def build_fixed_collects
          lines = []
          peace = fetch_liturgical_text("morning_collect_peace")
          lines << line_item(peace.title, type: "heading") if peace
          lines << line_item(peace.content) if peace

          grace = fetch_liturgical_text("morning_collect_grace")
          lines << line_item(grace.title, type: "heading") if grace
          lines << line_item(grace.content) if grace

          { name: "Coletas Fixas", slug: "fixed_collects", lines: lines.compact }
        end

        def build_additional_prayers
          lines = []
          rubric = fetch_liturgical_text("morning_additional_prayers_rubric")
          lines << line_item(rubric.content, type: "rubric") if rubric

          # Usually includes Prayer for Civil Authority, Clergy and People, St. Chrysostom
          auth = fetch_liturgical_text("morning_prayer_civil_authority_1")
          lines << line_item(auth.title, type: "heading") if auth
          lines << line_item(auth.content) if auth

          clerg = fetch_liturgical_text("morning_prayer_clergy_people")
          lines << line_item(clerg.title, type: "heading") if clerg
          lines << line_item(clerg.content) if clerg

          chrys = fetch_liturgical_text("prayer_st_chrysostom")
          lines << line_item(chrys.title, type: "heading") if chrys
          lines << line_item(chrys.content) if chrys

          { name: "Orações Adicionais", slug: "additional_prayers", lines: lines.compact }
        end

        def build_litany
          return nil unless is_litany_day?

          lines = []
          rubric = fetch_liturgical_text("litany_rubric")
          lines << line_item(rubric.content, type: "rubric") if rubric

          (1..5).each do |i|
            text = fetch_liturgical_text("litany_part_#{i}")
            lines << line_item(text.content, type: "responsive") if text
          end

          lp_rubric = fetch_liturgical_text("litany_lords_prayer_rubric")
          lines << line_item(lp_rubric.content, type: "rubric") if lp_rubric
          lp = fetch_liturgical_text("morning_lords_prayer")
          lines << line_item(lp.content, type: "congregation") if lp

          after_lp = fetch_liturgical_text("litany_after_lords_prayer")
          lines << line_item(after_lp.content, type: "responsive") if after_lp

          lines << line_item("Oremos.", type: "rubric")
          lines << line_item(fetch_liturgical_text("litany_prayer_1")&.content, type: "leader")
          lines << line_item(fetch_liturgical_text("litany_prayer_2")&.content, type: "leader")
          lines << line_item(fetch_liturgical_text("litany_gloria_patri")&.content, type: "responsive")
          lines << line_item(fetch_liturgical_text("litany_final_prayer")&.content, type: "leader")

          { name: "A Litania", slug: "litany", lines: lines.compact }
        end

        def is_litany_day?
          # Sundays, Wednesdays, and Fridays
          date.sunday? || date.wednesday? || date.friday?
        end

        def build_the_grace
          text = fetch_liturgical_text("the_grace")
          return nil unless text
          { name: text.title, slug: "the_grace", lines: [ line_item(text.content) ] }
        end

        def use_athanasian_creed?
          # Christmas, Epiphany, St. Matthias, Easter, Ascension, Pentecost,
          # St. John Baptist, St. James, St. Bartholomew, St. Matthew,
          # Saints Simon and Jude, St. Andrew, Trinity Sunday
          athanasian_feasts = %w[
            christmas_day epiphany saint_matthias easter_day
            ascension_day pentecost_sunday nativity_of_john_baptist
            saint_james saint_bartholomew saint_matthew
            saints_simon_and_jude saint_andrew trinity_sunday
          ]
          athanasian_feasts.include?(day_info[:celebration]&.dig(:name))
        end
      end
    end
  end
end
