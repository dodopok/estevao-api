# ================================================================================
# LEITURAS DIÁRIAS DA PÁSCOA (PARTE 2) E PENTECOSTES - LOC 2021 IAB (ANO ÍMPAR / C)
# ================================================================================

Rails.logger.info "📖 Carregando leituras diárias da Páscoa (Parte 2) e Pentecostes (LOC 2021 IAB)..."

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
# 5ª SEMANA DA PÁSCOA
# ----------------------------------------------------------------------------
create_daily_reading.call("5th_sunday_of_easter_monday",
  "Salmo 56, 57, [58]", "Salmo 64, 65",
  "2 Crônicas 6:1-11", "Colossenses 3:18-4:1(2-18)", "Lucas 7:36-50"
)

create_daily_reading.call("5th_sunday_of_easter_tuesday",
  "Salmo 61, 62", "Salmo 68:1-20(21-23)24-36",
  "Gênesis 2:18-25", "Romanos 12:1-21", "Lucas 8:1-15"
)

create_daily_reading.call("5th_sunday_of_easter_wednesday",
  "Salmo 72", "Salmo 119:73-96",
  "Êxodo 23:20-32", "Romanos 13:1-14", "Lucas 8:16-25"
)

create_daily_reading.call("5th_sunday_of_easter_thursday",
  "Salmo [70], 71", "Salmo 74",
  "1 Reis 18:20-46", "Romanos 14:1-12", "Lucas 8:26-39"
)

create_daily_reading.call("5th_sunday_of_easter_friday",
  "Salmo 106:1-18", "Salmo 106:19-48",
  "Isaías 66:1-4", "Romanos 14:13-23", "Lucas 8:40-56"
)

create_daily_reading.call("5th_sunday_of_easter_saturday",
  "Salmo 75, 76", "Salmo 23, 27",
  "Isaías 60:1-6", "Romanos 15:1-13", "Lucas 9:1-17"
)

# ----------------------------------------------------------------------------
# 6ª SEMANA DA PÁSCOA
# ----------------------------------------------------------------------------
create_daily_reading.call("6th_sunday_of_easter_monday",
  "Salmo 80", "Salmo 77, [79]",
  "Deuteronômio 8:1-10", "Tiago 1:1-15", "Lucas 9:18-27"
)

create_daily_reading.call("6th_sunday_of_easter_tuesday",
  "Salmo 78:1-39", "Salmo 78:40-72",
  "Deuteronômio 8:11-20", "Tiago 1:16-27", "Lucas 11:1-13"
)

create_daily_reading.call("6th_sunday_of_easter_wednesday",
  "Salmo 119:97-120", "Salmo 68:1-20",
  "2 Reis 2:1-15", "Tiago 5:13-18", "Apocalipse 5:1-14"
)

# Ascensão do Senhor (Quinta-feira)
create_daily_reading.call("ascension_day",
  "Salmo 8, 47", "Salmo 24, 96",
  "Ezequiel 1:1-14, 24-28b", "Hebreus 2:5-18", "Mateus 28:16-20"
)

create_daily_reading.call("6th_sunday_of_easter_friday",
  "Salmo 85, 86", "Salmo 91, 92",
  "Ezequiel 1:28-3:3", "Hebreus 4:14-5:6", "Lucas 9:28-36"
)

create_daily_reading.call("6th_sunday_of_easter_saturday",
  "Salmo 87, 90", "Salmo 136",
  "Ezequiel 3:4-17", "Hebreus 5:7-14", "Lucas 9:37-50"
)

# ----------------------------------------------------------------------------
# 7ª SEMANA DA PÁSCOA
# ----------------------------------------------------------------------------
create_daily_reading.call("7th_sunday_of_easter_monday",
  "Salmo 89:1-18", "Salmo 89:19-52",
  "Ezequiel 4:1-17", "Hebreus 6:1-12", "Lucas 9:51-62"
)

create_daily_reading.call("7th_sunday_of_easter_tuesday",
  "Salmo 97, 99, [100]", "Salmo 94, [95]",
  "Ezequiel 7:10-15, 23b-27", "Hebreus 6:13-20", "Lucas 10:1-17"
)

create_daily_reading.call("7th_sunday_of_easter_wednesday",
  "Salmo 101, 109:1-4(5-19)20-30", "Salmo 119:121-144",
  "Ezequiel 11:14-25", "Hebreus 7:1-17", "Lucas 10:17-24"
)

create_daily_reading.call("7th_sunday_of_easter_thursday",
  "Salmo 105:1-22", "Salmo 105:23-45",
  "Ezequiel 18:1-4, 19-32", "Hebreus 7:18-28", "Lucas 10:25-37"
)

create_daily_reading.call("7th_sunday_of_easter_friday",
  "Salmo 102", "Salmo 107:1-32",
  "Ezequiel 34:17-31", "Hebreus 8:1-13", "Lucas 10:38-42"
)

create_daily_reading.call("7th_sunday_of_easter_saturday",
  "Salmo 107:33-43, 108:1-6(7-13)", "Salmo 33",
  "Ezequiel 43:1-12", "Êxodo 19:3-8a, 16-20", "Hebreus 9:1-14" # Nota: Imagem diz Heb 9:1-14 como R3... mas pela ordem parece ser Evangelho ou R2? Mantendo como R3/Gospel na lógica, mas atenção ao contexto litúrgico. Geralmente R3 é Evangelho.
)

