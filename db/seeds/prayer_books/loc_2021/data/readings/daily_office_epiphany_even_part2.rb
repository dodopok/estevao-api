# ================================================================================
# LEITURAS DIÁRIAS DA EPIFANIA (PARTE 2) - LOC 2021 IAB (ANO PAR / A-B)
# ================================================================================

Rails.logger.info "📖 Carregando leituras diárias da Epifania (Parte 2 - Ano Par) (LOC 2021 IAB)..."

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
# 4ª SEMANA DA EPIFANIA (SE HOUVER)
# ----------------------------------------------------------------------------
create_daily_reading.call("4th_sunday_after_epiphany_monday",
  "Salmo 56, 57, [58]", "Salmo 64, 65",
  "Gênesis 19:1-17(18-23)24-29", "Hebreus 11:1-12", "João 6:27-40"
)

create_daily_reading.call("4th_sunday_after_epiphany_tuesday",
  "Salmo 61, 62", "Salmo 68:1-20(21-23)24-36",
  "Gênesis 21:1-21", "Hebreus 11:13-22", "João 6:41-51"
)

create_daily_reading.call("4th_sunday_after_epiphany_wednesday",
  "Salmo 72", "Salmo 119:73-96",
  "Gênesis 22:1-18", "Hebreus 11:23-31", "João 6:52-59"
)

create_daily_reading.call("4th_sunday_after_epiphany_thursday",
  "Salmo [70], 71", "Salmo 74",
  "Gênesis 23:1-20", "Hebreus 11:32-12:2", "João 6:60-71"
)

create_daily_reading.call("4th_sunday_after_epiphany_friday",
  "Salmo 69:1-23[24-30]31-38", "Salmo 73",
  "Gênesis 24:1-27", "Hebreus 12:3-11", "João 7:1-13"
)

create_daily_reading.call("4th_sunday_after_epiphany_saturday",
  "Salmo 75, 76", "Salmo 23, 27",
  "Gênesis 24:28-38, 49-51", "Hebreus 12:12-29", "João 7:14-36"
)

# ----------------------------------------------------------------------------
# 5ª SEMANA DA EPIFANIA (SE HOUVER)
# ----------------------------------------------------------------------------
create_daily_reading.call("5th_sunday_after_epiphany_monday",
  "Salmo 80", "Salmo 77, [79]",
  "Gênesis 25:19-34", "Hebreus 13:1-16", "João 7:37-52"
)

create_daily_reading.call("5th_sunday_after_epiphany_tuesday",
  "Salmo 78:1-39", "Salmo 78:40-72",
  "Gênesis 26:1-6, 12-33", "Hebreus 13:17-25", "João 7:53-8:11"
)

create_daily_reading.call("5th_sunday_after_epiphany_wednesday",
  "Salmo 119:97-120", "Salmo 81, 82",
  "Gênesis 27:1-29", "Romanos 12:1-8", "João 8:12-20"
)

create_daily_reading.call("5th_sunday_after_epiphany_thursday",
  "Salmo [83] ou 146, 147", "Salmo 85, 86",
  "Gênesis 27:30-45", "Romanos 12:9-21", "João 8:21-32"
)

create_daily_reading.call("5th_sunday_after_epiphany_friday",
  "Salmo 88", "Salmo 91, 92",
  "Gênesis 27:46-28:4, 10-22", "Romanos 13:1-14", "João 8:33-47"
)

create_daily_reading.call("5th_sunday_after_epiphany_saturday",
  "Salmo 87, 90", "Salmo 136",
  "Gênesis 29:1-20", "Romanos 14:1-23", "João 8:47-59"
)

# ----------------------------------------------------------------------------
# 6ª SEMANA DA EPIFANIA (SE HOUVER)
# ----------------------------------------------------------------------------
create_daily_reading.call("6th_sunday_after_epiphany_monday",
  "Salmo 89:1-18", "Salmo 89:19-52",
  "Gênesis 30:1-24", "1 João 1:1-10", "João 9:1-17"
)

create_daily_reading.call("6th_sunday_after_epiphany_tuesday",
  "Salmo 97, 99, [100]", "Salmo 94, [95]",
  "Gênesis 31:1-24", "1 João 2:1-11", "João 9:18-41"
)

create_daily_reading.call("6th_sunday_after_epiphany_wednesday",
  "Salmo 101, 109:1-4(5-19)20-30", "Salmo 119:121-144",
  "Gênesis 31:25-50", "1 João 2:12-17", "João 10:1-18"
)

create_daily_reading.call("6th_sunday_after_epiphany_thursday",
  "Salmo 105:1-22", "Salmo 105:23-45",
  "Gênesis 32:3-21", "1 João 2:18-29", "João 10:19-30"
)

create_daily_reading.call("6th_sunday_after_epiphany_friday",
  "Salmo 102", "Salmo 107:1-32",
  "Gênesis 32:22-33:17", "1 João 3:1-10", "João 10:31-42"
)

create_daily_reading.call("6th_sunday_after_epiphany_saturday",
  "Salmo 107:33-43, 108:1-6(7-13)", "Salmo 33",
  "Gênesis 35:1-20", "1 João 3:11-18", "João 11:1-16"
)

