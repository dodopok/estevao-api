# ================================================================================
# LEITURAS DIÁRIAS - OUTUBRO (LOC 1662)
# ================================================================================

prayer_book = PrayerBook.find_by!(code: 'loc_1662')

readings = [
  # DIA 1
  { month: 10, day: 1, service_type: 'morning_prayer', first_reading: 'Tobias 7', second_reading: 'Marcos 4' },
  { month: 10, day: 1, service_type: 'evening_prayer', first_reading: 'Tobias 8', second_reading: '1 Coríntios 16' },

  # DIA 2
  { month: 10, day: 2, service_type: 'morning_prayer', first_reading: 'Tobias 9', second_reading: 'Marcos 5' },
  { month: 10, day: 2, service_type: 'evening_prayer', first_reading: 'Tobias 10', second_reading: '2 Coríntios 1' },

  # DIA 3
  { month: 10, day: 3, service_type: 'morning_prayer', first_reading: 'Tobias 11', second_reading: 'Marcos 6' },
  { month: 10, day: 3, service_type: 'evening_prayer', first_reading: 'Tobias 12', second_reading: '2 Coríntios 2' },

  # DIA 4
  { month: 10, day: 4, service_type: 'morning_prayer', first_reading: 'Tobias 13', second_reading: 'Marcos 7' },
  { month: 10, day: 4, service_type: 'evening_prayer', first_reading: 'Tobias 14', second_reading: '2 Coríntios 3' },

  # DIA 5
  { month: 10, day: 5, service_type: 'morning_prayer', first_reading: 'Judite 1', second_reading: 'Marcos 8' },
  { month: 10, day: 5, service_type: 'evening_prayer', first_reading: 'Judite 2', second_reading: '2 Coríntios 4' },

  # DIA 6
  { month: 10, day: 6, service_type: 'morning_prayer', first_reading: 'Judite 3', second_reading: 'Marcos 9' },
  { month: 10, day: 6, service_type: 'evening_prayer', first_reading: 'Judite 4', second_reading: '2 Coríntios 5' },

  # DIA 7
  { month: 10, day: 7, service_type: 'morning_prayer', first_reading: 'Judite 5', second_reading: 'Marcos 10' },
  { month: 10, day: 7, service_type: 'evening_prayer', first_reading: 'Judite 6', second_reading: '2 Coríntios 6' },

  # DIA 8
  { month: 10, day: 8, service_type: 'morning_prayer', first_reading: 'Judite 7', second_reading: 'Marcos 11' },
  { month: 10, day: 8, service_type: 'evening_prayer', first_reading: 'Judite 8', second_reading: '2 Coríntios 7' },

  # DIA 9
  { month: 10, day: 9, service_type: 'morning_prayer', first_reading: 'Judite 9', second_reading: 'Marcos 12' },
  { month: 10, day: 9, service_type: 'evening_prayer', first_reading: 'Judite 10', second_reading: '2 Coríntios 8' },

  # DIA 10
  { month: 10, day: 10, service_type: 'morning_prayer', first_reading: 'Judite 11', second_reading: 'Marcos 13' },
  { month: 10, day: 10, service_type: 'evening_prayer', first_reading: 'Judite 12', second_reading: '2 Coríntios 9' },

  # DIA 11
  { month: 10, day: 11, service_type: 'morning_prayer', first_reading: 'Judite 13', second_reading: 'Marcos 14' },
  { month: 10, day: 11, service_type: 'evening_prayer', first_reading: 'Judite 14', second_reading: '2 Coríntios 10' },

  # DIA 12
  { month: 10, day: 12, service_type: 'morning_prayer', first_reading: 'Judite 15', second_reading: 'Marcos 15' },
  { month: 10, day: 12, service_type: 'evening_prayer', first_reading: 'Judite 16', second_reading: '2 Coríntios 11' },

  # DIA 13
  { month: 10, day: 13, service_type: 'morning_prayer', first_reading: 'Sabedoria 1', second_reading: 'Marcos 16' },
  { month: 10, day: 13, service_type: 'evening_prayer', first_reading: 'Sabedoria 2', second_reading: '2 Coríntios 12' },

  # DIA 14
  { month: 10, day: 14, service_type: 'morning_prayer', first_reading: 'Sabedoria 3', second_reading: 'Lucas 1:1-38' },
  { month: 10, day: 14, service_type: 'evening_prayer', first_reading: 'Sabedoria 4', second_reading: '2 Coríntios 13' },

  # DIA 15
  { month: 10, day: 15, service_type: 'morning_prayer', first_reading: 'Sabedoria 5', second_reading: 'Lucas 1:39-80' },
  { month: 10, day: 15, service_type: 'evening_prayer', first_reading: 'Sabedoria 6', second_reading: 'Gálatas 1' },

  # DIA 16
  { month: 10, day: 16, service_type: 'morning_prayer', first_reading: 'Sabedoria 7', second_reading: 'Lucas 2' },
  { month: 10, day: 16, service_type: 'evening_prayer', first_reading: 'Sabedoria 8', second_reading: 'Gálatas 2' },

  # DIA 17
  { month: 10, day: 17, service_type: 'morning_prayer', first_reading: 'Sabedoria 9', second_reading: 'Lucas 3' },
  { month: 10, day: 17, service_type: 'evening_prayer', first_reading: 'Sabedoria 10', second_reading: 'Gálatas 3' },

  # DIA 18 - São Lucas (Proper)
  # Uses Daily 2nd readings
  { month: 10, day: 18, service_type: 'morning_prayer', first_reading: nil, second_reading: 'Lucas 4' },
  { month: 10, day: 18, service_type: 'evening_prayer', first_reading: nil, second_reading: 'Gálatas 4' },

  # DIA 19
  { month: 10, day: 19, service_type: 'morning_prayer', first_reading: 'Sabedoria 11', second_reading: 'Lucas 5' },
  { month: 10, day: 19, service_type: 'evening_prayer', first_reading: 'Sabedoria 12', second_reading: 'Gálatas 5' },

  # DIA 20
  { month: 10, day: 20, service_type: 'morning_prayer', first_reading: 'Sabedoria 13', second_reading: 'Lucas 6' },
  { month: 10, day: 20, service_type: 'evening_prayer', first_reading: 'Sabedoria 14', second_reading: 'Gálatas 6' },

  # DIA 21
  { month: 10, day: 21, service_type: 'morning_prayer', first_reading: 'Sabedoria 15', second_reading: 'Lucas 7' },
  { month: 10, day: 21, service_type: 'evening_prayer', first_reading: 'Sabedoria 16', second_reading: 'Efésios 1' },

  # DIA 22
  { month: 10, day: 22, service_type: 'morning_prayer', first_reading: 'Sabedoria 17', second_reading: 'Lucas 8' },
  { month: 10, day: 22, service_type: 'evening_prayer', first_reading: 'Sabedoria 18', second_reading: 'Efésios 2' },

  # DIA 23
  { month: 10, day: 23, service_type: 'morning_prayer', first_reading: 'Sabedoria 19', second_reading: 'Lucas 9' },
  { month: 10, day: 23, service_type: 'evening_prayer', first_reading: 'Eclesiástico 1', second_reading: 'Efésios 3' },

  # DIA 24
  { month: 10, day: 24, service_type: 'morning_prayer', first_reading: 'Eclesiástico 2', second_reading: 'Lucas 10' },
  { month: 10, day: 24, service_type: 'evening_prayer', first_reading: 'Eclesiástico 3', second_reading: 'Efésios 4' },

  # DIA 25
  { month: 10, day: 25, service_type: 'morning_prayer', first_reading: 'Eclesiástico 4', second_reading: 'Lucas 11' },
  { month: 10, day: 25, service_type: 'evening_prayer', first_reading: 'Eclesiástico 5', second_reading: 'Efésios 5' },

  # DIA 26
  { month: 10, day: 26, service_type: 'morning_prayer', first_reading: 'Eclesiástico 6', second_reading: 'Lucas 12' },
  { month: 10, day: 26, service_type: 'evening_prayer', first_reading: 'Eclesiástico 7', second_reading: 'Efésios 6' },

  # DIA 27
  { month: 10, day: 27, service_type: 'morning_prayer', first_reading: 'Eclesiástico 8', second_reading: 'Lucas 13' },
  { month: 10, day: 27, service_type: 'evening_prayer', first_reading: 'Eclesiástico 9', second_reading: 'Filipenses 1' },

  # DIA 28 - São Simão e São Judas (Proper)
  # Uses Daily 2nd readings
  { month: 10, day: 28, service_type: 'morning_prayer', first_reading: nil, second_reading: 'Lucas 14' },
  { month: 10, day: 28, service_type: 'evening_prayer', first_reading: nil, second_reading: 'Filipenses 2' },

  # DIA 29
  { month: 10, day: 29, service_type: 'morning_prayer', first_reading: 'Eclesiástico 10', second_reading: 'Lucas 15' },
  { month: 10, day: 29, service_type: 'evening_prayer', first_reading: 'Eclesiástico 11', second_reading: 'Filipenses 3' },

  # DIA 30
  { month: 10, day: 30, service_type: 'morning_prayer', first_reading: 'Eclesiástico 12', second_reading: 'Lucas 16' },
  { month: 10, day: 30, service_type: 'evening_prayer', first_reading: 'Eclesiástico 13', second_reading: 'Filipenses 4' },

  # DIA 31
  { month: 10, day: 31, service_type: 'morning_prayer', first_reading: 'Eclesiástico 14', second_reading: 'Lucas 17' },
  { month: 10, day: 31, service_type: 'evening_prayer', first_reading: 'Eclesiástico 15', second_reading: 'Colossenses 1' },
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

Rails.logger.info "✅ Leituras de Outubro carregadas!"
