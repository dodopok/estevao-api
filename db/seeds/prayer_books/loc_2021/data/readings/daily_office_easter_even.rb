# ================================================================================
# LEITURAS DIÁRIAS DA SEMANA SANTA E PÁSCOA - LOC 2021 IAB (ANO PAR / A-B)
# ================================================================================

Rails.logger.info "📖 Carregando leituras diárias da Semana Santa e Páscoa (Ano Par) (LOC 2021 IAB)..."

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
# SEMANA SANTA
# ----------------------------------------------------------------------------
create_daily_reading.call("holy_week_monday",
  "Salmo 51:1-18(19-20)", "Salmo 69:1-23",
  "Lamentações 1:1-2, 6-12", "2 Coríntios 1:1-7", "Marcos 11:12-25"
)

create_daily_reading.call("holy_week_tuesday",
  "Salmo 6, 12", "Salmo 94",
  "Lamentações 1:17-22", "2 Coríntios 1:8-22", "Marcos 11:27-33"
)

create_daily_reading.call("holy_week_wednesday",
  "Salmo 55", "Salmo 74",
  "Lamentações 2:1-9, 14-17", "2 Coríntios 1:23-2:11", "Marcos 12:1-11"
)

create_daily_reading.call("holy_week_thursday",
  "Salmo 102", "Salmo 142, 143",
  "Lamentações 2:10-18", "1 Coríntios 10:14-17, 11:27-32", "Marcos 14:12-25"
)

create_daily_reading.call("holy_week_friday",
  "Salmo 95, 22", "Salmo 40:1-14(15-19), 54",
  "Lamentações 3:1-9, 19-33", "1 Pedro 1:10-20", "João 13:36-38"
)

create_daily_reading.call("holy_week_saturday",
  "Salmo 95, 88", "Salmo 27",
  "Lamentações 3:37-58", "Hebreus 4:1-16", "João 19:38-42"
)

# ----------------------------------------------------------------------------
# TEMPO DA PÁSCOA
# ----------------------------------------------------------------------------

# 1ª SEMANA DA PÁSCOA
create_daily_reading.call("1st_sunday_of_easter_monday",
  "Salmo 93, 98", "Salmo 66",
  "Êxodo 12:14-27", "1 Coríntios 15:1-11", "Marcos 16:1-8"
)

create_daily_reading.call("1st_sunday_of_easter_tuesday",
  "Salmo 103", "Salmo 111, 114",
  "Êxodo 12:28-39", "1 Coríntios 15:12-28", "Marcos 16:9-20"
)

create_daily_reading.call("1st_sunday_of_easter_wednesday",
  "Salmo 97, 99", "Salmo 115",
  "Êxodo 12:40-51", "1 Coríntios 15:(29)30-41", "Mateus 28:1-16"
)

create_daily_reading.call("1st_sunday_of_easter_thursday",
  "Salmo 146, 147", "Salmo 148, 149",
  "Êxodo 13:3-10", "1 Coríntios 15:41-50", "Mateus 28:16-20"
)

create_daily_reading.call("1st_sunday_of_easter_friday",
  "Salmo 136", "Salmo 118",
  "Êxodo 13:1-2, 11-16", "1 Coríntios 15:51-58", "Lucas 24:1-12"
)

create_daily_reading.call("1st_sunday_of_easter_saturday",
  "Salmo 145", "Salmo 104",
  "Êxodo 13:17-14:4", "2 Coríntios 4:16-5:10", "Marcos 12:18-27" # Nota: Imagem 8 Sábado diz "2 Coríntios 4:16-5:10 Marcos 12:18-27".
  # Marcos 12:18-27 não é narrativa de ressurreição.
  # Mas é o que está escrito.
)

# 2ª SEMANA DA PÁSCOA
create_daily_reading.call("2nd_sunday_of_easter_monday",
  "Salmo 1, 2, 3", "Salmo 4, 7",
  "Êxodo 14:21-31", "1 Pedro 1:1-12", "João 14:(1-7)8-17"
)

create_daily_reading.call("2nd_sunday_of_easter_tuesday",
  "Salmo 5, 6", "Salmo 10, 11",
  "Êxodo 15:1-21", "1 Pedro 1:13-25", "João 14:18-31"
)

create_daily_reading.call("2nd_sunday_of_easter_wednesday",
  "Salmo 119:1-24", "Salmo 12, 13, 14",
  "Êxodo 15:22-16:10", "1 Pedro 2:1-10", "João 15:1-11"
)

