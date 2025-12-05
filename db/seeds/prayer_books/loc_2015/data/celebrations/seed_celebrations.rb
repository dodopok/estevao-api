# ================================================================================
# SEED DE CELEBRAÇÕES (Principal Feasts, Festivals e Lesser Feasts)
# Carrega dados dos arquivos JSON e insere/atualiza no banco
# ================================================================================

Rails.logger.info "📅 Carregando celebrações do calendário..."

CALENDAR_PATH = File.dirname(__FILE__)
PRAYER_BOOK_CODE = 'loc_2015'

prayer_book = PrayerBook.find_by!(code: PRAYER_BOOK_CODE)

# Mapeia cores do JSON (em inglês) para o banco
COLOR_MAP = {
  'white' => 'branco',
  'red' => 'vermelho',
  'green' => 'verde',
  'purple' => 'roxo',
  'blue' => 'azul',
  'rose' => 'rosa',
  'black' => 'preto'
}.freeze

# Rank padrão por tipo de celebração (quando não especificado)
DEFAULT_RANKS = {
  'principal_feast' => 0,
  'major_holy_day' => 50,
  'festival' => 100,
  'lesser_feast' => 200,
  'commemoration' => 300
}.freeze

def load_json_file(filename)
  file_path = File.join(CALENDAR_PATH, filename)
  return [] unless File.exist?(file_path)

  JSON.parse(File.read(file_path))
rescue JSON::ParserError => e
  Rails.logger.error "❌ Erro ao parsear #{filename}: #{e.message}"
  []
end

def normalize_celebration(data, prayer_book_id, default_rank_base)
  # Normaliza a cor litúrgica
  color = data['liturgical_color']
  normalized_color = COLOR_MAP[color] || color || 'branco'

  # Define rank: usa o do JSON ou calcula baseado no tipo
  rank = data['rank'] || default_rank_base

  # NÃO usar .compact - todos os registros precisam ter as mesmas chaves para upsert_all
  {
    name: data['name'],
    celebration_type: data['celebration_type'],
    fixed_month: data['fixed_month'],
    fixed_day: data['fixed_day'],
    movable: data['movable'] || false,
    calculation_rule: data['calculation_rule'],
    liturgical_color: normalized_color,
    description: data['description'],
    description_year: data['description_year'],
    can_be_transferred: data['can_be_transferred'].nil? ? true : data['can_be_transferred'],
    transfer_rules: data['transfer_rules'],
    rank: rank,
    prayer_book_id: prayer_book_id
  }
end

# Alternativa mais rápida usando upsert_all (Rails 6+)
def bulk_upsert_celebrations(celebrations_data, prayer_book, type_name)
  return if celebrations_data.empty?

  Rails.logger.info "  📖 Processando #{celebrations_data.size} #{type_name} (bulk)..."

  default_rank = DEFAULT_RANKS[celebrations_data.first['celebration_type']]

  records = celebrations_data.each_with_index.map do |data, index|
    attrs = normalize_celebration(data, prayer_book.id, default_rank + index)
    attrs[:created_at] = Time.current
    attrs[:updated_at] = Time.current
    attrs
  end

  # Upsert baseado em name + prayer_book_id
  result = Celebration.upsert_all(
    records,
    unique_by: %i[name prayer_book_id],
    update_only: %i[
      celebration_type fixed_month fixed_day movable calculation_rule
      liturgical_color description description_year can_be_transferred transfer_rules rank
    ]
  )

  Rails.logger.info "    ✅ #{type_name}: #{result.rows.size} registros processados"
end

# ================================================================================
# Execução principal
# ================================================================================

begin
  ActiveRecord::Base.transaction do
    # Carrega e processa Principal Feasts
    principal_feasts = load_json_file('principal_feast.json')
    bulk_upsert_celebrations(principal_feasts, prayer_book, 'Festas Principais')

    # Carrega e processa Lesser Feasts
    lesser_feasts = load_json_file('lesser_feast.json')
    bulk_upsert_celebrations(lesser_feasts, prayer_book, 'Festas Menores')

    # Carrega e processa Lesser Feasts
    festival = load_json_file('festival.json')
    bulk_upsert_celebrations(festival, prayer_book, 'Festivais')

    # Carrega e processa Major Holy Days
    major_holy_days = load_json_file('major_holy_days.json')
    bulk_upsert_celebrations(major_holy_days, prayer_book, 'Dias Santos Principais')

    # Carrega e processa Semana Santa
    holy_week = load_json_file('holy_week.json')
    bulk_upsert_celebrations(holy_week, prayer_book, 'Semana Santa')
  end

  total = Celebration.where(prayer_book_id: prayer_book.id).count
  Rails.logger.info "✅ Calendário carregado! Total: #{total} celebrações"

rescue ActiveRecord::RecordInvalid => e
  Rails.logger.error "❌ Erro de validação: #{e.message}"
  raise
rescue StandardError => e
  Rails.logger.error "❌ Erro ao carregar celebrações: #{e.message}"
  raise
end
