# ================================================================================
# LEITURAS SEMANAIS DO OFÍCIO DIÁRIO - LOC 2015 IEAB
# ================================================================================
#
# Conteúdo:
# - Leituras diárias (Segunda a Sábado) para os 3 ciclos (A, B, C)
# - Formato: Salmo, Antigo Testamento, Novo Testamento
# - Tipos: Semicontínua (padrão) e Complementar
#
# Fonte: script/ieab_weekly_v2.csv
# Total esperado: ~1,370 leituras
#
# ================================================================================

Rails.logger.info "📖 Carregando leituras semanais do Ofício Diário (LOC 2015)..."

csv_path = Rails.root.join('db/seeds/prayer_books/loc_2015/data/daily_readings.csv')

if File.exist?(csv_path)
  require Rails.root.join('db/seeds/prayer_books/loc_2015/data/daily_readings.rb')

  importer = WeeklyReadingsImporter.new(csv_path)
  importer.import

  total_weekly = LectionaryReading.where(service_type: 'weekly').count
  Rails.logger.info "✓ #{total_weekly} leituras semanais carregadas"
else
  Rails.logger.info "⚠️  CSV não encontrado: #{csv_path}"
  Rails.logger.info "   Pulando importação de leituras semanais"
end