create_daily_reading.call("2nd_sunday_of_easter_thursday",
  "Salmo 18:1-20", "Salmo 18:21-50",
  "Êxodo 16:10-21", "1 Pedro 2:11-25", "João 15:12-27"
)

create_daily_reading.call("2nd_sunday_of_easter_friday",
  "Salmo 16, 17", "Salmo 134, 135",
  "Êxodo 16:22-36", "1 Pedro 3:13-4:6", "João 16:1-15"
)

create_daily_reading.call("2nd_sunday_of_easter_saturday",
  "Salmo 20, 21:1-7(8-14)", "Salmo 110:1-5(6-7), 116, 117",
  "Êxodo 17:1-16", "1 Pedro 4:7-19", "João 16:16-33"
)

# 3ª SEMANA DA PÁSCOA
create_daily_reading.call("3rd_sunday_of_easter_monday",
  "Salmo 25", "Salmo 9, 15",
  "Êxodo 18:13-27", "1 Pedro 5:1-14", "Mateus (1:1-17), 3:1-6"
)

create_daily_reading.call("3rd_sunday_of_easter_tuesday",
  "Salmo 26, 28", "Salmo 36, 39",
  "Êxodo 19:1-16", "Colossenses 1:1-14", "Mateus 3:7-12"
)

create_daily_reading.call("3rd_sunday_of_easter_wednesday",
  "Salmo 38", "Salmo 119:25-48",
  "Êxodo 19:16-25", "Colossenses 1:15-23", "Mateus 3:13-17"
)

create_daily_reading.call("3rd_sunday_of_easter_thursday",
  "Salmo 37:1-18", "Salmo 37:19-42",
  "Êxodo 20:1-21", "Colossenses 1:24-2:7", "Mateus 4:1-11"
)

create_daily_reading.call("3rd_sunday_of_easter_friday",
  "Salmo 105:1-22", "Salmo 105:23-45",
  "Êxodo 24:1-18", "Colossenses 2:8-23", "Mateus 4:12-17"
)

create_daily_reading.call("3rd_sunday_of_easter_saturday",
  "Salmo 30, 32", "Salmo 42, 43",
  "Êxodo 25:1-22", "Colossenses 3:1-17", "Mateus 4:18-25"
)

# 4ª SEMANA DA PÁSCOA
create_daily_reading.call("4th_sunday_of_easter_monday",
  "Salmo 41, 52", "Salmo 44",
  "Êxodo 32:1-20", "Colossenses 3:18-4:6(7-16)", "Mateus 5:1-10"
)

create_daily_reading.call("4th_sunday_of_easter_tuesday",
  "Salmo 45", "Salmo 47, 48",
  "Êxodo 32:21-34", "1 Tessalonicenses 1", "Mateus 5:11-16"
)

create_daily_reading.call("4th_sunday_of_easter_wednesday",
  "Salmo 119:49-72", "Salmo 49, [53]",
  "Êxodo 33:1-23", "1 Tessalonicenses 2:1-12", "Mateus 5:17-20"
)

create_daily_reading.call("4th_sunday_of_easter_thursday",
  "Salmo 50", "Salmo [59, 60]ou 114, 115",
  "Êxodo 34:1-17", "1 Tessalonicenses 2:13-20", "Mateus 5:21-26"
)

create_daily_reading.call("4th_sunday_of_easter_friday",
  "Salmo 40, 54", "Salmo 51",
  "Êxodo 34:18-35", "1 Tessalonicenses 3", "Mateus 5:27-37"
)

create_daily_reading.call("4th_sunday_of_easter_saturday",
  "Salmo 55", "Salmo 138, 139:1-17(18-23)",
  "Êxodo 40:18-38", "1 Tessalonicenses 4:1-12", "Mateus 5:38-48"
)

# 5ª SEMANA DA PÁSCOA
create_daily_reading.call("5th_sunday_of_easter_monday",
  "Salmo 56-57, [58]", "Salmo 64, 65",
  "Levítico 16:1-19", "1 Tessalonicenses 4:13-18", "Mateus 6:1-6, 16-18"
)

create_daily_reading.call("5th_sunday_of_easter_tuesday",
  "Salmo 61, 62", "Salmo 68:1-20(21-23)24-36",
  "Levítico 16:20-34", "1 Tessalonicenses 5:1-11", "Mateus 6:7-15"
)

create_daily_reading.call("5th_sunday_of_easter_wednesday",
  "Salmo 72", "Salmo 119:73-96",
  "Levítico 19:1-18", "1 Tessalonicenses 5:12-28", "Mateus 6:19-24"
)

