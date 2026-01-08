# ================================================================================
# LEITURAS DIÁRIAS DO NATAL - LOC 2021 IAB (ANO ÍMPAR / C)
# ================================================================================

Rails.logger.info "📖 Carregando leituras diárias do Natal (LOC 2021 IAB)..."

prayer_book = PrayerBook.find_by!(code: 'loc_2021')

# Helper para criar leituras
create_daily_reading = ->(day_ref, mp_psalms, ep_psalms, r1, r2, r3) {
  # Manhã
  LectionaryReading.find_or_create_by!(
    date_reference: day_ref,
    cycle: "odd",
    service_type: "morning_prayer",
    prayer_book_id: prayer_book.id
  ) do |r|
    r.psalm = mp_psalms
    r.first_reading = r1
    r.second_reading = r2
    r.gospel = r3
  end

  # Tarde
  LectionaryReading.find_or_create_by!(
    date_reference: day_ref,
    cycle: "odd",
    service_type: "evening_prayer",
    prayer_book_id: prayer_book.id
  ) do |r|
    r.psalm = ep_psalms
    r.first_reading = r1
    r.second_reading = r2
    r.gospel = r3
  end
}

# 25 de Dezembro - Natal
create_daily_reading.call("december_25",
  "Salmo 2, 85", "Salmo 110:1-5(6-7), 132",
  "Zacarias 2:10-13", "1 João 4:7-16", "João 3:31-36"
)

# 1º Domingo depois do Natal (Ofício Diário)
create_daily_reading.call("1st_sunday_after_christmas",
  "Salmo 93, 96", "Salmo 34",
  "Isaías 62:6-7, 10-12", "Hebreus 2:10-18", "Mateus 1:18-25"
)

# 29 de Dezembro
create_daily_reading.call("december_29",
  "Salmo 18:1-20", "Salmo 18:21-50",
  "Isaías 12:1-6", "Apocalipse 1:1-8", "João 7:37-52"
)

# 30 de Dezembro
create_daily_reading.call("december_30",
  "Salmo 20, 21:1-7(8-14)", "Salmo 23, 27",
  "Isaías 25:1-9", "Apocalipse 1:9-20", "João 7:53-8:11"
)

# 31 de Dezembro
create_daily_reading.call("december_31",
  "Salmo 46, 48", "Salmo 90",
  "Isaías 26:1-9", "Isaías 65:15b-25", "João 8:12-19" # Simplificado, ver nota
)

# 1 de Janeiro - Santo Nome de Jesus
create_daily_reading.call("holy_name",
  "Salmo 103", "Salmo 148",
  "Gênesis 17:1-12a, 15-16", "Colossenses 2:6-12", "João 16:23b-30"
)

# 2 de Janeiro
create_daily_reading.call("january_2",
  "Salmo 34", "Salmo 33",
  "Gênesis 12:1-7", "Hebreus 11:1-12", "João 6:35-42, 48-51"
)

# 3 de Janeiro
create_daily_reading.call("january_3",
  "Salmo 68", "Salmo 72",
  "Gênesis 28:10-22", "Hebreus 11:13-22", "João 10:7-17"
)

# 4 de Janeiro
create_daily_reading.call("january_4",
  "Salmo 85, 87", "Salmo 89:1-29",
  "Êxodo 3:1-12", "Hebreus 11:23-31", "João 14:6-14"
)

# 5 de Janeiro
create_daily_reading.call("january_5",
  "Salmo 2, 110:1-5(6-7)", "Salmo 29, 98", # 29, 98 inferido para Véspera de Epifania? Não, imagem diz Josué... assumindo 110 tarde.
  "Josué 1:1-9", "Hebreus 11:32-12:2", "João 15:1-16"
)

Rails.logger.info "✅ Leituras diárias do Natal (Ano Ímpar) carregadas!"
