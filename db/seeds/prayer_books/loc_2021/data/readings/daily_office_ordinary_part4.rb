# ================================================================================
# LEITURAS DIÁRIAS DO TEMPO COMUM (PARTE 4) - LOC 2021 IAB (ANO ÍMPAR / C)
# ================================================================================

Rails.logger.info "📖 Carregando leituras diárias do Tempo Comum (Parte 4) (LOC 2021 IAB)..."

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
# PRÓPRIO 25 (Continuação) - PRÓXIMO A 26 DE OUTUBRO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_25_wednesday", "Salmo 119:49-72", "Salmo 49, [53]", "Neemias 1:1-11", "Apocalipse 12:1-6", "Lucas 11:37-52")
create_daily_reading.call("proper_25_thursday", "Salmo 50", "Salmo [59, 60] ou 103", "Provérbios 23:29-35", "Apocalipse 12:7-17", "Lucas 11:53-12:12")
create_daily_reading.call("proper_25_friday", "Salmo 40, 54", "Salmo 51", "Neemias 2:1-20", "Apocalipse 13:1-10", "Lucas 12:13-31")
create_daily_reading.call("proper_25_saturday", "Salmo 55", "Salmo 138, 139:1-17(18-23)", "Neemias 4:1-23", "Apocalipse 13:11-18", "Lucas 12:32-48")

# ----------------------------------------------------------------------------
# PRÓPRIO 26 - PRÓXIMO A 2 DE NOVEMBRO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_26_monday", "Salmo 56, 57, [58]", "Salmo 64, 65", "Neemias 6:1-19", "Apocalipse 14:1-13", "Lucas 12:49-59")
create_daily_reading.call("proper_26_tuesday", "Salmo 61, 62", "Salmo 68:1-20(21-23)24-36", "Neemias 12:27-31a, 42b-47", "Apocalipse 14:14-15:8", "Lucas 13:1-9")
create_daily_reading.call("proper_26_wednesday", "Salmo 72", "Salmo 119:73-96", "Neemias 13:4-22", "Apocalipse 16:1-11", "Lucas 13:10-17")
create_daily_reading.call("proper_26_thursday", "Salmo [70], 71", "Salmo 74", "Esdras 7:(1-10)11-26", "Apocalipse 16:12-21", "Lucas 14:18-30")
create_daily_reading.call("proper_26_friday", "Salmo 69:1-23[24-30]31-38", "Salmo 73", "Esdras 7:27-28, 8:21-36", "Apocalipse 17:1-18", "Lucas 13:31-35")
create_daily_reading.call("proper_26_saturday", "Salmo 75, 76", "Salmo 23, 27", "Esdras 9:1-15", "Apocalipse 18:1-14", "Lucas 14:1-11")

# ----------------------------------------------------------------------------
# PRÓPRIO 27 - PRÓXIMO A 9 DE NOVEMBRO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_27_monday", "Salmo 80", "Salmo 77, [79]", "Neemias 9:1-15(16-25)", "Apocalipse 18:15-24", "Lucas 14:12-24")
create_daily_reading.call("proper_27_tuesday", "Salmo 78:1-39", "Salmo 78:40-72", "Neemias 9:26-38", "Apocalipse 19:1-10", "Lucas 14:25-35")
create_daily_reading.call("proper_27_wednesday", "Salmo 119:97-120", "Salmo 81, 82", "Neemias 7:73b-8:3, 5-18", "Apocalipse 19:11-21", "Lucas 15:1-10")
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

Rails.logger.info "✅ Leituras diárias do Tempo Comum (Parte 4 - Ano Ímpar) carregadas!"