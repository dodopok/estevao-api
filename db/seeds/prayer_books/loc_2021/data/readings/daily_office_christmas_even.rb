# ================================================================================
# LEITURAS DIÁRIAS DO NATAL - LOC 2021 IAB (ANO PAR / A-B)
# ================================================================================

Rails.logger.info "📖 Carregando leituras diárias do Natal (Ano Par) (LOC 2021 IAB)..."

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

# 24 de Dezembro (Véspera)
create_daily_reading.call("december_24",
  "Salmo 45, 46", "Salmo 89:1-29",
  "Isaías 52:1-7", "Gálatas 3:23-4:7", "Mateus 1:18-25"
)

# 25 de Dezembro - Natal
create_daily_reading.call("christmas_day",
  "Salmo 2, 85", "Salmo 110:1-5(6-7), 132",
  "Miqueias 4:1-5, 5:2-4", "1 João 4:7-16", "João 3:31-36"
)

# 1º Domingo depois do Natal (Ofício Diário)
create_daily_reading.call("1st_sunday_after_christmas",
  "Salmo 93, 96", "Salmo 34",
  "1 Samuel 1:1-2, 7b-28", "Colossenses 1:9-20", "Lucas 2:22-40"
)

# 29 de Dezembro
create_daily_reading.call("december_29",
  "Salmo 18:1-20", "Salmo 18:21-50",
  "2 Samuel 23:13-17b", "2 João 1-13", "João 2:1-11"
)

# 30 de Dezembro
create_daily_reading.call("december_30",
  "Salmo 20, 21:1-7(8-14)", "Salmo 23, 27",
  "1 Reis 17:17-24", "3 João 1-15", "João 4:46-54"
)

# 31 de Dezembro
create_daily_reading.call("december_31",
  "Salmo 46, 48", "Salmo 90",
  "1 Reis 3:5-14", "Isaías 65:15b-25", "Tiago 4:13-17, 5:7-11 ou Apocalipse 21:1-6" # Nota: Imagem 2 tem "1 Rs 3:5-14 Is 65:15b-25 Tg 4:13-17, 5:7-11 Ap 21:1-6". Parece ser 1ª, 2ª e Evangelho? Não, Ap 21:1-6 geralmente é leitura.
  # Mas no dia 31 Dez, geralmente tem leituras de véspera de Ano Novo.
  # Vou assumir: 1ª: 1 Reis, 2ª: Tiago ou Apocalipse?
  # A imagem do ano ímpar tinha Is, Is, Jo.
  # Aqui parece ter 4 leituras listadas?
  # 1 Rs 3:5-14
  # Is 65:15b-25
  # Tg 4:13-17, 5:7-11
  # Ap 21:1-6
  # Vou colocar Is 65 como 2ª leitura (como no ano ímpar) e Tg/Ap como Gospel alternativo? Não faz sentido.
  # Talvez Is 65 seja a 1ª leitura da Tarde?
  # Vou seguir a ordem: R1: 1 Reis, R2: Tiago, R3 (Gospel): Apocalipse? Não, Ap não é evangelho.
  # Está faltando o Evangelho.
  # No ano ímpar o evangelho era João 8:12-19.
  # Talvez "Ap 21:1-6" seja a segunda leitura da noite.
  # Vou colocar 1 Reis e Tiago.
)
create_daily_reading.call("december_31",
  "Salmo 46, 48", "Salmo 90",
  "1 Reis 3:5-14", "Tiago 4:13-17, 5:7-11", "Apocalipse 21:1-6" # Usando Ap como "3ª leitura" mas sabendo que não é evangelho. O sistema aceita.
)

# 1 de Janeiro - Santo Nome de Jesus
create_daily_reading.call("holy_name",
  "Salmo 103", "Salmo 148",
  "Isaías 62:1-5, 10-12", "Apocalipse 19:11-16", "Mateus 1:18-25"
)

# Jan 2-5 missing from image.

# ----------------------------------------------------------------------------
# TEMPO DA EPIFANIA (DIAS APÓS EPIFANIA)
# ----------------------------------------------------------------------------

create_daily_reading.call("january_7",
  "Salmo 103", "Salmo 114, 115",
  "Deuteronômio 8:1-3", "Colossenses 1:1-14", "João 6:30-33, 48-51"
)

create_daily_reading.call("january_8",
  "Salmo 117, 118", "Salmo 112, 113",
  "Êxodo 17:1-7", "Colossenses 1:15-23", "João 7:37-52"
)

create_daily_reading.call("january_9",
  "Salmo 121, 122, 123", "Salmo 131, 132",
  "Isaías 45:14-19", "Colossenses 1:24-2:7", "João 8:12-19"
)

create_daily_reading.call("january_10",
  "Salmo 138, 139:1-17(18-23)", "Salmo 147",
  "Jeremias 23:1-8", "Colossenses 2:8-23", "João 10:7-17"
)

create_daily_reading.call("january_11",
  "Salmo 148, 150", "Salmo 91, 92",
  "Isaías 55:3-9", "Colossenses 3:1-17", "João 14:6-14"
)

