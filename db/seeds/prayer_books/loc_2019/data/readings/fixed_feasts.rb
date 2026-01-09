# ================================================================================
# LEITURAS DE DIAS SANTOS E COMEMORAÇÕES - LOC 2019
# ================================================================================

Rails.logger.info "📖 Carregando leituras de Dias Santos e Especiais for LOC 2019..."

prayer_book = PrayerBook.find_by!(code: 'loc_2019')
celebrations = Celebration.where(prayer_book: prayer_book)

def create_reading(attrs, prayer_book_id)
  attrs[:prayer_book_id] = prayer_book_id
  attrs[:cycle] ||= "all" # Dias fixos geralmente servem para todos os ciclos

  # Tentar vincular celebration_id por heurística de nome se não fornecido
  if attrs[:celebration_id].nil?
    celebration = Celebration.where(prayer_book_id: prayer_book_id)
                             .find { |c| c.name.parameterize.underscore == attrs[:date_reference] }
    attrs[:celebration_id] = celebration.id if celebration
  end

  existing = LectionaryReading.find_by(
    date_reference: attrs[:date_reference],
    celebration_id: attrs[:celebration_id],
    cycle: attrs[:cycle],
    service_type: attrs[:service_type],
    prayer_book_id: prayer_book_id
  )

  if existing.nil?
    LectionaryReading.create!(attrs)
  else
    existing.update!(attrs)
  end
end

