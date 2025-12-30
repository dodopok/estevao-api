# frozen_string_literal: true

# Serviço para buscar coletas (orações) litúrgicas para uma data específica
#
# CACHING: Uses v4 cache strategy with prayer_book.updated_at versioning
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

    "v7/collects/#{date}/#{prayer_book_code}/#{office_type}/pb_#{pb_version}"
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

  # Find collects without cache (internal use)
  def find_collects_uncached
    all_collects = []

    # 1. Coletas de todas as celebrações do dia
    celebrations = calendar.celebrations_for_date(date)
    celebrations.each do |cel_info|
      collects = collects_for_celebration_id(cel_info[:id])
      if collects.any?
        all_collects.concat(format_collect_records(collects, title: cel_info[:name]))
      else
        # Se não tem coleta específica, tenta uma comum baseada no tipo/descrição
        common = find_common_collect_for(cel_info)
        all_collects.concat(common) if common.any?
      end
    end

    # 2. Coleta do domingo (se for domingo)
    if date.sunday?
      sunday_ref = SundayReferenceMapper.map(date, calendar)
      collects = collects_for_sunday(sunday_ref)
      all_collects.concat(format_collect_records(collects, title: calendar.sunday_name(date)))
    end

    # 3. Coleta sazonal (baseada no último domingo) se não for domingo
    unless date.sunday?
      seasonal = find_by_season
      all_collects.concat(seasonal) if seasonal.any?
    end

    # 4. Coleta fixa do ofício (ex: Renewal of Life)
    fixed = find_fixed_office_collect
    all_collects.concat(fixed) if fixed.any?

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
  def find_common_collect_for(cel_info)
    return [] unless cel_info[:description].present?

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
    format_collect_records(collects, title: cel_info[:name], substitution: cel_info[:name])
  end

  # 3. Buscar pela coleta do último domingo
  def find_by_season
    last_sunday = find_last_sunday
    return [] unless last_sunday

    sunday_calendar = calendar_for_date(last_sunday)
    sunday_name = sunday_calendar.sunday_name(last_sunday)
    pb_language = prayer_book&.language
    
    # Translate sunday name if in English
    if pb_language == "en"
      sunday_name = Liturgical::Translator.translate_sunday_name(sunday_name)
    end

    weekday_name = Liturgical::Translator.day_name_en(date)
    
    # Title for weekday in season
    title = if pb_language == "en"
              "#{weekday_name} after #{sunday_name}"
            else
              "#{Liturgical::Translator.day_name_pt(date)} após #{sunday_name}"
            end

    seasonal_collects = []

    # 1. Tentar pelo nome do domingo (referência principal da quadra)
    sunday_ref = SundayReferenceMapper.map(last_sunday, sunday_calendar)
    if sunday_ref
      records = collects_for_sunday(sunday_ref)
      seasonal_collects.concat(format_collect_records(records, title: title))
    end

    # 2. Se não encontrou, tentar por Proper
    if seasonal_collects.empty?
      proper_num = sunday_calendar.proper_number(last_sunday)
      if proper_num
        records = collects_for_sunday("proper_#{proper_num}")
        seasonal_collects.concat(format_collect_records(records, title: title))
      end
    end

    # 3. Se ainda não encontrou, ver se o domingo tinha uma celebração especial (Páscoa, etc)
    if seasonal_collects.empty?
      records = find_collect_records_for_sunday_celebration(last_sunday)
      seasonal_collects.concat(format_collect_records(records, title: title))
    end

    seasonal_collects
  end

  # Encontra a coleta fixa do ofício
  def find_fixed_office_collect
    weekday_name = date.strftime("%A").downcase
    slug = "#{office_type}_collect_#{weekday_name}"
    
    text_record = LiturgicalText.find_text(slug, prayer_book_code: prayer_book_code)
    return [] unless text_record

    [{
      text: text_record.content,
      title: text_record.title || text_record.slug.humanize,
      slug: text_record.slug
    }]
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
  def format_collect_records(records, title: nil, substitution: nil)
    return [] if records.blank?

    records.map do |c|
      text = c.text
      text = text.gsub("N.", substitution) if substitution && text.include?("N.")
      
      {
        text: text,
        preface: c.preface,
        title: title
      }.compact
    end
  end

  # Compatibility method for old code that expects format_response
  def format_response(collects)
    return nil if collects.nil? || collects.empty?
    format_collect_records(collects)
  end
end