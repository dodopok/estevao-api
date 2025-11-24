#!/usr/bin/env ruby
# ================================================================================
# Script para exportar leituras do lecionário para arquivo XLSX
# ================================================================================
#
# Uso:
#   rails runner script/export_readings_to_xlsx.rb
#
# Gera um arquivo Excel com todas as leituras do banco de dados
# Colunas: cycle, service_type, date_reference, first_reading, psalm, 
#          second_reading, gospel
#
# ================================================================================

require 'caxlsx'

puts "📊 Exportando leituras para XLSX..."

# Buscar dados primeiro
readings = LectionaryReading.order(:date_reference, :cycle, :service_type)
date_refs = LectionaryReading.distinct.pluck(:date_reference).sort

puts "📖 Encontradas #{readings.count} leituras no banco de dados"
puts "📅 Encontradas #{date_refs.count} date_references únicas"

# Criar arquivo Excel
Axlsx::Package.new do |package|
  workbook = package.workbook
  
  # Estilos
  header_style = workbook.styles.add_style(
    bg_color: "4472C4",
    fg_color: "FFFFFF",
    b: true,
    alignment: { horizontal: :center, vertical: :center }
  )
  
  cell_style = workbook.styles.add_style(
    alignment: { wrap_text: true, vertical: :top }
  )
  
  # ==============================================================
  # PLANILHA 1: Todas as leituras existentes
  # ==============================================================
  workbook.add_worksheet(name: "Lectionary Readings") do |sheet|
    # Cabeçalhos
    sheet.add_row [
      "cycle",
      "service_type",
      "date_reference",
      "first_reading",
      "psalm",
      "second_reading",
      "gospel"
    ], style: header_style
    
    # Dados
    readings.each do |reading|
      sheet.add_row [
        reading.cycle || "",
        reading.service_type || "",
        reading.date_reference || "",
        reading.first_reading || "",
        reading.psalm || "",
        reading.second_reading || "",
        reading.gospel || ""
      ], style: cell_style
    end
    
    # Largura das colunas
    sheet.column_widths 8, 15, 30, 30, 25, 30, 30
  end
  
  # ==============================================================
  # PLANILHA 2: Template com ciclos faltantes
  # ==============================================================
  workbook.add_worksheet(name: "Date References Template") do |sheet|
    # Cabeçalhos
    sheet.add_row [
      "date_reference",
      "cycle",
      "service_type",
      "first_reading",
      "psalm",
      "second_reading",
      "gospel"
    ], style: header_style
    
    # Template para ciclos faltantes
    date_refs.each do |date_ref|
      existing_cycles = LectionaryReading.where(date_reference: date_ref).pluck(:cycle).uniq
      
      ['A', 'B', 'C'].each do |cycle|
        next if existing_cycles.include?(cycle)
        
        sheet.add_row [
          date_ref,
          cycle,
          'eucharist',
          '',
          '',
          '',
          ''
        ], style: cell_style
      end
    end
    
    # Largura das colunas
    sheet.column_widths 30, 8, 15, 30, 25, 30, 30
  end
  
  # Salvar arquivo
  output_path = Rails.root.join("tmp", "lectionary_readings_export.xlsx")
  package.serialize(output_path)
  
  puts "✅ Arquivo exportado com sucesso!"
  puts "📁 Localização: #{output_path}"
  puts ""
  puts "📊 O arquivo contém duas planilhas:"
  puts "   1. 'Lectionary Readings' - Todas as leituras existentes"
  puts "   2. 'Date References Template' - Template com date_references faltantes"
end
