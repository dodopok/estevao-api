# ================================================================================
# LEITURAS DOS DIAS SANTOS E FESTAS FIXAS
# Revised Common Lectionary (RCL)
# ================================================================================
#
# Conteúdo:
# - Dias Santos Principais
# - Festas de Apóstolos e Evangelistas
# - Festas Marianas
# - Dias de Santos e Mártires
#
# Nota: Este arquivo usa celebration_id references como no arquivo original
#       holy_days_readings.rb
#
# ================================================================================

puts "📖 Carregando leituras dos dias santos e festas fixas..."

# Buscar o prayer book
prayer_book = PrayerBook.find_by!(code: 'loc_2015')

count = 0
skipped = 0

# Helper para criar leituras por celebration_id
def create_reading_by_celebration(celebration_name, reading_data, prayer_book_id)
  celebration = Celebration.find_by(name: celebration_name)

  unless celebration
    puts "⚠️  Celebração não encontrada: #{celebration_name}"
    return false
  end

  year = reading_data[:year] || "all"

  existing = LectionaryReading.find_by(
    celebration_id: celebration.id,
    cycle: year,
    service_type: "eucharist",
    prayer_book_id: prayer_book_id
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
      gospel: reading_data[:gospel],
      prayer_book_id: prayer_book_id
    )
    return true
  end
  false
end

# Helper para criar leituras sem celebration (por date_reference)
def create_reading_direct(reading_hash, prayer_book_id)
  existing = LectionaryReading.find_by(
    date_reference: reading_hash[:date_reference],
    cycle: reading_hash[:cycle],
    service_type: reading_hash[:service_type],
  )

  if existing.nil?
    reading_hash[:prayer_book_id] = prayer_book_id
    LectionaryReading.create!(reading_hash)
    return true
  end
  false
end

# ============================================================================
# JANEIRO
# ============================================================================

