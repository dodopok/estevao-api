# ================================================================================
# LEITURAS SEMANAIS DO OFÍCIO DIÁRIO - LOC 2015 IEAB
# ================================================================================
#
# Conteúdo:
# - Leituras diárias (Segunda a Sábado) para os 3 ciclos (A, B, C)
# - Formato: Salmo, Antigo Testamento, Novo Testamento
# - Tipos: Semicontínua (padrão) e Complementar
#
# Fonte: script/ieab_weekly.csv
# Total esperado: ~1,370 leituras
#
# ================================================================================

puts "📖 Carregando leituras semanais do Ofício Diário (LOC 2015)..."

csv_path = Rails.root.join('script/ieab_weekly.csv')

if File.exist?(csv_path)
  require Rails.root.join('script/import_weekly_readings.rb')

  importer = WeeklyReadingsImporter.new(csv_path)
  importer.import

  total_weekly = LectionaryReading.where(service_type: 'weekly').count
  puts "✓ #{total_weekly} leituras semanais carregadas"
else
  puts "⚠️  CSV não encontrado: #{csv_path}"
  puts "   Pulando importação de leituras semanais"
end
