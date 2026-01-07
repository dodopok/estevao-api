# ================================================================================
# LEITURAS DIÁRIAS DO ADVENTO - LOC 2021 IAB (ANO PAR / A-B)
# ================================================================================

Rails.logger.info "📖 Carregando leituras diárias do Advento (Ano Par) (LOC 2021 IAB)..."

prayer_book = PrayerBook.find_by!(code: 'loc_2021')

create_daily_reading = ->(day_ref, mp_psalms, ep_psalms, r1, r2, r3) {
  # Manhã
  LectionaryReading.find_or_create_by!(
    date_reference: day_ref,
    cycle: "even",
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
    cycle: "even",
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
  "Amós 2:6-16", "2 Pedro 1:1-11", "Mateus 21:1-11"
)

create_daily_reading.call("1st_sunday_of_advent_tuesday",
  "Salmo 5, 6", "Salmo 10, 11",
  "Amós 3:1-11", "2 Pedro 1:12-21", "Mateus 21:12-22"
)

create_daily_reading.call("1st_sunday_of_advent_wednesday",
  "Salmo 119:1-24", "Salmo 12, 13, 14",
  "Amós 3:12-4:5", "2 Pedro 2:1-10", "Mateus 21:23-32"
)

create_daily_reading.call("1st_sunday_of_advent_thursday",
  "Salmo 18:1-20", "Salmo 18:21-50",
  "Amós 4:6-13", "2 Pedro 3:1-11", "Mateus 21:33-46"
)

create_daily_reading.call("1st_sunday_of_advent_friday",
  "Salmo 16, 17", "Salmo 22",
  "Amós 5:1-17", "Judas 1-16", "Mateus 22:1-14"
)

create_daily_reading.call("1st_sunday_of_advent_saturday",
  "Salmo 20, 21:1-7(8-14)", "Salmo 110:1-5(6-7), 116, 117",
  "Amós 5:18-27", "Judas 1:17-25", "Mateus 22:15-22"
)

# ----------------------------------------------------------------------------
# 2ª SEMANA DO ADVENTO
# ----------------------------------------------------------------------------
create_daily_reading.call("2nd_sunday_of_advent_monday",
  "Salmo 25", "Salmo 9, 15",
  "Amós 7:1-9", "Apocalipse 1:1-8", "Mateus 22:23-33"
)

create_daily_reading.call("2nd_sunday_of_advent_tuesday",
  "Salmo 26, 28", "Salmo 36, 39",
  "Amós 7:10-17", "Apocalipse 1:9-16", "Mateus 22:34-46"
)

create_daily_reading.call("2nd_sunday_of_advent_wednesday",
  "Salmo 38", "Salmo 119:25-48",
  "Amós 8:1-14", "Apocalipse 1:17-2:7", "Mateus 23:1-12"
)

create_daily_reading.call("2nd_sunday_of_advent_thursday",
  "Salmo 37:1-18", "Salmo 37:19-42",
  "Amós 9:1-10", "Apocalipse 2:8-17", "Mateus 23:13-26"
)

create_daily_reading.call("2nd_sunday_of_advent_friday",
  "Salmo 31", "Salmo 35",
  "Ageu 1:1-15", "Apocalipse 2:18-29", "Mateus 23:27-39"
)

create_daily_reading.call("2nd_sunday_of_advent_saturday",
  "Salmo 30, 32", "Salmo 42, 43",
  "Ageu 2:1-19", "Apocalipse 3:1-6", "Mateus 24:1-14"
)

# ----------------------------------------------------------------------------
# 3ª SEMANA DO ADVENTO
# ----------------------------------------------------------------------------
create_daily_reading.call("3rd_sunday_of_advent_monday",
  "Salmo 41, 52", "Salmo 44",
  "Zacarias 1:7-17", "Apocalipse 3:7-13", "Mateus 24:15-31"
)

create_daily_reading.call("3rd_sunday_of_advent_tuesday",
  "Salmo 45", "Salmo 47, 48",
  "Zacarias 2:1-13", "Apocalipse 3:14-22", "Mateus 24:32-44"
)

create_daily_reading.call("3rd_sunday_of_advent_wednesday",
  "Salmo 119:49-72", "Salmo 49, [53]",
  "Zacarias 3:1-10", "Apocalipse 4:1-8", "Mateus 24:45-51"
)

create_daily_reading.call("3rd_sunday_of_advent_thursday",
  "Salmo 50", "Salmo [59, 60] ou 33",
  "Zacarias 4:1-14", "Apocalipse 4:9-5:5", "Mateus 25:1-13"
)

create_daily_reading.call("3rd_sunday_of_advent_friday",
  "Salmo 40, 54", "Salmo 51",
  "Zacarias 7:8-8:8", "Apocalipse 5:6-14", "Mateus 25:14-30"
)

create_daily_reading.call("3rd_sunday_of_advent_saturday",
  "Salmo 55", "Salmo 138, 139:1-17(18-23)",
  "Zacarias 8:9-17", "Apocalipse 6:1-17", "Mateus 25:31-46"
)

# ----------------------------------------------------------------------------
# 4ª SEMANA DO ADVENTO
# ----------------------------------------------------------------------------
create_daily_reading.call("4th_sunday_of_advent_monday",
  "Salmo 61, 62", "Salmo 112, 115",
  "Sofonias 3:14-20", "Tito 1:1-16", "Lucas 1:1-25"
)

create_daily_reading.call("4th_sunday_of_advent_tuesday",
  "Salmo 66, 67", "Salmo 116, 117",
  "1 Samuel 2:1b-10", "Tito 2:1-10", "Lucas 1:26-38"
)

create_daily_reading.call("4th_sunday_of_advent_wednesday",
  "Salmo 72", "Salmo 111, 113",
  "2 Samuel 7:1-17", "Tito 2:11-3:8a", "Lucas 1:39-48a(48b-56)"
)

create_daily_reading.call("4th_sunday_of_advent_thursday",
  "Salmo 80", "Salmo 146, 147",
  "2 Samuel 7:18-29", "Gálatas 3:1-14", "Lucas 1:57-66"
)

create_daily_reading.call("4th_sunday_of_advent_friday",
  "Salmo 93, 96", "Salmo 148, 150",
  "Isaías 40:1-11", "Gálatas 3:15-22", "Lucas 1:67-80 ou Mateus 1:1-17"
)

# Sábado da 4ª semana é 24 de Dezembro (Véspera de Natal) geralmente.
# A imagem não mostra Sábado explicitamente como "Sábado", mas a página 2 começa com "24 de Dezembro".
# Se o dia 24 for sábado, usa-se a leitura do dia 24.

Rails.logger.info "✅ Leituras diárias do Advento (Ano Par) carregadas!"