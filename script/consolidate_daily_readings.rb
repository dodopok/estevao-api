#!/usr/bin/env ruby
# frozen_string_literal: true

# Script para consolidar as leituras diárias de 2 linhas por dia para 1 linha só
# Junta os salmos da manhã e noite, e separa novo_testamento (epístola) e evangelho

require 'csv'
require 'fileutils'

INPUT_FILE = File.expand_path('../../db/seeds/prayer_books/locb_2008/data/daily_readings.csv', __FILE__)
BACKUP_FILE = File.expand_path('../../db/seeds/prayer_books/locb_2008/data/daily_readings.csv.bak', __FILE__)
OUTPUT_FILE = INPUT_FILE

puts "Lendo arquivo: #{INPUT_FILE}"

# Fazer backup
FileUtils.cp(INPUT_FILE, BACKUP_FILE)
puts "Backup criado: #{BACKUP_FILE}"

# Ler todas as linhas
rows = CSV.read(INPUT_FILE, headers: true)
puts "Total de linhas lidas: #{rows.size}"

# Agrupar linhas em pares (manhã e noite)
consolidated = []
rows.each_slice(2) do |morning, evening|
  unless morning && evening
    puts "AVISO: Linha ímpar encontrada no final do arquivo"
    next
  end

  # Validar que são do mesmo dia
  if morning['ciclo'] != evening['ciclo'] ||
     morning['semana'] != evening['semana'] ||
     morning['dia'] != evening['dia']
    puts "ERRO: Linhas não correspondem ao mesmo dia:"
    puts "  Manhã: #{morning['ciclo']}, #{morning['semana']}, #{morning['dia']}"
    puts "  Noite: #{evening['ciclo']}, #{evening['semana']}, #{evening['dia']}"
    exit 1
  end

  consolidated << {
    'ciclo' => morning['ciclo'],
    'semana' => morning['semana'],
    'dia' => morning['dia'],
    'salmo_manha' => morning['salmo'],
    'salmo_noite' => evening['salmo'],
    'antigo_testamento' => morning['antigo_testamento'],
    'novo_testamento' => morning['novo_testamento'],
    'evangelho' => evening['novo_testamento']
  }
end

puts "Total de linhas consolidadas: #{consolidated.size}"

# Escrever novo arquivo
CSV.open(OUTPUT_FILE, 'w') do |csv|
  csv << %w[ciclo semana dia salmo_manha salmo_noite antigo_testamento novo_testamento evangelho]
  consolidated.each do |row|
    csv << row.values
  end
end

puts "Arquivo consolidado salvo: #{OUTPUT_FILE}"
puts "Concluído!"