create_daily_reading.call("5th_sunday_of_easter_thursday",
  "Salmo [70], 71", "Salmo 74",
  "Levítico 19:26-37", "2 Tessalonicenses 1", "Mateus 6:25-34"
)

create_daily_reading.call("5th_sunday_of_easter_friday",
  "Salmo 106:1-18", "Salmo 106:19-48",
  "Levítico 23:1-22", "2 Tessalonicenses 2", "Mateus 7:1-12"
)

create_daily_reading.call("5th_sunday_of_easter_saturday",
  "Salmo 75, 76", "Salmo 23, 27",
  "Levítico 23:23-44", "2 Tessalonicenses 3:1-18", "Mateus 7:13-21"
)

# 6ª SEMANA DA PÁSCOA
create_daily_reading.call("6th_sunday_of_easter_monday",
  "Salmo 80", "Salmo 77, [79]",
  "Levítico 25:35-55", "Colossenses 1:9-14", "Mateus 13:1-16"
)

create_daily_reading.call("6th_sunday_of_easter_tuesday",
  "Salmo 78:1-39", "Salmo 78:40-72",
  "Levítico 26:1-20", "1 Timóteo 2:1-6", "Mateus 13:18-23"
)

create_daily_reading.call("6th_sunday_of_easter_wednesday",
  "Salmo 119:97-120", "Salmo 68:1-20",
  "Levítico 26:27-42", "Efésios 1:1-10", "Mateus 22:41-46"
)

# Ascensão do Senhor (Quinta-feira)
create_daily_reading.call("ascension_day",
  "Salmo 8, 47", "Salmo 24, 96",
  "Daniel 7:9-14", "Hebreus 2:5-18", "Mateus 28:16-20"
)

create_daily_reading.call("6th_sunday_of_easter_friday",
  "Salmo 85, 86", "Salmo 91, 92",
  "1 Samuel 2:1-10", "Efésios 2:1-10", "Mateus 7:22-27"
)

create_daily_reading.call("6th_sunday_of_easter_saturday",
  "Salmo 87, 90", "Salmo 136",
  "Números 11:16-17, 24-29", "Efésios 2:11-22", "Mateus 7:28-8:4"
)

# 7ª SEMANA DA PÁSCOA
create_daily_reading.call("7th_sunday_of_easter_monday",
  "Salmo 89:1-18", "Salmo 89:19-52",
  "Josué 1:1-9", "Efésios 3:1-13", "Mateus 8:5-17"
)

create_daily_reading.call("7th_sunday_of_easter_tuesday",
  "Salmo 97, 99, [100]", "Salmo 94, [95]",
  "1 Samuel 16:1-13a", "Efésios 3:14-21", "Mateus 8:18-27"
)

create_daily_reading.call("7th_sunday_of_easter_wednesday",
  "Salmo 101, 109:1-4(5-19)20-30", "Salmo 119:121-144",
  "Isaías 4:2-6", "Efésios 4:1-16", "Mateus 8:28-34"
)

create_daily_reading.call("7th_sunday_of_easter_thursday",
  "Salmo 105:1-22", "Salmo 105:23-45",
  "Zacarias 4:1-14", "Efésios 4:17-32", "Mateus 9:1-8"
)

create_daily_reading.call("7th_sunday_of_easter_friday",
  "Salmo 102", "Salmo 107:1-32",
  "Jeremias 31:27-34", "Efésios 5:1-20", "Mateus 9:9-17"
)

create_daily_reading.call("7th_sunday_of_easter_saturday",
  "Salmo 107:33-43, 108:1-6(7-13)", "Salmo 33",
  "Ezequiel 36:22-27", "Efésios 6:10-24", "Mateus 9:18-26"
)

# ----------------------------------------------------------------------------
# PENTECOSTES (TEMPO APÓS) - PRÓPRIO 1
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_1_monday",
  "Salmo 106:1-18", "Salmo 106:19-48",
  "Ezequiel 33:1-11", "1 João 1", "Mateus 9:27-34"
)

create_daily_reading.call("proper_1_tuesday",
  "Salmo [120], 121, 122, 123", "Salmo 124, 125, 126, [127]",
  "Ezequiel 33:21-33", "1 João 2:1-11", "Mateus 9:35-10:4"
)

Rails.logger.info "✅ Leituras diárias da Semana Santa, Páscoa e Início de Pentecostes (Ano Par) carregadas!"
