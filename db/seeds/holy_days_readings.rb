# Leituras dos Dias Santos e Festas Maiores
# Baseado no Livro de Oração Comum da IEAB

puts "📖 Carregando leituras dos dias santos e festas maiores..."

count = 0
skipped = 0

# Helper para criar leituras
def create_reading(celebration_name, reading_data)
  celebration = Celebration.find_by(name: celebration_name)

  unless celebration
    puts "⚠️  Celebração não encontrada: #{celebration_name}"
    return false
  end

  # Determina o year baseado no reading_data
  year = reading_data[:year] || "ABC"

  existing = LectionaryReading.find_by(
    celebration_id: celebration.id,
    cycle: year,
    service_type: "eucharist"
  )

  if existing.nil?
    LectionaryReading.create!(
      celebration_id: celebration.id,
      date_reference: "#{celebration.fixed_month}-#{celebration.fixed_day}",
      cycle: year,
      service_type: "eucharist",
      first_reading: reading_data[:first_reading],
      psalm: reading_data[:psalm],
      second_reading: reading_data[:second_reading],
      gospel: reading_data[:gospel]
    )
    return true
  end
  false
end

# =====================================================
# JANEIRO
# =====================================================

# Santo Nome de Jesus (1 de janeiro)
if create_reading("Santo Nome e Circuncisão de nosso Senhor Jesus Cristo", {
  year: "ABC",
  first_reading: "Isaías 9:2-7",
  psalm: "Salmo 8",
  second_reading: "Atos 4:8-12",
  gospel: "Lucas 2:15-21"
})
  count += 1
else
  skipped += 1
end

# Conversão de São Paulo (25 de janeiro)
if create_reading("Conversão de Paulo, Apóstolo", {
  year: "ABC",
  first_reading: "Atos 26:9-23",
  psalm: "Salmo 67",
  second_reading: "Gálatas 1:11-24",
  gospel: "Marcos 10:46-52"
})
  count += 1
else
  skipped += 1
end

# =====================================================
# FEVEREIRO
# =====================================================

# Apresentação de Cristo no Templo (2 de fevereiro)
if create_reading("Apresentação de nosso Senhor Jesus Cristo no Templo", {
  year: "ABC",
  first_reading: "Malaquias 3:1-4",
  psalm: "Salmo 24",
  second_reading: "Hebreus 2:14-18",
  gospel: "Lucas 2:22-40"
})
  count += 1
else
  skipped += 1
end

# =====================================================
# MARÇO
# =====================================================

# João e Charles Wesley (3 de março)
wesley = Celebration.find_by("name LIKE ?", "%Wesley%")
if wesley
  existing = LectionaryReading.find_by(
    celebration_id: wesley.id,
    cycle: "ABC",
    service_type: "eucharist"
  )
  if existing.nil?
    LectionaryReading.create!(
      celebration_id: wesley.id,
      date_reference: "#{wesley.fixed_month}-#{wesley.fixed_day}",
      cycle: "ABC",
      service_type: "eucharist",
      first_reading: "Êxodo 3:1-15",
      psalm: "Salmo 31",
      second_reading: "Colossenses 3:12-17",
      gospel: "Mateus 12:46-50"
    )
    count += 1
  else
    skipped += 1
  end
end

# São José (19 de março)
if create_reading("José de Nazaré", {
  year: "ABC",
  first_reading: "Deuteronômio 33:13-16",
  psalm: "Salmo 89:2-9",
  second_reading: "Filipenses 4:5-8",
  gospel: "Mateus 13:53-58"
})
  count += 1
else
  skipped += 1
end

# Thomas Cranmer (21 de março)
cranmer = Celebration.find_by("name LIKE ?", "%Cranmer%")
if cranmer
  existing = LectionaryReading.find_by(
    celebration_id: cranmer.id,
    cycle: "ABC",
    service_type: "eucharist"
  )
  if existing.nil?
    LectionaryReading.create!(
      celebration_id: cranmer.id,
      date_reference: "#{cranmer.fixed_month}-#{cranmer.fixed_day}",
      cycle: "ABC",
      service_type: "eucharist",
      first_reading: "Êxodo 3:1-15",
      psalm: "Salmo 31",
      second_reading: "Colossenses 3:12-17",
      gospel: "Mateus 12:46-50"
    )
    count += 1
  else
    skipped += 1
  end
