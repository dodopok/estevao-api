# ================================================================================
# LEITURAS PRÓPRIAS (LOC 1662)
# Domingos e Principais Dias Santos
# ================================================================================

Rails.logger.info "📖 Carregando leituras próprias do LOC 1662..."

prayer_book = PrayerBook.find_by!(code: 'loc_1662')

readings = [
  # ============================================================================
  # ADVENTO
  # ============================================================================
  { date_reference: "1st_sunday_of_advent", service_type: "morning_prayer", first_reading: "Isaías 1" },
  { date_reference: "1st_sunday_of_advent", service_type: "evening_prayer", first_reading: "Isaías 2" },

  { date_reference: "2nd_sunday_of_advent", service_type: "morning_prayer", first_reading: "Isaías 5" },
  { date_reference: "2nd_sunday_of_advent", service_type: "evening_prayer", first_reading: "Isaías 24" },

  { date_reference: "3rd_sunday_of_advent", service_type: "morning_prayer", first_reading: "Isaías 25" },
  { date_reference: "3rd_sunday_of_advent", service_type: "evening_prayer", first_reading: "Isaías 26" },

  { date_reference: "4th_sunday_of_advent", service_type: "morning_prayer", first_reading: "Isaías 30" },
  { date_reference: "4th_sunday_of_advent", service_type: "evening_prayer", first_reading: "Isaías 32" },

  # ============================================================================
  # NATAL
  # ============================================================================
  { date_reference: "christmas_day", service_type: "morning_prayer", first_reading: "Isaías 9:1-7", second_reading: "Lucas 2:1-14", psalm: "19, 45, 85" },
  { date_reference: "christmas_day", service_type: "evening_prayer", first_reading: "Isaías 7:10-16", second_reading: "Tito 3:4-8", psalm: "89, 110, 132" },

  { date_reference: "1st_sunday_after_christmas", service_type: "morning_prayer", first_reading: "Isaías 37" },
  { date_reference: "1st_sunday_after_christmas", service_type: "evening_prayer", first_reading: "Isaías 38" },

  { date_reference: "2nd_sunday_after_christmas", service_type: "morning_prayer", first_reading: "Isaías 41" },
  { date_reference: "2nd_sunday_after_christmas", service_type: "evening_prayer", first_reading: "Isaías 43" },

  # ============================================================================
  # EPIFANIA
  # ============================================================================
  { date_reference: "epiphany", service_type: "morning_prayer", first_reading: "Isaías 60", second_reading: "Lucas 3:1-22" },
  { date_reference: "epiphany", service_type: "evening_prayer", first_reading: "Isaías 49", second_reading: "João 2:1-11" },

  { date_reference: "1st_sunday_after_epiphany", service_type: "morning_prayer", first_reading: "Isaías 44" },
  { date_reference: "1st_sunday_after_epiphany", service_type: "evening_prayer", first_reading: "Isaías 46" },

  { date_reference: "2nd_sunday_after_epiphany", service_type: "morning_prayer", first_reading: "Isaías 51" },
  { date_reference: "2nd_sunday_after_epiphany", service_type: "evening_prayer", first_reading: "Isaías 53" },

  { date_reference: "3rd_sunday_after_epiphany", service_type: "morning_prayer", first_reading: "Isaías 55" },
  { date_reference: "3rd_sunday_after_epiphany", service_type: "evening_prayer", first_reading: "Isaías 56" },

  { date_reference: "4th_sunday_after_epiphany", service_type: "morning_prayer", first_reading: "Isaías 57" },
  { date_reference: "4th_sunday_after_epiphany", service_type: "evening_prayer", first_reading: "Isaías 58" },

  { date_reference: "5th_sunday_after_epiphany", service_type: "morning_prayer", first_reading: "Isaías 59" },
  { date_reference: "5th_sunday_after_epiphany", service_type: "evening_prayer", first_reading: "Isaías 64" },

  { date_reference: "6th_sunday_after_epiphany", service_type: "morning_prayer", first_reading: "Isaías 65" },
  { date_reference: "6th_sunday_after_epiphany", service_type: "evening_prayer", first_reading: "Isaías 66" },

  # ============================================================================
  # PRÉ-QUARESMA
  # ============================================================================
  { date_reference: "septuagesima", service_type: "morning_prayer", first_reading: "Gênesis 1" },
  { date_reference: "septuagesima", service_type: "evening_prayer", first_reading: "Gênesis 2" },

  { date_reference: "sexagesima", service_type: "morning_prayer", first_reading: "Gênesis 3" },
  { date_reference: "sexagesima", service_type: "evening_prayer", first_reading: "Gênesis 6" },

  { date_reference: "quinquagesima", service_type: "morning_prayer", first_reading: "Gênesis 9:1-19" },
  { date_reference: "quinquagesima", service_type: "evening_prayer", first_reading: "Gênesis 12" },

  # ============================================================================
  # QUARESMA
  # ============================================================================
  { date_reference: "ash_wednesday", service_type: "morning_prayer", first_reading: nil, second_reading: nil, psalm: "6, 32, 38" },
  { date_reference: "ash_wednesday", service_type: "evening_prayer", first_reading: nil, second_reading: nil, psalm: "102, 130, 143" },

  { date_reference: "1st_sunday_in_lent", service_type: "morning_prayer", first_reading: "Gênesis 19:1-29" },
  { date_reference: "1st_sunday_in_lent", service_type: "evening_prayer", first_reading: "Gênesis 22" },

  { date_reference: "2nd_sunday_in_lent", service_type: "morning_prayer", first_reading: "Gênesis 27" },
  { date_reference: "2nd_sunday_in_lent", service_type: "evening_prayer", first_reading: "Gênesis 34" },

  { date_reference: "3rd_sunday_in_lent", service_type: "morning_prayer", first_reading: "Gênesis 39" },
  { date_reference: "3rd_sunday_in_lent", service_type: "evening_prayer", first_reading: "Gênesis 42" },

  { date_reference: "4th_sunday_in_lent", service_type: "morning_prayer", first_reading: "Gênesis 43" },
  { date_reference: "4th_sunday_in_lent", service_type: "evening_prayer", first_reading: "Gênesis 45" },

  { date_reference: "5th_sunday_in_lent", service_type: "morning_prayer", first_reading: "Êxodo 3" },
  { date_reference: "5th_sunday_in_lent", service_type: "evening_prayer", first_reading: "Êxodo 5" },

  # 6º Domingo (Ramos)
  { date_reference: "palm_sunday", service_type: "morning_prayer", first_reading: "Êxodo 9", second_reading: "Mateus 26" },
  { date_reference: "palm_sunday", service_type: "evening_prayer", first_reading: "Êxodo 10", second_reading: "Hebreus 5:1-10" },

  # Semana Santa (Quarta, Quinta, Sexta, Sábado) - Extraído de pág 0008-0009 (Dias Santos)
  { date_reference: "wednesday_in_holy_week", service_type: "morning_prayer", first_reading: "Oseias 13", second_reading: "João 11:45-47" },
  { date_reference: "wednesday_in_holy_week", service_type: "evening_prayer", first_reading: "Oseias 14", second_reading: nil },

  { date_reference: "maundy_thursday", service_type: "morning_prayer", first_reading: "Daniel 9", second_reading: "João 13" },
  { date_reference: "maundy_thursday", service_type: "evening_prayer", first_reading: "Jeremias 31", second_reading: nil },

  { date_reference: "good_friday", service_type: "morning_prayer", first_reading: "Gênesis 22:1-19", second_reading: "João 18", psalm: "22, 40, 54" },
  { date_reference: "good_friday", service_type: "evening_prayer", first_reading: "Isaías 53", second_reading: "1 Pedro 2", psalm: "69, 88" },

  { date_reference: "holy_saturday", service_type: "morning_prayer", first_reading: "Zacarias 9", second_reading: "Lucas 23:50-56" },
  { date_reference: "holy_saturday", service_type: "evening_prayer", first_reading: "Êxodo 13", second_reading: "Hebreus 4" },

  # ============================================================================
  # PÁSCOA
  # ============================================================================
  { date_reference: "easter_day", service_type: "morning_prayer", first_reading: "Êxodo 12", second_reading: "Romanos 6", psalm: "2, 57, 111" },
  { date_reference: "easter_day", service_type: "evening_prayer", first_reading: "Êxodo 14", second_reading: "Atos 2:22-27", psalm: "113, 114, 118" },

  { date_reference: "monday_in_easter_week", service_type: "morning_prayer", first_reading: "Êxodo 16", second_reading: "Mateus 28" },
  { date_reference: "monday_in_easter_week", service_type: "evening_prayer", first_reading: "Êxodo 17", second_reading: "Atos 3" },

  { date_reference: "tuesday_in_easter_week", service_type: "morning_prayer", first_reading: "Êxodo 20", second_reading: "Lucas 24:1-12" },
  { date_reference: "tuesday_in_easter_week", service_type: "evening_prayer", first_reading: "Êxodo 32", second_reading: "1 Coríntios 15" },

  { date_reference: "1st_sunday_after_easter", service_type: "morning_prayer", first_reading: "Números 16" },
  { date_reference: "1st_sunday_after_easter", service_type: "evening_prayer", first_reading: "Números 22" },

  { date_reference: "2nd_sunday_after_easter", service_type: "morning_prayer", first_reading: "Números 23-24" },
  { date_reference: "2nd_sunday_after_easter", service_type: "evening_prayer", first_reading: "Números 25" },

  { date_reference: "3rd_sunday_after_easter", service_type: "morning_prayer", first_reading: "Deuteronômio 4" },
  { date_reference: "3rd_sunday_after_easter", service_type: "evening_prayer", first_reading: "Deuteronômio 5" },

  { date_reference: "4th_sunday_after_easter", service_type: "morning_prayer", first_reading: "Deuteronômio 6" },
  { date_reference: "4th_sunday_after_easter", service_type: "evening_prayer", first_reading: "Deuteronômio 7" },

  { date_reference: "5th_sunday_after_easter", service_type: "morning_prayer", first_reading: "Deuteronômio 8" },
  { date_reference: "5th_sunday_after_easter", service_type: "evening_prayer", first_reading: "Deuteronômio 9" },

  # ============================================================================
  # ASCENSÃO E PENTECOSTES
  # ============================================================================
  { date_reference: "ascension_day", service_type: "morning_prayer", first_reading: "Deuteronômio 10", second_reading: "Lucas 24:44-53", psalm: "8, 15, 21" },
  { date_reference: "ascension_day", service_type: "evening_prayer", first_reading: "2 Reis 2", second_reading: "Efésios 4:1-16", psalm: "24, 47, 108" },

  { date_reference: "sunday_after_ascension", service_type: "morning_prayer", first_reading: "Deuteronômio 12" },
  { date_reference: "sunday_after_ascension", service_type: "evening_prayer", first_reading: "Deuteronômio 13" },

  { date_reference: "pentecost_sunday", service_type: "morning_prayer", first_reading: "Deuteronômio 16:1-17", second_reading: "Atos 10:34-48", psalm: "48, 68" },
  { date_reference: "pentecost_sunday", service_type: "evening_prayer", first_reading: "Isaías 11", second_reading: "Atos 19:1-20", psalm: "104, 145" },

  { date_reference: "monday_in_whitsun_week", service_type: "morning_prayer", first_reading: "Gênesis 11:1-9", second_reading: "1 Coríntios 12" },
  { date_reference: "monday_in_whitsun_week", service_type: "evening_prayer", first_reading: "Números 11:1-9", second_reading: "1 Coríntios 14:1-25" }, # Check Num 11

  { date_reference: "tuesday_in_whitsun_week", service_type: "morning_prayer", first_reading: "1 Samuel 19:18-24", second_reading: "1 Tessalonicenses 5:12-23" },
  { date_reference: "tuesday_in_whitsun_week", service_type: "evening_prayer", first_reading: "Deuteronômio 30", second_reading: "1 João 4:1-13" },

  # ============================================================================
  # TRINDADE
  # ============================================================================
  { date_reference: "trinity_sunday", service_type: "morning_prayer", first_reading: "Gênesis 1", second_reading: "Mateus 3" },
  { date_reference: "trinity_sunday", service_type: "evening_prayer", first_reading: "Gênesis 18", second_reading: "1 João 5" },
]

