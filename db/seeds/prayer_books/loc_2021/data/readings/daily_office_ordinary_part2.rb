# ================================================================================
# LEITURAS DIÁRIAS DO TEMPO COMUM (PARTE 2) - LOC 2021 IAB (ANO ÍMPAR / C)
# ================================================================================

Rails.logger.info "📖 Carregando leituras diárias do Tempo Comum (Parte 2) (LOC 2021 IAB)..."

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
# PRÓPRIO 12 - PRÓXIMO A 27 DE JULHO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_12_monday", "Salmo 56, 57, [58]", "Salmo 64, 65", "2 Samuel 2:1-11", "Atos 15:36-16:5", "Marcos 6:14-29")
create_daily_reading.call("proper_12_tuesday", "Salmo 61, 62", "Salmo 68:1-20(21-23)24-36", "2 Samuel 3:6-21", "Atos 16:6-15", "Marcos 6:30-46")
create_daily_reading.call("proper_12_wednesday", "Salmo 72", "Salmo 119:73-96", "2 Samuel 3:22-39", "Atos 16:16-24", "Marcos 6:47-56")
create_daily_reading.call("proper_12_thursday", "Salmo [70], 71", "Salmo 74", "2 Samuel 4:1-12", "Atos 16:25-40", "Marcos 7:1-23")
create_daily_reading.call("proper_12_friday", "Salmo 69:1-23[24-30]31-38", "Salmo 73", "2 Samuel 5:1-12", "Atos 17:1-15", "Marcos 7:24-37")
create_daily_reading.call("proper_12_saturday", "Salmo 75, 76", "Salmo 23, 27", "2 Samuel 5:22-6:11", "Atos 17:16-34", "Marcos 8:1-10")

# ----------------------------------------------------------------------------
# PRÓPRIO 13 - PRÓXIMO A 3 DE AGOSTO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_13_monday", "Salmo 80", "Salmo 77, [79]", "2 Samuel 7:1-17", "Atos 18:1-11", "Marcos 8:11-21")
create_daily_reading.call("proper_13_tuesday", "Salmo 78:1-39", "Salmo 78:40-72", "2 Samuel 7:18-29", "Atos 18:12-28", "Marcos 8:22-33")
create_daily_reading.call("proper_13_wednesday", "Salmo 119:97-120", "Salmo 81, 82", "2 Samuel 9:1-13", "Atos 19:1-10", "Marcos 8:34-9:1")
create_daily_reading.call("proper_13_thursday", "Salmo [83] ou 145", "Salmo 85, 86", "2 Samuel 11:1-27", "Atos 19:11-20", "Marcos 9:2-13")
create_daily_reading.call("proper_13_friday", "Salmo 88", "Salmo 91, 92", "2 Samuel 12:1-14", "Atos 19:21-41", "Marcos 9:14-29")
create_daily_reading.call("proper_13_saturday", "Salmo 87, 90", "Salmo 136", "2 Samuel 12:15-31", "Atos 20:1-16", "Marcos 9:30-41")

# ----------------------------------------------------------------------------
# PRÓPRIO 14 - PRÓXIMO A 10 DE AGOSTO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_14_monday", "Salmo 89:1-18", "Salmo 89:19-52", "2 Samuel 13:23-39", "Atos 20:17-38", "Marcos 9:42-50")
create_daily_reading.call("proper_14_tuesday", "Salmo 97, 99, [100]", "Salmo 94, [95]", "2 Samuel 14:1-20", "Atos 21:1-14", "Marcos 10:1-16")
create_daily_reading.call("proper_14_wednesday", "Salmo 101, 109:1-4(5-19)20-30", "Salmo 119:121-144", "2 Samuel 14:21-33", "Atos 21:15-26", "Marcos 10:17-31")
create_daily_reading.call("proper_14_thursday", "Salmo 105:1-22", "Salmo 105:23-45", "2 Samuel 15:1-18", "Atos 21:27-36", "Marcos 10:32-45")
create_daily_reading.call("proper_14_friday", "Salmo 102", "Salmo 107:1-32", "2 Samuel 15:19-37", "Atos 21:37-22:16", "Marcos 10:46-52")
create_daily_reading.call("proper_14_saturday", "Salmo 107:33-43, 108:1-6(7-13)", "Salmo 33", "2 Samuel 16:1-23", "Atos 22:17-29", "Marcos 11:1-11")

