# ================================================================================
# LEITURAS EUCARISTIA (EPÍSTOLA E EVANGELHO) - LOC 1662
# ================================================================================

Rails.logger.info "🍷 Carregando Leituras da Eucaristia do LOC 1662..."

prayer_book = PrayerBook.find_by!(code: 'loc_1662')

readings = [
  # ADVENTO
  
  # 1º Domingo do Advento
  {
    celebration: "1st_sunday_of_advent",
    epistle: "Romanos 13:8-14",
    gospel: "Mateus 21:1-13"
  },

  # 2º Domingo do Advento
  {
    celebration: "2nd_sunday_of_advent",
    epistle: "Romanos 15:4-13",
    gospel: "Lucas 21:25-33"
  },

  # 3º Domingo do Advento
  {
    celebration: "3rd_sunday_of_advent",
    epistle: "1 Coríntios 4:1-5",
    gospel: "Mateus 11:2-10"
  },

  # 4º Domingo do Advento
  {
    celebration: "4th_sunday_of_advent",
    epistle: "Filipenses 4:4-7",
    gospel: "João 1:19-28"
  },

  # NATAL
  {
    celebration: "christmas_day",
    epistle: "Hebreus 1:1-12",
    gospel: "João 1:1-14"
  },

  # Santo Estevão
  {
    celebration: "saint_stephen",
    epistle: "Atos 7:55-60",
    gospel: "Mateus 23:34-39"
  },

  # São João Evangelista
  {
    celebration: "saint_john_apostle",
    epistle: "1 João 1:1-7",
    gospel: "João 21:19-25"
  },

  # Santos Inocentes
  {
    celebration: "holy_innocents",
    epistle: "Apocalipse 14:1-5",
    gospel: "Mateus 2:13-18"
  },

  # Domingo após o Natal
  {
    celebration: "1st_sunday_after_christmas",
    epistle: "Gálatas 4:1-7",
    gospel: "Mateus 1:18-25"
  },

  # Circuncisão
  {
    celebration: "circumcision_of_christ",
    epistle: "Romanos 4:8-14",
    gospel: "Lucas 2:15-21"
  },

  # Epifania
  {
    celebration: "epiphany",
    epistle: "Efésios 3:1-12",
    gospel: "Mateus 2:1-12"
  },

  # 1º Domingo após Epifania
  {
    celebration: "1st_sunday_after_epiphany",
    epistle: "Romanos 12:1-5",
    gospel: "Lucas 2:41-52"
  },

  # 3º Domingo após Epifania
  {
    celebration: "3rd_sunday_after_epiphany",
    epistle: "Romanos 12:16-21",
    gospel: "Mateus 8:1-13"
  },

  # 4º Domingo após Epifania
  {
    celebration: "4th_sunday_after_epiphany",
    epistle: "Romanos 13:1-7",
    gospel: "Mateus 8:23-34"
  },

  # 5º Domingo após Epifania
  {
    celebration: "5th_sunday_after_epiphany",
    epistle: "Colossenses 3:12-17",
    gospel: "Mateus 13:24-30"
  },

  # 6º Domingo após Epifania
  {
    celebration: "6th_sunday_after_epiphany",
    epistle: "1 João 3:1-8",
    gospel: "Mateus 24:23-31"
  },

  # Septuagésima
  {
    celebration: "septuagesima",
    epistle: "1 Coríntios 9:24-27",
    gospel: "Mateus 20:1-16"
  },

  # Sexagésima
  {
    celebration: "sexagesima",
    epistle: "2 Coríntios 11:19-31",
    gospel: "Lucas 8:4-15"
  },

  # Quinquagesima
  {
    celebration: "quinquagesima",
    epistle: "1 Coríntios 13",
    gospel: "Lucas 18:31-43"
  },

  # Quarta-feira de Cinzas
  {
    celebration: "ash_wednesday",
    epistle: "Joel 2:12-17",
    gospel: "Mateus 6:16-21"
  },

  # 1º Domingo na Quaresma
  {
    celebration: "1st_sunday_in_lent",
    epistle: "2 Coríntios 6:1-10",
    gospel: "Mateus 4:1-11"
  },

  # 2º Domingo na Quaresma
  {
    celebration: "2nd_sunday_in_lent",
    epistle: "1 Tessalonicenses 4:1-8",
    gospel: "Mateus 15:21-28"
  },

  # 3º Domingo na Quaresma
  {
    celebration: "3rd_sunday_in_lent",
    epistle: "Efésios 5:1-14",
    gospel: "Lucas 11:14-28"
  },

  # 5º Domingo na Quaresma
  {
    celebration: "5th_sunday_in_lent",
    epistle: "Hebreus 9:11-15",
    gospel: "João 8:46-59"
  },

  # Domingo de Ramos (Antes da Páscoa)
  {
    celebration: "palm_sunday",
    epistle: "Filipenses 2:5-11",
    gospel: "Mateus 27:1-54"
  },

  # Segunda-feira antes da Páscoa
  {
    celebration: "monday_in_holy_week",
    epistle: "Isaías 63",
    gospel: "Marcos 14"
  },

  # Terça-feira antes da Páscoa
  {
    celebration: "tuesday_in_holy_week",
    epistle: "Isaías 50:5-11",
    gospel: "Marcos 15:1-39"
  },

  # Quarta-feira antes da Páscoa
  {
    celebration: "wednesday_in_holy_week",
    epistle: "Hebreus 9:16-28",
    gospel: "Lucas 22"
  },

  # Quinta-feira antes da Páscoa
  {
    celebration: "maundy_thursday",
    epistle: "1 Coríntios 11:17-34",
    gospel: "Lucas 23:1-49"
  },

  # Sexta-feira Santa
  {
    celebration: "good_friday",
    epistle: "Hebreus 10:1-25",
    gospel: "João 19:1-37"
  },

  # Sábado Santo (Vigília Pascal)
  {
    celebration: "holy_saturday",
    epistle: "1 Pedro 3:17-22",
    gospel: "Mateus 27:57-66"
  },

  # Dia da Páscoa
  {
    celebration: "easter_day",
    epistle: "Colossenses 3:1-7",
    gospel: "João 20:1-10"
  },

  # Segunda-feira da Páscoa
  {
    celebration: "monday_in_easter_week",
    epistle: "Atos 10:34-43",
    gospel: "Lucas 24:13-35"
  },

  # Terça-feira da Páscoa
  {
    celebration: "tuesday_in_easter_week",
    epistle: "Atos 13:26-41",
    gospel: "Lucas 24:36-48"
  },

  # 1º Domingo após a Páscoa
  {
    celebration: "1st_sunday_after_easter",
    epistle: "1 João 5:4-12",
    gospel: "João 20:19-23"
  },

  # 2º Domingo após a Páscoa
  {
    celebration: "2nd_sunday_after_easter",
    epistle: "1 Pedro 2:19-25",
    gospel: "João 10:11-16"
  },

  # 3º Domingo após a Páscoa
  {
    celebration: "3rd_sunday_after_easter",
    epistle: "1 Pedro 2:11-17",
    gospel: "João 16:16-22"
  },

  # 4º Domingo após a Páscoa
  {
    celebration: "4th_sunday_after_easter",
    epistle: "Tiago 1:17-21",
    gospel: "João 16:5-15"
  },

  # 5º Domingo após a Páscoa
  {
    celebration: "5th_sunday_after_easter",
    epistle: "Tiago 1:22-27",
    gospel: "João 16:23-33"
  },

  # Dia da Ascensão
  {
    celebration: "ascension_day",
    epistle: "Atos 1:1-11",
    gospel: "Marcos 16:14-20"
  },

  # Domingo após a Ascensão
  {
    celebration: "sunday_after_ascension",
    epistle: "1 Pedro 4:7-11",
    gospel: "João 15:26-16:4"
  },

  # Domingo de Pentecostes
  {
    celebration: "pentecost_sunday",
    epistle: "Atos 2:1-11",
    gospel: "João 14:15-31"
  },

  # Segunda-feira da Semana de Pentecostes
  {
    celebration: "monday_in_whitsun_week",
    epistle: "Atos 10:34-48",
    gospel: "João 3:16-21"
  },

  # Terça-feira da Semana de Pentecostes
  {
    celebration: "tuesday_in_whitsun_week",
    epistle: "Atos 8:14-17",
    gospel: "João 10:1-10"
  },

  # Domingo da Trindade
  {
    celebration: "trinity_sunday",
    epistle: "Apocalipse 4:1-11",
    gospel: "João 3:1-15"
  },

  # 1º Domingo depois da Trindade
  {
    celebration: "1st_sunday_after_trinity",
    epistle: "1 João 4:7-21",
    gospel: "Lucas 16:19-31"
  },

  # 2º Domingo depois da Trindade
  {
    celebration: "2nd_sunday_after_trinity",
    epistle: "1 João 3:13-24",
    gospel: "Lucas 14:16-24"
  },

  # 3º Domingo depois da Trindade
  {
    celebration: "3rd_sunday_after_trinity",
    epistle: "1 Pedro 5:5-11",
    gospel: "Lucas 15:1-10"
  },

  # 4º Domingo depois da Trindade
  {
    celebration: "4th_sunday_after_trinity",
    epistle: "Romanos 8:18-23",
    gospel: "Lucas 6:36-42"
  },

  # 5º Domingo depois da Trindade
  {
    celebration: "5th_sunday_after_trinity",
    epistle: "1 Pedro 3:8-15",
    gospel: "Lucas 5:1-11"
  },

  # 6º Domingo depois da Trindade
  {
    celebration: "6th_sunday_after_trinity",
    epistle: "Romanos 6:3-11",
    gospel: "Mateus 5:20-26"
  },

  # 7º Domingo depois da Trindade
  {
    celebration: "7th_sunday_after_trinity",
    epistle: "Romanos 6:19-23",
    gospel: "Marcos 8:1-9"
  },

  # 8º Domingo depois da Trindade
  {
    celebration: "8th_sunday_after_trinity",
    epistle: "Romanos 8:12-17",
    gospel: "Mateus 7:15-21"
  },

  # 9º Domingo depois da Trindade
  {
    celebration: "9th_sunday_after_trinity",
    epistle: "1 Coríntios 10:1-13",
    gospel: "Lucas 16:1-9"
  },

  # 10º Domingo depois da Trindade
  {
    celebration: "10th_sunday_after_trinity",
    epistle: "1 Coríntios 12:1-11",
    gospel: "Lucas 19:41-47"
  },

  # 11º Domingo depois da Trindade
  {
    celebration: "11th_sunday_after_trinity",
    epistle: "1 Coríntios 15:1-11",
    gospel: "Lucas 18:9-14"
  },

  # 12º Domingo depois da Trindade
  {
    celebration: "12th_sunday_after_trinity",
    epistle: "2 Coríntios 3:4-9",
    gospel: "Marcos 7:31-37"
  },

  # 13º Domingo depois da Trindade
  {
    celebration: "13th_sunday_after_trinity",
    epistle: "Gálatas 3:16-22",
    gospel: "Lucas 10:23-37"
  },

  # 14º Domingo depois da Trindade
  {
    celebration: "14th_sunday_after_trinity",
    epistle: "Gálatas 5:16-24",
    gospel: "Lucas 17:11-19"
  },

  # 15º Domingo depois da Trindade
  {
    celebration: "15th_sunday_after_trinity",
    epistle: "Gálatas 6:11-18",
    gospel: "Mateus 6:24-34"
  },

  # 16º Domingo depois da Trindade
  {
    celebration: "16th_sunday_after_trinity",
    epistle: "Efésios 3:13-21",
    gospel: "Lucas 7:11-17"
  },

  # 17º Domingo depois da Trindade
  {
    celebration: "17th_sunday_after_trinity",
    epistle: "Efésios 4:1-6",
    gospel: "Lucas 14:1-11"
  },

  # 18º Domingo depois da Trindade
  {
    celebration: "18th_sunday_after_trinity",
    epistle: "1 Coríntios 1:4-8",
    gospel: "Mateus 22:34-46"
  },

  # 19º Domingo depois da Trindade
  {
    celebration: "19th_sunday_after_trinity",
    epistle: "Efésios 4:17-32",
    gospel: "Mateus 9:1-8"
  },

  # 20º Domingo depois da Trindade
  {
    celebration: "20th_sunday_after_trinity",
    epistle: "Efésios 5:15-21",
    gospel: "Mateus 22:1-14"
  },

  # 21º Domingo depois da Trindade
  {
    celebration: "21st_sunday_after_trinity",
    epistle: "Efésios 6:10-20",
    gospel: "João 4:46-54"
  },

  # 22º Domingo depois da Trindade
  {
    celebration: "22nd_sunday_after_trinity",
    epistle: "Filipenses 1:3-11",
    gospel: "Mateus 18:21-35"
  },

  # 23º Domingo depois da Trindade
  {
    celebration: "23rd_sunday_after_trinity",
    epistle: "Filipenses 3:17-21",
    gospel: "Mateus 22:15-22"
  },

  # 24º Domingo depois da Trindade
  {
    celebration: "24th_sunday_after_trinity",
    epistle: "Colossenses 1:3-12",
    gospel: "Mateus 9:18-26"
  },

  # 25º Domingo depois da Trindade
  {
    celebration: "25th_sunday_after_trinity",
    epistle: "Jeremias 23:5-8",
    gospel: "João 6:5-14"
  },

  # Santo André
  {
    celebration: "saint_andrew",
    epistle: "Romanos 10:9-21",
    gospel: "Mateus 4:18-22"
  },

  # São Tomé
  {
    celebration: "saint_thomas_apostle",
    epistle: "Efésios 2:19-22",
    gospel: "João 20:24-31"
  },

  # Conversão de São Paulo
  {
    celebration: "conversion_of_saint_paulo",
    epistle: "Atos 9:1-22",
    gospel: "Mateus 19:27-30"
  },

  # Purificação de Maria
  {
    celebration: "purification_of_mary",
    epistle: "Malaquias 3:1-5",
    gospel: "Lucas 2:22-40"
  },

  # São Matias
  {
    celebration: "saint_matthias",
    epistle: "Atos 1:15-26",
    gospel: "Mateus 11:25-30"
  },

  # Anunciação de Maria
  {
    celebration: "annunciation_of_mary",
    epistle: "Isaías 7:10-15",
    gospel: "Lucas 1:26-38"
  },

  # São Marcos
  {
    celebration: "saint_mark",
    epistle: "Efésios 4:7-16",
    gospel: "João 15:1-11"
  },

  # São Filipe e São Tiago
  {
    celebration: "saints_philip_and_james",
    epistle: "Tiago 1:1-12",
    gospel: "João 14:1-14"
  },

  # São Barnabé
  {
    celebration: "saint_barnabas",
    epistle: "Atos 11:22-30",
    gospel: "João 15:12-16"
  },

  # São João Batista
  {
    celebration: "nativity_of_john_baptist",
    epistle: "Isaías 40:1-11",
    gospel: "Lucas 1:57-80"
  },

  # São Pedro
  {
    celebration: "saint_pedro",
    epistle: "Atos 12:1-11",
    gospel: "Mateus 16:13-19"
  },

  # São Tiago
  {
    celebration: "saint_james",
    epistle: "Atos 11:27 - 12:3",
    gospel: "Mateus 20:20-28"
  },

  # São Bartolomeu
  {
    celebration: "saint_bartholomew",
    epistle: "Atos 5:12-16",
    gospel: "Lucas 22:24-30"
  },

  # São Mateus
  {
    celebration: "saint_matthew",
    epistle: "2 Coríntios 4:1-6",
    gospel: "Mateus 9:9-13"
  },

  # São Miguel e Todos os Anjos
  {
    celebration: "saint_michael_and_all_angels",
    epistle: "Apocalipse 12:7-12",
    gospel: "Mateus 18:1-10"
  },

  # São Lucas
  {
    celebration: "saint_luke",
    epistle: "2 Timóteo 4:5-15",
    gospel: "Lucas 10:1-7"
  },

  # São Simão e São Judas
  {
    celebration: "saints_simon_and_jude",
    epistle: "Judas 1:1-8",
    gospel: "João 15:17-27"
  },

  # Todos os Santos
  {
    celebration: "all_saints",
    epistle: "Apocalipse 7:2-12",
    gospel: "Mateus 5:1-12"
  },
]

readings.each do |r|
  celebration = Celebration.find_by(name: r[:celebration], prayer_book_id: prayer_book.id)
  
  unless celebration
    Rails.logger.warn "⚠️  Celebração não encontrada para leituras: #{r[:celebration]}"
    next
  end

  # Epístola (First Reading in Communion context usually, but stored as second_reading in some systems? 
  # No, usually Epistle = second_reading or first_reading depending on if OT is present. 
  # In 1662, it's Epistle and Gospel. I'll map Epistle to `first_reading` and Gospel to `gospel`.
  
  LectionaryReading.create!(
    prayer_book_id: prayer_book.id,
    celebration_id: celebration.id,
    reading_type: 'eucharist_lectionary',
    cycle: 'all',
    service_type: 'eucharist',
    first_reading: r[:epistle],
    gospel: r[:gospel]
  )
end

Rails.logger.info "✅ Leituras da Eucaristia carregadas!"
