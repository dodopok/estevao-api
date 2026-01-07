# ================================================================================
# LEITURAS DIÁRIAS DO TEMPO COMUM (PARTE 2) - LOC 2021 IAB (ANO PAR / A-B)
# ================================================================================

Rails.logger.info "📖 Carregando leituras diárias do Tempo Comum (Parte 2 - Ano Par) (LOC 2021 IAB)..."

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
# PRÓPRIO 13 - PRÓXIMO A 3 DE AGOSTO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_13_monday", "Salmo 80", "Salmo 77, [79]", "Juízes 6:25-40", "Atos 2:37-47", "João 1:1-18")
create_daily_reading.call("proper_13_tuesday", "Salmo 78:1-39", "Salmo 78:40-72", "Juízes 7:1-18", "Atos 3:1-11", "João 1:19-28")
create_daily_reading.call("proper_13_wednesday", "Salmo 119:97-120", "Salmo 81, 82", "Juízes 7:19-8:12", "Atos 3:12-26", "João 1:29-42")
create_daily_reading.call("proper_13_thursday", "Salmo [83] ou 145", "Salmo 85, 86", "Juízes 8:22-35", "Atos 4:1-12", "João 1:43-51")
create_daily_reading.call("proper_13_friday", "Salmo 88", "Salmo 91, 92", "Juízes 9:1-16, 19-21", "Atos 4:13-31", "João 2:1-12")
create_daily_reading.call("proper_13_saturday", "Salmo 87, 90", "Salmo 136", "Juízes 9:22-25, 50-57", "Atos 4:32-5:11", "João 2:13-25")

# ----------------------------------------------------------------------------
# PRÓPRIO 14 - PRÓXIMO A 10 DE AGOSTO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_14_monday", "Salmo 89:1-18", "Salmo 89:19-52", "Juízes 12:1-7", "Atos 5:12-26", "João 3:1-21")
create_daily_reading.call("proper_14_tuesday", "Salmo 97, 99, [100]", "Salmo 94, [95]", "Juízes 13:1-15", "Atos 5:27-42", "João 3:22-36")
create_daily_reading.call("proper_14_wednesday", "Salmo 101, 109:1-4(5-19)20-30", "Salmo 119:121-144", "Juízes 13:15-24", "Atos 6:1-15", "João 4:1-26")
create_daily_reading.call("proper_14_thursday", "Salmo 105:1-22", "Salmo 105:23-45", "Juízes 14:1-19", "Atos 6:15-7:16", "João 4:27-42")
create_daily_reading.call("proper_14_friday", "Salmo 102", "Salmo 107:1-32", "Juízes 14:20-15:20", "Atos 7:17-29", "João 4:43-54")
create_daily_reading.call("proper_14_saturday", "Salmo 107:33-43, 108:1-6(7-13)", "Salmo 33", "Juízes 16:1-14", "Atos 7:30-43", "João 5:1-18")

# ----------------------------------------------------------------------------
# PRÓPRIO 15 - PRÓXIMO A 17 DE AGOSTO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_15_monday", "Salmo 106:1-18", "Salmo 106:19-48", "Juízes 17:1-13", "Atos 7:44-8:1a", "João 5:19-29")
create_daily_reading.call("proper_15_tuesday", "Salmo [120], 121, 122, 123", "Salmo 124, 125, 126, [127]", "Juízes 18:1-15", "Atos 8:1-13", "João 5:30-47")
create_daily_reading.call("proper_15_wednesday", "Salmo 119:145-176", "Salmo 128, 129, 130", "Juízes 18:16-31", "Atos 8:14-25", "João 6:1-15")
create_daily_reading.call("proper_15_thursday", "Salmo 131, 132, [133]", "Salmo 134, 135", "Jó 1:1-22", "Atos 8:26-40", "João 6:16-27")
create_daily_reading.call("proper_15_friday", "Salmo 140, 142", "Salmo 141, 143:1-11(12)", "Jó 2:1-13", "Atos 9:1-9", "João 6:27-40")
create_daily_reading.call("proper_15_saturday", "Salmo 137:1-6(7-9), 144", "Salmo 104", "Jó 3:1-26", "Atos 9:10-19a", "João 6:41-51")

