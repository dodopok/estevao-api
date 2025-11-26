#!/usr/bin/env ruby
# ================================================================================
# Script para exportar leituras do lecionário para arquivo CSV
# ================================================================================
#
# Uso:
#   rails runner script/export_readings_to_csv.rb
#
# Gera um arquivo CSV com todas as leituras do banco de dados
#
# ================================================================================

require 'csv'

puts "📊 Exportando leituras para CSV..."

# Buscar todas as leituras ordenadas
readings = LectionaryReading.order(:date_reference, :cycle, :service_type)

puts "📖 Encontradas #{readings.count} leituras no banco de dados"

# Criar arquivo CSV
output_path = Rails.root.join("tmp", "lectionary_readings_export.csv")

CSV.open(output_path, "w", write_headers: true, headers: [
  "cycle",
  "service_type",
  "date_reference",
  "first_reading",
  "psalm",
  "second_reading",
  "gospel"
]) do |csv|
  readings.each do |reading|
    csv << [
      reading.cycle,
      reading.service_type,
      reading.date_reference,
      reading.first_reading,
      reading.psalm,
      reading.second_reading,
      reading.gospel
    ]
  end
end

puts "✅ Arquivo CSV exportado com sucesso!"
puts "📁 Localização: #{output_path}"
puts ""
puts "💡 Você pode abrir este arquivo no Excel ou Google Sheets"