# --- HOLY DAYS (Vincular por celebration_id) ---
holy_days_readings = [
  [ 'André, o Apóstolo', "Deuteronômio 30:11-14", "Salmo 19 ou 19:1-6", "Romanos 10:8b-18", "Mateus 4:18-22" ],
  [ 'Tomé, o Apóstolo', "Habacuque 2:1-4", "Salmo 126", "Hebreus 10:35-11:1", "João 20:19-29" ],
  [ 'Estêvão, Diácono e Mártir', "Jeremias 26:1-9(10-11)12-15", "Salmo 31:1-6(7-27)", "Atos 6:8-7:2a, 51-60", "Mateus 23:29-39" ],
  [ 'João, Apóstolo e Evangelista', "Êxodo 33:18-23", "Salmo 92:1-4(5-10)11-14", "1 João 1", "João 21:9-25 ou João 1:1-18" ],
  [ 'Os Santos Inocentes', "Jeremias 31:15-17", "Salmo 124", "Apocalipse 21:1-7", "Mateus 2:13-18" ],
  [ 'A Circuncisão e o Santo Nome de Nosso Senhor Jesus Cristo', "Êxodo 34:1-9", "Salmo 8", "Romanos 1:1-7", "Lucas 2:15-21" ],
  [ 'Confissão do Apóstolo Pedro', "Atos 4:8-13", "Salmo 23", "1 Pedro 5:1-11", "Mateus 16:13-19" ],
  [ 'Conversão do Apóstolo Paulo', "Atos 26:9-21", "Salmo 67", "Gálatas 1:11-24", "Mateus 10:16-25" ],
  [ 'A Apresentação de Nosso Senhor Jesus Cristo no Templo', "Malaquias 3:1-4", "Salmo 84", "Hebreus 2:14-18", "Lucas 2:22-40" ],
  [ 'Matias, o Apóstolo', "Atos 1:15-26", "Salmo 15", "Filipenses 3:12-21", "João 15:1-16" ],
  [ 'José, Esposo da Virgem Maria e Guardião de Jesus', "2 Samuel 7:4, 8-16", "Salmo 89:1-4(5-18)19-29", "Romanos 4:13-18", "Lucas 2:41-52" ],
  [ 'A Anunciação de nosso Senhor Jesus Cristo à Virgem Maria', "Isaías 7:10-14", "Salmo 40:1-13 ou Magnificat", "Hebreus 10:5-10", "Lucas 1:26-38" ],
  [ 'Marcos, o Evangelista', "Isaías 52:7-10", "Salmo 2", "Efésios 4:7-8, 11-16", "Marcos 16:15-20" ],
  [ 'Filipe e Tiago, Apóstolos', "Isaías 30:18-21", "Salmo 119:33-40", "2 Coríntios 4:1-7", "João 14:6-14" ],
  [ 'A Visitação da Virgem Maria a Isabel e Zacarias', "Sofonias 3:14-18", "Salmo 113 ou Ecce Deus", "Colossenses 3:12-17", "Lucas 1:39-56" ],
  [ 'Barnabé, o Apóstolo', "Isaías 42:5-12", "Salmo 112", "Atos 11:19-30, 13:1-3", "Mateus 10:7-16" ],
  [ 'O Nascimento de João Batista', "Isaías 40:1-11", "Salmo 85:7-13", "Atos 13:14b-26", "Lucas 1:57-80" ],
  [ 'Pedro e Paulo, Apóstolos', "Ezequiel 34:11-16", "Salmo 87", "2 Timóteo 4:1-8", "João 21:15-19" ],
  [ 'Maria Madalena', "Juízes 4:4-10 ou Judite 9:1, 11-14", "Salmo 42:1-7(8-15)", "2 Coríntios 5:14-20a", "João 20:11-18" ],
  [ 'Tiago, o Maior, Apóstolo', "Jeremias 45:1-5", "Salmo 7:1-11(12-18)", "Atos 11:27-12:3", "Mateus 20:20-28" ],
  [ 'A Transfiguração de Nosso Senhor Jesus Cristo', "Êxodo 34:29-35", "Salmo 99", "2 Pedro 1:13-21", "Lucas 9:28-36" ],
  [ 'A Virgem Maria, Mãe de Nosso Senhor Jesus Cristo', "Isaías 61:10-11", "Salmo 34", "Gálatas 4:4-7", "Lucas 1:46-55" ],
  [ 'Bartolomeu, o Apóstolo', "Deuteronômio 18:15-18", "Salmo 91", "1 Coríntios 4:9-16", "Lucas 22:24-30" ],
  [ 'Dia da Santa Cruz', "Isaías 45:21-25", "Salmo 98", "Filipenses 2:5-11", "João 12:31-36a" ],
  [ 'Mateus, Apóstolo e Evangelista', "Provérbios 3:1-12", "Salmo 119:33-40", "2 Timóteo 3:1-17", "Mateus 9:9-13" ],
  [ 'São Miguel e Todos os Anjos', "Gênesis 28:10-17", "Salmo 103", "Apocalipse 12:7-12", "João 1:47-51" ],
  [ 'Lucas, o Evangelista e Companheiro de Paulo', "Eclesiástico 38:1-14", "Salmo 147:1-11", "2 Timóteo 4:1-13", "Lucas 4:14-21" ],
  [ 'Tiago de Jerusalém, Bispo e Mártir', "Atos 15:12-22a", "Salmo 1", "1 Coríntios 15:1-11", "Mateus 13:54-58" ],
  [ 'Simão e Judas, Apóstolos', "Deuteronômio 32:1-4", "Salmo 119:89-96", "Efésios 2:13-22", "João 15:17-27" ],
  [ "Dia de Todos os Santos", "Eclesiástico 44:1-14 ou Apocalipse 7:9-17", "Salmo 149", "Apocalipse 7:9-17 ou Efésios 1:(11-14)15-23", "Mateus 5:1-12 ou Lucas 6:20-26(27-36)" ]
]

holy_days_readings.each do |name, first, psalm, second, gospel|
  c = celebrations.find_by(name: name)
  if c
    create_reading({ celebration_id: c.id, date_reference: name.parameterize.underscore, service_type: 'eucharist', first_reading: first, psalm: psalm, second_reading: second, gospel: gospel }, prayer_book.id)
  else
    Rails.logger.warn "⚠️  Celebration not found for reading: #{name}"
  end