end

# Anunciação (25 de março)
if create_reading("Anunciação de nosso Senhor Jesus Cristo à Bem-Aventurada Virgem Maria", {
  year: "ABC",
  first_reading: "Isaías 7:10-14",
  psalm: "Salmo 113",
  second_reading: "Romanos 5:12-17",
  gospel: "Lucas 1:26-38"
})
  count += 1
else
  skipped += 1
end

# =====================================================
# ABRIL
# =====================================================

# São Marcos (25 de abril)
if create_reading("Marcos, Evangelista", {
  year: "ABC",
  first_reading: "Isaías 52:7-10",
  psalm: "Salmo 119:9-16",
  second_reading: "Efésios 4:7-16",
  gospel: "Marcos 1:1-15"
})
  count += 1
else
  skipped += 1
end

# =====================================================
# MAIO
# =====================================================

# São Filipe e São Tiago (1 de maio)
if create_reading("Filipe e Tiago Menor, Apóstolos", {
  year: "ABC",
  first_reading: "Provérbios 4:10-18",
  psalm: "Salmo 84",
  second_reading: "1 Coríntios 12:4-13",
  gospel: "João 14:1-14"
})
  count += 1
else
  skipped += 1
end

# São Matias (14 de maio - transferido de 24 de fevereiro)
if create_reading("Matias, Apóstolo", {
  year: "ABC",
  first_reading: "Isaías 22:15-22",
  psalm: "Salmo 16",
  second_reading: "Atos 1:15-26",
  gospel: "João 13:12-30"
})
  count += 1
else
  skipped += 1
end

# Visitação (31 de maio)
if create_reading("Visitação da Bem-Aventurada Virgem Maria", {
  year: "ABC",
  first_reading: "Sofonias 3:14-18a",
  psalm: "Salmo 113",
  second_reading: "Efésios 5:18b-20",
  gospel: "Lucas 1:39-49"
})
  count += 1
else
  skipped += 1
end

# =====================================================
# JUNHO
# =====================================================

# São Barnabé (11 de junho)
if create_reading("Barnabé, Apóstolo", {
  year: "ABC",
  first_reading: "Jó 29:11-16",
  psalm: "Salmo 112",
  second_reading: "Atos 11:19-30",
  gospel: "João 15:12-17"
})
  count += 1
else
  skipped += 1
end

# Natividade de João Batista (24 de junho)
if create_reading("Natividade de João Batista", {
  year: "ABC",
  first_reading: "Isaías 40:1-11",
  psalm: "Salmo 119:161-168",
  second_reading: "Atos 13:16-25",
  gospel: "Lucas 1:57-66,80"
})
  count += 1
else
  skipped += 1
end

# Pedro e Paulo (29 de junho)
if create_reading("Pedro e Paulo, Apóstolos", {
  year: "ABC",
  first_reading: "Jonas 3",
  psalm: "Salmo 34:2-10",
  second_reading: "2 Timóteo 4:1-8",
  gospel: "Mateus 16:13-19"
})
  count += 1
else
  skipped += 1
end

# =====================================================
# JULHO
# =====================================================

# São Tomé (3 de julho - transferido de 21 de dezembro)
if create_reading("Tomé, Apóstolo", {
  year: "ABC",
  first_reading: "Jó 42:1-6",
  psalm: "Salmo 126",
  second_reading: "Hebreus 10:35-11:1",
  gospel: "João 20:24-29"
})
  count += 1
else
  skipped += 1
end

# Santa Maria Madalena (22 de julho)
if create_reading("Maria Madalena, Apóstola", {
  year: "ABC",
  first_reading: "Cantares 3:1-4a",
  psalm: "Salmo 63:2-10",
  second_reading: "2 Coríntios 5:14-17",
  gospel: "João 20:1-18"
})
  count += 1
else
  skipped += 1
end

# São Tiago (25 de julho)
if create_reading("Tiago, Apóstolo", {
  year: "ABC",
  first_reading: "Jeremias 45",
  psalm: "Salmo 15",
  second_reading: "Atos 11:27-12:3",
  gospel: "Marcos 10:35-45"
})
  count += 1
else
  skipped += 1
end

# =====================================================
# AGOSTO
# =====================================================

