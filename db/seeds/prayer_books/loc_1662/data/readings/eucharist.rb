# ================================================================================
# LEITURAS EUCARISTIA (EPÍSTOLA E EVANGELHO) - LOC 1662
# ================================================================================

Rails.logger.info "🍷 Carregando Leituras da Eucaristia do LOC 1662..."

prayer_book = PrayerBook.find_by!(code: 'loc_1662')

readings = [
  # ADVENTO

  # 1º Domingo do Advento
  {
    date_reference: "1st_sunday_of_advent",
    epistle: "Romanos 13:8-14",
    gospel: "Mateus 21:1-13"
  },

  # 2º Domingo do Advento
  {
    date_reference: "2nd_sunday_of_advent",
    epistle: "Romanos 15:4-13",
    gospel: "Lucas 21:25-33"
  },

  # 3º Domingo do Advento
  {
    date_reference: "3rd_sunday_of_advent",
    epistle: "1 Coríntios 4:1-5",
    gospel: "Mateus 11:2-10"
  },

  # 4º Domingo do Advento
  {
    date_reference: "4th_sunday_of_advent",
    epistle: "Filipenses 4:4-7",
    gospel: "João 1:19-28"
  },

  # NATAL
  {
    date_reference: "christmas_day",
    epistle: "Hebreus 1:1-12",
    gospel: "João 1:1-14"
  },

  # Santo Estevão
  {
    date_reference: "saint_stephen",
    epistle: "Atos 7:55-60",
    gospel: "Mateus 23:34-39"
  },

  # São João Evangelista
  {
    date_reference: "saint_john_apostle",
    epistle: "1 João 1:1-7",
    gospel: "João 21:19-25"
  },

  # Santos Inocentes
  {
    date_reference: "holy_innocents",
    epistle: "Apocalipse 14:1-5",
    gospel: "Mateus 2:13-18"
  },

  # Domingo após o Natal
  {
    date_reference: "1st_sunday_after_christmas",
    epistle: "Gálatas 4:1-7",
    gospel: "Mateus 1:18-25"
  },

  # 2º Domingo após o Natal
  {
    date_reference: "2nd_sunday_after_christmas",
    epistle: "Gálatas 4:1-7",
    gospel: "Mateus 1:18-25"
  },

  # Circuncisão
  {
    date_reference: "circumcision_of_christ",
    epistle: "Romanos 4:8-14",
    gospel: "Lucas 2:15-21"
  },

  # Epifania
  {
    date_reference: "epiphany",
    epistle: "Efésios 3:1-12",
    gospel: "Mateus 2:1-12"
  },

  # 1º Domingo após Epifania
  {
    date_reference: "1st_sunday_after_epiphany",
    epistle: "Romanos 12:1-5",
    gospel: "Lucas 2:41-52"
  },

  # 2º Domingo após Epifania
  {
    date_reference: "2nd_sunday_after_epiphany",
    epistle: "Romanos 12:6-16",
    gospel: "João 2:1-11"
  },

  # 3º Domingo após Epifania
  {
    date_reference: "3rd_sunday_after_epiphany",
    epistle: "Romanos 12:16-21",
    gospel: "Mateus 8:1-13"
  },

  # 4º Domingo após Epifania
  {
    date_reference: "4th_sunday_after_epiphany",
    epistle: "Romanos 13:1-7",
    gospel: "Mateus 8:23-34"
  },

  # 5º Domingo após Epifania
  {
    date_reference: "5th_sunday_after_epiphany",
    epistle: "Colossenses 3:12-17",
    gospel: "Mateus 13:24-30"
  },

  # 6º Domingo após Epifania
  {
    date_reference: "6th_sunday_after_epiphany",
    epistle: "1 João 3:1-8",
    gospel: "Mateus 24:23-31"
  },

  # Septuagésima
  {
    date_reference: "septuagesima",
    epistle: "1 Coríntios 9:24-27",
    gospel: "Mateus 20:1-16"
  },

  # Sexagésima
  {
    date_reference: "sexagesima",
    epistle: "2 Coríntios 11:19-31",
    gospel: "Lucas 8:4-15"
  },

  # Quinquagesima
  {
    date_reference: "quinquagesima",
    epistle: "1 Coríntios 13",
    gospel: "Lucas 18:31-43"
  },

  # Quarta-feira de Cinzas
  {
    date_reference: "ash_wednesday",
    epistle: "Joel 2:12-17",
    gospel: "Mateus 6:16-21"
  },

  # 1º Domingo na Quaresma
  {
    date_reference: "1st_sunday_in_lent",
    epistle: "2 Coríntios 6:1-10",
    gospel: "Mateus 4:1-11"
  },

  # 2º Domingo na Quaresma
  {
    date_reference: "2nd_sunday_in_lent",
    epistle: "1 Tessalonicenses 4:1-8",
    gospel: "Mateus 15:21-28"
  },

  # 3º Domingo na Quaresma
  {
    date_reference: "3rd_sunday_in_lent",
    epistle: "Efésios 5:1-14",
    gospel: "Lucas 11:14-28"
  },

  # 4º Domingo na Quaresma
  {
    date_reference: "4th_sunday_in_lent",
    epistle: "Gálatas 4:21-31",
    gospel: "João 6:1-14"
  },

  # 5º Domingo na Quaresma
  {
    date_reference: "5th_sunday_in_lent",
    epistle: "Hebreus 9:11-15",
    gospel: "João 8:46-59"
  },

  # Domingo de Ramos (Antes da Páscoa)
  {
    date_reference: "palm_sunday",
    epistle: "Filipenses 2:5-11",
    gospel: "Mateus 27:1-54"
  },

  # Segunda-feira antes da Páscoa
  {
    date_reference: "monday_in_holy_week",
    epistle: "Isaías 63",
    gospel: "Marcos 14"
  },

  # Terça-feira antes da Páscoa
  {
    date_reference: "tuesday_in_holy_week",
    epistle: "Isaías 50:5-11",
    gospel: "Marcos 15:1-39"
  },

  # Quarta-feira antes da Páscoa
  {
    date_reference: "wednesday_in_holy_week",
    epistle: "Hebreus 9:16-28",
    gospel: "Lucas 22"
  },

  # Quinta-feira antes da Páscoa
  {
    date_reference: "maundy_thursday",
    epistle: "1 Coríntios 11:17-34",
    gospel: "Lucas 23:1-49"
  },

  # Sexta-feira Santa
  {
    date_reference: "good_friday",
    epistle: "Hebreus 10:1-25",
    gospel: "João 19:1-37"
  },

  # Sábado Santo (Vigília Pascal)
  {
    date_reference: "holy_saturday",
    epistle: "1 Pedro 3:17-22",
    gospel: "Mateus 27:57-66"
  },

  # Dia da Páscoa
  {
    date_reference: "easter_day",
    epistle: "Colossenses 3:1-7",
    gospel: "João 20:1-10"
  },

  # Segunda-feira da Páscoa
  {
    date_reference: "monday_in_easter_week",
    epistle: "Atos 10:34-43",
    gospel: "Lucas 24:13-35"
  },

  # Terça-feira da Páscoa
  {
    date_reference: "tuesday_in_easter_week",
    epistle: "Atos 13:26-41",
    gospel: "Lucas 24:36-48"
  },

  # 1º Domingo após a Páscoa
  {
    date_reference: "1st_sunday_after_easter",
    epistle: "1 João 5:4-12",
    gospel: "João 20:19-23"
  },

  # 2º Domingo após a Páscoa
  {
    date_reference: "2nd_sunday_after_easter",
    epistle: "1 Pedro 2:19-25",
    gospel: "João 10:11-16"
  },

  # 3º Domingo após a Páscoa
  {
    date_reference: "3rd_sunday_after_easter",
    epistle: "1 Pedro 2:11-17",
    gospel: "João 16:16-22"
  },

  # 4º Domingo após a Páscoa
  {
    date_reference: "4th_sunday_after_easter",
    epistle: "Tiago 1:17-21",
    gospel: "João 16:5-15"
  },

  # 5º Domingo após a Páscoa
  {
    date_reference: "5th_sunday_after_easter",
    epistle: "Tiago 1:22-27",
    gospel: "João 16:23-33"
  },

  # Dia da Ascensão
  {
    date_reference: "ascension_day",
    epistle: "Atos 1:1-11",
    gospel: "Marcos 16:14-20"
  },

  # Domingo após a Ascensão
  {
    date_reference: "sunday_after_ascension",
    epistle: "1 Pedro 4:7-11",
    gospel: "João 15:26-16:4"
  },

  # Domingo de Pentecostes
  {
    date_reference: "pentecost_sunday",
    epistle: "Atos 2:1-11",
    gospel: "João 14:15-31"
  },

  # Segunda-feira da Semana de Pentecostes
  {
    date_reference: "monday_in_whitsun_week",
    epistle: "Atos 10:34-48",
    gospel: "João 3:16-21"
  },

  # Terça-feira da Semana de Pentecostes
  {
    date_reference: "tuesday_in_whitsun_week",
    epistle: "Atos 8:14-17",
    gospel: "João 10:1-10"
  },

  # Domingo da Trindade
  {
    date_reference: "trinity_sunday",
    epistle: "Apocalipse 4:1-11",
    gospel: "João 3:1-15"
  },

  # 1º Domingo depois da Trindade
  {
    date_reference: "1st_sunday_after_trinity",
    epistle: "1 João 4:7-21",
    gospel: "Lucas 16:19-31"
  },

  # 2º Domingo depois da Trindade
  {
    date_reference: "2nd_sunday_after_trinity",
    epistle: "1 João 3:13-24",
    gospel: "Lucas 14:16-24"
  },

  # 3º Domingo depois da Trindade
  {
    date_reference: "3rd_sunday_after_trinity",
    epistle: "1 Pedro 5:5-11",
    gospel: "Lucas 15:1-10"
  },

  # 4º Domingo depois da Trindade
  {
    date_reference: "4th_sunday_after_trinity",
    epistle: "Romanos 8:18-23",
    gospel: "Lucas 6:36-42"
  },

  # 5º Domingo depois da Trindade
  {
    date_reference: "5th_sunday_after_trinity",
    epistle: "1 Pedro 3:8-15",
    gospel: "Lucas 5:1-11"
  },

  # 6º Domingo depois da Trindade
  {
    date_reference: "6th_sunday_after_trinity",
    epistle: "Romanos 6:3-11",
    gospel: "Mateus 5:20-26"
  },

  # 7º Domingo depois da Trindade
  {
    date_reference: "7th_sunday_after_trinity",
    epistle: "Romanos 6:19-23",
    gospel: "Marcos 8:1-9"
  },

  # 8º Domingo depois da Trindade
  {
    date_reference: "8th_sunday_after_trinity",
    epistle: "Romanos 8:12-17",
    gospel: "Mateus 7:15-21"
  },

  # 9º Domingo depois da Trindade
  {
    date_reference: "9th_sunday_after_trinity",
    epistle: "1 Coríntios 10:1-13",
    gospel: "Lucas 16:1-9"
  },

  # 10º Domingo depois da Trindade
  {
    date_reference: "10th_sunday_after_trinity",
    epistle: "1 Coríntios 12:1-11",
    gospel: "Lucas 19:41-47"
  },

  # 11º Domingo depois da Trindade
  {
    date_reference: "11th_sunday_after_trinity",
    epistle: "1 Coríntios 15:1-11",
    gospel: "Lucas 18:9-14"
  },

  # 12º Domingo depois da Trindade
  {
    date_reference: "12th_sunday_after_trinity",
    epistle: "2 Coríntios 3:4-9",
    gospel: "Marcos 7:31-37"
  },

  # 13º Domingo depois da Trindade
  {
    date_reference: "13th_sunday_after_trinity",
    epistle: "Gálatas 3:16-22",
    gospel: "Lucas 10:23-37"
  },

  # 14º Domingo depois da Trindade
  {
    date_reference: "14th_sunday_after_trinity",
    epistle: "Gálatas 5:16-24",
    gospel: "Lucas 17:11-19"
  },

  # 15º Domingo depois da Trindade
  {
    date_reference: "15th_sunday_after_trinity",
    epistle: "Gálatas 6:11-18",
    gospel: "Mateus 6:24-34"
  },

  # 16º Domingo depois da Trindade
  {
    date_reference: "16th_sunday_after_trinity",
    epistle: "Efésios 3:13-21",
    gospel: "Lucas 7:11-17"
  },

  # 17º Domingo depois da Trindade
  {
    date_reference: "17th_sunday_after_trinity",
    epistle: "Efésios 4:1-6",
    gospel: "Lucas 14:1-11"
  },

  # 18º Domingo depois da Trindade
  {
    date_reference: "18th_sunday_after_trinity",
    epistle: "1 Coríntios 1:4-8",
    gospel: "Mateus 22:34-46"
  },

  # 19º Domingo depois da Trindade
  {
    date_reference: "19th_sunday_after_trinity",
    epistle: "Efésios 4:17-32",
    gospel: "Mateus 9:1-8"
  },

  # 20º Domingo depois da Trindade
  {
    date_reference: "20th_sunday_after_trinity",
    epistle: "Efésios 5:15-21",
    gospel: "Mateus 22:1-14"
  },

  # 21º Domingo depois da Trindade
  {
    date_reference: "21st_sunday_after_trinity",
    epistle: "Efésios 6:10-20",
    gospel: "João 4:46-54"
  },

  # 22º Domingo depois da Trindade
  {
    date_reference: "22nd_sunday_after_trinity",
    epistle: "Filipenses 1:3-11",
    gospel: "Mateus 18:21-35"
  },

  # 23º Domingo depois da Trindade
  {
    date_reference: "23rd_sunday_after_trinity",
    epistle: "Filipenses 3:17-21",
    gospel: "Mateus 22:15-22"
  },

  # 24º Domingo depois da Trindade
  {
    date_reference: "24th_sunday_after_trinity",
    epistle: "Colossenses 1:3-12",
    gospel: "Mateus 9:18-26"
  },

  # 25º Domingo depois da Trindade
  {
    date_reference: "25th_sunday_after_trinity",
    epistle: "Jeremias 23:5-8",
    gospel: "João 6:5-14"
  },

  # Santo André
  {
    date_reference: "saint_andrew",
    epistle: "Romanos 10:9-21",
    gospel: "Mateus 4:18-22"
  },

  # São Tomé
  {
    date_reference: "saint_thomas_apostle",
    epistle: "Efésios 2:19-22",
    gospel: "João 20:24-31"
  },

  # Conversão de São Paulo
  {
    date_reference: "conversion_of_saint_paulo",
    epistle: "Atos 9:1-22",
    gospel: "Mateus 19:27-30"
  },

  # Purificação de Maria
  {
    date_reference: "purification_of_mary",
    epistle: "Malaquias 3:1-5",
    gospel: "Lucas 2:22-40"
  },

  # São Matias
  {
    date_reference: "saint_matthias",
    epistle: "Atos 1:15-26",
    gospel: "Mateus 11:25-30"
  },

  # Anunciação de Maria
  {
    date_reference: "annunciation_of_mary",
    epistle: "Isaías 7:10-15",
    gospel: "Lucas 1:26-38"
  },

  # São Marcos
  {
    date_reference: "saint_mark",
    epistle: "Efésios 4:7-16",
    gospel: "João 15:1-11"
  },

  # São Filipe e São Tiago
  {
    date_reference: "saints_philip_and_james",
    epistle: "Tiago 1:1-12",
    gospel: "João 14:1-14"
  },

  # São Barnabé
  {
    date_reference: "saint_barnabas",
    epistle: "Atos 11:22-30",
    gospel: "João 15:12-16"
  },

  # São João Batista
  {
    date_reference: "nativity_of_john_baptist",
    epistle: "Isaías 40:1-11",
    gospel: "Lucas 1:57-80"
  },

  # São Pedro
  {
    date_reference: "saint_pedro",
    epistle: "Atos 12:1-11",
    gospel: "Mateus 16:13-19"
  },

  # São Tiago
  {
    date_reference: "saint_james",
    epistle: "Atos 11:27 - 12:3",
    gospel: "Mateus 20:20-28"
  },

  # São Bartolomeu
  {
    date_reference: "saint_bartholomew",
    epistle: "Atos 5:12-16",
    gospel: "Lucas 22:24-30"
  },

  # São Mateus
  {
    date_reference: "saint_matthew",
    epistle: "2 Coríntios 4:1-6",
    gospel: "Mateus 9:9-13"
  },

  # São Miguel e Todos os Anjos
  {
    date_reference: "saint_michael_and_all_angels",
    epistle: "Apocalipse 12:7-12",
    gospel: "Mateus 18:1-10"
  },

  # São Lucas
  {
    date_reference: "saint_luke",
    epistle: "2 Timóteo 4:5-15",
    gospel: "Lucas 10:1-7"
  },

  # São Simão e São Judas
  {
    date_reference: "saints_simon_and_jude",
    epistle: "Judas 1:1-8",
    gospel: "João 15:17-27"
  },

  # Todos os Santos
  {
    date_reference: "all_saints",
    epistle: "Apocalipse 7:2-12",
    gospel: "Mateus 5:1-12"
  }
]

