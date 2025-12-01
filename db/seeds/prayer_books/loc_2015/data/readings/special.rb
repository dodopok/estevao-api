# Observâncias Especiais da Tradição Anglicana/Episcopal
# Dias de ação de graças, rogação, e outras celebrações nacionais

Rails.logger.info "📖 Carregando observâncias especiais..."

# Buscar o prayer book
prayer_book = PrayerBook.find_by!(code: 'loc_2015')

special_observances = [
  # Thanksgiving Day (EUA - 4ª quinta-feira de novembro)
  {
    date_reference: "thanksgiving_usa",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Deuteronômio 8:7-18",
    psalm: "Salmo 65",
    second_reading: "2 Coríntios 9:6-15",
    gospel: "Lucas 17:11-19"
  },

  # Thanksgiving Day (Alternativa 1)
  {
    date_reference: "thanksgiving_usa_alt1",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Joel 2:21-27",
    psalm: "Salmo 126",
    second_reading: "1 Timóteo 2:1-7",
    gospel: "Mateus 6:25-33"
  },

  # Thanksgiving Day (Alternativa 2)
  {
    date_reference: "thanksgiving_usa_alt2",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Deuteronômio 26:1-11",
    psalm: "Salmo 100",
    second_reading: "Filipenses 4:4-9",
    gospel: "João 6:25-35"
  },

  # Thanksgiving Day (Canadá - 2ª segunda-feira de outubro)
  {
    date_reference: "thanksgiving_canada",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Deuteronômio 8:7-18",
    psalm: "Salmo 65",
    second_reading: "2 Coríntios 9:6-15",
    gospel: "Lucas 12:15-21"
  },

  # Rogation Days (3 dias antes da Ascensão)
  {
    date_reference: "rogation_day",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Deuteronômio 11:10-15",
    psalm: "Salmo 104:13-23",
    second_reading: "1 Timóteo 6:6-10, 17-19",
    gospel: "Lucas 12:13-21"
  },

  # Independence Day (4 de julho - EUA)
  {
    date_reference: "independence_day_usa",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Deuteronômio 10:17-21",
    psalm: "Salmo 145:1-9",
    second_reading: "Hebreus 11:8-16",
    gospel: "Mateus 5:43-48"
  },

  # Ember Days - Primavera (Spring Ember Days)
  {
    date_reference: "ember_days_spring",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Ezequiel 34:11-16",
    psalm: "Salmo 23",
    second_reading: "1 Pedro 5:1-11",
    gospel: "João 21:15-17"
  },

  # Ember Days - Verão (Summer Ember Days)
  {
    date_reference: "ember_days_summer",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jeremias 1:4-10",
    psalm: "Salmo 84",
    second_reading: "Atos 13:44-49",
    gospel: "Lucas 4:16-21"
  },

  # Ember Days - Outono (Fall Ember Days)
  {
    date_reference: "ember_days_fall",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaías 6:1-8",
    psalm: "Salmo 122",
    second_reading: "1 Coríntios 3:10-17",
    gospel: "Lucas 12:35-43"
  },

  # Ember Days - Inverno (Winter Ember Days)
  {
    date_reference: "ember_days_winter",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaías 52:7-10",
    psalm: "Salmo 96",
    second_reading: "Atos 1:8-14",
    gospel: "Lucas 10:1-9"
  },

  # For the Unity of the Church (Semana de Oração pela Unidade)
  {
    date_reference: "unity_of_church",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaías 35:1-10",
    psalm: "Salmo 122",
    second_reading: "1 Coríntios 1:10-17",
    gospel: "João 17:15-23"
  },

  # For the Mission of the Church
  {
    date_reference: "mission_of_church",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaías 49:1-6",
    psalm: "Salmo 67",
    second_reading: "Atos 13:44-49",
    gospel: "Lucas 10:1-9"
  },

  # For Peace (Dia de Oração pela Paz)
  {
    date_reference: "for_peace",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Miqueias 4:1-5",
    psalm: "Salmo 85:7-13",
    second_reading: "Efésios 2:13-18",
    gospel: "João 14:23-29"
  },

  # For Social Justice
  {
    date_reference: "social_justice",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Amós 5:18-24",
    psalm: "Salmo 72:1-4, 12-14",
    second_reading: "Tiago 2:1-9, 14-17",
    gospel: "Mateus 25:31-46"
  },

  # Dia de Finados (2 de novembro)
  {
    date_reference: "all_souls",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Sabedoria 3:1-9 or Isaías 25:6-9",
    psalm: "Salmo 23",
    second_reading: "Romanos 8:31-39",
    gospel: "João 6:37-40"
  },

  # Harvest Thanksgiving (Ação de Graças pela Colheita)
  {
    date_reference: "harvest_thanksgiving",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Deuteronômio 26:1-11",
    psalm: "Salmo 65",
    second_reading: "2 Coríntios 9:6-15",
    gospel: "Lucas 12:16-30"
  }
]

# Criar leituras (evita duplicatas)
count = 0
skipped = 0
special_observances.each do |reading|
  reading[:prayer_book_id] = prayer_book.id
  existing = LectionaryReading.find_by(
    date_reference: reading[:date_reference],
    cycle: reading[:cycle],
    service_type: reading[:service_type],
    prayer_book_id: prayer_book.id
  )

  if existing.nil?
    LectionaryReading.create!(reading)
    count += 1
    print "." if count % 5 == 0
  else
    skipped += 1
  end
end

Rails.logger.info "\n✅ #{count} observâncias especiais criadas!"
Rails.logger.info "⏭️  #{skipped} já existiam." if skipped > 0