# DOMINGOS DA TRINDADE (1 a 26) - Page 0008
trinity_sundays = [
  { n: 1, mat: "Josué 10", vesp: "Josué 23" },
  { n: 2, mat: "Juízes 4", vesp: "Juízes 5" },
  { n: 3, mat: "1 Samuel 2", vesp: "1 Samuel 3" },
  { n: 4, mat: "1 Samuel 12", vesp: "1 Samuel 13" },
  { n: 5, mat: "1 Samuel 15", vesp: "1 Samuel 17" },
  { n: 6, mat: "2 Samuel 12", vesp: "2 Samuel 19" },
  { n: 7, mat: "2 Samuel 21", vesp: "2 Samuel 24" },
  { n: 8, mat: "1 Reis 13", vesp: "1 Reis 17" },
  { n: 9, mat: "1 Reis 18", vesp: "1 Reis 19" },
  { n: 10, mat: "1 Reis 21", vesp: "1 Reis 22" },
  { n: 11, mat: "2 Reis 5", vesp: "2 Reis 9" },
  { n: 12, mat: "2 Reis 10", vesp: "2 Reis 18" },
  { n: 13, mat: "2 Reis 19", vesp: "2 Reis 23" },
  { n: 14, mat: "Jeremias 5", vesp: "Jeremias 22" },
  { n: 15, mat: "Jeremias 35", vesp: "Jeremias 36" },
  { n: 16, mat: "Ezequiel 2", vesp: "Ezequiel 13" },
  { n: 17, mat: "Ezequiel 14", vesp: "Ezequiel 18" },
  { n: 18, mat: "Ezequiel 20", vesp: "Ezequiel 24" },
  { n: 19, mat: "Daniel 3", vesp: "Daniel 6" },
  { n: 20, mat: "Joel 2", vesp: "Miqueias 6" },
  { n: 21, mat: "Habacuque 2", vesp: "Provérbios 1" },
  { n: 22, mat: "Provérbios 2", vesp: "Provérbios 3" },
  { n: 23, mat: "Provérbios 11", vesp: "Provérbios 12" },
  { n: 24, mat: "Provérbios 13", vesp: "Provérbios 14" },
  { n: 25, mat: "Provérbios 15", vesp: "Provérbios 16" },
  { n: 26, mat: "Provérbios 17", vesp: "Provérbios 19" },
]

