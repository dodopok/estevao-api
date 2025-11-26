# frozen_string_literal: true

module DailyOffice
  module Components
    class PrayerBuilder
      attr_reader :date, :preferences, :day_info

      def initialize(date:, preferences: {}, day_info: {})
        @date = date
        @preferences = preferences
        @day_info = day_info
      end

      def build_opening_sentence(office_type)
        slug = case office_type
        when :morning then season_specific_slug("opening_sentence", "morning")
        when :evening then season_specific_slug("opening_sentence", "evening")
        when :midday then "opening_sentence_midday"
        when :compline then "opening_sentence_compline"
        else season_specific_slug("opening_sentence", "morning")
        end

        text = fetch_liturgical_text(slug)
        return nil unless text

        lines = [ line_item(text.content, type: "leader") ]
        lines << line_item(text.reference, type: "citation") if text.reference

        {
          name: "Sentença de Abertura",
          slug: "opening_sentence",
          lines: lines
        }
      end

      def build_confession
        slug = preferences[:confession_type] == "short" ? "confession_short" : "confession_long"
        text = fetch_liturgical_text(slug)
        return nil unless text

        {
          name: "Confissão de Pecados",
          slug: "confession",
          lines: [
            line_item("O Oficiante diz ao povo:", type: "rubric"),
            line_item("", type: "spacer"),
            line_item(text.content, type: "congregation")
          ]
        }
      end

      def build_absolution
        text = fetch_liturgical_text("absolution")
        return nil unless text

        {
          name: "Absolvição",
          slug: "absolution",
          lines: [
            line_item("O Sacerdote pronuncia:", type: "rubric"),
            line_item(text.content, type: "leader")
          ]
        }
      end

      def build_invocation
        text = fetch_liturgical_text("invocation")
        return nil unless text

        {
          name: "Invocação",
          slug: "invocation",
          lines: [
            line_item("Oficiante: Senhor, abre os nossos lábios.", type: "leader"),
            line_item("Povo: E a nossa boca anunciará o teu louvor.", type: "congregation")
          ]
        }
      end

      def build_creed(type = nil)
        creed_type = type || preferences[:creed_type]
        slug = creed_type == :nicene ? "nicene_creed" : "apostles_creed"
        text = fetch_liturgical_text(slug)
        return nil unless text

        name = slug == "nicene_creed" ? "Credo Niceno" : "Credo Apostólico"

        {
          name: name,
          slug: "creed",
          lines: [
            line_item("Todos de pé", type: "rubric"),
            line_item(text.content, type: "congregation")
          ]
        }
      end

      def build_kyrie
        {
          name: "Kyrie",
          slug: "kyrie",
          lines: [
            line_item("O Senhor esteja convosco.", type: "leader"),
            line_item("E com o teu espírito.", type: "congregation"),
            line_item("Oremos.", type: "leader"),
            line_item("", type: "spacer"),
            line_item("Senhor, tem piedade de nós.", type: "leader"),
            line_item("Cristo, tem piedade de nós.", type: "congregation"),
            line_item("Senhor, tem piedade de nós.", type: "leader")
          ]
        }
      end

      def build_lords_prayer
        version = preferences[:lords_prayer_version]
        slug = version == "contemporary" ? "lords_prayer_contemporary" : "lords_prayer_traditional"
        text = fetch_liturgical_text(slug)
        return nil unless text

        {
          name: "Oração do Senhor",
          slug: "lords_prayer",
          lines: [
            line_item(text.content, type: "congregation")
          ]
        }
      end

      def build_morning_suffrages
        text = fetch_liturgical_text("morning_suffrages")
        return nil unless text

        {
          name: "Sufrágios",
          slug: "suffrages",
          lines: [
            line_item(text.content, type: "responsive")
          ]
        }
      end

      def build_evening_suffrages
        text = fetch_liturgical_text("evening_suffrages")
        return nil unless text

        {
          name: "Sufrágios",
          slug: "suffrages",
          lines: [
            line_item(text.content, type: "responsive")
          ]
        }
      end

      def build_collects
        collects_data = CollectService.new(date, prayer_book_code: prayer_book_code).find_collects || []
        collect_text = collects_data.first&.dig(:text) || ""

        {
          name: "Coletas",
          slug: "collects",
          lines: [
            line_item("Coleta do Dia", type: "heading"),
            line_item(collect_text, type: "leader"),
            line_item("", type: "spacer"),
            line_item("Coleta pela Paz", type: "heading"),
            line_item(fetch_liturgical_text("collect_peace")&.content || "", type: "leader"),
            line_item("", type: "spacer"),
            line_item("Coleta pela Graça", type: "heading"),
            line_item(fetch_liturgical_text("collect_grace")&.content || "", type: "leader")
          ]
        }
      end

      def build_simple_collect
        collects_data = CollectService.new(date, prayer_book_code: prayer_book_code).find_collects || []
        collect_text = collects_data.first&.dig(:text)
        return nil unless collect_text

        {
          name: "Coleta do Dia",
          slug: "collect",
          lines: [
            line_item("Coleta do Dia", type: "heading"),
            line_item(collect_text, type: "leader")
          ]
        }
      end

      def build_midday_collect
        text = fetch_liturgical_text("midday_collect")
        return nil unless text

        {
          name: "Coleta",
          slug: "collect",
          lines: [
            line_item(text.content, type: "leader")
          ]
        }
      end

      def build_compline_prayers
        {
          name: "Orações",
          slug: "prayers",
          lines: [
            line_item("Guarda-nos, Senhor, nesta noite, livres de todo pecado.", type: "leader"),
            line_item("Tem misericórdia de nós, Senhor, tem misericórdia.", type: "congregation"),
            line_item("", type: "spacer"),
            line_item(fetch_liturgical_text("compline_collect")&.content || "", type: "leader")
          ]
        }
      end

      def build_general_thanksgiving
        text = fetch_liturgical_text("general_thanksgiving")
        return nil unless text

        {
          name: "Ação de Graças",
          slug: "thanksgiving",
          lines: [
            line_item(text.content, type: "congregation")
          ]
        }
      end

      def build_chrysostom_prayer
        text = fetch_liturgical_text("chrysostom_prayer")
        return nil unless text

        {
          name: "Oração de São João Crisóstomo",
          slug: "chrysostom",
          lines: [
            line_item(text.content, type: "leader")
          ]
        }
      end

      def build_dismissal
        text = fetch_liturgical_text("dismissal")
        return nil unless text

        {
          name: "Despedida",
          slug: "dismissal",
          lines: [
            line_item(text.content, type: "leader"),
            line_item("Amém.", type: "congregation")
          ]
        }
      end

      private

      def season_specific_slug(base_slug, office_type)
        season_slug = season_to_slug(day_info[:liturgical_season])
        "#{base_slug}_#{season_slug}_#{office_type}"
      end

      def season_to_slug(season)
        return "ordinary" unless season

        season.downcase.gsub(/\s+/, "_")
      end

      def fetch_liturgical_text(slug)
        prayer_book = PrayerBook.find_by(code: prayer_book_code)
        return nil unless prayer_book

        LiturgicalText.find_by(
          slug: slug,
          prayer_book_id: prayer_book.id
        )
      end

      def line_item(text, type: "text")
        { text: text, type: type }
      end

      def prayer_book_code
        preferences[:prayer_book_code] || "loc_2015"
      end
    end
  end
end
