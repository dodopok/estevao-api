# ================================================================================
# LEITURAS DIÁRIAS DA SEMANA SANTA E PÁSCOA - LOC 2021 IAB (ANO ÍMPAR / C)
# ================================================================================

Rails.logger.info "📖 Carregando leituras diárias da Semana Santa e Páscoa (LOC 2021 IAB)..."

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
# SEMANA DA PAIXÃO (Anterior à Semana Santa - Imagem 9)
# ----------------------------------------------------------------------------
create_daily_reading.call("5th_sunday_of_lent_thursday",
  "Salmo 131, 132, [133]", "Salmo 140, 142",
  "Jeremias 26:1-16", "Romanos 11:1-12", "João 10:19-42"
)

create_daily_reading.call("5th_sunday_of_lent_friday",
  "Salmo 95, 22", "Salmo 141, 143:1-11(12)",
  "Jeremias 29:1, 4-13", "Romanos 11:13-24", "João 11:1-27 ou 12:1-10"
)

create_daily_reading.call("5th_sunday_of_lent_saturday",
  "Salmo 137:1-6(7-9), 144", "Salmo 42, 43",
  "Jeremias 31:27-34", "Romanos 11:25-36", "João 11:28-44 ou 12:37-50"
)

# ----------------------------------------------------------------------------
# SEMANA SANTA
# ----------------------------------------------------------------------------
create_daily_reading.call("holy_week_monday",
  "Salmo 51:1-18(19-20)", "Salmo 69:1-23",
  "Jeremias 12:1-16", "Filipenses 3:1-14", "João 12:9-19"
)

create_daily_reading.call("holy_week_tuesday",
  "Salmo 6, 12", "Salmo 94",
  "Jeremias 15:10-21", "Filipenses 3:15-21", "João 12:20-26"
)

create_daily_reading.call("holy_week_wednesday",
  "Salmo 55, 12", "Salmo 74",
  "Jeremias 17:5-10, 14-17", "Filipenses 4:1-13", "João 12:27-26" # Nota: Provavelmente 12:27-36 ou 50. Verificando imagem: 12:27-26 parece erro de digitação no original ou leitura estranha. Assumindo João 12:27-50 pelo contexto ou mantendo literal. Imagem diz 12:27-26. Pode ser 12:27-36. Vou manter literal e adicionar nota.
)

create_daily_reading.call("holy_week_thursday",
  "Salmo 102", "Salmo 142, 143",
  "Jeremias 20:7-11", "1 Coríntios 10:14-17; 11:27-32", "João 17:1-11(12-26)"
)

create_daily_reading.call("holy_week_friday",
  "Salmo 95, 22", "Salmo 40:1-14(15-19), 54",
  "Gênesis 22:1-14", "1 Pedro 1:10-20", "João 13:36-38"
)

create_daily_reading.call("holy_week_saturday",
  "Salmo 95, 88", "Salmo 27",
  "Jó 19:21-27a", "Hebreus 4:1-16", "João 19:38-42"
)

# ----------------------------------------------------------------------------
# TEMPO DA PÁSCOA
# ----------------------------------------------------------------------------

# 1ª SEMANA DA PÁSCOA
create_daily_reading.call("1st_sunday_of_easter_monday",
  "Salmo 93, 98", "Salmo 66",
  "Jonas 2:1-9", "Atos 2:14, 22-32", "João 14:1-14"
)

create_daily_reading.call("1st_sunday_of_easter_tuesday",
  "Salmo 103", "Salmo 111, 114",
  "Isaías 30:18-21", "Atos 2:26-41(42-47)", "João 14:15-31"
)

create_daily_reading.call("1st_sunday_of_easter_wednesday",
  "Salmo 97, 99", "Salmo 115",
  "Miqueias 7:7-15", "Atos 3:1-10", "João 15:1-11"
)

create_daily_reading.call("1st_sunday_of_easter_thursday",
  "Salmo 146, 147", "Salmo 148, 149",
  "Ezequiel 37:1-14", "Atos 3:11-26", "João 15:12-27"
)

create_daily_reading.call("1st_sunday_of_easter_friday",
  "Salmo 136", "Salmo 118",
  "Daniel 12:1-4, 13", "Atos 4:1-12", "João 16:1-15"
)

create_daily_reading.call("1st_sunday_of_easter_saturday",
  "Salmo 145", "Salmo 104",
  "Isaías 25:1-9", "Atos 4:13-21(22-31)", "João 16:16-33"
)