# ----------------------------------------------------------------------------
# PRÓPRIO 16 - PRÓXIMO A 24 DE AGOSTO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_16_monday", "Salmo 1, 2, 3", "Salmo 4, 7", "Jó 4:1, 5:1-11, 17-21, 26-27", "Atos 9:19b-31", "João 6:52-59")
create_daily_reading.call("proper_16_tuesday", "Salmo 5, 6", "Salmo 10, 11", "Jó 6:1-4, 8-15, 21", "Atos 9:32-43", "João 6:60-71")
create_daily_reading.call("proper_16_wednesday", "Salmo 119:1-24", "Salmo 12, 13, 14", "Jó 6:1, 7:1-21", "Atos 10:1-16", "João 7:1-13")
create_daily_reading.call("proper_16_thursday", "Salmo 18:1-20", "Salmo 18:21-50", "Jó 8:1-10, 20-22", "Atos 10:17-33", "João 7:14-36")
create_daily_reading.call("proper_16_friday", "Salmo 16, 17", "Salmo 22", "Jó 9:1-15, 32-35", "Atos 10:34-48", "João 7:37-52")
create_daily_reading.call("proper_16_saturday", "Salmo 20, 21:1-7(8-14)", "Salmo 110:1-5(6-7), 116, 117", "Jó 9:1, 10:1-9, 16-22", "Atos 11:1-18", "João 8:12-20")

# ----------------------------------------------------------------------------
# PRÓPRIO 17 - PRÓXIMO A 31 DE AGOSTO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_17_monday", "Salmo 25", "Salmo 9, 15", "Jó 12:1-6, 13-25", "Atos 11:19-30", "João 8:21-32")
create_daily_reading.call("proper_17_tuesday", "Salmo 26, 28", "Salmo 36, 39", "Jó 12:1, 13:3-17, 21-27", "Atos 12:1-17", "João 8:33-47")
create_daily_reading.call("proper_17_wednesday", "Salmo 38", "Salmo 119:25-48", "Jó 12:1, 14:1-22", "Atos 12:18-25", "João 8:47-59")
create_daily_reading.call("proper_17_thursday", "Salmo 37:1-18", "Salmo 37:19-42", "Jó 16:16-22, 17:1, 13-16", "Atos 13:1-12", "João 9:1-17")
create_daily_reading.call("proper_17_friday", "Salmo 31", "Salmo 35", "Jó 19:1-7, 14-27", "Atos 13:13-25", "João 9:18-41")
create_daily_reading.call("proper_17_saturday", "Salmo 30, 32", "Salmo 42, 43", "Jó 22:1-4, 21--23:7", "Atos 13:26-43", "João 10:1-18")

# ----------------------------------------------------------------------------
# PRÓPRIO 18 - PRÓXIMO A 7 DE SETEMBRO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_18_monday", "Salmo 41, 52", "Salmo 44", "Jó 32:1-10, 19--33:1, 19-28", "Atos 13:44-52", "João 10:19-30")
create_daily_reading.call("proper_18_tuesday", "Salmo 45", "Salmo 47, 48", "Jó 29:1-20", "Atos 14:1-18", "João 10:31-42")
create_daily_reading.call("proper_18_wednesday", "Salmo 119:49-72", "Salmo 49, [53]", "Jó 29:1, 30:1-2, 16-31", "Atos 14:19-28", "João 11:1-16")
create_daily_reading.call("proper_18_thursday", "Salmo 50", "Salmo [59, 60] ou 93, 96", "Jó 29:1, 31:1-23", "Atos 15:1-11", "João 11:17-29")
create_daily_reading.call("proper_18_friday", "Salmo 40, 54", "Salmo 51", "Jó 29:1, 31:24-40", "Atos 15:12-21", "João 11:30-44")
create_daily_reading.call("proper_18_saturday", "Salmo 55", "Salmo 138, 139:1-17(18-23)", "Jó 38:1-17", "Atos 15:22-35", "João 11:45-54")

# ----------------------------------------------------------------------------
# PRÓPRIO 19 - PRÓXIMO A 14 DE SETEMBRO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_19_monday", "Salmo 56, 57, [58]", "Salmo 64, 65", "Jó 40:1-24", "Atos 15:36-16:5", "João 11:55-12:8")
create_daily_reading.call("proper_19_tuesday", "Salmo 61, 62", "Salmo 68:1-20(21-23)24-36", "Jó 40:1, 41:1-11", "Atos 16:6-15", "João 12:9-19")
create_daily_reading.call("proper_19_wednesday", "Salmo 72", "Salmo 119:73-96", "Jó 42:1-17", "Atos 16:16-24", "João 12:20-26")
create_daily_reading.call("proper_19_thursday", "Salmo [70], 71", "Salmo 74", "Jó 28:1-28", "Atos 16:25-40", "João 12:27-36a")
create_daily_reading.call("proper_19_friday", "Salmo 69:1-23[24-30]31-38", "Salmo 73", "Ester 1:1-4, 10-19", "Atos 17:1-15", "João 12:36b-43")
create_daily_reading.call("proper_19_saturday", "Salmo 75, 76", "Salmo 23, 27", "Ester 2:5-8, 15-23", "Atos 17:16-34", "João 12:44-50")

