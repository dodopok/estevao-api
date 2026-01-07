# ================================================================================
# LEITURAS DIÁRIAS DO ADVENTO - LOC 2021 IAB (ANO ÍMPAR / C)
# ================================================================================

Rails.logger.info "📖 Carregando leituras diárias do Advento (LOC 2021 IAB)..."

prayer_book = PrayerBook.find_by!(code: 'loc_2021')

# Helper para criar leituras
create_daily_reading = ->(day_ref, mp_psalms, ep_psalms, r1, r2, r3) {
  # Manhã
  LectionaryReading.find_or_create_by!(
    date_reference: day_ref,
    cycle: "odd", # Anos ímpares
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
    cycle: "odd", # Anos ímpares
    service_type: "evening_prayer",
    prayer_book_id: prayer_book.id
  ) do |r|
    r.psalm = ep_psalms
    r.first_reading = r1
    r.second_reading = r2
    r.gospel = r3
  end
}

# ----------------------------------------------------------------------------
# 1ª SEMANA DO ADVENTO
# ----------------------------------------------------------------------------
create_daily_reading.call("1st_sunday_of_advent_monday", 
  "Salmo 1, 2, 3", "Salmo 4, 7", 
  "Isaías 1:10-20", "1 Tessalonicenses 1:1-10", "Lucas 20:1-8"
)

create_daily_reading.call("1st_sunday_of_advent_tuesday",
  "Salmo 5, 6", "Salmo 10, 11",
  "Isaías 1:21-31", "1 Tessalonicenses 2:1-12", "Lucas 20:9-18"
)

create_daily_reading.call("1st_sunday_of_advent_wednesday",
  "Salmo 119:1-24", "Salmo 12, 13, 14",
  "Isaías 2:1-11", "1 Tessalonicenses 2:13-20", "Lucas 20:19-26"
)

create_daily_reading.call("1st_sunday_of_advent_thursday",
  "Salmo 18:1-20", "Salmo 18:21-50",
  "Isaías 2:12-22", "1 Tessalonicenses 3:1-13", "Lucas 20:27-40"
)

create_daily_reading.call("1st_sunday_of_advent_friday",
  "Salmo 16, 17", "Salmo 22",
  "Isaías 3:8-15", "1 Tessalonicenses 4:1-12", "Lucas 20:41-21:4"
)

create_daily_reading.call("1st_sunday_of_advent_saturday",
  "Salmo 20, 21:1-7(8-14)", "Salmo 110:1-5(6-7), 116, 117",
  "Isaías 4:2-6", "1 Tessalonicenses 4:13-18", "Lucas 21:5-19"
)

# ----------------------------------------------------------------------------
# 2ª SEMANA DO ADVENTO
# ----------------------------------------------------------------------------
create_daily_reading.call("2nd_sunday_of_advent_monday",
  "Salmo 25", "Salmo 9, 15",
  "Isaías 5:8-12, 18-23", "1 Tessalonicenses 5:1-11", "Lucas 21:20-28"
)

create_daily_reading.call("2nd_sunday_of_advent_tuesday",
  "Salmo 26, 28", "Salmo 36, 39",
  "Isaías 5:13-17, 24-25", "1 Tessalonicenses 5:12-28", "Lucas 21:29-38"
)

create_daily_reading.call("2nd_sunday_of_advent_wednesday",
  "Salmo 38", "Salmo 119:25-48",
  "Isaías 6:1-13", "2 Tessalonicenses 1:1-12", "João 7:53-8:11"
)

create_daily_reading.call("2nd_sunday_of_advent_thursday",
  "Salmo 37:1-18", "Salmo 37:19-42",
  "Isaías 7:1-9", "2 Tessalonicenses 2:1-12", "Lucas 22:1-13"
)

create_daily_reading.call("2nd_sunday_of_advent_friday",
  "Salmo 31", "Salmo 35",
  "Isaías 7:10-25", "2 Tessalonicenses 2:13-3:5", "Lucas 22:14-30"
)

create_daily_reading.call("2nd_sunday_of_advent_saturday",
  "Salmo 30, 32", "Salmo 42, 43",
  "Isaías 8:1-15", "2 Tessalonicenses 3:6-18", "Lucas 22:31-38"
)

# ----------------------------------------------------------------------------
# 3ª SEMANA DO ADVENTO
# ----------------------------------------------------------------------------
create_daily_reading.call("3rd_sunday_of_advent_monday",
  "Salmo 41, 52", "Salmo 44",
  "Isaías 8:16-9:1", "2 Pedro 1:1-11", "Lucas 22:39-53"
)

create_daily_reading.call("3rd_sunday_of_advent_tuesday",
  "Salmo 45", "Salmo 47, 48",
  "Isaías 9:1-7", "2 Pedro 1:12-21", "Lucas 22:54-69"
)

create_daily_reading.call("3rd_sunday_of_advent_wednesday",
  "Salmo 119:49-72", "Salmo 49, 53",
  "Isaías 9:8-17", "2 Pedro 2:1-10a", "Marcos 1:1-8"
)

create_daily_reading.call("3rd_sunday_of_advent_thursday",
  "Salmo 50", "Salmo 59, 60 or 33",
  "Isaías 9:18-10:4", "2 Pedro 2:10b-16", "Mateus 3:1-12"
)

create_daily_reading.call("3rd_sunday_of_advent_friday",
  "Salmo 40, 54", "Salmo 51",
  "Isaías 10:5-19", "2 Pedro 2:17-22", "Mateus 11:2-15"
)

create_daily_reading.call("3rd_sunday_of_advent_saturday",
  "Salmo 55", "Salmo 138, 139:1-17(18-23)",
  "Isaías 10:20-27", "Judas 1:17-25", "Lucas 3:1-9"
)

# ----------------------------------------------------------------------------
# 4ª SEMANA DO ADVENTO
# ----------------------------------------------------------------------------
create_daily_reading.call("4th_sunday_of_advent_monday",
  "Salmo 61, 62", "Salmo 112, 115",
  "Isaías 11:1-9", "Apocalipse 20:1-10", "João 5:30-47"
)

create_daily_reading.call("4th_sunday_of_advent_tuesday",
  "Salmo 66, 67", "Salmo 116, 117",
  "Isaías 11:10-16", "Apocalipse 20:11-21:8", "Lucas 1:5-25"
)

create_daily_reading.call("4th_sunday_of_advent_wednesday",
  "Salmo 72", "Salmo 111, 113",
  "Isaías 28:9-22", "Apocalipse 21:9-21", "Lucas 1:26-38"
)

create_daily_reading.call("4th_sunday_of_advent_thursday",
  "Salmo 80", "Salmo 146, 147",
  "Isaías 29:13-24", "Apocalipse 21:22-22:5", "Lucas 1:39-48(56)"
)

create_daily_reading.call("4th_sunday_of_advent_friday",
  "Salmo 93, 96", "Salmo 148, 150",
  "Isaías 33:17-22", "Apocalipse 22:6-11, 18-20", "Lucas 1:57-66"
)

# 24 de Dezembro (Véspera de Natal)
create_daily_reading.call("december_24",
  "Salmo 45, 46", "Salmo 89:1-29",
  "Isaías 35:1-10", "Apocalipse 22:12-17, 21", "Lucas 1:67-80"
)

Rails.logger.info "✅ Leituras diárias do Advento (Ano Ímpar) carregadas!"
