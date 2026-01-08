# ================================================================================
# LEITURAS DIÁRIAS - JUNHO (LOC 1662)
# ================================================================================

prayer_book = PrayerBook.find_by!(code: 'loc_1662')

readings = [
  # DIA 1
  { month: 6, day: 1, service_type: 'morning_prayer', first_reading: 'Ester 5', second_reading: 'Marcos 2' },
  { month: 6, day: 1, service_type: 'evening_prayer', first_reading: 'Ester 6', second_reading: '1 Coríntios 15' },

  # DIA 2
  { month: 6, day: 2, service_type: 'morning_prayer', first_reading: 'Ester 7', second_reading: 'Marcos 3' },
  { month: 6, day: 2, service_type: 'evening_prayer', first_reading: 'Ester 8', second_reading: '1 Coríntios 16' },

  # DIA 3
  { month: 6, day: 3, service_type: 'morning_prayer', first_reading: 'Ester 9', second_reading: 'Marcos 4' },
  { month: 6, day: 3, service_type: 'evening_prayer', first_reading: 'Jó 1', second_reading: '2 Coríntios 1' },

  # DIA 4
  { month: 6, day: 4, service_type: 'morning_prayer', first_reading: 'Jó 2', second_reading: 'Marcos 5' },
  { month: 6, day: 4, service_type: 'evening_prayer', first_reading: 'Jó 3', second_reading: '2 Coríntios 2' },

  # DIA 5
  { month: 6, day: 5, service_type: 'morning_prayer', first_reading: 'Jó 4', second_reading: 'Marcos 6' },
  { month: 6, day: 5, service_type: 'evening_prayer', first_reading: 'Jó 5', second_reading: '2 Coríntios 3' },

  # DIA 6
  { month: 6, day: 6, service_type: 'morning_prayer', first_reading: 'Jó 6', second_reading: 'Marcos 7' },
  { month: 6, day: 6, service_type: 'evening_prayer', first_reading: 'Jó 7', second_reading: '2 Coríntios 4' },

  # DIA 7
  { month: 6, day: 7, service_type: 'morning_prayer', first_reading: 'Jó 8', second_reading: 'Marcos 8' },
  { month: 6, day: 7, service_type: 'evening_prayer', first_reading: 'Jó 9', second_reading: '2 Coríntios 5' },

  # DIA 8
  { month: 6, day: 8, service_type: 'morning_prayer', first_reading: 'Jó 10', second_reading: 'Marcos 9' },
  { month: 6, day: 8, service_type: 'evening_prayer', first_reading: 'Jó 11', second_reading: '2 Coríntios 6' },

  # DIA 9
  { month: 6, day: 9, service_type: 'morning_prayer', first_reading: 'Jó 12', second_reading: 'Marcos 10' },
  { month: 6, day: 9, service_type: 'evening_prayer', first_reading: 'Jó 13', second_reading: '2 Coríntios 7' },

  # DIA 10
  { month: 6, day: 10, service_type: 'morning_prayer', first_reading: 'Jó 14', second_reading: 'Marcos 11' },
  { month: 6, day: 10, service_type: 'evening_prayer', first_reading: 'Jó 15', second_reading: '2 Coríntios 8' },

  # DIA 11 - São Barnabé (Proper)
  { month: 6, day: 11, service_type: 'morning_prayer', first_reading: nil, second_reading: nil },
  { month: 6, day: 11, service_type: 'evening_prayer', first_reading: nil, second_reading: nil },

  # DIA 12
  { month: 6, day: 12, service_type: 'morning_prayer', first_reading: 'Jó 16', second_reading: 'Marcos 12' },
  { month: 6, day: 12, service_type: 'evening_prayer', first_reading: 'Jó 17-18', second_reading: '2 Coríntios 9' },

  # DIA 13
  { month: 6, day: 13, service_type: 'morning_prayer', first_reading: 'Jó 19', second_reading: 'Marcos 13' },
  { month: 6, day: 13, service_type: 'evening_prayer', first_reading: 'Jó 20', second_reading: '2 Coríntios 10' },

  # DIA 14
  { month: 6, day: 14, service_type: 'morning_prayer', first_reading: 'Jó 21', second_reading: 'Marcos 14' },
  { month: 6, day: 14, service_type: 'evening_prayer', first_reading: 'Jó 22', second_reading: '2 Coríntios 11' },

  # DIA 15
  { month: 6, day: 15, service_type: 'morning_prayer', first_reading: 'Jó 23', second_reading: 'Marcos 15' },
  { month: 6, day: 15, service_type: 'evening_prayer', first_reading: 'Jó 24-25', second_reading: '2 Coríntios 12' },

  # DIA 16
  { month: 6, day: 16, service_type: 'morning_prayer', first_reading: 'Jó 26-27', second_reading: 'Marcos 16' },
  { month: 6, day: 16, service_type: 'evening_prayer', first_reading: 'Jó 28', second_reading: '2 Coríntios 13' },

  # DIA 17
  { month: 6, day: 17, service_type: 'morning_prayer', first_reading: 'Jó 29', second_reading: 'Lucas 1' },
  { month: 6, day: 17, service_type: 'evening_prayer', first_reading: 'Jó 30', second_reading: 'Gálatas 1' },

  # DIA 18
  { month: 6, day: 18, service_type: 'morning_prayer', first_reading: 'Jó 31', second_reading: 'Lucas 2' },
  { month: 6, day: 18, service_type: 'evening_prayer', first_reading: 'Jó 32', second_reading: 'Gálatas 2' },

  # DIA 19
  { month: 6, day: 19, service_type: 'morning_prayer', first_reading: 'Jó 33', second_reading: 'Lucas 3' },
  { month: 6, day: 19, service_type: 'evening_prayer', first_reading: 'Jó 34', second_reading: 'Gálatas 3' },

  # DIA 20
  { month: 6, day: 20, service_type: 'morning_prayer', first_reading: 'Jó 35', second_reading: 'Lucas 4' },
  { month: 6, day: 20, service_type: 'evening_prayer', first_reading: 'Jó 36', second_reading: 'Gálatas 4' },

  # DIA 21
  { month: 6, day: 21, service_type: 'morning_prayer', first_reading: 'Jó 37', second_reading: 'Lucas 5' },
  { month: 6, day: 21, service_type: 'evening_prayer', first_reading: 'Jó 38', second_reading: 'Gálatas 5' },

  # DIA 22
  { month: 6, day: 22, service_type: 'morning_prayer', first_reading: 'Jó 39', second_reading: 'Lucas 6' },
  { month: 6, day: 22, service_type: 'evening_prayer', first_reading: 'Jó 40', second_reading: 'Gálatas 6' },

  # DIA 23
  { month: 6, day: 23, service_type: 'morning_prayer', first_reading: 'Jó 41', second_reading: 'Lucas 7' },
  { month: 6, day: 23, service_type: 'evening_prayer', first_reading: 'Jó 42', second_reading: 'Efésios 1' },

  # DIA 24 - Natividade de João Batista (Proper)
  { month: 6, day: 24, service_type: 'morning_prayer', first_reading: nil, second_reading: nil },
  { month: 6, day: 24, service_type: 'evening_prayer', first_reading: nil, second_reading: nil },

  # DIA 25
  { month: 6, day: 25, service_type: 'morning_prayer', first_reading: 'Provérbios 1', second_reading: 'Lucas 8' },
  { month: 6, day: 25, service_type: 'evening_prayer', first_reading: 'Provérbios 2', second_reading: 'Efésios 2' },

  # DIA 26
  { month: 6, day: 26, service_type: 'morning_prayer', first_reading: 'Provérbios 3', second_reading: 'Lucas 9' },
  { month: 6, day: 26, service_type: 'evening_prayer', first_reading: 'Provérbios 4', second_reading: 'Efésios 3' },

  # DIA 27
  { month: 6, day: 27, service_type: 'morning_prayer', first_reading: 'Provérbios 5', second_reading: 'Lucas 10' },
  { month: 6, day: 27, service_type: 'evening_prayer', first_reading: 'Provérbios 6', second_reading: 'Efésios 4' },

  # DIA 28
  { month: 6, day: 28, service_type: 'morning_prayer', first_reading: 'Provérbios 7', second_reading: 'Lucas 11' },
  { month: 6, day: 28, service_type: 'evening_prayer', first_reading: 'Provérbios 8', second_reading: 'Efésios 5' },

  # DIA 29 - São Pedro (Proper)
  { month: 6, day: 29, service_type: 'morning_prayer', first_reading: nil, second_reading: nil },
  { month: 6, day: 29, service_type: 'evening_prayer', first_reading: nil, second_reading: nil },

  # DIA 30
  { month: 6, day: 30, service_type: 'morning_prayer', first_reading: 'Provérbios 9', second_reading: 'Lucas 12' },
  { month: 6, day: 30, service_type: 'evening_prayer', first_reading: 'Provérbios 10', second_reading: 'Efésios 6' },
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

Rails.logger.info "✅ Leituras de Junho carregadas!"
