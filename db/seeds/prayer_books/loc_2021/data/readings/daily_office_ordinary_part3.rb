# ================================================================================
# LEITURAS DIÁRIAS DO TEMPO COMUM (PARTE 3) - LOC 2021 IAB (ANO ÍMPAR / C)
# ================================================================================

Rails.logger.info "📖 Carregando leituras diárias do Tempo Comum (Parte 3) (LOC 2021 IAB)..."

prayer_book = PrayerBook.find_by!(code: 'loc_2021')

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

# ----------------------------------------------------------------------------
# PRÓPRIO 19 - PRÓXIMO A 14 DE SETEMBRO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_19_monday", "Salmo 56, 57, [58]", "Salmo 64, 65", "1 Reis 21:1-16", "Atos 15:36-16:5", "João 11:55-12:8")
create_daily_reading.call("proper_19_tuesday", "Salmo 61, 62", "Salmo 68:1-20(21-23)24-36", "1 Reis 21:17-29", "Atos 16:6-15", "João 12:9-19")
create_daily_reading.call("proper_19_wednesday", "Salmo 72", "Salmo 119:73-96", "1 Reis 22:1-28", "Atos 16:16-24", "João 12:20-26")
create_daily_reading.call("proper_19_thursday", "Salmo [70], 71", "Salmo 74", "1 Reis 22:29-45", "Atos 16:25-40", "João 12:27-36a")
create_daily_reading.call("proper_19_friday", "Salmo 69:1-23[24-30]31-38", "Salmo 73", "2 Reis 1:2-17", "Atos 17:1-15", "João 12:36b-43")
create_daily_reading.call("proper_19_saturday", "Salmo 75, 76", "Salmo 23, 27", "2 Reis 2:1-18", "Atos 17:16-34", "João 12:44-50")

# ----------------------------------------------------------------------------
# PRÓPRIO 20 - PRÓXIMO A 21 DE SETEMBRO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_20_monday", "Salmo 80", "Salmo 77, [79]", "2 Reis 5:1-19", "Atos 18:1-11", "Lucas 1:(1-4), 3:1-14")
create_daily_reading.call("proper_20_tuesday", "Salmo 78:1-39", "Salmo 78:40-72", "2 Reis 5:19-27", "Atos 18:12-28", "Lucas 3:15-22")
create_daily_reading.call("proper_20_wednesday", "Salmo 119:97-120", "Salmo 81, 82", "2 Reis 6:1-23", "Atos 19:1-10", "Lucas 4:1-13")
create_daily_reading.call("proper_20_thursday", "Salmo [83] ou 146, 147", "Salmo 85, 86", "2 Reis 9:1-16", "Atos 19:11-20", "Lucas 4:14-30")
create_daily_reading.call("proper_20_friday", "Salmo 88", "Salmo 91, 92", "2 Reis 9:17-37", "Atos 19:21-41", "Lucas 4:31-37")
create_daily_reading.call("proper_20_saturday", "Salmo 87, 90", "Salmo 136", "2 Reis 11:1-20a", "Atos 20:1-16", "Lucas 4:38-44")

# ----------------------------------------------------------------------------
# PRÓPRIO 21 - PRÓXIMO A 28 DE SETEMBRO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_21_monday", "Salmo 89:1-18", "Salmo 89:19-52", "2 Reis 17:24-41", "Atos 20:17-38", "Lucas 5:1-11")
create_daily_reading.call("proper_21_tuesday", "Salmo 97, 99, [100]", "Salmo 94, [95]", "2 Crônicas 29:1-3, 30:1(2-9)10-27", "Atos 21:1-14", "Lucas 5:12-26")
create_daily_reading.call("proper_21_wednesday", "Salmo 101, 109:1-4(5-19)20-30", "Salmo 119:121-144", "2 Reis 18:9-25", "Atos 21:15-26", "Lucas 5:27-39")
create_daily_reading.call("proper_21_thursday", "Salmo 105:1-22", "Salmo 105:23-45", "2 Reis 18:28-37", "Atos 21:27-36", "Lucas 6:1-11")
create_daily_reading.call("proper_21_friday", "Salmo 102", "Salmo 107:1-32", "2 Reis 19:1-20", "Atos 21:37-22:16", "Lucas 6:12-26")
create_daily_reading.call("proper_21_saturday", "Salmo 107:33-43, 108:1-6(7-13)", "Salmo 33", "2 Reis 19:21-36", "Atos 22:17-29", "Lucas 6:27-38")