# 2ª SEMANA DA PÁSCOA
create_daily_reading.call("2nd_sunday_of_easter_monday",
  "Salmo 1, 2, 3", "Salmo 4, 7",
  "Daniel 1:1-21", "1 João 1:1-10", "João 17:1-11"
)

create_daily_reading.call("2nd_sunday_of_easter_tuesday",
  "Salmo 5, 6", "Salmo 10, 11",
  "Daniel 2:1-16", "1 João 2:1-11", "João 17:12-19"
)

create_daily_reading.call("2nd_sunday_of_easter_wednesday",
  "Salmo 119:1-24", "Salmo 12, 13, 14",
  "Daniel 2:17-30", "1 João 2:12-17", "João 17:20-26"
)

create_daily_reading.call("2nd_sunday_of_easter_thursday",
  "Salmo 18:1-20", "Salmo 18:21-50",
  "Daniel 2:31-49", "1 João 2:18-29", "Lucas 3:1-14"
)

create_daily_reading.call("2nd_sunday_of_easter_friday",
  "Salmo 16, 17", "Salmo 134, 135",
  "Daniel 3:1-18", "1 João 3:1-10", "Lucas 3:15-22"
)

create_daily_reading.call("2nd_sunday_of_easter_saturday",
  "Salmo 20, 21:1-7(8-14)", "Salmo 110:1-5(6-7), 116, 117",
  "Daniel 3:19-30", "1 João 3:11-18", "Lucas 4:1-13"
)

# 3ª SEMANA DA PÁSCOA
create_daily_reading.call("3rd_sunday_of_easter_monday",
  "Salmo 25", "Salmo 9, 15",
  "Daniel 4:19-27", "1 João 3:19-4:6", "Lucas 4:14-30"
)

create_daily_reading.call("3rd_sunday_of_easter_tuesday",
  "Salmo 26, 28", "Salmo 36, 39",
  "Daniel 4:28-37", "1 João 4:7-21", "Lucas 4:31-37"
)

create_daily_reading.call("3rd_sunday_of_easter_wednesday",
  "Salmo 38", "Salmo 119:25-48",
  "Daniel 5:1-12", "1 João 5:1-12", "Lucas 4:38-44"
)

create_daily_reading.call("3rd_sunday_of_easter_thursday",
  "Salmo 37:1-18", "Salmo 37:19-42",
  "Daniel 5:13-30", "1 João 5:13-20(21)", "Lucas 5:1-11"
)

create_daily_reading.call("3rd_sunday_of_easter_friday",
  "Salmo 105:1-22", "Salmo 105:23-45",
  "Daniel 6:1-15", "2 João 1-13", "Lucas 5:12-26"
)

create_daily_reading.call("3rd_sunday_of_easter_saturday",
  "Salmo 30, 32", "Salmo 42, 43",
  "Daniel 6:16-28", "3 João 1:1-15", "Lucas 5:27-39"
)

# 4ª SEMANA DA PÁSCOA (Até Sábado - Imagem 10)
create_daily_reading.call("4th_sunday_of_easter_monday",
  "Salmo 41, 52", "Salmo 44",
  "Eclesiastes 12:1-8", "Colossenses 1:1-14", "Lucas 6:1-11"
)

create_daily_reading.call("4th_sunday_of_easter_tuesday",
  "Salmo 45", "Salmo 47, 48",
  "Gênesis 15:1-6", "Colossenses 1:15-23", "Lucas 6:12-26"
)

create_daily_reading.call("4th_sunday_of_easter_wednesday",
  "Salmo 119:49-72", "Salmo 49, [53]",
  "Deuteronômio 32:44-47", "Colossenses 1:24-2:7", "Lucas 6:27-38"
)

create_daily_reading.call("4th_sunday_of_easter_thursday",
  "Salmo 50", "Salmo [59, 60] ou 114, 115",
  "Provérbios 16:1-7", "Colossenses 2:8-23", "Lucas 6:39-49"
)

create_daily_reading.call("4th_sunday_of_easter_friday",
  "Salmo 40, 54", "Salmo 51",
  "Provérbios 1:1-7", "Colossenses 3:1-11", "Lucas 7:1-17"
)

create_daily_reading.call("4th_sunday_of_easter_saturday",
  "Salmo 55", "Salmo 138, 139:1-17(18-23)",
  "Eclesiastes 1:12-18", "Colossenses 3:12-17", "Lucas 7:18-28(29-30)31-35"
)

Rails.logger.info "✅ Leituras diárias da Semana Santa e Páscoa (Ano Ímpar) carregadas!"