# ----------------------------------------------------------------------------
# PRÓPRIO 20 - PRÓXIMO A 21 DE SETEMBRO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_20_monday", "Salmo 80", "Salmo 77, [79]", "Ester 4:4-17", "Atos 18:1-11", "Lucas 1:(1-4), 3:1-14")
create_daily_reading.call("proper_20_tuesday", "Salmo 78:1-39", "Salmo 78:40-72", "Ester 5:1-14", "Atos 18:12-28", "Lucas 3:15-22")
create_daily_reading.call("proper_20_wednesday", "Salmo 119:97-120", "Salmo 81, 82", "Ester 6:1-14", "Atos 19:1-10", "Lucas 4:1-13")
create_daily_reading.call("proper_20_thursday", "Salmo [83] ou 146, 147", "Salmo 85, 86", "Ester 7:1-10", "Atos 19:11-20", "Lucas 4:14-30")
create_daily_reading.call("proper_20_friday", "Salmo 88", "Salmo 91, 92", "Ester 8:1-8, 15-17", "Atos 19:21-41", "Lucas 4:31-37")
create_daily_reading.call("proper_20_saturday", "Salmo 87, 90", "Salmo 136", "Oséias 1:1-2:1", "Atos 20:1-16", "Lucas 4:38-44")

# ----------------------------------------------------------------------------
# PRÓPRIO 21 - PRÓXIMO A 28 DE SETEMBRO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_21_monday", "Salmo 89:1-18", "Salmo 89:19-52", "Oséias 2:14-23", "Atos 20:17-38", "Lucas 5:1-11")
create_daily_reading.call("proper_21_tuesday", "Salmo 97, 99, [100]", "Salmo 94, [95]", "Oséias 4:1-10", "Atos 21:1-14", "Lucas 5:12-26")
create_daily_reading.call("proper_21_wednesday", "Salmo 101, 109:1-4(5-19)20-30", "Salmo 119:121-144", "Oséias 4:11-19", "Atos 21:15-26", "Lucas 5:27-39")
create_daily_reading.call("proper_21_thursday", "Salmo 105:1-22", "Salmo 105:23-45", "Oséias 5:8-6:6", "Atos 21:27-36", "Lucas 6:1-11")
create_daily_reading.call("proper_21_friday", "Salmo 102", "Salmo 107:1-32", "Oséias 10:1-15", "Atos 21:37-22:16", "Lucas 6:12-26")
create_daily_reading.call("proper_21_saturday", "Salmo 107:33-43, 108:1-6(7-13)", "Salmo 33", "Oséias 11:1-9", "Atos 22:17-29", "Lucas 6:27-38")

# ----------------------------------------------------------------------------
# PRÓPRIO 22 - PRÓXIMO A 5 DE OUTUBRO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_22_monday", "Salmo 106:1-18", "Salmo 106:19-48", "Oséias 14:1-9", "Atos 22:30-23:11", "Lucas 6:39-49")
create_daily_reading.call("proper_22_tuesday", "Salmo [120], 121, 122, 123", "Salmo 124, 125, 126, [127]", "Miqueias 1:1-9", "Atos 23:12-24", "Lucas 7:1-17")
create_daily_reading.call("proper_22_wednesday", "Salmo 119:145-176", "Salmo 128, 129, 130", "Miqueias 2:1-13", "Atos 23:23-35", "Lucas 7:18-35")
create_daily_reading.call("proper_22_thursday", "Salmo 131, 132, [133]", "Salmo 134, 135", "Miqueias 3:1-8", "Atos 24:1-23", "Lucas 7:36-50")
create_daily_reading.call("proper_22_friday", "Salmo 140, 142", "Salmo 141, 143:1-11(12)", "Miqueias 3:9-4:5", "Atos 24:24-25:12", "Lucas 8:1-15")
create_daily_reading.call("proper_22_saturday", "Salmo 137:1-6(7-9), 144", "Salmo 104", "Miqueias 5:1-4, 10-15", "Atos 25:13-27", "Lucas 8:16-25")

