#!/usr/bin/env ruby
# ================================================================================
# Script para importar leituras de arquivo XLSX para o banco de dados
# ================================================================================
#
# Uso:
#   rails runner script/import_readings_from_xlsx.rb [arquivo.xlsx]
#
# Importa leituras do arquivo Excel para o banco de dados
# Espera colunas: cycle, service_type, date_reference, first_reading,
#                 psalm, second_reading, gospel
#
# ================================================================================

require 'roo'

# Verificar se arquivo foi fornecido
if ARGV.empty?
  puts "❌ Erro: Nenhum arquivo fornecido"
  puts "📖 Uso: rails runner script/import_readings_from_xlsx.rb arquivo.xlsx"
  exit 1
end

file_path = ARGV[0]

unless File.exist?(file_path)
  puts "❌ Erro: Arquivo não encontrado: #{file_path}"
  exit 1
end

puts "📥 Importando leituras de: #{file_path}"

# Abrir arquivo Excel
xlsx = Roo::Spreadsheet.open(file_path)

# Usar primeira planilha
sheet = xlsx.sheet(0)

# Verificar cabeçalhos (primeira linha)
headers = sheet.row(1)
expected_headers = [ "cycle", "service_type", "date_reference", "first_reading", "psalm", "second_reading", "gospel" ]

unless headers == expected_headers
  puts "⚠️  Aviso: Cabeçalhos não correspondem ao esperado"
  puts "   Esperado: #{expected_headers.join(', ')}"
  puts "   Encontrado: #{headers.join(', ')}"
end

# Processar linhas (pulando cabeçalho)
created = 0
updated = 0
skipped = 0
errors = []

(2..sheet.last_row).each do |i|
  row = sheet.row(i)

  # Pular linhas vazias
  next if row.all?(&:nil?) || row.all? { |cell| cell.to_s.strip.empty? }

  reading_data = {
    cycle: row[0]&.to_s&.strip,
    service_type: row[1]&.to_s&.strip,
    date_reference: row[2]&.to_s&.strip,
    first_reading: row[3]&.to_s&.strip,
    psalm: row[4]&.to_s&.strip,
    second_reading: row[5]&.to_s&.strip,
    gospel: row[6]&.to_s&.strip
  }

  # Validar dados essenciais
  if reading_data[:cycle].blank? || reading_data[:date_reference].blank?
    skipped += 1
    next
  end

  begin
    # Procurar leitura existente
    existing = LectionaryReading.find_by(
      cycle: reading_data[:cycle],
      service_type: reading_data[:service_type],
      date_reference: reading_data[:date_reference]
    )

    if existing
      existing.update!(reading_data)
      updated += 1
    else
      LectionaryReading.create!(reading_data)
      created += 1
    end

    print "." if (created + updated) % 10 == 0

  rescue => e
    errors << "Linha #{i}: #{e.message}"
  end
end

puts "\n"
puts "✅ Importação concluída!"
puts "   📝 #{created} leituras criadas"
puts "   🔄 #{updated} leituras atualizadas"
puts "   ⏭️  #{skipped} linhas puladas (vazias ou incompletas)"

if errors.any?
  puts "\n❌ Erros encontrados:"
  errors.each { |error| puts "   #{error}" }
end