# ----------------------------------------------------------------------------
# 7ª SEMANA DA EPIFANIA (SE HOUVER)
# ----------------------------------------------------------------------------
create_daily_reading.call("7th_sunday_after_epiphany_monday",
  "Salmo 106:1-18", "Salmo 106:19-48",
  "Provérbios 3:11-20", "1 João 3:18-4:6", "João 11:17-29"
)

create_daily_reading.call("7th_sunday_after_epiphany_tuesday",
  "Salmo [120], 121, 122, 123", "Salmo 124, 125, 126, [127]",
  "Provérbios 4:1-27", "1 João 4:7-21", "João 11:30-44"
)

create_daily_reading.call("7th_sunday_after_epiphany_wednesday",
  "Salmo 119:145-176", "Salmo 128, 129, 130",
  "Provérbios 6:1-19", "1 João 5:1-12", "João 11:45-54"
)

create_daily_reading.call("7th_sunday_after_epiphany_thursday",
  "Salmo 131, 132, [133]", "Salmo 134, 135",
  "Provérbios 7:1-27", "1 João 5:13-21", "João 11:55-12:8"
)

create_daily_reading.call("7th_sunday_after_epiphany_friday",
  "Salmo 140, 142", "Salmo 141, 143:1-11(12)",
  "Provérbios 8:1-21", "Filemon 1-25", "João 12:9-19"
)

create_daily_reading.call("7th_sunday_after_epiphany_saturday",
  "Salmo 137:1-6(7-9), 144", "Salmo 104",
  "Provérbios 8:22-36", "2 Timóteo 1:1-14", "João 12:20-26"
)

# ----------------------------------------------------------------------------
# 8ª SEMANA DA EPIFANIA (SE HOUVER)
# ----------------------------------------------------------------------------
create_daily_reading.call("8th_sunday_after_epiphany_monday",
  "Salmo 1, 2, 3", "Salmo 4, 7",
  "Provérbios 10:1-12", "2 Timóteo 1:15-2:13", "João 12:27-36a"
)

create_daily_reading.call("8th_sunday_after_epiphany_tuesday",
  "Salmo 5, 6", "Salmo 10, 11",
  "Provérbios 15:16-33", "2 Timóteo 2:14-26", "João 12:36b-50"
)

create_daily_reading.call("8th_sunday_after_epiphany_wednesday",
  "Salmo 119:1-24", "Salmo 12, 13, 14",
  "Provérbios 17:1-20", "2 Timóteo 3:1-17", "João 13:1-20"
)

create_daily_reading.call("8th_sunday_after_epiphany_thursday",
  "Salmo 18:1-20", "Salmo 18:21-50",
  "Provérbios 21:30-22:6", "2 Timóteo 4:1-8", "João 13:21-30"
)

create_daily_reading.call("8th_sunday_after_epiphany_friday",
  "Salmo 16, 17", "Salmo 22",
  "Provérbios 23:19-21, 29-24:2", "2 Timóteo 4:9-22", "João 13:31-38"
)

create_daily_reading.call("8th_sunday_after_epiphany_saturday",
  "Salmo 20, 21:1-7(8-14)", "Salmo 110:1-5(6-7), 116, 117",
  "Provérbios 25:15-28", "Filipenses 1:1-11", "João 18:1-14" # Nota: Imagem diz "Fp 1:1-11".
)

# ----------------------------------------------------------------------------
# ÚLTIMA SEMANA DA EPIFANIA (SEMANA DA TRANSFIGURAÇÃO)
# ----------------------------------------------------------------------------
create_daily_reading.call("last_sunday_after_epiphany_monday",
  "Salmo 25", "Salmo 9, 15",
  "Provérbios 27:1-6, 10-12", "Filipenses 2:1-13", "João 18:15-18, 25-27"
)

create_daily_reading.call("last_sunday_after_epiphany_tuesday",
  "Salmo 26, 28", "Salmo 36, 39",
  "Provérbios 30:1-4, 24-33", "Filipenses 3:1-11", "João 18:28-38"
)

create_daily_reading.call("ash_wednesday",
  "Salmo 95, 32, 143", "Salmo 102, 130",
  "Amós 5:6-15", "Hebreus 12:1-14", "Lucas 18:9-14"
)

create_daily_reading.call("thursday_after_ash_wednesday",
  "Salmo 37:1-18", "Salmo 37:19-42",
  "Habacuque 3:1-10(11-15)16-18", "Filipenses 3:12-21", "João 17:1-8"
)

create_daily_reading.call("friday_after_ash_wednesday",
  "Salmo 95, 31", "Salmo 35",
  "Ezequiel 18:1-4, 25:32", "Filipenses 4:1-9", "João 17:9-19" # Nota: Imagem diz "Ez 18:1-4, 25:32". Talvez 25-32?
  # Vou assumir 25-32.
)
create_daily_reading.call("friday_after_ash_wednesday",
  "Salmo 95, 31", "Salmo 35",
  "Ezequiel 18:1-4, 25-32", "Filipenses 4:1-9", "João 17:9-19"
)

create_daily_reading.call("saturday_after_ash_wednesday",
  "Salmo 30, 32", "Salmo 42, 43",
  "Ezequiel 39:21-29", "Filipenses 4:10-20", "João 17:20-26"
)

Rails.logger.info "✅ Leituras diárias da Epifania (Parte 2 - Ano Par) carregadas!"