# ----------------------------------------------------------------------------
# PRÓPRIO 23 - PRÓXIMO A 12 DE OUTUBRO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_23_monday", "Salmo 1, 2, 3", "Salmo 4, 7", "Miqueias 7:1-7", "Atos 26:1-23", "Lucas 8:26-39")
create_daily_reading.call("proper_23_tuesday", "Salmo 5, 6", "Salmo 10, 11", "Jonas 1:1-17a", "Atos 26:24--27:8", "Lucas 8:40-56")
create_daily_reading.call("proper_23_wednesday", "Salmo 119:1-24", "Salmo 12, 13, 14", "Jonas 1:17-2:10", "Atos 27:9-26", "Lucas 9:1-17")
create_daily_reading.call("proper_23_thursday", "Salmo 18:1-20", "Salmo 18:21-50", "Jonas 3:1-4:11", "Atos 27:27-44", "Lucas 9:18-27")
create_daily_reading.call("proper_23_friday", "Salmo 16, 17", "Salmo 22", "Provérbios 15:1-11", "Atos 28:1-16", "Lucas 9:28-36")
create_daily_reading.call("proper_23_saturday", "Salmo 20, 21:1-7(8-14)", "Salmo 110:1-5(6-7), 116, 117", "Provérbios 13:7-12", "Atos 28:17-31", "Lucas 9:37-50")

# ----------------------------------------------------------------------------
# PRÓPRIO 24 - PRÓXIMO A 19 DE OUTUBRO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_24_monday", "Salmo 25", "Salmo 9, 15", "Provérbios 14:24-27", "Apocalipse 7:1-8", "Lucas 9:51-62")
create_daily_reading.call("proper_24_tuesday", "Salmo 26, 28", "Salmo 36, 39", "Provérbios 10:11-21", "Apocalipse 7:9-17", "Lucas 10:1-16")
create_daily_reading.call("proper_24_wednesday", "Salmo 38", "Salmo 119:25-48", "Provérbios 10:1-10", "Apocalipse 8:1-13", "Lucas 10:17-24")
create_daily_reading.call("proper_24_thursday", "Salmo 37:1-18", "Salmo 37:19-42", "Provérbios 14:28-35", "Apocalipse 9:1-12", "Lucas 10:25-37")
create_daily_reading.call("proper_24_friday", "Salmo 31", "Salmo 35", "Provérbios 16:20-24", "Apocalipse 9:13-21", "Lucas 10:38-42")
create_daily_reading.call("proper_24_saturday", "Salmo 30, 32", "Salmo 42, 43", "Provérbios 17:1-10", "Apocalipse 10:1-11", "Lucas 11:1-13")

# ----------------------------------------------------------------------------
# PRÓPRIO 25 - PRÓXIMO A 26 DE OUTUBRO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_25_monday", "Salmo 41, 52", "Salmo 44", "Provérbios 1:10-19", "Apocalipse 11:1-14", "Lucas 11:14-26")
create_daily_reading.call("proper_25_tuesday", "Salmo 45", "Salmo 47, 48", "Provérbios 1:20-33", "Apocalipse 11:14-19", "Lucas 11:27-36")
create_daily_reading.call("proper_25_wednesday", "Salmo 119:49-72", "Salmo 49, [53]", "Provérbios 4:20-27", "Apocalipse 12:1-6", "Lucas 11:37-52")
create_daily_reading.call("proper_25_thursday", "Salmo 50", "Salmo [59, 60] ou 103", "Provérbios 23:29-35", "Apocalipse 12:7-17", "Lucas 11:53-12:12")
create_daily_reading.call("proper_25_friday", "Salmo 40, 54", "Salmo 51", "Provérbios 16:1-9", "Apocalipse 13:1-10", "Lucas 12:13-31")
create_daily_reading.call("proper_25_saturday", "Salmo 55", "Salmo 138, 139:1-17(18-23)", "Provérbios 14:20-23", "Apocalipse 13:11-18", "Lucas 12:32-48")

# ----------------------------------------------------------------------------
# PRÓPRIO 26 - PRÓXIMO A 2 DE NOVEMBRO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_26_monday", "Salmo 56, 57, [58]", "Salmo 64, 65", "Provérbios 27:23-27", "Apocalipse 14:1-13", "Lucas 12:49-59")
create_daily_reading.call("proper_26_tuesday", "Salmo 61, 62", "Salmo 68:1-20(21-23)24-36", "Josué 3:1-7", "Apocalipse 14:14-15:8", "Lucas 13:1-9")
create_daily_reading.call("proper_26_wednesday", "Salmo 72", "Salmo 119:73-96", "2 Reis 4:1-7", "Apocalipse 16:1-11", "Lucas 13:10-17")
create_daily_reading.call("proper_26_thursday", "Salmo [70], 71", "Salmo 74", "2 Crônicas 6:3-10", "Apocalipse 16:12-21", "Lucas 14:18-30")
create_daily_reading.call("proper_26_friday", "Salmo 69:1-23[24-30]31-38", "Salmo 73", "Levítico 10:1-11", "Apocalipse 17:1-18", "Lucas 13:31-35")
create_daily_reading.call("proper_26_saturday", "Salmo 75, 76", "Salmo 23, 27", "2 Crônicas 6:12-21", "Apocalipse 18:1-14", "Lucas 14:1-11")