# Map date_reference to localized celebration name in LOC 1662
CELEBRATION_NAME_MAP = {
  "1st_sunday_of_advent" => "1º Domingo do Advento",
  "2nd_sunday_of_advent" => "2º Domingo do Advento",
  "3rd_sunday_of_advent" => "3º Domingo do Advento",
  "4th_sunday_of_advent" => "4º Domingo do Advento",
  "christmas_day" => "Dia de Natal",
  "saint_stephen" => "Santo Estevão, o Mártir",
  "saint_john_apostle" => "São João, o Evangelista",
  "holy_innocents" => "Santos Inocentes",
  "1st_sunday_after_christmas" => "1º Domingo após o Natal",
  "2nd_sunday_after_christmas" => "2º Domingo após o Natal",
  "circumcision_of_christ" => "Circuncisão do Senhor",
  "epiphany" => "Epifania",
  "1st_sunday_after_epiphany" => "1º Domingo após Epifania",
  "2nd_sunday_after_epiphany" => "2º Domingo após Epifania",
  "3rd_sunday_after_epiphany" => "3º Domingo após Epifania",
  "4th_sunday_after_epiphany" => "4º Domingo após Epifania",
  "5th_sunday_after_epiphany" => "5º Domingo após Epifania",
  "6th_sunday_after_epiphany" => "6º Domingo após Epifania",
  "septuagesima" => "Septuagésima",
  "sexagesima" => "Sexagésima",
  "quinquagesima" => "Quinquagésima",
  "ash_wednesday" => "Quarta-feira de Cinzas",
  "1st_sunday_in_lent" => "1º Domingo na Quaresma",
  "2nd_sunday_in_lent" => "2º Domingo na Quaresma",
  "3rd_sunday_in_lent" => "3º Domingo na Quaresma",
  "4th_sunday_in_lent" => "4º Domingo na Quaresma",
  "5th_sunday_in_lent" => "5º Domingo na Quaresma",
  "palm_sunday" => "Domingo de Ramos",
  "monday_in_holy_week" => "Segunda-feira antes da Páscoa",
  "tuesday_in_holy_week" => "Terça-feira antes da Páscoa",
  "wednesday_in_holy_week" => "Quarta-feira antes da Páscoa",
  "maundy_thursday" => "Quinta-feira Santa",
  "good_friday" => "Sexta-feira da Paixão",
  "holy_saturday" => "Sábado Santo",
  "easter_day" => "Domingo da Páscoa",
  "monday_in_easter_week" => "Segunda-feira da Páscoa",
  "tuesday_in_easter_week" => "Terça-feira da Páscoa",
  "1st_sunday_after_easter" => "1º Domingo após a Páscoa",
  "2nd_sunday_after_easter" => "2º Domingo após a Páscoa",
  "3rd_sunday_after_easter" => "3º Domingo após a Páscoa",
  "4th_sunday_after_easter" => "4º Domingo após a Páscoa",
  "5th_sunday_after_easter" => "5º Domingo após a Páscoa",
  "ascension_day" => "Dia da Ascensão",
  "sunday_after_ascension" => "Domingo após a Ascensão",
  "pentecost_sunday" => "Pentecostes",
  "monday_in_whitsun_week" => "Segunda-feira de Pentecostes",
  "tuesday_in_whitsun_week" => "Terça-feira de Pentecostes",
  "trinity_sunday" => "Santíssima Trindade",
  "1st_sunday_after_trinity" => "1º Domingo após a Trindade",
  "2nd_sunday_after_trinity" => "2º Domingo após a Trindade",
  "3rd_sunday_after_trinity" => "3º Domingo após a Trindade",
  "4th_sunday_after_trinity" => "4º Domingo após a Trindade",
  "5th_sunday_after_trinity" => "5º Domingo após a Trindade",
  "6th_sunday_after_trinity" => "6º Domingo após a Trindade",
  "7th_sunday_after_trinity" => "7º Domingo após a Trindade",
  "8th_sunday_after_trinity" => "8º Domingo após a Trindade",
  "9th_sunday_after_trinity" => "9º Domingo após a Trindade",
  "10th_sunday_after_trinity" => "10º Domingo após a Trindade",
  "11th_sunday_after_trinity" => "11º Domingo após a Trindade",
  "12th_sunday_after_trinity" => "12º Domingo após a Trindade",
  "13th_sunday_after_trinity" => "13º Domingo após a Trindade",
  "14th_sunday_after_trinity" => "14º Domingo após a Trindade",
  "15th_sunday_after_trinity" => "15º Domingo após a Trindade",
  "16th_sunday_after_trinity" => "16º Domingo após a Trindade",
  "17th_sunday_after_trinity" => "17º Domingo após a Trindade",
  "18th_sunday_after_trinity" => "18º Domingo após a Trindade",
  "19th_sunday_after_trinity" => "19º Domingo após a Trindade",
  "20th_sunday_after_trinity" => "20º Domingo após a Trindade",
  "21st_sunday_after_trinity" => "21º Domingo após a Trindade", # Note: using ordinal logic
  "22nd_sunday_after_trinity" => "22º Domingo após a Trindade",
  "23rd_sunday_after_trinity" => "23º Domingo após a Trindade",
  "24th_sunday_after_trinity" => "24º Domingo após a Trindade",
  "25th_sunday_after_trinity" => "25º Domingo após a Trindade",
  "saint_andrew" => "Santo André, o Apóstolo",
  "saint_thomas_apostle" => "São Tomé, o Apóstolo",
  "conversion_of_saint_paulo" => "Conversão de São Paulo",
  "purification_of_mary" => "Purificação de Maria",
  "saint_matthias" => "São Matias, o Apóstolo",
  "annunciation_of_mary" => "Anunciação da Bem-Aventurada Virgem Maria",
  "saint_mark" => "São Marcos, o Evangelista",
  "saints_philip_and_james" => "São Filipe e São Tiago, os Apóstolos",
  "saint_barnabas" => "São Barnabé",
  "nativity_of_john_baptist" => "Nascimento de São João Batista",
  "saint_pedro" => "São Pedro, o Apóstolo",
  "saint_james" => "São Tiago, o Apóstolo",
  "saint_bartholomew" => "São Bartolomeu, o Apóstolo",
  "saint_matthew" => "São Mateus, o Apóstolo",
  "saint_michael_and_all_angels" => "São Miguel e Todos os Anjos",
  "saint_luke" => "São Lucas, o Evangelista",
  "saints_simon_and_jude" => "São Simão e São Judas, os Apóstolos",
  "all_saints" => "Todos os Santos"
}.freeze

readings.each do |r|
  cel_name = CELEBRATION_NAME_MAP[r[:date_reference]]
  celebration = Celebration.find_by(name: cel_name, prayer_book_id: prayer_book.id) if cel_name

  # Epístola (First Reading in Communion context usually, but stored as second_reading in some systems?
  # No, usually Epistle = second_reading or first_reading depending on if OT is present.
  # In 1662, it's Epistle and Gospel. I'll map Epistle to `first_reading` and Gospel to `gospel`.

  existing = LectionaryReading.find_by(
    date_reference: r[:date_reference],
    cycle: 'all',
    service_type: 'eucharist',
    prayer_book_id: prayer_book.id
  )

  if existing
    existing.update!(
      celebration_id: celebration&.id,
      first_reading: r[:epistle],
      gospel: r[:gospel]
    )
  else
    LectionaryReading.create!(
      prayer_book_id: prayer_book.id,
      celebration_id: celebration&.id,
      date_reference: r[:date_reference],
      cycle: 'all',
      service_type: 'eucharist',
      first_reading: r[:epistle],
      gospel: r[:gospel]
    )
  end
end

Rails.logger.info "✅ Leituras da Eucaristia carregadas!"