# ----------------------------------------------------------------------------
# PRÓPRIO 22 - PRÓXIMO A 5 DE OUTUBRO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_22_monday", "Salmo 106:1-18", "Salmo 106:19-48", "2 Reis 21:1-18", "Atos 22:30-23:11", "Lucas 6:39-49")
create_daily_reading.call("proper_22_tuesday", "Salmo [120], 121, 122, 123", "Salmo 124, 125, 126, [127]", "2 Reis 22:1-13", "Atos 23:12-24", "Lucas 7:1-17")
create_daily_reading.call("proper_22_wednesday", "Salmo 119:145-176", "Salmo 128, 129, 130", "2 Reis 22:14-23:3", "Atos 23:23-35", "Lucas 7:18-35")
create_daily_reading.call("proper_22_thursday", "Salmo 131, 132, [133]", "Salmo 134, 135", "2 Reis 23:4-25", "Atos 24:1-23", "Lucas 7:36-50")
create_daily_reading.call("proper_22_friday", "Salmo 140, 142", "Salmo 141, 143:1-11(12)", "2 Reis 23:36-24:17", "Atos 24:24-25:12", "Lucas 8:1-15")
create_daily_reading.call("proper_22_saturday", "Salmo 137:1-6(7-9), 144", "Salmo 104", "Jeremias 35:1-19", "Atos 25:13-27", "Lucas 8:16-25")

# ----------------------------------------------------------------------------
# PRÓPRIO 23 - PRÓXIMO A 12 DE OUTUBRO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_23_monday", "Salmo 1, 2, 3", "Salmo 4, 7", "Jeremias 36:11-26", "Atos 26:1-23", "Lucas 8:26-39")
create_daily_reading.call("proper_23_tuesday", "Salmo 5, 6", "Salmo 10, 11", "Jeremias 36:27-37:2", "Atos 26:24--27:8", "Lucas 8:40-56")
create_daily_reading.call("proper_23_wednesday", "Salmo 119:1-24", "Salmo 12, 13, 14", "Jeremias 37:3-21", "Atos 27:9-26", "Lucas 9:1-17")
create_daily_reading.call("proper_23_thursday", "Salmo 18:1-20", "Salmo 18:21-50", "Jeremias 38:1-13", "Atos 27:27-44", "Lucas 9:18-27")
create_daily_reading.call("proper_23_friday", "Salmo 16, 17", "Salmo 22", "Jeremias 38:14-28", "Atos 28:1-16", "Lucas 9:28-36")
create_daily_reading.call("proper_23_saturday", "Salmo 20, 21:1-7(8-14)", "Salmo 110:1-5(6-7), 116, 117", "2 Reis 25:8-12, 22-26", "Atos 28:17-31", "Lucas 9:37-50")

# ----------------------------------------------------------------------------
# PRÓPRIO 24 - PRÓXIMO A 19 DE OUTUBRO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_24_monday", "Salmo 25", "Salmo 9, 15", "Jeremias 44:1-14", "Apocalipse 7:1-8", "Lucas 9:51-62")
create_daily_reading.call("proper_24_tuesday", "Salmo 26, 28", "Salmo 36, 39", "Lamentações 1:1-5(6-9)10-12", "Apocalipse 7:9-17", "Lucas 10:1-16")
create_daily_reading.call("proper_24_wednesday", "Salmo 38", "Salmo 119:25-48", "Lamentações 2:8-15", "Apocalipse 8:1-13", "Lucas 10:17-24")
create_daily_reading.call("proper_24_thursday", "Salmo 37:1-18", "Salmo 37:19-42", "Esdras 1:1-11", "Apocalipse 9:1-12", "Lucas 10:25-37")
create_daily_reading.call("proper_24_friday", "Salmo 31", "Salmo 35", "Esdras 3:1-13", "Apocalipse 9:13-21", "Lucas 10:38-42")
create_daily_reading.call("proper_24_saturday", "Salmo 30, 32", "Salmo 42, 43", "Esdras 4:7, 11-24", "Apocalipse 10:1-11", "Lucas 11:1-13")

# ----------------------------------------------------------------------------
# PRÓPRIO 25 - PRÓXIMO A 26 DE OUTUBRO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_25_monday", "Salmo 41, 52", "Salmo 44", "Zacarias 1:7-17", "Apocalipse 11:1-14", "Lucas 11:14-26")
create_daily_reading.call("proper_25_tuesday", "Salmo 45", "Salmo 47, 48", "Esdras 5:1-17", "Apocalipse 11:14-19", "Lucas 11:27-36")

Rails.logger.info "✅ Leituras diárias do Tempo Comum (Parte 3 - Ano Ímpar) carregadas!"