# ----------------------------------------------------------------------------
# PRÓPRIO 15 - PRÓXIMO A 17 DE AGOSTO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_15_monday", "Salmo 106:1-18", "Salmo 106:19-48", "2 Samuel 17:24-18:8", "Atos 22:30-23:11", "Marcos 11:12-26")
create_daily_reading.call("proper_15_tuesday", "Salmo [120], 121, 122, 123", "Salmo 124, 125, 126, [127]", "2 Samuel 18:9-18", "Atos 23:12-24", "Marcos 11:27-33")
create_daily_reading.call("proper_15_wednesday", "Salmo 119:145-176", "Salmo 128, 129, 130", "2 Samuel 18:19-33", "Atos 23:23-35", "Marcos 12:13-27")
create_daily_reading.call("proper_15_thursday", "Salmo 131, 132, [133]", "Salmo 134, 135", "2 Samuel 19:1-23", "Atos 24:1-23", "Marcos 12:28-34")
create_daily_reading.call("proper_15_friday", "Salmo 140, 142", "Salmo 141, 143:1-11(12)", "2 Samuel 19:24-43", "Atos 24:24-25:12", "Marcos 12:35-44")
create_daily_reading.call("proper_15_saturday", "Salmo 137:1-6(7-9), 144", "Salmo 104", "2 Samuel 23:1-17", "Atos 25:13-27", "Marcos 13:1-13")

# ----------------------------------------------------------------------------
# PRÓPRIO 16 - PRÓXIMO A 24 DE AGOSTO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_16_monday", "Salmo 1, 2, 3", "Salmo 4, 7", "1 Reis 1:5-31", "Atos 26:1-23", "Marcos 13:14-27")
create_daily_reading.call("proper_16_tuesday", "Salmo 5, 6", "Salmo 10, 11", "1 Reis 1:38-2:4", "Atos 26:24-27:8", "Marcos 13:28-37")
create_daily_reading.call("proper_16_wednesday", "Salmo 119:1-24", "Salmo 12, 13, 14", "1 Reis 3:1-15", "Atos 27:9-26", "Marcos 14:1-11")
create_daily_reading.call("proper_16_thursday", "Salmo 18:1-20", "Salmo 18:21-50", "1 Reis 3:16-28", "Atos 27:27-44", "Marcos 14:12-26")
create_daily_reading.call("proper_16_friday", "Salmo 16, 17", "Salmo 22", "1 Reis 5:1-6:1", "Atos 28:1-16", "Marcos 14:27-42")
create_daily_reading.call("proper_16_saturday", "Salmo 20, 21:1-7(8-14)", "Salmo 110:1-5(6-7), 116, 117", "1 Reis 7:51-8:21", "Atos 28:17-31", "Marcos 14:43-52")

# ----------------------------------------------------------------------------
# PRÓPRIO 17 - PRÓXIMO A 31 DE AGOSTO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_17_monday", "Salmo 25", "Salmo 9, 15", "1 Reis 8:1-21", "Atos 11:19-30", "João 8:21-32")
create_daily_reading.call("proper_17_tuesday", "Salmo 26, 28", "Salmo 36, 39", "1 Reis 8:22-30, 41-43", "Atos 12:1-17", "João 8:33-47")
create_daily_reading.call("proper_17_wednesday", "Salmo 38", "Salmo 119:25-48", "1 Reis 8:54-65", "Atos 12:18-25", "João 8:47-59")
create_daily_reading.call("proper_17_thursday", "Salmo 37:1-18", "Salmo 37:19-42", "1 Reis 11:1-13", "Atos 13:1-12", "João 9:1-17")
create_daily_reading.call("proper_17_friday", "Salmo 31", "Salmo 35", "1 Reis 11:26-43", "Atos 13:13-25", "João 9:18-41")
create_daily_reading.call("proper_17_saturday", "Salmo 30, 32", "Salmo 42, 43", "1 Reis 12:1-20", "Atos 13:26-43", "João 10:1-18")

# ----------------------------------------------------------------------------
# PRÓPRIO 18 - PRÓXIMO A 7 DE SETEMBRO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_18_monday", "Salmo 41, 52", "Salmo 44", "1 Reis 13:1-10", "Atos 13:44-52", "João 10:19-30")
create_daily_reading.call("proper_18_tuesday", "Salmo 45", "Salmo 47, 48", "1 Reis 16:23-34", "Atos 14:1-18", "João 10:31-42")
create_daily_reading.call("proper_18_wednesday", "Salmo 119:49-72", "Salmo 49, [53]", "1 Reis 17:1-24", "Atos 14:19-28", "João 11:1-16")
create_daily_reading.call("proper_18_thursday", "Salmo 50", "Salmo [59, 60] ou 93, 96", "1 Reis 18:1-19", "Atos 15:1-11", "João 11:17-29")
create_daily_reading.call("proper_18_friday", "Salmo 40, 54", "Salmo 51", "1 Reis 18:20-40", "Atos 15:12-21", "João 11:30-44")
create_daily_reading.call("proper_18_saturday", "Salmo 55", "Salmo 138, 139:1-17(18-23)", "1 Reis 18:41-19:8", "Atos 15:22-35", "João 11:45-54")

Rails.logger.info "✅ Leituras diárias do Tempo Comum (Parte 2 - Ano Ímpar) carregadas!"