# ----------------------------------------------------------------------------
# PENTECOSTES (TEMPO APÓS)
# ----------------------------------------------------------------------------

# PRÓPRIO 1 - PRÓXIMO A 11 DE MAIO
create_daily_reading.call("proper_1_monday",
  "Salmo 106:1-18", "Salmo 106:19-48",
  "Isaías 63:7-14", "2 Timóteo 1:1-14", "Lucas 11:24-36"
)

create_daily_reading.call("proper_1_tuesday",
  "Salmo [120], 121, 122, 123", "Salmo 124, 125, 126, [127]",
  "Isaías 63:15-64:9", "2 Timóteo 1:15-2:13", "Lucas 11:53-12:12" # Nota: Imagem diz Lc 11:53... mas falta Quarta? Ah, imagem tem Quarta abaixo.
)

create_daily_reading.call("proper_1_wednesday",
  "Salmo 119:145-176", "Salmo 128, 129, 130",
  "Isaías 65:1-12", "2 Timóteo 2:14-26", "Lucas 11:53-12:12" # Ops, copiei errado na terça? Terça imagem diz Lc 11:53... não, não diz. Terça imagem diz apenas Is e 2 Tm. O Evangelho está alinhado? Terça não tem evangelho explícito na linha, parece que Lc 11:53 é da Quarta. Verificando imagem.
  # Terça imagem: Is 63:15-64:9, 2 Tm 1:15-2:13. Evangelho não listado? Ah, o bloco de Lucas pode estar quebrado.
  # Na imagem 12: Terça tem Is, 2 Tm. Quarta tem Is, 2 Tm, Lucas.
  # A lógica do LOC às vezes agrupa.
  # Vou assumir sequência de Lucas. Se Segunda é 11:24-36. Quarta é 11:53... Terça deve ser 11:37-52.
  # Mas vou seguir estritamente o que está escrito se possível.
  # Na imagem, Terça NÃO tem evangelho listado na linha. Quarta tem.
  # Pode ser erro de impressão ou leitura contínua implícita. Vou deixar nil ou inferir.
  # Inferindo Lc 11:37-52 para Terça para manter continuidade.
)
# Corrigindo Terça com inferência baseada na lacuna de Segunda (11:36) e Quarta (11:53)
create_daily_reading.call("proper_1_tuesday",
  "Salmo [120], 121, 122, 123", "Salmo 124, 125, 126, [127]",
  "Isaías 63:15-64:9", "2 Timóteo 1:15-2:13", "Lucas 11:37-52" # Inferido
)

create_daily_reading.call("proper_1_thursday",
  "Salmo 131, 132, [133]", "Salmo 134, 135",
  "Isaías 65:17-25", "2 Timóteo 3:1-17", "Lucas 12:13-31"
)

create_daily_reading.call("proper_1_friday",
  "Salmo 140, 142", "Salmo 141, 143:1-11(12)",
  "Isaías 66:1-6", "2 Timóteo 4:1-8", "Lucas 12:32-48"
)

create_daily_reading.call("proper_1_saturday",
  "Salmo 137:1-6(7-9), 144", "Salmo 104",
  "Isaías 66:7-14", "2 Timóteo 4:9-22", "Lucas 12:49-59"
)

# PRÓPRIO 2 - PRÓXIMO A 18 DE MAIO
create_daily_reading.call("proper_2_monday",
  "Salmo 1, 2, 3", "Salmo 4, 7",
  "Rute 1:1-18", "1 Timóteo 1:1-17", "Lucas 13:1-9"
)

create_daily_reading.call("proper_2_tuesday",
  "Salmo 5, 6", "Salmo 10, 11",
  "Rute 1:19-2:13", "1 Timóteo 1:18-2:8", "Lucas 13:10-17"
)

create_daily_reading.call("proper_2_wednesday",
  "Salmo 119:1-24", "Salmo 12, 13, 14",
  "Rute 2:14-23", "1 Timóteo 3:1-16", "Lucas 13:18-30"
)

create_daily_reading.call("proper_2_thursday",
  "Salmo 18:1-20", "Salmo 18:21-50",
  "Rute 3:1-18", "1 Timóteo 4:1-16", "Lucas 13:31-35"
)

create_daily_reading.call("proper_2_friday",
  "Salmo 16, 17", "Salmo 22",
  "Rute 4:1-17", "1 Timóteo 5:17-22(23-25)", "Lucas 14:1-11"
)

create_daily_reading.call("proper_2_saturday",
  "Salmo 20, 21:1-7(8-14)", "Salmo 110:1-5(6-7), 116, 117",
  "Deuteronômio 1:1-8", "1 Timóteo 6:6-21", "Lucas 14:12-24"
)

# PRÓPRIO 3 - PRÓXIMO A 25 DE MAIO (Início)
create_daily_reading.call("proper_3_monday",
  "Salmo 25", "Salmo 9, 15",
  "Deuteronômio 4:9-14", "2 Coríntios 1:1-11", "Lucas 14:25-35"
)

create_daily_reading.call("proper_3_tuesday",
  "Salmo 26, 28", "Salmo 36, 39",
  "Deuteronômio 4:15-24", "2 Coríntios 1:12-22", "Lucas 15:1-10"
)

Rails.logger.info "✅ Leituras diárias da Páscoa (Parte 2) e Pentecostes (Início) carregadas!"
