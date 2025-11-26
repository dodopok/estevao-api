#!/usr/bin/env ruby
# ================================================================================
# Script para exportar leituras do lecionário para arquivo XLSX
# Versão alternativa usando write_xlsx (melhor compatibilidade com Google Sheets)
# ================================================================================
#
# Uso:
#   rails runner script/export_readings_to_xlsx_alt.rb
#
# ================================================================================

require 'write_xlsx'

puts "📊 Exportando leituras para XLSX (versão compatível)..."

# Buscar dados
readings = LectionaryReading.order(:date_reference, :cycle, :service_type)
date_refs = LectionaryReading.distinct.pluck(:date_reference).sort

puts "📖 Encontradas #{readings.count} leituras no banco de dados"
puts "📅 Encontradas #{date_refs.count} date_references únicas"

# Criar arquivo Excel
output_path = Rails.root.join("tmp", "lectionary_readings_export.xlsx")
workbook = WriteXLSX.new(output_path.to_s)

# Formatos
header_format = workbook.add_format(
  bold: true,
  bg_color: '#4472C4',
  color: 'white',
  align: 'center',
  valign: 'vcenter',
  border: 1
)

cell_format = workbook.add_format(
  text_wrap: true,
  valign: 'top',
  border: 1
)

# ==============================================================
# PLANILHA 1: Todas as leituras existentes
# ==============================================================
worksheet1 = workbook.add_worksheet('Lectionary Readings')

# Configurar larguras das colunas
worksheet1.set_column(0, 0, 8)   # cycle
worksheet1.set_column(1, 1, 15)  # service_type
worksheet1.set_column(2, 2, 30)  # date_reference
worksheet1.set_column(3, 3, 30)  # first_reading
worksheet1.set_column(4, 4, 25)  # psalm
worksheet1.set_column(5, 5, 30)  # second_reading
worksheet1.set_column(6, 6, 30)  # gospel

# Cabeçalhos
headers = [ "cycle", "service_type", "date_reference", "first_reading", "psalm", "second_reading", "gospel" ]
worksheet1.write_row(0, 0, headers, header_format)

# Dados
row = 1
readings.each do |reading|
  worksheet1.write(row, 0, reading.cycle || "", cell_format)
  worksheet1.write(row, 1, reading.service_type || "", cell_format)
  worksheet1.write(row, 2, reading.date_reference || "", cell_format)
  worksheet1.write(row, 3, reading.first_reading || "", cell_format)
  worksheet1.write(row, 4, reading.psalm || "", cell_format)
  worksheet1.write(row, 5, reading.second_reading || "", cell_format)
  worksheet1.write(row, 6, reading.gospel || "", cell_format)
  row += 1
end

# ==============================================================
# PLANILHA 2: Template com ciclos faltantes
# ==============================================================
worksheet2 = workbook.add_worksheet('Date References Template')

# Configurar larguras das colunas
worksheet2.set_column(0, 0, 30)  # date_reference
worksheet2.set_column(1, 1, 8)   # cycle
worksheet2.set_column(2, 2, 15)  # service_type
worksheet2.set_column(3, 3, 30)  # first_reading
worksheet2.set_column(4, 4, 25)  # psalm
worksheet2.set_column(5, 5, 30)  # second_reading
worksheet2.set_column(6, 6, 30)  # gospel

# Cabeçalhos
headers2 = [ "date_reference", "cycle", "service_type", "first_reading", "psalm", "second_reading", "gospel" ]
worksheet2.write_row(0, 0, headers2, header_format)

# Template para ciclos faltantes
row = 1
date_refs.each do |date_ref|
  existing_cycles = LectionaryReading.where(date_reference: date_ref).pluck(:cycle).uniq

  [ 'A', 'B', 'C' ].each do |cycle|
    next if existing_cycles.include?(cycle)

    worksheet2.write(row, 0, date_ref, cell_format)
    worksheet2.write(row, 1, cycle, cell_format)
    worksheet2.write(row, 2, 'eucharist', cell_format)
    worksheet2.write(row, 3, '', cell_format)
    worksheet2.write(row, 4, '', cell_format)
    worksheet2.write(row, 5, '', cell_format)
    worksheet2.write(row, 6, '', cell_format)
    row += 1
  end
end

# Fechar e salvar
workbook.close

puts "✅ Arquivo exportado com sucesso!"
puts "📁 Localização: #{output_path}"
puts ""
puts "📊 O arquivo contém duas planilhas:"
puts "   1. 'Lectionary Readings' - Todas as leituras existentes"
puts "   2. 'Date References Template' - Template com date_references faltantes"
puts ""
puts "💡 Este arquivo deve abrir corretamente no Google Sheets"
