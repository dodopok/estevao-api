# ================================================================================
# LEITURAS DIÁRIAS - JANEIRO (LOC 1662)
# ================================================================================

prayer_book = PrayerBook.find_by!(code: 'loc_1662')

readings = [
  # DIA 1 - Circuncisão (Usa Próprias)

  # DIA 2
  { month: 1, day: 2, service_type: 'morning_prayer', first_reading: 'Gênesis 1', second_reading: 'Mateus 1' },
  { month: 1, day: 2, service_type: 'evening_prayer', first_reading: 'Gênesis 2', second_reading: 'Romanos 1' },

  # DIA 3
  { month: 1, day: 3, service_type: 'morning_prayer', first_reading: 'Gênesis 3', second_reading: 'Mateus 2' },
  { month: 1, day: 3, service_type: 'evening_prayer', first_reading: 'Gênesis 4', second_reading: 'Romanos 2' },

  # DIA 4
  { month: 1, day: 4, service_type: 'morning_prayer', first_reading: 'Gênesis 5', second_reading: 'Mateus 3' },
  { month: 1, day: 4, service_type: 'evening_prayer', first_reading: 'Gênesis 6', second_reading: 'Romanos 3' },

  # DIA 5
  { month: 1, day: 5, service_type: 'morning_prayer', first_reading: 'Gênesis 7', second_reading: 'Mateus 4' },
  { month: 1, day: 5, service_type: 'evening_prayer', first_reading: 'Gênesis 8', second_reading: 'Romanos 4' },

  # DIA 6 - Epifania (Usa Próprias)

  # DIA 7
  { month: 1, day: 7, service_type: 'morning_prayer', first_reading: 'Gênesis 9', second_reading: 'Mateus 5' },
  { month: 1, day: 7, service_type: 'evening_prayer', first_reading: 'Gênesis 12', second_reading: 'Romanos 5' },

  # DIA 8
  { month: 1, day: 8, service_type: 'morning_prayer', first_reading: 'Gênesis 13', second_reading: 'Mateus 6' },
  { month: 1, day: 8, service_type: 'evening_prayer', first_reading: 'Gênesis 14', second_reading: 'Romanos 6' },

  # DIA 9
  { month: 1, day: 9, service_type: 'morning_prayer', first_reading: 'Gênesis 15', second_reading: 'Mateus 7' },
  { month: 1, day: 9, service_type: 'evening_prayer', first_reading: 'Gênesis 16', second_reading: 'Romanos 7' },

  # DIA 10
  { month: 1, day: 10, service_type: 'morning_prayer', first_reading: 'Gênesis 17', second_reading: 'Mateus 8' },
  { month: 1, day: 10, service_type: 'evening_prayer', first_reading: 'Gênesis 18', second_reading: 'Romanos 8' },

  # DIA 11
  { month: 1, day: 11, service_type: 'morning_prayer', first_reading: 'Gênesis 19', second_reading: 'Mateus 9' },
  { month: 1, day: 11, service_type: 'evening_prayer', first_reading: 'Gênesis 20', second_reading: 'Romanos 9' },

  # DIA 12
  { month: 1, day: 12, service_type: 'morning_prayer', first_reading: 'Gênesis 21', second_reading: 'Mateus 10' },
  { month: 1, day: 12, service_type: 'evening_prayer', first_reading: 'Gênesis 22', second_reading: 'Romanos 10' },

  # DIA 13
  { month: 1, day: 13, service_type: 'morning_prayer', first_reading: 'Gênesis 23', second_reading: 'Mateus 11' },
  { month: 1, day: 13, service_type: 'evening_prayer', first_reading: 'Gênesis 24', second_reading: 'Romanos 11' },

  # DIA 14
  { month: 1, day: 14, service_type: 'morning_prayer', first_reading: 'Gênesis 25', second_reading: 'Mateus 12' },
  { month: 1, day: 14, service_type: 'evening_prayer', first_reading: 'Gênesis 26', second_reading: 'Romanos 12' },

  # DIA 15
  { month: 1, day: 15, service_type: 'morning_prayer', first_reading: 'Gênesis 27', second_reading: 'Mateus 13' },
  { month: 1, day: 15, service_type: 'evening_prayer', first_reading: 'Gênesis 28', second_reading: 'Romanos 13' },

  # DIA 16
  { month: 1, day: 16, service_type: 'morning_prayer', first_reading: 'Gênesis 29', second_reading: 'Mateus 14' },
  { month: 1, day: 16, service_type: 'evening_prayer', first_reading: 'Gênesis 30', second_reading: 'Romanos 14' },

  # DIA 17
  { month: 1, day: 17, service_type: 'morning_prayer', first_reading: 'Gênesis 31', second_reading: 'Mateus 15' },
  { month: 1, day: 17, service_type: 'evening_prayer', first_reading: 'Gênesis 32', second_reading: 'Romanos 15' },

  # DIA 18
  { month: 1, day: 18, service_type: 'morning_prayer', first_reading: 'Gênesis 33', second_reading: 'Mateus 16' },
  { month: 1, day: 18, service_type: 'evening_prayer', first_reading: 'Gênesis 34', second_reading: 'Romanos 16' },

  # DIA 19
  { month: 1, day: 19, service_type: 'morning_prayer', first_reading: 'Gênesis 35', second_reading: 'Mateus 17' },
  { month: 1, day: 19, service_type: 'evening_prayer', first_reading: 'Gênesis 37', second_reading: '1 Coríntios 1' },

  # DIA 20
  { month: 1, day: 20, service_type: 'morning_prayer', first_reading: 'Gênesis 38', second_reading: 'Mateus 18' },
  { month: 1, day: 20, service_type: 'evening_prayer', first_reading: 'Gênesis 39', second_reading: '1 Coríntios 2' },

  # DIA 21
  { month: 1, day: 21, service_type: 'morning_prayer', first_reading: 'Gênesis 40', second_reading: 'Mateus 19' },
  { month: 1, day: 21, service_type: 'evening_prayer', first_reading: 'Gênesis 41', second_reading: '1 Coríntios 3' },

  # DIA 22
  { month: 1, day: 22, service_type: 'morning_prayer', first_reading: 'Gênesis 42', second_reading: 'Mateus 20' },
  { month: 1, day: 22, service_type: 'evening_prayer', first_reading: 'Gênesis 43', second_reading: '1 Coríntios 4' },

  # DIA 23
  { month: 1, day: 23, service_type: 'morning_prayer', first_reading: 'Gênesis 44', second_reading: 'Mateus 21' },
  { month: 1, day: 23, service_type: 'evening_prayer', first_reading: 'Gênesis 45', second_reading: '1 Coríntios 5' },

  # DIA 24
  { month: 1, day: 24, service_type: 'morning_prayer', first_reading: 'Gênesis 46', second_reading: 'Mateus 22' },
  { month: 1, day: 24, service_type: 'evening_prayer', first_reading: 'Gênesis 47', second_reading: '1 Coríntios 6' },

  # DIA 25 - Conversão de São Paulo (Usa Próprias)

  # DIA 26
  { month: 1, day: 26, service_type: 'morning_prayer', first_reading: 'Gênesis 48', second_reading: 'Mateus 23' },
  { month: 1, day: 26, service_type: 'evening_prayer', first_reading: 'Gênesis 49', second_reading: '1 Coríntios 7' },

  # DIA 27
  { month: 1, day: 27, service_type: 'morning_prayer', first_reading: 'Gênesis 50', second_reading: 'Mateus 24' },
  { month: 1, day: 27, service_type: 'evening_prayer', first_reading: 'Êxodo 1', second_reading: '1 Coríntios 8' },

  # DIA 28
  { month: 1, day: 28, service_type: 'morning_prayer', first_reading: 'Êxodo 2', second_reading: 'Mateus 25' },
  { month: 1, day: 28, service_type: 'evening_prayer', first_reading: 'Êxodo 3', second_reading: '1 Coríntios 9' },

  # DIA 29
  { month: 1, day: 29, service_type: 'morning_prayer', first_reading: 'Êxodo 4', second_reading: 'Mateus 26' },
  { month: 1, day: 29, service_type: 'evening_prayer', first_reading: 'Êxodo 5', second_reading: '1 Coríntios 10' },

  # DIA 30
  { month: 1, day: 30, service_type: 'morning_prayer', first_reading: 'Êxodo 6:1-13', second_reading: 'Mateus 27' },
  { month: 1, day: 30, service_type: 'evening_prayer', first_reading: 'Êxodo 7', second_reading: '1 Coríntios 11' },

  # DIA 31
  { month: 1, day: 31, service_type: 'morning_prayer', first_reading: 'Êxodo 8', second_reading: 'Mateus 28' },
  { month: 1, day: 31, service_type: 'evening_prayer', first_reading: 'Êxodo 9', second_reading: '1 Coríntios 12' }
]

readings.each do |r|
  LectionaryReading.create!(
    prayer_book_id: prayer_book.id,
    date_reference: "#{r[:month]}-#{r[:day]}", # Formato mês-dia para leituras fixas
    cycle: 'all',
    service_type: r[:service_type],
    first_reading: r[:first_reading],
    second_reading: r[:second_reading]
  )
end

Rails.logger.info "✅ Leituras de Janeiro carregadas!"