# ----------------------------------------------------------------------------
# PRÓPRIO 27 - PRÓXIMO A 9 DE NOVEMBRO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_27_monday", "Salmo 80", "Salmo 77, [79]", "Joel 1:1-13", "Apocalipse 18:15-24", "Lucas 14:12-24")
create_daily_reading.call("proper_27_tuesday", "Salmo 78:1-39", "Salmo 78:40-72", "Joel 2:21-27", "Apocalipse 19:1-10", "Lucas 14:25-35")
create_daily_reading.call("proper_27_wednesday", "Salmo 119:97-120", "Salmo 81, 82", "Joel 2:12-19", "Apocalipse 19:11-21", "Lucas 15:1-10")
create_daily_reading.call("proper_27_thursday", "Salmo [83], 23, 27", "Salmo 85, 86", "Joel 2:21-27", "Tiago 1:1-15", "Lucas 15:1-2, 11-32")
create_daily_reading.call("proper_27_friday", "Salmo 88", "Salmo 91, 92", "Joel 2:28-3:8", "Tiago 1:16-27", "Lucas 16:1-9")
create_daily_reading.call("proper_27_saturday", "Salmo 87, 90", "Salmo 136", "Joel 3:9-17", "Tiago 2:1-13", "Lucas 16:10-18(18)")

# ----------------------------------------------------------------------------
# PRÓPRIO 28 - PRÓXIMO A 16 DE NOVEMBRO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_28_monday", "Salmo 89:1-18", "Salmo 89:19-52", "Habacuque 2:1-4, 9-20", "Tiago 2:14-26", "Lucas 16:19-31")
create_daily_reading.call("proper_28_tuesday", "Salmo 97, 99, [100]", "Salmo 94, [95]", "Habacuque 3:1-10(11-15)16-18", "Tiago 3:1-12", "Lucas 17:1-10")
create_daily_reading.call("proper_28_wednesday", "Salmo 101, 109:1-4(5-19)20-30", "Salmo 119:121-144", "Malaquias 1:1, 6-14", "Tiago 3:13-4:12", "Lucas 17:11-19")
create_daily_reading.call("proper_28_thursday", "Salmo 105:1-22", "Salmo 105:23-45", "Malaquias 2:1-16", "Tiago 4:13-5:6", "Lucas 17:20-37")
create_daily_reading.call("proper_28_friday", "Salmo 102", "Salmo 107:1-32", "Malaquias 3:1-12", "Tiago 5:7-12", "Lucas 18:1-8")
create_daily_reading.call("proper_28_saturday", "Salmo 107:33-43, 108:1-6(7-13)", "Salmo 33", "Malaquias 3:13-4:6", "Tiago 5:13-20", "Lucas 18:9-14")

# ----------------------------------------------------------------------------
# PRÓPRIO 29 - PRÓXIMO A 23 DE NOVEMBRO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_29_monday", "Salmo 106:1-18", "Salmo 106:19-48", "Zacarias 10:1-12", "Gálatas 6:1-10", "Lucas 18:15-30")
create_daily_reading.call("proper_29_tuesday", "Salmo [120], 121, 122, 123", "Salmo 124, 125, 126, [127]", "Zacarias 11:4-17", "1 Coríntios 3:10-23", "Lucas 18:31-43")
create_daily_reading.call("proper_29_wednesday", "Salmo 119:145-176", "Salmo 128, 129, 130", "Zacarias 12:1-10", "Efésios 1:3-14", "Lucas 19:1-10")
create_daily_reading.call("proper_29_thursday", "Salmo 131, 132, [133]", "Salmo 134, 135", "Zacarias 13:1-9", "Efésios 1:15-23", "Lucas 19:11-27")
create_daily_reading.call("proper_29_friday", "Salmo 140, 142", "Salmo 141, 143:1-11(12)", "Zacarias 14:1-11", "Romanos 15:7-13", "Lucas 19:28-40")
create_daily_reading.call("proper_29_saturday", "Salmo 137:1-6(7-9), 144", "Salmo 104", "Zacarias 14:12-21", "Filipenses 2:1-11", "Lucas 19:41-48")

Rails.logger.info "✅ Leituras diárias do Tempo Comum (Parte 2 - Ano Par) carregadas!"
