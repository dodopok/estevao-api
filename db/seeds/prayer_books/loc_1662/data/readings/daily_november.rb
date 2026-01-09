# ================================================================================
# LEITURAS DIÁRIAS - NOVEMBRO (LOC 1662)
# ================================================================================

prayer_book = PrayerBook.find_by!(code: 'loc_1662')

readings = [
  # DIA 1 - Todos os Santos (Proper)
  { month: 11, day: 1, service_type: 'morning_prayer', first_reading: nil, second_reading: nil },
  { month: 11, day: 1, service_type: 'evening_prayer', first_reading: nil, second_reading: nil },

  # DIA 2
  { month: 11, day: 2, service_type: 'morning_prayer', first_reading: 'Eclesiástico 16', second_reading: 'Lucas 18' },
  { month: 11, day: 2, service_type: 'evening_prayer', first_reading: 'Eclesiástico 17', second_reading: 'Colossenses 2' },

  # DIA 3
  { month: 11, day: 3, service_type: 'morning_prayer', first_reading: 'Eclesiástico 18', second_reading: 'Lucas 19' },
  { month: 11, day: 3, service_type: 'evening_prayer', first_reading: 'Eclesiástico 19', second_reading: 'Colossenses 3' },

  # DIA 4
  { month: 11, day: 4, service_type: 'morning_prayer', first_reading: 'Eclesiástico 20', second_reading: 'Lucas 20' },
  { month: 11, day: 4, service_type: 'evening_prayer', first_reading: 'Eclesiástico 21', second_reading: 'Colossenses 4' },

  # DIA 5
  { month: 11, day: 5, service_type: 'morning_prayer', first_reading: 'Eclesiástico 22', second_reading: 'Lucas 21' },
  { month: 11, day: 5, service_type: 'evening_prayer', first_reading: 'Eclesiástico 23', second_reading: '1 Tessalonicenses 1' },

  # DIA 6
  { month: 11, day: 6, service_type: 'morning_prayer', first_reading: 'Eclesiástico 24', second_reading: 'Lucas 22' },
  { month: 11, day: 6, service_type: 'evening_prayer', first_reading: 'Eclesiástico 25:1-17', second_reading: '1 Tessalonicenses 2' },

  # DIA 7
  { month: 11, day: 7, service_type: 'morning_prayer', first_reading: 'Eclesiástico 27', second_reading: 'Lucas 23' },
  { month: 11, day: 7, service_type: 'evening_prayer', first_reading: 'Eclesiástico 28', second_reading: '1 Tessalonicenses 3' },

  # DIA 8
  { month: 11, day: 8, service_type: 'morning_prayer', first_reading: 'Eclesiástico 29', second_reading: 'Lucas 24' },
  { month: 11, day: 8, service_type: 'evening_prayer', first_reading: 'Eclesiástico 30:1-17', second_reading: '1 Tessalonicenses 4' },

  # DIA 9
  { month: 11, day: 9, service_type: 'morning_prayer', first_reading: 'Eclesiástico 31', second_reading: 'João 1' },
  { month: 11, day: 9, service_type: 'evening_prayer', first_reading: 'Eclesiástico 32', second_reading: '1 Tessalonicenses 5' },

  # DIA 10
  { month: 11, day: 10, service_type: 'morning_prayer', first_reading: 'Eclesiástico 33', second_reading: 'João 2' },
  { month: 11, day: 10, service_type: 'evening_prayer', first_reading: 'Eclesiástico 34', second_reading: '2 Tessalonicenses 1' },

  # DIA 11
  { month: 11, day: 11, service_type: 'morning_prayer', first_reading: 'Eclesiástico 35', second_reading: 'João 3' },
  { month: 11, day: 11, service_type: 'evening_prayer', first_reading: 'Eclesiástico 36', second_reading: '2 Tessalonicenses 2' },

  # DIA 12
  { month: 11, day: 12, service_type: 'morning_prayer', first_reading: 'Eclesiástico 37', second_reading: 'João 4' },
  { month: 11, day: 12, service_type: 'evening_prayer', first_reading: 'Eclesiástico 38', second_reading: '2 Tessalonicenses 3' },

  # DIA 13
  { month: 11, day: 13, service_type: 'morning_prayer', first_reading: 'Eclesiástico 39', second_reading: 'João 5' },
  { month: 11, day: 13, service_type: 'evening_prayer', first_reading: 'Eclesiástico 40', second_reading: '1 Timóteo 1' },

  # DIA 14
  { month: 11, day: 14, service_type: 'morning_prayer', first_reading: 'Eclesiástico 41', second_reading: 'João 6' },
  { month: 11, day: 14, service_type: 'evening_prayer', first_reading: 'Eclesiástico 42', second_reading: '1 Timóteo 2-3' },

  # DIA 15
  { month: 11, day: 15, service_type: 'morning_prayer', first_reading: 'Eclesiástico 43', second_reading: 'João 7' },
  { month: 11, day: 15, service_type: 'evening_prayer', first_reading: 'Eclesiástico 44', second_reading: '1 Timóteo 4' },

  # DIA 16
  { month: 11, day: 16, service_type: 'morning_prayer', first_reading: 'Eclesiástico 45', second_reading: 'João 8' },
  { month: 11, day: 16, service_type: 'evening_prayer', first_reading: 'Eclesiástico 46:1-19', second_reading: '1 Timóteo 5' },

  # DIA 17
  { month: 11, day: 17, service_type: 'morning_prayer', first_reading: 'Eclesiástico 47', second_reading: 'João 9' },
  { month: 11, day: 17, service_type: 'evening_prayer', first_reading: 'Eclesiástico 48', second_reading: '1 Timóteo 6' },

  # DIA 18
  { month: 11, day: 18, service_type: 'morning_prayer', first_reading: 'Eclesiástico 49', second_reading: 'João 10' },
  { month: 11, day: 18, service_type: 'evening_prayer', first_reading: 'Eclesiástico 50', second_reading: '2 Timóteo 1' },

  # DIA 19
  { month: 11, day: 19, service_type: 'morning_prayer', first_reading: 'Eclesiástico 51', second_reading: 'João 11' },
  { month: 11, day: 19, service_type: 'evening_prayer', first_reading: 'Baruque 1', second_reading: '2 Timóteo 2' },

  # DIA 20
  { month: 11, day: 20, service_type: 'morning_prayer', first_reading: 'Baruque 2', second_reading: 'João 12' },
  { month: 11, day: 20, service_type: 'evening_prayer', first_reading: 'Baruque 3', second_reading: '2 Timóteo 3' },

  # DIA 21
  { month: 11, day: 21, service_type: 'morning_prayer', first_reading: 'Baruque 4', second_reading: 'João 13' },
  { month: 11, day: 21, service_type: 'evening_prayer', first_reading: 'Baruque 5', second_reading: '2 Timóteo 4' },

  # DIA 22
  { month: 11, day: 22, service_type: 'morning_prayer', first_reading: 'Baruque 6', second_reading: 'João 14' },
  { month: 11, day: 22, service_type: 'evening_prayer', first_reading: 'Susana', second_reading: 'Tito 1' },

  # DIA 23
  { month: 11, day: 23, service_type: 'morning_prayer', first_reading: 'Bel e o Dragão', second_reading: 'João 15' },
  { month: 11, day: 23, service_type: 'evening_prayer', first_reading: 'Isaías 1', second_reading: 'Tito 2-3' },

  # DIA 24
  { month: 11, day: 24, service_type: 'morning_prayer', first_reading: 'Isaías 2', second_reading: 'João 16' },
  { month: 11, day: 24, service_type: 'evening_prayer', first_reading: 'Isaías 3', second_reading: 'Filemom' },

  # DIA 25
  { month: 11, day: 25, service_type: 'morning_prayer', first_reading: 'Isaías 4', second_reading: 'João 17' },
  { month: 11, day: 25, service_type: 'evening_prayer', first_reading: 'Isaías 5', second_reading: 'Hebreus 1' },

  # DIA 26
  { month: 11, day: 26, service_type: 'morning_prayer', first_reading: 'Isaías 6', second_reading: 'João 18' },
  { month: 11, day: 26, service_type: 'evening_prayer', first_reading: 'Isaías 7', second_reading: 'Hebreus 2' },

  # DIA 27
  { month: 11, day: 27, service_type: 'morning_prayer', first_reading: 'Isaías 8', second_reading: 'João 19' },
  { month: 11, day: 27, service_type: 'evening_prayer', first_reading: 'Isaías 9', second_reading: 'Hebreus 3' },

  # DIA 28
  { month: 11, day: 28, service_type: 'morning_prayer', first_reading: 'Isaías 10', second_reading: 'João 20' },
  { month: 11, day: 28, service_type: 'evening_prayer', first_reading: 'Isaías 11', second_reading: 'Hebreus 4' },

  # DIA 29
  { month: 11, day: 29, service_type: 'morning_prayer', first_reading: 'Isaías 12', second_reading: 'João 21' },
  { month: 11, day: 29, service_type: 'evening_prayer', first_reading: 'Isaías 13', second_reading: 'Hebreus 5' },

  # DIA 30 - Santo André (Proper)
  # Uses Daily 2nd readings
  { month: 11, day: 30, service_type: 'morning_prayer', first_reading: nil, second_reading: 'Atos 1' },
  { month: 11, day: 30, service_type: 'evening_prayer', first_reading: nil, second_reading: 'Hebreus 6' },
]

readings.each do |r|
  LectionaryReading.create!(
    prayer_book_id: prayer_book.id,
    date_reference: "#{r[:month]}-#{r[:day]}",
    cycle: 'daily',
    service_type: r[:service_type],
    first_reading: r[:first_reading],
    second_reading: r[:second_reading]
  )
end

Rails.logger.info "✅ Leituras de Novembro carregadas!"
