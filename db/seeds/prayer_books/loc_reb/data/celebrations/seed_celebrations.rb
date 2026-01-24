# ================================================================================
# SEED DE CELEBRAÇÕES - LOC REB
# Carrega dados dos arquivos JSON e insere/atualiza no banco
# ================================================================================

Rails.logger.info "📅 Carregando celebrações do calendário (LOC REB)..."

CALENDAR_PATH = File.dirname(__FILE__)
PRAYER_BOOK_CODE = 'loc_reb'

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

# Rank padrão por tipo de celebração
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

def bulk_upsert_celebrations(celebrations_data, prayer_book, type_name)
  return if celebrations_data.empty?

  Rails.logger.info "  📖 Processando #{celebrations_data.size} #{type_name}..."

  default_rank = DEFAULT_RANKS[celebrations_data.first['celebration_type']] || 100

  records = celebrations_data.each_with_index.map do |data, index|
    {
      name: data['name'],
      celebration_type: data['celebration_type'],
      fixed_month: data['fixed_month'],
      fixed_day: data['fixed_day'],
      movable: data['movable'] || false,
      calculation_rule: data['calculation_rule'],
      liturgical_color: COLOR_MAP[data['liturgical_color']] || data['liturgical_color'] || 'branco',
      description: data['description'],
      can_be_transferred: data['can_be_transferred'].nil? ? true : data['can_be_transferred'],
      rank: data['rank'] || (default_rank + index),
      prayer_book_id: prayer_book.id,
      created_at: Time.current,
      updated_at: Time.current
    }
  end

  Celebration.upsert_all(
    records,
    unique_by: %i[name prayer_book_id],
    update_only: %i[celebration_type fixed_month fixed_day movable calculation_rule
                    liturgical_color description can_be_transferred rank]
  )

  Rails.logger.info "    ✅ #{type_name}: #{records.size} registros processados"
end

# Execução
begin
  ActiveRecord::Base.transaction do
    # Carrega festas principais
    major_feasts = load_json_file('major_holy_days.json')
    bulk_upsert_celebrations(major_feasts, prayer_book, 'Festas Principais')

    # Carrega memórias (lesser feasts)
    lesser_feasts = load_json_file('lesser_feasts.json')
    bulk_upsert_celebrations(lesser_feasts, prayer_book, 'Memórias')
  end

  total = Celebration.where(prayer_book_id: prayer_book.id).count
  Rails.logger.info "✅ Calendário carregado! Total: #{total} celebrações"

rescue StandardError => e
  Rails.logger.error "❌ Erro ao carregar celebrações: #{e.message}"
  raise
end