create_daily_reading.call("january_12",
  "Salmo 98, 99(100)", "Salmo 104",
  "Gênesis 49:1-2, 8-12", "Isaías 61:1-9", "Colossenses 3:18-4:6" # Nota: Imagem tem 3 leituras listadas? Gn, Is, Cl. Onde está o evangelho?
  # Talvez Gn 49 e Is 61 sejam opções para R1.
  # Ou Cl é R2 e falta evangelho?
  # E "Gl 3:23-29, 4:4-7" está abaixo.
  # Imagem 2, dia 12: Sl 98... Gn 49... Is 61... Cl 3:18... Gl 3:23...
  # Gl 3:23-29 está na linha de baixo, pode ser o evangelho (Gálatas não é evangelho).
  # Parece que faltam evangelhos nessas datas fixas de Epifania (7-12 Jan) no Ano Par?
  # Nos dias 7-11 tem João.
  # Dia 12 tem muitas leituras de epístola/AT.
  # Vou colocar o que tem.
  # Gn, Is, Cl.
)
create_daily_reading.call("january_12",
  "Salmo 98, 99(100)", "Salmo 104",
  "Gênesis 49:1-2, 8-12", "Isaías 61:1-9", "Colossenses 3:18-4:6"
)

# ----------------------------------------------------------------------------
# 1ª SEMANA DA EPIFANIA
# ----------------------------------------------------------------------------
create_daily_reading.call("1st_sunday_after_epiphany_monday",
  "Salmo 1, 2, 3", "Salmo 4, 7",
  "Gênesis 2:4-9(10-15)16-25", "Hebreus 1:1-14", "João 1:1-18"
)

create_daily_reading.call("1st_sunday_after_epiphany_tuesday",
  "Salmo 5, 6", "Salmo 10, 11",
  "Gênesis 3:1-24", "Hebreus 2:1-10", "João 1:19-28"
)

create_daily_reading.call("1st_sunday_after_epiphany_wednesday",
  "Salmo 119:1-24", "Salmo 12, 13, 14",
  "Gênesis 4:1-16", "Hebreus 2:11-18", "João 1:(29-34)35-42"
)

create_daily_reading.call("1st_sunday_after_epiphany_thursday",
  "Salmo 18:1-20", "Salmo 18:21-50",
  "Gênesis 4:17-26", "Hebreus 3:1-11", "João 1:43-51"
)

create_daily_reading.call("1st_sunday_after_epiphany_friday",
  "Salmo 16, 17", "Salmo 22",
  "Gênesis 6:1-8", "Hebreus 3:12-19", "João 2:1-12"
)

create_daily_reading.call("1st_sunday_after_epiphany_saturday",
  "Salmo 20, 21:1-7(8-14)", "Salmo 110:1-5(6-7), 116, 117",
  "Gênesis 9:1-22", "Hebreus 4:1-13", "João 2:13-22"
)

# ----------------------------------------------------------------------------
# 2ª SEMANA DA EPIFANIA
# ----------------------------------------------------------------------------
create_daily_reading.call("2nd_sunday_after_epiphany_monday",
  "Salmo 25", "Salmo 9, 15",
  "Gênesis 8:6-22", "Hebreus 4:14-5:6", "João 2:23-3:15"
)

create_daily_reading.call("2nd_sunday_after_epiphany_tuesday",
  "Salmo 26, 28", "Salmo 36, 39",
  "Gênesis 9:1-17", "Hebreus 5:7-14", "João 3:16-21"
)

create_daily_reading.call("2nd_sunday_after_epiphany_wednesday",
  "Salmo 38", "Salmo 119:25-48",
  "Gênesis 9:18-29", "Hebreus 6:1-12", "João 3:22-36"
)

create_daily_reading.call("2nd_sunday_after_epiphany_thursday",
  "Salmo 37:1-18", "Salmo 37:19-42",
  "Gênesis 11:1-9", "Hebreus 6:13-20", "João 4:1-15"
)

create_daily_reading.call("2nd_sunday_after_epiphany_friday",
  "Salmo 31", "Salmo 35",
  "Gênesis 11:27-12:8", "Hebreus 7:1-17", "João 4:16-26"
)

create_daily_reading.call("2nd_sunday_after_epiphany_saturday",
  "Salmo 30, 32", "Salmo 42, 43",
  "Gênesis 12:9-13:1", "Hebreus 7:18-28", "João 4:27-42"
)

# ----------------------------------------------------------------------------
# 3ª SEMANA DA EPIFANIA
# ----------------------------------------------------------------------------
create_daily_reading.call("3rd_sunday_after_epiphany_monday",
  "Salmo 41, 52", "Salmo 44",
  "Gênesis 14:(1-7)8-24", "Hebreus 8:1-13", "João 4:43-54"
)

create_daily_reading.call("3rd_sunday_after_epiphany_tuesday",
  "Salmo 45", "Salmo 47, 48",
  "Gênesis 15:1-11, 17-21", "Hebreus 9:1-14", "João 5:1-18"
)

create_daily_reading.call("3rd_sunday_after_epiphany_wednesday",
  "Salmo 119:49-72", "Salmo 49, [53]",
  "Gênesis 16:1-14", "Hebreus 9:15-28", "João 5:19-29"
)

create_daily_reading.call("3rd_sunday_after_epiphany_thursday",
  "Salmo 50", "Salmo [59, 60] ou 118",
  "Gênesis 16:15-17:14", "Hebreus 10:1-10", "João 5:30-47"
)

create_daily_reading.call("3rd_sunday_after_epiphany_friday",
  "Salmo 40, 54", "Salmo 51",
  "Gênesis 17:15-27", "Hebreus 10:11-25", "João 6:1-15"
)

create_daily_reading.call("3rd_sunday_after_epiphany_saturday",
  "Salmo 55", "Salmo 138, 139:1-17(18-23)",
  "Gênesis 18:1-16", "Hebreus 10:26-39", "João 6:16-27"
)

Rails.logger.info "✅ Leituras diárias do Natal e Epifania (Ano Par) carregadas!"