# Transfiguração (6 de agosto)
if create_reading("Transfiguração de nosso Senhor Jesus Cristo", {
  year: "ABC",
  first_reading: "Êxodo 34:29-35",
  psalm: "Salmo 99",
  second_reading: "2 Coríntios 3:4-18",
  gospel: "Lucas 9:28-36"
})
  count += 1
else
  skipped += 1
end

# São Bartolomeu (24 de agosto)
if create_reading("Bartolomeu, Apóstolo", {
  year: "ABC",
  first_reading: "Gênesis 28:10-17",
  psalm: "Salmo 103:1b-8",
  second_reading: "Atos 5:12-16",
  gospel: "João 1:43-51"
})
  count += 1
else
  skipped += 1
end

# =====================================================
# SETEMBRO
# =====================================================

# Bem-aventurada Virgem Maria (8 de setembro - transferido de 15 de agosto)
bvm = Celebration.find_by("name LIKE ?", "%Virgem Maria%") || Celebration.find_by(fixed_month: 8, fixed_day: 15)
if bvm
  # Ano A
  existing_a = LectionaryReading.find_by(celebration_id: bvm.id, cycle: "A", service_type: "eucharist")
  if existing_a.nil?
    LectionaryReading.create!(
      celebration_id: bvm.id,
      date_reference: "#{bvm.fixed_month}-#{bvm.fixed_day}",
      cycle: "A",
      service_type: "eucharist",
      first_reading: "Gênesis 3:8-15",
      psalm: "Salmo 113",
      second_reading: "Gálatas 4:4-7",
      gospel: "Lucas 11:27-28"
    )
    count += 1
  else
    skipped += 1
  end

  # Ano B
  existing_b = LectionaryReading.find_by(celebration_id: bvm.id, cycle: "B", service_type: "eucharist")
  if existing_b.nil?
    LectionaryReading.create!(
      celebration_id: bvm.id,
      date_reference: "#{bvm.fixed_month}-#{bvm.fixed_day}",
      cycle: "B",
      service_type: "eucharist",
      first_reading: "Gênesis 3:8-15",
      psalm: "Salmo 113",
      second_reading: "Gálatas 4:4-7",
      gospel: "Lucas 1:39-49"
    )
    count += 1
  else
    skipped += 1
  end
end

# São Mateus (21 de setembro)
if create_reading("Mateus, Apóstolo e Evangelista", {
  year: "ABC",
  first_reading: "Provérbios 3:9-18",
  psalm: "Salmo 19",
  second_reading: "2 Timóteo 3:14-17",
  gospel: "Mateus 9:9-13"
})
  count += 1
else
  skipped += 1
end

# São Miguel e Todos os Anjos (29 de setembro)
if create_reading("Arcanjo Miguel e Todos os Anjos", {
  year: "ABC",
  first_reading: "Jó 38:1-7",
  psalm: "Salmo 148:1-6",
  second_reading: "Apocalipse 12:7-12",
  gospel: "Mateus 18:1-10"
})
  count += 1
else
  skipped += 1
end

# =====================================================
# OUTUBRO
# =====================================================

# São Lucas (18 de outubro)
if create_reading("Lucas, Evangelista", {
  year: "ABC",
  first_reading: "Isaías 61:1-6",
  psalm: "Salmo 147:1-7",
  second_reading: "Atos 1:1-8",
  gospel: "Lucas 10:1-9"
})
  count += 1
else
  skipped += 1
end

# Simão e Judas (28 de outubro)
if create_reading("Simão e Judas, Apóstolos", {
  year: "ABC",
  first_reading: "Isaías 28:9-16",
  psalm: "Salmo 119:89-96",
  second_reading: "Apocalipse 21:9-14",
  gospel: "Lucas 6:12-23"
})
  count += 1
else
  skipped += 1
end

# Dia da Reforma Protestante - Martinho Lutero (31 de outubro)
luther = Celebration.find_by("name LIKE ?", "%Lutero%") || Celebration.find_by("name LIKE ?", "%Reforma%")
if luther
  existing = LectionaryReading.find_by(
    celebration_id: luther.id,
    cycle: "ABC",
    service_type: "eucharist"
  )
  if existing.nil?
    LectionaryReading.create!(
      celebration_id: luther.id,
      date_reference: "#{luther.fixed_month}-#{luther.fixed_day}",
      cycle: "ABC",
      service_type: "eucharist",
      first_reading: "Êxodo 3:1-15",
      psalm: "Salmo 31",
      second_reading: "Colossenses 3:12-17",
      gospel: "Mateus 12:46-50"
    )
    count += 1
  else
    skipped += 1
  end
