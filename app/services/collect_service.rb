# frozen_string_literal: true

# Serviço para buscar coletas (orações) litúrgicas para uma data específica
#
# CACHING: Uses v5 cache strategy with prayer_book.updated_at versioning
# - Collects are cached per date/prayer_book with 1-day TTL
# - Uses Collect.collects_cache_for for base data (30-day TTL)
#
class CollectService
  include PrayerBookAware

  attr_reader :date, :calendar, :office_type

  def initialize(date, prayer_book_code: "loc_2015", calendar: nil, office_type: :morning)
    @date = date
    @prayer_book_code = prayer_book_code
    @calendar = calendar || LiturgicalCalendar.new(date.year, prayer_book_code: prayer_book_code)
    @office_type = office_type
  end

  # Retorna a(s) coleta(s) para o dia (cached)
  # Retorna array de hashes ou nil se não houver
  def find_collects
    cache_key = build_collects_cache_key

    result = Rails.cache.fetch(cache_key, expires_in: 1.day) do
      record_cache_miss
      find_collects_uncached
    end

    result.present? ? result : nil
  end

  private

  # Build cache key for collects
  def build_collects_cache_key
    pb = PrayerBook.find_by_code(prayer_book_code)
    pb_version = pb&.updated_at&.to_i || 0

    "v8/collects/#{date}/#{prayer_book_code}/#{office_type}/pb_#{pb_version}"
  end

  # Find collects without cache (internal use)
  def find_collects_uncached
    all_collects = []
    celebrations = calendar.celebrations_for_date(date)
    language = prayer_book&.language || "pt-BR"

    collect_of_the_day_label = (language == "en" ? "Collect of the Day" : "Coleta do Dia")

    # 1. Coletas de celebrações de alta prioridade (Principais, Dias Santos, Festivais)
    high_priority = celebrations.select { |c| %w[principal_feast major_holy_day festival].include?(c[:type].to_s) }
    high_priority.each do |c|
      all_collects.concat(collects_for_celebration_info(c, module_title: collect_of_the_day_label))
    end

    # 2. Coleta do domingo ou sazonal da semana
    if date.sunday?
      all_collects.concat(collects_for_sunday_with_proper(date, calendar, module_title: collect_of_the_day_label, title: calendar.sunday_name(date)))
    else
      all_collects.concat(find_by_season(module_title: collect_of_the_day_label))
    end

    # 3. Coletas de celebrações de baixa prioridade (Santos, Comemorações)
    low_priority = celebrations.select { |c| %w[lesser_feast commemoration].include?(c[:type].to_s) }
    low_priority.each do |c|
      all_collects.concat(collects_for_celebration_info(c, module_title: collect_of_the_day_label, join_subtitle: true))
    end

    # 4. Coleta fixa do ofício (ex: Renewal of Life)
    all_collects.concat(find_fixed_office_collect)

    # Remover duplicatas mantendo a primeira ocorrência (pela ordem de prioridade acima)
    all_collects.uniq { |c| c[:text] }
  end

  # Record cache miss for Datadog metrics
  def record_cache_miss
    return unless defined?(Datadog) && Datadog.respond_to?(:statsd)

    Datadog.statsd.increment(
      "cache.miss",
      tags: [
        "cache_category:collects",
        "prayer_book:#{prayer_book_code}"
      ]
    )
  rescue StandardError
    # Don't let metrics failures affect the app
  end

  # Memoized Liturgical::CelebrationResolver for a specific year
  def resolver_for_year(year)
    @resolvers ||= {}
    @resolvers[year] ||= Liturgical::CelebrationResolver.new(year, prayer_book_code: prayer_book_code)
  end

  # Helper para buscar e formatar coletas de uma celebração
  def collects_for_celebration_info(cel_info, module_title: nil, join_subtitle: false)
    name = cel_info[:name]
    desc = [ cel_info[:description], cel_info[:description_year] ].compact_blank.join(", ")

    title = name
    subtitle = desc

    if join_subtitle && desc.present?
      title = "#{name}, #{desc}"
      subtitle = nil
    end

    # Buscar a celebration do banco para ter acesso aos campos de gramática
    celebration = Celebration.find_by(id: cel_info[:id])

    collects = collects_for_celebration_id(cel_info[:id])
    if collects.any?
      format_collect_records(collects, module_title: module_title, title: title, subtitle: subtitle, celebration: celebration)
    else
      find_common_collect_for(cel_info, celebration: celebration, module_title: module_title, title: title, subtitle: subtitle)
    end
  end

  # Helper para buscar coleta de domingo (por nome, proper ou celebração)
  def collects_for_sunday_with_proper(target_date, target_calendar, module_title: nil, title: nil)
    # Translate title if it's a Sunday name and language is English
    language = prayer_book&.language
    if language == "en" && title.present?
      title = Liturgical::Translator.translate_sunday_name(title)
    end

    # 1. Tentar pelo nome do domingo (referência principal da quadra e apelidos)
    sunday_refs = SundayReferenceMapper.map_with_aliases(target_date, target_calendar)
    sunday_refs.each do |ref|
      records = collects_for_sunday(ref)
      return format_collect_records(records, module_title: module_title, title: title) if records.any?
    end

    # 2. Tentar por Proper
    proper_num = target_calendar.proper_number(target_date)
    if proper_num
      records = collects_for_sunday("proper_#{proper_num}")
      return format_collect_records(records, module_title: module_title, title: title) if records.any?
    end

    # 3. Ver se o domingo tinha uma celebração especial (Páscoa, etc)
    records = find_collect_records_for_sunday_celebration(target_date)
    format_collect_records(records, module_title: module_title, title: title)
  end

  # Common query for collects by celebration id
  def collects_for_celebration_id(celebration_id)
    return [] unless celebration_id

    Collect.for_celebration(celebration_id)
           .for_prayer_book_id(prayer_book_id)
  end

  # Common query for collects by sunday reference
  def collects_for_sunday(sunday_ref)
    return [] unless sunday_ref

    Collect.for_sunday(sunday_ref)
           .for_prayer_book_id(prayer_book_id)
  end

  # Tenta encontrar uma coleta comum para uma celebração
  def find_common_collect_for(cel_info, celebration: nil, module_title: nil, title: nil, subtitle: nil)
    return [] unless cel_info[:description].present?

    # Se a celebração é de um evento (não pessoa), não usar coleta comum
    return [] if celebration&.event?

    desc = cel_info[:description].downcase
    common_ref = nil

    if desc.include?("martyr") || desc.include?("mártir")
      common_ref = "common_martyrs"
    elsif desc.include?("missionary") || desc.include?("missionário")
      common_ref = "common_missionaries"
    elsif desc.include?("pastor") || desc.include?("bispo") || desc.include?("bishop")
      common_ref = "common_pastors"
    elsif desc.include?("teacher") || desc.include?("professor") || desc.include?("doutor") || desc.include?("doctor")
      common_ref = "common_teachers"
    elsif desc.include?("monk") || desc.include?("nun") || desc.include?("monge") || desc.include?("monja") || desc.include?("religious") || desc.include?("religioso")
      common_ref = "common_religious"
    elsif desc.include?("ecumenist") || desc.include?("ecumenista")
      common_ref = "common_ecumenists"
    elsif desc.include?("reformer") || desc.include?("reformador")
      common_ref = "common_reformers"
    elsif desc.include?("renewer") || desc.include?("renovador")
      common_ref = "common_renewers"
    else
      common_ref = "common_saints"
    end

    collects = collects_for_sunday(common_ref)
    format_collect_records(collects, module_title: module_title, title: title, subtitle: subtitle, celebration: celebration)
  end

  # 3. Buscar pela coleta do último domingo
  def find_by_season(module_title: nil)
    last_sunday = find_last_sunday
    return [] unless last_sunday

    sunday_calendar = calendar_for_date(last_sunday)
    sunday_name = sunday_calendar.sunday_name(last_sunday)
    language = prayer_book&.language

    # Translate sunday name if in English
    if language == "en"
      sunday_name = Liturgical::Translator.translate_sunday_name(sunday_name)
    end

    weekday_name = (language == "en" ? Liturgical::Translator.day_name_en(date) : Liturgical::Translator.day_name_pt(date))

    # Title for weekday in season
    title = if language == "en"
              "#{weekday_name} after the #{sunday_name}"
    else
              "#{Liturgical::Translator.day_name_pt(date)} após o #{sunday_name}"
    end

    # Fix for "after the 1st Sunday after Christmas" -> "after the First Sunday of Christmas" if needed?
    # User example: "Monday after the First Sunday of Christmas"
    if language == "en"
      title = title.gsub("1st Sunday after Christmas", "First Sunday of Christmas")
                   .gsub("2nd Sunday after Christmas", "Second Sunday of Christmas")
    end

    collects_for_sunday_with_proper(last_sunday, sunday_calendar, module_title: module_title, title: title)
  end

  # Encontra a coleta fixa do ofício
  def find_fixed_office_collect
    weekday_name = date.strftime("%A").downcase
    slug = "#{office_type}_collect_#{weekday_name}"

    text_record = LiturgicalText.find_text(slug, prayer_book_code: prayer_book_code)
    return [] unless text_record

    # User example: Heading: "A Collect for the Renewal of Life", Subtitle: "Monday"
    language = prayer_book&.language
    weekday_label = (language == "en" ? date.strftime("%A") : Liturgical::Translator.day_name_pt(date))

    [ {
      text: text_record.content,
      module_title: text_record.title || text_record.slug.humanize,
      title: weekday_label,
      slug: text_record.slug
    } ]
  end

  # Busca coletas por celebração do domingo
  def find_collect_records_for_sunday_celebration(sunday_date)
    year_resolver = resolver_for_year(sunday_date.year)
    celebration = year_resolver.resolve_for_date(sunday_date)
    collects_for_celebration_id(celebration&.id)
  end

  # Retorna o calendário apropriado para uma data
  def calendar_for_date(target_date)
    target_date.year == date.year ? calendar : LiturgicalCalendar.new(target_date.year, prayer_book_code: prayer_book_code)
  end

  # Encontra o domingo anterior à data atual
  def find_last_sunday
    days_since_sunday = date.wday # 0 = domingo, 1 = segunda, etc
    return nil if days_since_sunday == 0 # Se já é domingo, não busca

    date - days_since_sunday.days
  end

  # Formata a resposta
  def format_collect_records(records, module_title: nil, title: nil, subtitle: nil, celebration: nil)
    return [] if records.blank?

    records.map do |c|
      text = c.text

      # Se a coleta contém "N." e temos uma celebration que não é evento, fazer substituição gramatical
      if celebration && !celebration.event? && text.include?("N.")
        # Substituir padrões gramaticais comuns
        text = substitute_grammatical_patterns(text, celebration)
      end

      {
        text: text,
        preface: c.preface,
        module_title: module_title,
        title: title,
        subtitle: subtitle
      }.compact
    end
  end

  # Substitui padrões gramaticais na coleta usando informações da celebration
  def substitute_grammatical_patterns(text, celebration)
    name = celebration.name

    # Substituir padrões comuns de concordância
    # Ex: "teu servo N." -> "tua serva Inês" ou "teus servos Timóteo e Tito"
    text = text.gsub(/teu servo N\./, celebration.servant_phrase(name))
    text = text.gsub(/tua serva N\./, celebration.servant_phrase(name))
    text = text.gsub(/teus servos N\./, celebration.servant_phrase(name))
    text = text.gsub(/tuas servas N\./, celebration.servant_phrase(name))

    # Caso genérico: apenas substituir N. pelo nome se nenhum padrão acima foi encontrado
    text = text.gsub("N.", name)

    text
  end

  # Compatibility method for old code that expects format_response
  def format_response(collects)
    return nil if collects.nil? || collects.empty?
    format_collect_records(collects)
  end

  # For test compatibility
  def find_by_celebration
    celebration = calendar.celebration_for_date(date)
    return [] unless celebration
    collects_for_celebration_id(celebration[:id])
  end

  # For test compatibility
  def find_by_sunday
    return [] unless date.sunday?
    sunday_ref = SundayReferenceMapper.map(date, calendar)
    collects_for_sunday(sunday_ref)
  end

  # For test compatibility
  def find_collect_for_sunday_celebration(sunday_date)
    find_collect_records_for_sunday_celebration(sunday_date)
  end
end
