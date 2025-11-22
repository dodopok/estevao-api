# Service to assemble complete Daily Office liturgies
# Generates structured JSON for Morning Prayer, Evening Prayer, Midday Prayer, and Compline
class DailyOfficeService
  attr_reader :date, :office_type, :prefs, :day_info, :readings

  def initialize(date:, office_type: :morning, preferences: {})
    @date = date.to_date
    @office_type = office_type.to_sym # :morning, :evening, :midday, :compline
    @prefs = default_preferences.merge(preferences)
  end

  def call
    # 1. Identify the Liturgical Day (Season, Color, Saint, Psalm Week)
    @day_info = liturgical_calendar.day_info(@date)

    # 2. Fetch the Readings for the Day
    @readings = ReadingService.new(@date).find_readings || {}

    # 3. Assemble the Office based on type
    structure = case @office_type
    when :morning then assemble_morning_prayer
    when :evening then assemble_evening_prayer
    when :midday then assemble_midday_prayer
    when :compline then assemble_compline
    else
                  raise "Unknown office type: #{@office_type}"
    end

    # 4. Return the final JSON
    {
      date: @date.strftime("%Y-%m-%d"),
      office_type: @office_type.to_s,
      season: @day_info[:liturgical_season],
      color: @day_info[:liturgical_color],
      celebration: @day_info[:celebration],
      saint: @day_info[:saint],
      modules: structure,
      metadata: {
        version: @prefs[:version],
        bible_version: @prefs[:bible_version],
        language: @prefs[:language]
      }
    }
  end

  private

  # --- Assembly Methods for Each Office ---

  def assemble_morning_prayer
    [
      build_opening_sentence,
      build_confession,
      build_absolution,
      build_invocation,
      build_invitatory,
      build_psalms,
      build_first_reading,
      build_first_canticle,
      build_second_reading,
      build_second_canticle,
      build_creed,
      build_kyrie,
      build_lords_prayer,
      build_morning_suffrages,
      build_collects,
      build_general_thanksgiving,
      build_chrysostom_prayer,
      build_dismissal
    ].compact
  end

  def assemble_evening_prayer
    [
      build_opening_sentence,
      build_confession,
      build_absolution,
      build_invocation,
      build_evening_psalms,
      build_first_reading,
      build_magnificat,
      build_second_reading,
      build_nunc_dimittis,
      build_creed,
      build_kyrie,
      build_lords_prayer,
      build_evening_suffrages,
      build_collects,
      build_general_thanksgiving,
      build_chrysostom_prayer,
      build_dismissal
    ].compact
  end

  def assemble_midday_prayer
    [
      build_opening_sentence(:midday),
      build_midday_psalms,
      build_short_reading,
      build_kyrie,
      build_lords_prayer,
      build_midday_collect,
      build_dismissal
    ].compact
  end

  def assemble_compline
    [
      build_opening_sentence(:compline),
      build_confession,
      build_absolution,
      build_invocation,
      build_compline_psalms,
      build_short_reading,
      build_compline_hymn,
      build_nunc_dimittis,
      build_creed(:apostles),
      build_kyrie,
      build_lords_prayer,
      build_compline_prayers,
      build_dismissal
    ].compact
  end

  # --- Building Blocks (Modules) ---

  def build_opening_sentence(time = nil)
    # Opening sentence based on season or time of day
    slug = if time == :midday
             "opening_sentence_midday"
    elsif time == :compline
             "opening_sentence_compline"
    else
             season_slug = season_to_slug(@day_info[:liturgical_season])
             "opening_sentence_#{season_slug}"
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
    slug = @prefs[:confession_type] == "short" ? "confession_short" : "confession_long"
    text = fetch_liturgical_text(slug)
    return nil unless text

    {
      name: "Confiss\u00E3o de Pecados",
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
      name: "Absolvi\u00E7\u00E3o",
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
      name: "Invoca\u00E7\u00E3o",
      slug: "invocation",
      lines: [
        line_item("Oficiante: Senhor, abre os nossos l\u00E1bios.", type: "leader"),
        line_item("Povo: E a nossa boca anunciar\u00E1 o teu louvor.", type: "congregation")
      ]
    }
  end

  def build_invitatory
    # Choose Venite or Jubilate based on season
    canticle_slug = should_use_jubilate? ? "jubilate" : "venite"
    text = fetch_liturgical_text(canticle_slug)
    return nil unless text

    canticle_name = canticle_slug == "venite" ? "Venite (Salmo 95)" : "Jubilate (Salmo 100)"

    {
      name: canticle_name,
      slug: "invitatory",
      lines: [
        line_item("Todos de p\u00E9", type: "rubric"),
        line_item(text.content, type: "congregation")
      ]
    }
  end

  def build_psalms
    cycle = PsalmCycle.find_for_date_and_office(@date, "morning")
    return nil unless cycle

    {
      name: "Salt\u00E9rio",
      slug: "psalms",
      lines: build_psalm_lines(cycle)
    }
  end

  def build_evening_psalms
    cycle = PsalmCycle.find_for_date_and_office(@date, "evening")
    return nil unless cycle

    {
      name: "Salt\u00E9rio",
      slug: "psalms",
      lines: build_psalm_lines(cycle)
    }
  end

  def build_midday_psalms
    # Midday typically uses Psalm 119 portions or fixed psalms
    cycle = PsalmCycle.find_for_date_and_office(@date, "midday")
    return build_fixed_psalm(119) unless cycle

    {
      name: "Salmo",
      slug: "psalms",
      lines: build_psalm_lines(cycle)
    }
  end

  def build_compline_psalms
    # Compline uses fixed psalms: 4, 31, 91, 134
    {
      name: "Salmos",
      slug: "compline_psalms",
      lines: [
        line_item("Salmos 4, 31, 91, 134", type: "heading"),
        line_item("Todos sentados", type: "rubric"),
        *build_multiple_psalms_lines([ 4, 31, 91, 134 ])
      ]
    }
  end

  def build_psalm_lines(cycle)
    lines = [
      line_item(cycle.formatted_psalm_numbers, type: "heading"),
      line_item("Todos sentados", type: "rubric"),
      line_item("", type: "spacer")
    ]

    cycle.psalms(translation: @prefs[:version]).each do |psalm|
      next unless psalm

      lines << line_item(psalm.full_title, type: "subheading")

      # Add verses (responsive format: alternating leader/congregation)
      psalm.responsive_format.each do |verse|
        lines << line_item(
          "#{verse[:number]}  #{verse[:text]}",
          type: verse[:speaker]
        )
      end

      # Gloria Patri at end of each psalm
      lines << line_item("", type: "spacer")
      lines << line_item(gloria_patri, type: "congregation")
      lines << line_item("", type: "spacer")
    end

    lines
  end

  def build_multiple_psalms_lines(psalm_numbers)
    lines = []

    psalm_numbers.each do |number|
      psalm = Psalm.find_psalm(number, translation: @prefs[:version])
      next unless psalm

      lines << line_item(psalm.full_title, type: "subheading")

      psalm.responsive_format.each do |verse|
        lines << line_item(
          "#{verse[:number]}  #{verse[:text]}",
          type: verse[:speaker]
        )
      end

      lines << line_item("", type: "spacer")
      lines << line_item(gloria_patri, type: "congregation")
      lines << line_item("", type: "spacer")
    end

    lines
  end

  def build_fixed_psalm(number)
    psalm = Psalm.find_psalm(number, translation: @prefs[:version])
    return nil unless psalm

    {
      name: psalm.full_title,
      slug: "psalm",
      lines: [
        line_item("Todos sentados", type: "rubric"),
        *build_multiple_psalms_lines([ number ])
      ]
    }
  end

  def build_first_reading
    return nil unless @readings
    reading_ref = @readings[:first_reading]
    return nil unless reading_ref

    {
      name: "Primeira Leitura",
      slug: "first_reading",
      lines: [
        line_item("Primeira Leitura", type: "heading"),
        line_item(reading_ref, type: "subheading"),
        line_item("", type: "spacer"),
        line_item("Leitura de #{reading_ref}", type: "reader"),
        line_item(fetch_bible_text(reading_ref), type: "html"),
        line_item("", type: "spacer"),
        line_item("Palavra do Senhor.", type: "reader"),
        line_item("Gra\u00E7as a Deus.", type: "congregation")
      ]
    }
  end

  def build_second_reading
    return nil unless @readings
    reading_ref = @readings[:second_reading]
    return nil unless reading_ref

    {
      name: "Segunda Leitura",
      slug: "second_reading",
      lines: [
        line_item("Segunda Leitura", type: "heading"),
        line_item(reading_ref, type: "subheading"),
        line_item("", type: "spacer"),
        line_item("Leitura de #{reading_ref}", type: "reader"),
        line_item(fetch_bible_text(reading_ref), type: "html"),
        line_item("", type: "spacer"),
        line_item("Palavra do Senhor.", type: "reader"),
        line_item("Gra\u00E7as a Deus.", type: "congregation")
      ]
    }
  end

  def build_short_reading
    # Midday and Compline use short readings
    text = fetch_liturgical_text("short_reading")
    return nil unless text

    {
      name: "Leitura Breve",
      slug: "short_reading",
      lines: [
        line_item(text.reference, type: "subheading"),
        line_item(text.content, type: "reader")
      ]
    }
  end

  def build_first_canticle
    # Te Deum or Benedictus es Domine based on season
    slug = should_use_te_deum? ? "te_deum" : "benedictus_es_domine"
    text = fetch_liturgical_text(slug)
    return nil unless text

    name = slug == "te_deum" ? "Te Deum" : "Benedictus es Domine"

    {
      name: name,
      slug: "first_canticle",
      lines: [
        line_item("Todos de p\u00E9", type: "rubric"),
        line_item(text.content, type: "congregation")
      ]
    }
  end

  def build_second_canticle
    # Benedictus (Song of Zechariah)
    text = fetch_liturgical_text("benedictus")
    return nil unless text

    {
      name: "Benedictus (C\u00E2ntico de Zacarias)",
      slug: "benedictus",
      lines: [
        line_item("Todos de p\u00E9", type: "rubric"),
        line_item(text.content, type: "congregation")
      ]
    }
  end

  def build_magnificat
    # Magnificat (Song of Mary)
    text = fetch_liturgical_text("magnificat")
    return nil unless text

    {
      name: "Magnificat (C\u00E2ntico de Maria)",
      slug: "magnificat",
      lines: [
        line_item("Todos de p\u00E9", type: "rubric"),
        line_item(text.content, type: "congregation")
      ]
    }
  end

  def build_nunc_dimittis
    # Nunc Dimittis (Song of Simeon)
    text = fetch_liturgical_text("nunc_dimittis")
    return nil unless text

    {
      name: "Nunc Dimittis (C\u00E2ntico de Sime\u00E3o)",
      slug: "nunc_dimittis",
      lines: [
        line_item("Todos de p\u00E9", type: "rubric"),
        line_item(text.content, type: "congregation")
      ]
    }
  end

  def build_compline_hymn
    text = fetch_liturgical_text("compline_hymn")
    return nil unless text

    {
      name: "Hino",
      slug: "hymn",
      lines: [
        line_item(text.content, type: "congregation")
      ]
    }
  end

  def build_creed(type = nil)
    creed_type = type || @prefs[:creed_type]
    slug = creed_type == :nicene ? "nicene_creed" : "apostles_creed"
    text = fetch_liturgical_text(slug)
    return nil unless text

    name = slug == "nicene_creed" ? "Credo Niceno" : "Credo Apost\u00F3lico"

    {
      name: name,
      slug: "creed",
      lines: [
        line_item("Todos de p\u00E9", type: "rubric"),
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
        line_item("E com o teu esp\u00EDrito.", type: "congregation"),
        line_item("Oremos.", type: "leader"),
        line_item("", type: "spacer"),
        line_item("Senhor, tem piedade de n\u00F3s.", type: "leader"),
        line_item("Cristo, tem piedade de n\u00F3s.", type: "congregation"),
        line_item("Senhor, tem piedade de n\u00F3s.", type: "leader")
      ]
    }
  end

  def build_lords_prayer
    version = @prefs[:lords_prayer_version]
    slug = version == "contemporary" ? "lords_prayer_contemporary" : "lords_prayer_traditional"
    text = fetch_liturgical_text(slug)
    return nil unless text

    {
      name: "Ora\u00E7\u00E3o do Senhor",
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
      name: "Sufr\u00E1gios",
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
      name: "Sufr\u00E1gios",
      slug: "suffrages",
      lines: [
        line_item(text.content, type: "responsive")
      ]
    }
  end

  def build_collects
    collects_data = CollectService.new(@date).find_collects || {}

    {
      name: "Coletas",
      slug: "collects",
      lines: [
        line_item("Coleta do Dia", type: "heading"),
        line_item(collects_data[:text], type: "leader"),
        line_item("", type: "spacer"),
        line_item("Coleta pela Paz", type: "heading"),
        line_item(fetch_liturgical_text("collect_peace")&.content || "", type: "leader"),
        line_item("", type: "spacer"),
        line_item("Coleta pela Gra\u00E7a", type: "heading"),
        line_item(fetch_liturgical_text("collect_grace")&.content || "", type: "leader")
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
      name: "Ora\u00E7\u00F5es",
      slug: "prayers",
      lines: [
        line_item("Guarda-nos, Senhor, nesta noite, livres de todo pecado.", type: "leader"),
        line_item("Tem miseric\u00F3rdia de n\u00F3s, Senhor, tem miseric\u00F3rdia.", type: "congregation"),
        line_item("", type: "spacer"),
        line_item(fetch_liturgical_text("compline_collect")&.content || "", type: "leader")
      ]
    }
  end

  def build_general_thanksgiving
    text = fetch_liturgical_text("general_thanksgiving")
    return nil unless text

    {
      name: "A\u00E7\u00E3o de Gra\u00E7as",
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
      name: "Ora\u00E7\u00E3o de S\u00E3o Jo\u00E3o Cris\u00F3stomo",
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
        line_item("Am\u00E9m.", type: "congregation")
      ]
    }
  end

  # --- Helper Methods ---

  def line_item(content, type: "text", reference: nil, audio_id: nil)
    {
      content: content,
      line_type: type,
      reference: reference,
      audio_id: audio_id
    }.compact
  end

  def fetch_liturgical_text(slug)
    LiturgicalText.find_text(slug, version: @prefs[:version])
  end

  def fetch_bible_text(reference)
    bible_service.fetch_passage_html(reference)
  end

  def bible_service
    @bible_service ||= BibleTextService.new(translation: @prefs[:bible_version])
  end

  def liturgical_calendar
    @liturgical_calendar ||= LiturgicalCalendar.new(@date.year)
  end

  def gloria_patri
    "Glória ao Pai, e ao Filho, e ao Espírito Santo; como era no princípio, é agora e sempre será, pelos séculos dos séculos. Amém."
  end

  def should_use_jubilate?
    # Use Jubilate during Easter season, Venite otherwise
    @day_info[:liturgical_season] == "P\u00E1scoa"
  end

  def should_use_te_deum?
    # Use Te Deum except during Lent
    @day_info[:liturgical_season] != "Quaresma"
  end

  def season_to_slug(season)
    {
      "Advento" => "advent",
      "Natal" => "christmas",
      "Epifania" => "epiphany",
      "Quaresma" => "lent",
      "P\u00E1scoa" => "easter",
      "Tempo Comum" => "ordinary"
    }[season] || "ordinary"
  end

  def default_preferences
    {
      version: "loc_2015",
      language: "pt-BR",
      bible_version: "nvi",
      lords_prayer_version: "traditional",
      creed_type: :apostles,
      confession_type: "long"
    }
  end
end