end

# =====================================================
# NOVEMBRO
# =====================================================

# Todos os Santos (1 de novembro)
if create_reading("Todos os Santos e Santas", {
  year: "ABC",
  first_reading: "Jeremias 31:31-34",
  psalm: "Salmo 150",
  second_reading: "Apocalipse 7:2-4,9-14",
  gospel: "Mateus 5:1-12"
})
  count += 1
else
  skipped += 1
end

# Santo André (30 de novembro)
if create_reading("André, Apóstolo", {
  year: "ABC",
  first_reading: "Zacarias 8:20-23",
  psalm: "Salmo 47",
  second_reading: "Romanos 10:8b-18",
  gospel: "João 1:35-42"
})
  count += 1
else
  skipped += 1
end

# =====================================================
# DEZEMBRO
# =====================================================

# Santo Estevão (26 de dezembro)
if create_reading("Estêvão, Diácono e Protomártir", {
  year: "ABC",
  first_reading: "2 Crônicas 24:17-22",
  psalm: "Salmo 31:2-6",
  second_reading: "Atos 6:8-10; 7:54-60",
  gospel: "Mateus 10:17-22"
})
  count += 1
else
  skipped += 1
end

# São João Evangelista (27 de dezembro)
if create_reading("João, Apóstolo e Evangelista", {
  year: "ABC",
  first_reading: "Isaías 6:1-8",
  psalm: "Salmo 97",
  second_reading: "1 João 1",
  gospel: "João 21:20-24"
})
  count += 1
else
  skipped += 1
end

# Santos Inocentes (28 de dezembro)
if create_reading("Santos Inocentes", {
  year: "ABC",
  first_reading: "Jeremias 31:15-17",
  psalm: "Salmo 124",
  second_reading: "1 Pedro 4:12-16",
  gospel: "Mateus 2:13-18"
})
  count += 1
else
  skipped += 1
end

# John Wycliff (31 de dezembro)
wycliff = Celebration.find_by("name LIKE ?", "%Wycliff%")
if wycliff
  existing = LectionaryReading.find_by(
    celebration_id: wycliff.id,
    cycle: "ABC",
    service_type: "eucharist"
  )
  if existing.nil?
    LectionaryReading.create!(
      celebration_id: wycliff.id,
      date_reference: "#{wycliff.fixed_month}-#{wycliff.fixed_day}",
      cycle: "ABC",
      service_type: "eucharist",
      first_reading: "Êxodo 3:1-15",
      psalm: "Salmo 31",
      second_reading: "Colossenses 3:12-17",
      gospel: "Mateus 12:46-50"
    )
    count += 1
  else
    skipped += 1
  end
end

# =====================================================
# OBSERVÂNCIAS ESPECIAIS
# =====================================================

# Dia do Trabalho (1 de maio)
labor_day = Celebration.find_by("name LIKE ?", "%Trabalho%")
if labor_day
  puts "⚠️  Dia do Trabalho não tem leituras específicas definidas - usa-se o lecionário do dia."
end

# Dia da Pátria (7 de setembro)
independence_day = Celebration.find_by("name LIKE ?", "%Pátria%") ||
                   Celebration.find_by("name LIKE ?", "%Independência%")
if independence_day
  puts "⚠️  Dia da Pátria não tem leituras específicas definidas - usa-se o lecionário do dia."
end

# Ação de Graças (quarta quinta-feira de novembro)
thanksgiving = Celebration.find_by("name LIKE ?", "%Ação de Graças%") ||
               Celebration.find_by("name LIKE ?", "%Thanksgiving%")
if thanksgiving
  puts "⚠️  Dia de Ação de Graças não tem leituras específicas definidas - usa-se o lecionário do dia."
end

puts "\n✅ #{count} leituras de dias santos criadas com sucesso!"
puts "⏭️  #{skipped} leituras já existiam no banco de dados." if skipped > 0
