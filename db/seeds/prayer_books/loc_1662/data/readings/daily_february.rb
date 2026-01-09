# ================================================================================
# LEITURAS DIÁRIAS - FEVEREIRO (LOC 1662)
# ================================================================================

prayer_book = PrayerBook.find_by!(code: 'loc_1662')

readings = [
  # DIA 1
  { month: 2, day: 1, service_type: 'morning_prayer', first_reading: 'Êxodo 10', second_reading: 'Marcos 1' },
  { month: 2, day: 1, service_type: 'evening_prayer', first_reading: 'Êxodo 11', second_reading: '1 Coríntios 13' },

  # DIA 2 - Purificação de Maria (Proper)
  { month: 2, day: 2, service_type: 'morning_prayer', first_reading: nil, second_reading: 'Marcos 2' },
  { month: 2, day: 2, service_type: 'evening_prayer', first_reading: nil, second_reading: '1 Coríntios 14' },

  # DIA 3
  { month: 2, day: 3, service_type: 'morning_prayer', first_reading: 'Êxodo 12', second_reading: 'Marcos 3' },
  { month: 2, day: 3, service_type: 'evening_prayer', first_reading: 'Êxodo 13', second_reading: '1 Coríntios 15' },

  # DIA 4
  { month: 2, day: 4, service_type: 'morning_prayer', first_reading: 'Êxodo 14', second_reading: 'Marcos 4' },
  { month: 2, day: 4, service_type: 'evening_prayer', first_reading: 'Êxodo 15', second_reading: '1 Coríntios 16' },

  # DIA 5
  { month: 2, day: 5, service_type: 'morning_prayer', first_reading: 'Êxodo 16', second_reading: 'Marcos 5' },
  { month: 2, day: 5, service_type: 'evening_prayer', first_reading: 'Êxodo 17', second_reading: '2 Coríntios 1' },

  # DIA 6
  { month: 2, day: 6, service_type: 'morning_prayer', first_reading: 'Êxodo 18', second_reading: 'Marcos 6' },
  { month: 2, day: 6, service_type: 'evening_prayer', first_reading: 'Êxodo 19', second_reading: '2 Coríntios 2' },

  # DIA 7
  { month: 2, day: 7, service_type: 'morning_prayer', first_reading: 'Êxodo 20', second_reading: 'Marcos 7' },
  { month: 2, day: 7, service_type: 'evening_prayer', first_reading: 'Êxodo 21', second_reading: '2 Coríntios 3' },

  # DIA 8
  { month: 2, day: 8, service_type: 'morning_prayer', first_reading: 'Êxodo 22', second_reading: 'Marcos 8' },
  { month: 2, day: 8, service_type: 'evening_prayer', first_reading: 'Êxodo 23', second_reading: '2 Coríntios 4' },

  # DIA 9
  { month: 2, day: 9, service_type: 'morning_prayer', first_reading: 'Êxodo 24', second_reading: 'Marcos 9' },
  { month: 2, day: 9, service_type: 'evening_prayer', first_reading: 'Êxodo 32', second_reading: '2 Coríntios 5' },

  # DIA 10
  { month: 2, day: 10, service_type: 'morning_prayer', first_reading: 'Êxodo 33', second_reading: 'Marcos 10' },
  { month: 2, day: 10, service_type: 'evening_prayer', first_reading: 'Êxodo 34', second_reading: '2 Coríntios 6' },

  # DIA 11
  { month: 2, day: 11, service_type: 'morning_prayer', first_reading: 'Levítico 18', second_reading: 'Marcos 11' },
  { month: 2, day: 11, service_type: 'evening_prayer', first_reading: 'Levítico 19', second_reading: '2 Coríntios 7' },

  # DIA 12
  { month: 2, day: 12, service_type: 'morning_prayer', first_reading: 'Levítico 20', second_reading: 'Marcos 12' },
  { month: 2, day: 12, service_type: 'evening_prayer', first_reading: 'Levítico 26', second_reading: '2 Coríntios 8' },

  # DIA 13
  { month: 2, day: 13, service_type: 'morning_prayer', first_reading: 'Números 11', second_reading: 'Marcos 13' },
  { month: 2, day: 13, service_type: 'evening_prayer', first_reading: 'Números 12', second_reading: '2 Coríntios 9' },

  # DIA 14
  { month: 2, day: 14, service_type: 'morning_prayer', first_reading: 'Números 13', second_reading: 'Marcos 14' },
  { month: 2, day: 14, service_type: 'evening_prayer', first_reading: 'Números 14', second_reading: '2 Coríntios 10' },

  # DIA 15
  { month: 2, day: 15, service_type: 'morning_prayer', first_reading: 'Números 16', second_reading: 'Marcos 15' },
  { month: 2, day: 15, service_type: 'evening_prayer', first_reading: 'Números 17', second_reading: '2 Coríntios 11' },

  # DIA 16
  { month: 2, day: 16, service_type: 'morning_prayer', first_reading: 'Números 20', second_reading: 'Marcos 16' },
  { month: 2, day: 16, service_type: 'evening_prayer', first_reading: 'Números 21', second_reading: '2 Coríntios 12' },

  # DIA 17
  { month: 2, day: 17, service_type: 'morning_prayer', first_reading: 'Números 22', second_reading: 'Lucas 1:1-38' },
  { month: 2, day: 17, service_type: 'evening_prayer', first_reading: 'Números 23', second_reading: '2 Coríntios 13' },

  # DIA 18
  { month: 2, day: 18, service_type: 'morning_prayer', first_reading: 'Números 24', second_reading: 'Lucas 1:39-80' },
  { month: 2, day: 18, service_type: 'evening_prayer', first_reading: 'Números 25', second_reading: 'Gálatas 1' },

  # DIA 19
  { month: 2, day: 19, service_type: 'morning_prayer', first_reading: 'Números 27', second_reading: 'Lucas 2' },
  { month: 2, day: 19, service_type: 'evening_prayer', first_reading: 'Números 30', second_reading: 'Gálatas 2' },

  # DIA 20
  { month: 2, day: 20, service_type: 'morning_prayer', first_reading: 'Números 31', second_reading: 'Lucas 3' },
  { month: 2, day: 20, service_type: 'evening_prayer', first_reading: 'Números 32', second_reading: 'Gálatas 3' },

  # DIA 21
  { month: 2, day: 21, service_type: 'morning_prayer', first_reading: 'Números 35', second_reading: 'Lucas 4' },
  { month: 2, day: 21, service_type: 'evening_prayer', first_reading: 'Números 36', second_reading: 'Gálatas 4' },

  # DIA 22
  { month: 2, day: 22, service_type: 'morning_prayer', first_reading: 'Deuteronômio 1', second_reading: 'Lucas 5' },
  { month: 2, day: 22, service_type: 'evening_prayer', first_reading: 'Deuteronômio 2', second_reading: 'Gálatas 5' },

  # DIA 23
  { month: 2, day: 23, service_type: 'morning_prayer', first_reading: 'Deuteronômio 3', second_reading: 'Lucas 6' },
  { month: 2, day: 23, service_type: 'evening_prayer', first_reading: 'Deuteronômio 4', second_reading: 'Gálatas 6' },

  # DIA 24 - São Matias (Proper)
  { month: 2, day: 24, service_type: 'morning_prayer', first_reading: nil, second_reading: 'Lucas 7' },
  { month: 2, day: 24, service_type: 'evening_prayer', first_reading: nil, second_reading: 'Efésios 1' },

  # DIA 25
  { month: 2, day: 25, service_type: 'morning_prayer', first_reading: 'Deuteronômio 5', second_reading: 'Lucas 8' },
  { month: 2, day: 25, service_type: 'evening_prayer', first_reading: 'Deuteronômio 6', second_reading: 'Efésios 2' },

  # DIA 26
  { month: 2, day: 26, service_type: 'morning_prayer', first_reading: 'Deuteronômio 7', second_reading: 'Lucas 9' },
  { month: 2, day: 26, service_type: 'evening_prayer', first_reading: 'Deuteronômio 8', second_reading: 'Efésios 3' },

  # DIA 27
  { month: 2, day: 27, service_type: 'morning_prayer', first_reading: 'Deuteronômio 9', second_reading: 'Lucas 10' },
  { month: 2, day: 27, service_type: 'evening_prayer', first_reading: 'Deuteronômio 10', second_reading: 'Efésios 4' },

  # DIA 28
  { month: 2, day: 28, service_type: 'morning_prayer', first_reading: 'Deuteronômio 11', second_reading: 'Lucas 11' },
  { month: 2, day: 28, service_type: 'evening_prayer', first_reading: 'Deuteronômio 12', second_reading: 'Efésios 5' },

  # DIA 29 (Bissexto)
  { month: 2, day: 29, service_type: 'morning_prayer', first_reading: 'Deuteronômio 13', second_reading: 'Mateus 7' },
  { month: 2, day: 29, service_type: 'evening_prayer', first_reading: 'Deuteronômio 14', second_reading: 'Romanos 12' }
]

readings.each do |r|
  LectionaryReading.create!(
    prayer_book_id: prayer_book.id,
    date_reference: "#{r[:month]}-#{r[:day]}",
    cycle: 'all',
    service_type: r[:service_type],
    first_reading: r[:first_reading],
    second_reading: r[:second_reading]
  )
end

Rails.logger.info "✅ Leituras de Fevereiro carregadas!"
