# ================================================================================
# CICLO DE SALMOS - LOCB 2008
# Tabela Diária dos Salmos - Ciclo de 4 Semanas
# Oração Matutina e Oração Vespertina
# ================================================================================

puts "📖 Criando Ciclo de Salmos - LOCB 2008..."

prayer_book = PrayerBook.find_by!(code: 'locb_2008')

# ================================================================================
# I SEMANA
# ================================================================================

week_1_morning = {
  0 => [ 1, 2, 3, 4, 5 ],      # Domingo
  1 => [ 9, 10, 11 ],          # Segunda-feira
  2 => [ 15, 16, 17 ],         # Terça-feira
  3 => [ 19, 20, 21 ],         # Quarta-feira
  4 => [ 24, 25, 26 ],         # Quinta-feira
  5 => [ 30, 31 ],             # Sexta-feira
  6 => [ 35, 36 ]              # Sábado
}

week_1_evening = {
  0 => [ 6, 7, 8 ],            # Domingo
  1 => [ 12, 13, 14 ],         # Segunda-feira
  2 => [ 18 ],                 # Terça-feira
  3 => [ 22, 23 ],             # Quarta-feira
  4 => [ 27, 28, 29 ],         # Quinta-feira
  5 => [ 32, 33, 34 ],         # Sexta-feira
  6 => [ 37 ]                  # Sábado
}

# ================================================================================
# II SEMANA
# ================================================================================

week_2_morning = {
  0 => [ 38, 39, 40 ],         # Domingo
  1 => [ 44, 45, 46 ],         # Segunda-feira
  2 => [ 50, 51, 52 ],         # Terça-feira
  3 => [ 56, 57, 58 ],         # Quarta-feira
  4 => [ 62, 63, 64 ],         # Quinta-feira
  5 => [ 68, 69, 70 ],         # Sexta-feira
  6 => [ 73, 74, 75 ]          # Sábado
}

week_2_evening = {
  0 => [ 41, 42, 43 ],         # Domingo
  1 => [ 47, 48, 49 ],         # Segunda-feira
  2 => [ 53, 54, 55 ],         # Terça-feira
  3 => [ 59, 60, 61 ],         # Quarta-feira
  4 => [ 65, 66, 67 ],         # Quinta-feira
  5 => [ 71, 72 ],             # Sexta-feira
  6 => [ 76, 77, 78 ]          # Sábado
}

# ================================================================================
# III SEMANA
# ================================================================================

week_3_morning = {
  0 => [ 79, 80, 81 ],         # Domingo
  1 => [ 86, 87, 88 ],         # Segunda-feira
  2 => [ 90, 91, 92 ],         # Terça-feira
  3 => [ 95, 96, 97 ],         # Quarta-feira
  4 => [ 102, 103 ],           # Quinta-feira
  5 => [ 106, 107 ],           # Sexta-feira
  6 => [ 110, 111, 112, 113 ]  # Sábado
}

week_3_evening = {
  0 => [ 82, 83, 84, 85 ],     # Domingo
  1 => [ 89 ],                 # Segunda-feira
  2 => [ 93, 94 ],             # Terça-feira
  3 => [ 98, 99, 100, 101 ],   # Quarta-feira
  4 => [ 104, 105 ],           # Quinta-feira
  5 => [ 108, 109 ],           # Sexta-feira
  6 => [ 114, 115 ]            # Sábado
}

# ================================================================================
# IV SEMANA
# ================================================================================

week_4_morning = {
  0 => [ 116, 117, 118 ],      # Domingo
  1 => [ '119:33-40', '119:41-48', '119:49-56', '119:57-64', '119:65-72' ],  # Segunda-feira (seções do 119)
  2 => [ '119:105-112', '119:113-120', '119:121-128', '119:129-136', '119:137-144' ],  # Terça-feira
  3 => [ 120, 121, 122, 123, 124, 125 ],  # Quarta-feira
  4 => [ 132, 133, 134, 135 ], # Quinta-feira
  5 => [ 139, 140, 141 ],      # Sexta-feira
  6 => [ 144, 145, 146 ]       # Sábado
}

week_4_evening = {
  0 => [ '119:1-8', '119:9-16', '119:17-24', '119:25-32' ],  # Domingo (seções do 119)
  1 => [ '119:73-80', '119:81-88', '119:89-96', '119:97-104' ],  # Segunda-feira
  2 => [ '119:145-152', '119:153-160', '119:161-168', '119:169-176' ],  # Terça-feira
  3 => [ 126, 127, 128, 130, 131 ],  # Quarta-feira
  4 => [ 136, 137, 138 ],      # Quinta-feira
  5 => [ 142, 143 ],           # Sexta-feira
  6 => [ 147, 148, 149, 150 ]  # Sábado
}

# Criar ciclos para cada semana
[
  { week: 1, morning: week_1_morning, evening: week_1_evening },
  { week: 2, morning: week_2_morning, evening: week_2_evening },
  { week: 3, morning: week_3_morning, evening: week_3_evening },
  { week: 4, morning: week_4_morning, evening: week_4_evening }
].each do |week_data|
  week_num = week_data[:week]

  # Oração Matutina
  week_data[:morning].each do |day, psalms|
    # Converter para array de inteiros (ou strings para seções do 119)
    psalm_numbers = psalms.map { |p| p.is_a?(String) ? p : p.to_i }

    PsalmCycle.find_or_create_by!(
      prayer_book_id: prayer_book.id,
      cycle_type: 'weekly',
      week_number: week_num,
      day_of_week: day,
      office_type: 'morning'
    ) do |pc|
      pc.psalm_numbers = psalm_numbers
      pc.notes = "Semana #{week_num} - #{Date::DAYNAMES[day]} - Oração Matutina"
    end
  end

  # Oração Vespertina
  week_data[:evening].each do |day, psalms|
    psalm_numbers = psalms.map { |p| p.is_a?(String) ? p : p.to_i }

    PsalmCycle.find_or_create_by!(
      prayer_book_id: prayer_book.id,
      cycle_type: 'weekly',
      week_number: week_num,
      day_of_week: day,
      office_type: 'evening'
    ) do |pc|
      pc.psalm_numbers = psalm_numbers
      pc.notes = "Semana #{week_num} - #{Date::DAYNAMES[day]} - Oração Vespertina"
    end
  end

  puts "  ✓ Semana #{week_num} criada"
end

total_cycles = PsalmCycle.where(prayer_book_id: prayer_book.id).count
puts "  📖 Total: #{total_cycles} ciclos de salmos criados (4 semanas × 7 dias × 2 ofícios)"