# Santo Nome de Jesus (1 de janeiro)
if create_reading_by_celebration("Santo Nome de Jesus", {
  year: "all",
  first_reading: "Isaías 9:2-7",
  psalm: "Salmo 8",
  second_reading: "Atos 4:8-12",
  gospel: "Lucas 2:15-21"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

# Conversão de São Paulo (25 de janeiro)
if create_reading_by_celebration("Conversão de São Paulo", {
  year: "all",
  first_reading: "Atos 26:9-23",
  psalm: "Salmo 67",
  second_reading: "Gálatas 1:11-24",
  gospel: "Marcos 10:46-52"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

# ============================================================================
# FEVEREIRO
# ============================================================================

# Apresentação de Cristo no Templo (2 de fevereiro)
if create_reading_direct({
  date_reference: "presentation_of_the_lord",
  cycle: "all",
  service_type: "eucharist",
  first_reading: "Malaquias 3:1-4",
  psalm: "Salmo 84 or Salmo 24:7-10",
  second_reading: "Hebreus 2:14-18",
  gospel: "Lucas 2:22-40"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

if create_reading_by_celebration("Apresentação de nosso Senhor Jesus Cristo no Templo", {
  year: "all",
  first_reading: "Malaquias 3:1-4",
  psalm: "Salmo 24",
  second_reading: "Hebreus 2:14-18",
  gospel: "Lucas 2:22-40"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

# ============================================================================
# MARÇO
# ============================================================================

# João e Charles Wesley (3 de março)
wesley = Celebration.find_by("name LIKE ?", "%Wesley%")
if wesley
  existing = LectionaryReading.find_by(
    celebration_id: wesley.id,
    cycle: "all",
    service_type: "eucharist",
    prayer_book_id: prayer_book.id
  )
  if existing.nil?
    LectionaryReading.create!(
      celebration_id: wesley.id,
      date_reference: "#{wesley.fixed_month}-#{wesley.fixed_day}",
      cycle: "all",
      service_type: "eucharist",
      first_reading: "Êxodo 3:1-15",
      psalm: "Salmo 31",
      second_reading: "Colossenses 3:12-17",
      gospel: "Mateus 12:46-50",
      prayer_book_id: prayer_book.id
    )
    count += 1
  else
    skipped += 1
  end
end

# São José (19 de março)
if create_reading_by_celebration("São José", {
  year: "all",
  first_reading: "Deuteronômio 33:13-16",
  psalm: "Salmo 89:2-9",
  second_reading: "Filipenses 4:5-8",
  gospel: "Mateus 13:53-58"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

# Thomas Cranmer (21 de março)
cranmer = Celebration.find_by("name LIKE ?", "%Cranmer%")
if cranmer
  existing = LectionaryReading.find_by(
    celebration_id: cranmer.id,
    cycle: "all",
    service_type: "eucharist",
  )
  if existing.nil?
    LectionaryReading.create!(
      celebration_id: cranmer.id,
      date_reference: "#{cranmer.fixed_month}-#{cranmer.fixed_day}",
      cycle: "all",
      service_type: "eucharist",
      first_reading: "Êxodo 3:1-15",
      psalm: "Salmo 31",
      second_reading: "Colossenses 3:12-17",
      gospel: "Mateus 12:46-50",
      prayer_book_id: prayer_book.id
    )
    count += 1
  else
    skipped += 1
  end
end

# Anunciação (25 de março)
if create_reading_direct({
  date_reference: "annunciation",
  cycle: "all",
  service_type: "eucharist",
  first_reading: "Isaías 7:10-14",
  psalm: "Salmo 45 or Salmo 40:5-10",
  second_reading: "Hebreus 10:4-10",
  gospel: "Lucas 1:26-38"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

if create_reading_by_celebration("Anunciação de Nosso Senhor", {
  year: "all",
  first_reading: "Isaías 7:10-14",
  psalm: "Salmo 113",
  second_reading: "Romanos 5:12-17",
  gospel: "Lucas 1:26-38"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

# ============================================================================
# ABRIL
# ============================================================================

# São Marcos (25 de abril)
if create_reading_by_celebration("São Marcos Evangelista", {
  year: "all",
  first_reading: "Isaías 52:7-10",
  psalm: "Salmo 119:9-16",
  second_reading: "Efésios 4:7-16",
  gospel: "Marcos 1:1-15"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

# ============================================================================
# MAIO
# ============================================================================

# São Filipe e São Tiago (1 de maio)
if create_reading_by_celebration("São Matias", {
  year: "all",
  first_reading: "Provérbios 4:10-18",
  psalm: "Salmo 84",
  second_reading: "1 Coríntios 12:4-13",
  gospel: "João 14:1-14"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

# São Matias (14 de maio)
if create_reading_by_celebration("São Matias", {
  year: "all",
  first_reading: "Isaías 22:15-22",
  psalm: "Salmo 16",
  second_reading: "Atos 1:15-26",
  gospel: "João 13:12-30"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

# Visitação (31 de maio)
if create_reading_direct({
  date_reference: "visitation",
  cycle: "all",
  service_type: "eucharist",
  first_reading: "1 Samuel 2:1-10",
  psalm: "Salmo 113",
  second_reading: "Romanos 12:9-16b",
  gospel: "Lucas 1:39-57"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

if create_reading_by_celebration("Visitação da Bem-Aventurada Virgem Maria", {
  year: "all",
  first_reading: "Sofonias 3:14-18a",
  psalm: "Salmo 113",
  second_reading: "Efésios 5:18b-20",
  gospel: "Lucas 1:39-49"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

# ============================================================================
# JUNHO
# ============================================================================

# São Barnabé (11 de junho)
if create_reading_by_celebration("São Barnabé", {
  year: "all",
  first_reading: "Jó 29:11-16",
  psalm: "Salmo 112",
  second_reading: "Atos 11:19-30",
  gospel: "João 15:12-17"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

# Natividade de João Batista (24 de junho)
if create_reading_by_celebration("Natividade de São João Batista", {
  year: "all",
  first_reading: "Isaías 40:1-11",
  psalm: "Salmo 119:161-168",
  second_reading: "Atos 13:16-25",
  gospel: "Lucas 1:57-66,80"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

# Pedro e Paulo (29 de junho)
if create_reading_direct({
  date_reference: "peter_and_paul",
  cycle: "all",
  service_type: "eucharist",
  first_reading: "Atos 12:1-11",
  psalm: "Salmo 87",
  second_reading: "2 Timóteo 4:6-8, 17-18",
  gospel: "Mateus 16:13-19"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

if create_reading_by_celebration("São Pedro e São Paulo", {
  year: "all",
  first_reading: "Jonas 3",
  psalm: "Salmo 34:2-10",
  second_reading: "2 Timóteo 4:1-8",
  gospel: "Mateus 16:13-19"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

# ============================================================================
# JULHO
# ============================================================================

# São Tomé (3 de julho)
if create_reading_by_celebration("São Tomé", {
  year: "all",
  first_reading: "Jó 42:1-6",
  psalm: "Salmo 126",
  second_reading: "Hebreus 10:35-11:1",
  gospel: "João 20:24-29"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

# Santa Maria Madalena (22 de julho)
if create_reading_by_celebration("Santa Maria Madalena", {
  year: "all",
  first_reading: "Cantares 3:1-4a",
  psalm: "Salmo 63:2-10",
  second_reading: "2 Coríntios 5:14-17",
  gospel: "João 20:1-18"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

# São Tiago (25 de julho)
if create_reading_direct({
  date_reference: "james_apostle",
  cycle: "all",
  service_type: "eucharist",
  first_reading: "2 Coríntios 4:7-15",
  psalm: "Salmo 126",
  second_reading: "Atos 11:27-12:2",
  gospel: "Mateus 20:20-28"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

if create_reading_by_celebration("São Tiago", {
  year: "all",
  first_reading: "Jeremias 45",
  psalm: "Salmo 15",
  second_reading: "Atos 11:27-12:3",
  gospel: "Marcos 10:35-45"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

# ============================================================================
# AGOSTO
# ============================================================================

# Transfiguração (6 de agosto)
if create_reading_direct({
  date_reference: "transfiguration",
  cycle: "all",
  service_type: "eucharist",
  first_reading: "Daniel 7:9-10, 13-14",
  psalm: "Salmo 99",
  second_reading: "2 Pedro 1:16-19",
  gospel: "Lucas 9:28-36"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

if create_reading_by_celebration("Transfiguração de nosso Senhor Jesus Cristo", {
  year: "all",
  first_reading: "Êxodo 34:29-35",
  psalm: "Salmo 99",
  second_reading: "2 Coríntios 3:4-18",
  gospel: "Lucas 9:28-36"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

# São Bartolomeu (24 de agosto)
if create_reading_direct({
  date_reference: "bartholomew",
  cycle: "all",
  service_type: "eucharist",
  first_reading: "Êxodo 19:1-6a",
  psalm: "Salmo 12",
  second_reading: "1 Coríntios 12:27-31a",
  gospel: "João 1:43-51"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

if create_reading_by_celebration("São Bartolomeu", {
  year: "all",
  first_reading: "Gênesis 28:10-17",
  psalm: "Salmo 103:1b-8",
  second_reading: "Atos 5:12-16",
  gospel: "João 1:43-51"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

# ============================================================================
# SETEMBRO
# ============================================================================

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
      gospel: "Lucas 11:27-28",
      prayer_book_id: prayer_book.id
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
      gospel: "Lucas 1:39-49",
      prayer_book_id: prayer_book.id
    )
    count += 1
  else
    skipped += 1
  end
end

# São Mateus (21 de setembro)
if create_reading_direct({
  date_reference: "matthew",
  cycle: "all",
  service_type: "eucharist",
  first_reading: "Provérbios 3:1-6",
  psalm: "Salmo 119:33-40",
  second_reading: "2 Coríntios 4:1-6",
  gospel: "Mateus 9:9-13"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

if create_reading_by_celebration("Mateus, Apóstolo e Evangelista", {
  year: "all",
  first_reading: "Provérbios 3:9-18",
  psalm: "Salmo 19",
  second_reading: "2 Timóteo 3:14-17",
  gospel: "Mateus 9:9-13"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

# São Miguel e Todos os Anjos (29 de setembro)
if create_reading_by_celebration("Arcanjo Miguel e Todos os Anjos", {
  year: "all",
  first_reading: "Jó 38:1-7",
  psalm: "Salmo 148:1-6",
  second_reading: "Apocalipse 12:7-12",
  gospel: "Mateus 18:1-10"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

# ============================================================================
# OUTUBRO
# ============================================================================

# São Lucas (18 de outubro)
if create_reading_direct({
  date_reference: "luke",
  cycle: "all",
  service_type: "eucharist",
  first_reading: "Isaías 35:5-8",
  psalm: "Salmo 147:1-7",
  second_reading: "2 Timóteo 4:5-13",
  gospel: "Lucas 1:1-4"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

if create_reading_by_celebration("Lucas, Evangelista", {
  year: "all",
  first_reading: "Isaías 61:1-6",
  psalm: "Salmo 147:1-7",
  second_reading: "Atos 1:1-8",
  gospel: "Lucas 10:1-9"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

# Simão e Judas (28 de outubro)
if create_reading_direct({
  date_reference: "simon_and_jude",
  cycle: "all",
  service_type: "eucharist",
  first_reading: "Deuteronômio 32:1-4",
  psalm: "Salmo 119:89-96",
  second_reading: "Efésios 2:13-22",
  gospel: "João 15:17-27"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

if create_reading_by_celebration("Simão e Judas, Apóstolos", {
  year: "all",
  first_reading: "Isaías 28:9-16",
  psalm: "Salmo 119:89-96",
  second_reading: "Apocalipse 21:9-14",
  gospel: "Lucas 6:12-23"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

# Dia da Reforma Protestante - Martinho Lutero (31 de outubro)
luther = Celebration.find_by("name LIKE ?", "%Lutero%") || Celebration.find_by("name LIKE ?", "%Reforma%")
if luther
  existing = LectionaryReading.find_by(
    celebration_id: luther.id,
    cycle: "all",
    service_type: "eucharist",
  )
  if existing.nil?
    LectionaryReading.create!(
      celebration_id: luther.id,
      date_reference: "#{luther.fixed_month}-#{luther.fixed_day}",
      cycle: "all",
      service_type: "eucharist",
      first_reading: "Êxodo 3:1-15",
      psalm: "Salmo 31",
      second_reading: "Colossenses 3:12-17",
      gospel: "Mateus 12:46-50",
      prayer_book_id: prayer_book.id
    )
    count += 1
  else
    skipped += 1
  end
end

# ============================================================================
# NOVEMBRO
# ============================================================================

# Todos os Santos (1 de novembro)
if create_reading_direct({
  date_reference: "all_saints",
  cycle: "all",
  service_type: "eucharist",
  first_reading: "Apocalipse 7:9-17",
  psalm: "Salmo 34:1-10, 22",
  second_reading: "1 João 3:1-3",
  gospel: "Mateus 5:1-12"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

if create_reading_by_celebration("Todos os Santos e Santas", {
  year: "all",
  first_reading: "Jeremias 31:31-34",
  psalm: "Salmo 150",
  second_reading: "Apocalipse 7:2-4,9-14",
  gospel: "Mateus 5:1-12"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

# Santo André (30 de novembro)
if create_reading_direct({
  date_reference: "andrew",
  cycle: "all",
  service_type: "eucharist",
  first_reading: "Isaías 52:7-10",
  psalm: "Salmo 19:1-6",
  second_reading: "Romanos 10:12-18",
  gospel: "Mateus 4:18-22"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

if create_reading_by_celebration("André, Apóstolo", {
  year: "all",
  first_reading: "Zacarias 8:20-23",
  psalm: "Salmo 47",
  second_reading: "Romanos 10:8b-18",
  gospel: "João 1:35-42"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

# ============================================================================
# DEZEMBRO
# ============================================================================

# São Tomé (21 de dezembro)
if create_reading_direct({
  date_reference: "thomas_apostle",
  cycle: "all",
  service_type: "eucharist",
  first_reading: "Habacuque 2:1-4",
  psalm: "Salmo 126",
  second_reading: "Hebreus 10:35-11:1",
  gospel: "João 20:24-29"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

# Santo Estevão (26 de dezembro)
if create_reading_by_celebration("Estêvão, Diácono e Protomártir", {
  year: "all",
  first_reading: "2 Crônicas 24:17-22",
  psalm: "Salmo 31:2-6",
  second_reading: "Atos 6:8-10; 7:54-60",
  gospel: "Mateus 10:17-22"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

# São João Evangelista (27 de dezembro)
if create_reading_direct({
  date_reference: "john_apostle",
  cycle: "all",
  service_type: "eucharist",
  first_reading: "Êxodo 33:18-23",
  psalm: "Salmo 92:1-4, 11-14",
  second_reading: "1 João 1:1-9",
  gospel: "João 21:19b-24"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

if create_reading_by_celebration("João, Apóstolo e Evangelista", {
  year: "all",
  first_reading: "Isaías 6:1-8",
  psalm: "Salmo 97",
  second_reading: "1 João 1",
  gospel: "João 21:20-24"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

# Santos Inocentes (28 de dezembro)
if create_reading_direct({
  date_reference: "holy_innocents",
  cycle: "all",
  service_type: "eucharist",
  first_reading: "Jeremias 31:15-17",
  psalm: "Salmo 124",
  second_reading: "Apocalipse 21:1-7",
  gospel: "Mateus 2:13-18"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

if create_reading_by_celebration("Santos Inocentes", {
  year: "all",
  first_reading: "Jeremias 31:15-17",
  psalm: "Salmo 124",
  second_reading: "1 Pedro 4:12-16",
  gospel: "Mateus 2:13-18"
}, prayer_book.id)
  count += 1
else
  skipped += 1
end

# João Wycliff (31 de dezembro)
wycliff = Celebration.find_by("name LIKE ?", "%Wycliff%")
if wycliff
  existing = LectionaryReading.find_by(
    celebration_id: wycliff.id,
    cycle: "all",
    service_type: "eucharist",
  )
  if existing.nil?
    LectionaryReading.create!(
      celebration_id: wycliff.id,
      date_reference: "#{wycliff.fixed_month}-#{wycliff.fixed_day}",
      cycle: "all",
      service_type: "eucharist",
      first_reading: "Êxodo 3:1-15",
      psalm: "Salmo 31",
      second_reading: "Colossenses 3:12-17",
      gospel: "Mateus 12:46-50",
      prayer_book_id: prayer_book.id
    )
    count += 1
  else
    skipped += 1
  end
end

puts "\n✅ #{count} leituras de dias santos e festas fixas criadas!"
puts "⏭️  #{skipped} já existiam." if skipped > 0