trinity_sundays.each do |sunday|
  readings << {
    date_reference: "#{sunday[:n].to_i.ordinalize}_sunday_after_trinity",
    service_type: "morning_prayer",
    first_reading: sunday[:mat]
  }
  readings << {
    date_reference: "#{sunday[:n].to_i.ordinalize}_sunday_after_trinity",
    service_type: "evening_prayer",
    first_reading: sunday[:vesp]
  }
end

# DIAS SANTOS (FESTAS FIXAS) - Pages 0008-0009
holy_days = [
  { name: "saint_andrew", mat_1: "Provérbios 20", vesp_1: "Provérbios 21" },
  { name: "saint_thomas_apostle", mat_1: "Provérbios 23", vesp_1: "Provérbios 24" },
  { name: "saint_stephen", mat_1: "Provérbios 28", mat_2: "Atos 6:8-7:29", vesp_1: "Eclesiastes 4", vesp_2: "Atos 7:30-54" },
  { name: "saint_john_apostle", mat_1: "Eclesiastes 5", mat_2: "Apocalipse 1", vesp_1: "Eclesiastes 6", vesp_2: "Apocalipse 22" },
  { name: "holy_innocents", mat_1: "Jeremias 31:1-17", vesp_1: "Sabedoria 1" },
  { name: "circumcision_of_christ", mat_1: "Gênesis 17", mat_2: "Romanos 2", vesp_1: "Deuteronômio 10:12-22", vesp_2: "Colossenses 2" },
  { name: "conversion_of_saint_paulo", mat_1: "Sabedoria 5", mat_2: "Atos 22:1-21", vesp_1: "Sabedoria 6", vesp_2: "Atos 26" },
  { name: "purification_of_mary", mat_1: "Sabedoria 9", vesp_1: "Sabedoria 12" },
  { name: "saint_matthias", mat_1: "Sabedoria 19", vesp_1: "Eclesiástico 1" },
  { name: "annunciation_of_mary", mat_1: "Eclesiástico 2", vesp_1: "Eclesiástico 3" },
  { name: "saint_mark", mat_1: "Eclesiástico 4", vesp_1: "Eclesiástico 5" },
  { name: "saints_philip_and_james", mat_1: "Eclesiástico 7", mat_2: "João 1:43-51", vesp_1: "Eclesiástico 9", vesp_2: nil },
  { name: "saint_barnabas", mat_1: "Eclesiástico 10", mat_2: "Atos 14", vesp_1: "Eclesiástico 12", vesp_2: "Atos 15:1-35" },
  { name: "nativity_of_john_baptist", mat_1: "Malaquias 3", mat_2: "Mateus 3", vesp_1: "Malaquias 4", vesp_2: "Mateus 14:1-12" },
  { name: "saint_pedro", mat_1: "Eclesiástico 15", mat_2: "Atos 3", vesp_1: "Eclesiástico 19", vesp_2: "Atos 4" },
  { name: "saint_james", mat_1: "Eclesiástico 21", vesp_1: "Eclesiástico 22" },
  { name: "saint_bartholomew", mat_1: "Eclesiástico 24", vesp_1: "Eclesiástico 29" },
  { name: "saint_matthew", mat_1: "Eclesiástico 35", vesp_1: "Eclesiástico 38" },
  { name: "saint_michael_and_all_angels", mat_1: "Gênesis 32", mat_2: "Atos 12:1-19", vesp_1: "Daniel 10:5-21", vesp_2: "Judas 6:15" },
  { name: "saint_luke", mat_1: "Eclesiástico 51", vesp_1: "Jó 1" },
  { name: "saints_simon_and_jude", mat_1: "Jó 24-25", vesp_1: "Jó 42" },
  { name: "all_saints", mat_1: "Sabedoria 3:1-9", mat_2: "Hebreus 11:32-12:6", vesp_1: "Sabedoria 5:1-16", vesp_2: "Apocalipse 19:1-16" },
]

holy_days.each do |day|
  readings << {
    date_reference: day[:name],
    service_type: "morning_prayer",
    first_reading: day[:mat_1],
    second_reading: day[:mat_2]
  }
  readings << {
    date_reference: day[:name],
    service_type: "evening_prayer",
    first_reading: day[:vesp_1],
    second_reading: day[:vesp_2]
  }
end

# Inserir no banco
count = 0
skipped = 0

readings.each do |reading|
  reading[:prayer_book_id] = prayer_book.id
  reading[:cycle] = 'all' # LOC 1662 não tem ciclos A/B/C, é único

  existing = LectionaryReading.find_by(
    date_reference: reading[:date_reference],
    service_type: reading[:service_type],
    prayer_book_id: prayer_book.id
  )

  if existing.nil?
    LectionaryReading.create!(reading)
    count += 1
  else
    skipped += 1
  end
end

Rails.logger.info "\n✅ #{count} leituras próprias criadas!"
Rails.logger.info "⏭️  #{skipped} já existiam." if skipped > 0