end

# --- EMBER, ROGATION & NATIONAL DAYS ---
special_readings = [
  [ 'ember_days_1', "all", "eucharist", "Números 11:16-17, 24-29", "Salmo 99", "1 Coríntios 3:5-11", "João 4:31-38" ],
  [ 'ember_days_2', "all", "eucharist", "1 Samuel 3:1-10", "Salmo 63:1-8", "Efésios 4:11-16", "Mateus 9:35-38" ],
  [ 'rogation_days_1', "all", "eucharist", "Deuteronômio 11:10-15", "Salmo 147", "Romanos 8:18-25", "Marcos 4:26-32" ],
  [ 'rogation_days_2', "all", "eucharist", "Eclesiástico 38:27-32", "Salmo 107:1-9", "1 Coríntios 3:10-14", "Mateus 6:19-24" ],
  [ 'thanksgiving_day', "all", "eucharist", "Deuteronômio 8", "Salmo 65:1-8(9-14)", "Tiago 1:17-27", "Mateus 6:25-33" ],
  [ 'canada_day', "all", "eucharist", "Deuteronômio 6:1-15", "Salmo 145", "1 Pedro 2:1-6", "Mateus 22:16-21 ou Mateus 25:14-30" ],
  [ 'independence_day', "all", "eucharist", "Deuteronômio 10:17-21", "Salmo 145", "Hebreus 11:8-16", "Mateus 5:43-48" ],
  [ 'memorial_day', "all", "eucharist", "Sabedoria 3:1-9", "Salmo 121", "Apocalipse 7:9-17", "João 11:21-27 ou João 15:12-17" ]
]

special_readings.each do |ref, cycle, service, first, psalm, second, gospel|
  create_reading({ date_reference: ref, cycle: cycle, service_type: service, first_reading: first, psalm: psalm, second_reading: second, gospel: gospel }, prayer_book.id)
end

# --- COMMON OF THE COMMEMORATIONS ---
commons_readings = [
  [ 'common_martyrs', "Jeremias 15:15-21", "Salmo 34", "Apocalipse 7:9-17", "Lucas 12:4-12" ],
  [ 'common_missionaries', "Isaías 49:1-7", "Salmo 98", "Romanos 10:11-18", "Lucas 5:1-11" ],
  [ 'common_pastors', "Isaías 6:1-8", "Salmo 71:17-24", "1 Pedro 5:1-11 ou Atos 20:24-35", "Mateus 24:42-50" ],
  [ 'common_teachers', "Provérbios 3:13-26", "Salmo 119:89-106", "1 João 1:1-10", "Mateus 13:47-52" ],
  [ 'common_religious', "Lamentações 3:22-33", "Salmo 1", "Hebreus 4:1-13 ou Atos 2:42-47", "Marcos 10:23-31" ],
  [ 'common_ecumenists', "Ezequiel 34:11-16", "Salmo 133", "Efésios 3:14-21", "João 17:10-26" ],
  [ 'common_reformers', "Jeremias 1:4-10", "Salmo 46", "1 Coríntios 3:10-23", "Mateus 5:13-20" ],
  [ 'common_renewers', "Êxodo 3:7-12", "Salmo 145:1-13", "Romanos 12:9-21", "Lucas 6:20-38" ],
  [ 'common_any_1', "Miquéias 6:6-8", "Salmo 1", "1 Coríntios 1:18-31", "João 3:16-21" ],
  [ 'common_any_2', "Sabedoria 3:1-9", "Salmo 15", "Filipenses 4:4-9", "Lucas 6:17-23" ]
]

commons_readings.each do |ref, first, psalm, second, gospel|
  create_reading({ date_reference: ref, service_type: 'eucharist', first_reading: first, psalm: psalm, second_reading: second, gospel: gospel }, prayer_book.id)
end

Rails.logger.info "✅ Holy Days and Commons readings loaded!"
