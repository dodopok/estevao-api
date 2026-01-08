# ================================================================================
# LEITURAS DIÁRIAS - MAIO (LOC 1662)
# ================================================================================

prayer_book = PrayerBook.find_by!(code: 'loc_1662')

readings = [
  # DIA 1 - São Filipe e São Tiago (Proper)
  # Daily Lectionary lists Jude for Evening, which fits the sequence.
  { month: 5, day: 1, service_type: 'morning_prayer', first_reading: nil, second_reading: nil },
  { month: 5, day: 1, service_type: 'evening_prayer', first_reading: nil, second_reading: 'Judas' },

  # DIA 2
  { month: 5, day: 2, service_type: 'morning_prayer', first_reading: '1 Reis 8', second_reading: 'Atos 28' },
  { month: 5, day: 2, service_type: 'evening_prayer', first_reading: '1 Reis 9', second_reading: 'Romanos 1' },

  # DIA 3
  { month: 5, day: 3, service_type: 'morning_prayer', first_reading: '1 Reis 10', second_reading: 'Mateus 1' },
  { month: 5, day: 3, service_type: 'evening_prayer', first_reading: '1 Reis 11', second_reading: 'Romanos 2' },

  # DIA 4
  { month: 5, day: 4, service_type: 'morning_prayer', first_reading: '1 Reis 12', second_reading: 'Mateus 2' },
  { month: 5, day: 4, service_type: 'evening_prayer', first_reading: '1 Reis 13', second_reading: 'Romanos 3' },

  # DIA 5
  { month: 5, day: 5, service_type: 'morning_prayer', first_reading: '1 Reis 14', second_reading: 'Mateus 3' },
  { month: 5, day: 5, service_type: 'evening_prayer', first_reading: '1 Reis 15', second_reading: 'Romanos 4' },

  # DIA 6
  { month: 5, day: 6, service_type: 'morning_prayer', first_reading: '1 Reis 16', second_reading: 'Mateus 4' },
  { month: 5, day: 6, service_type: 'evening_prayer', first_reading: '1 Reis 17', second_reading: 'Romanos 5' },

  # DIA 7
  { month: 5, day: 7, service_type: 'morning_prayer', first_reading: '1 Reis 18', second_reading: 'Mateus 5' },
  { month: 5, day: 7, service_type: 'evening_prayer', first_reading: '1 Reis 19', second_reading: 'Romanos 6' },

  # DIA 8
  { month: 5, day: 8, service_type: 'morning_prayer', first_reading: '1 Reis 20', second_reading: 'Mateus 6' },
  { month: 5, day: 8, service_type: 'evening_prayer', first_reading: '1 Reis 21', second_reading: 'Romanos 7' },

  # DIA 9
  { month: 5, day: 9, service_type: 'morning_prayer', first_reading: '1 Reis 22', second_reading: 'Mateus 7' },
  { month: 5, day: 9, service_type: 'evening_prayer', first_reading: '2 Reis 1', second_reading: 'Romanos 8' },

  # DIA 10
  { month: 5, day: 10, service_type: 'morning_prayer', first_reading: '2 Reis 2', second_reading: 'Mateus 8' },
  { month: 5, day: 10, service_type: 'evening_prayer', first_reading: '2 Reis 3', second_reading: 'Romanos 9' },

  # DIA 11
  { month: 5, day: 11, service_type: 'morning_prayer', first_reading: '2 Reis 4', second_reading: 'Mateus 9' },
  { month: 5, day: 11, service_type: 'evening_prayer', first_reading: '2 Reis 5', second_reading: 'Romanos 10' },

  # DIA 12
  { month: 5, day: 12, service_type: 'morning_prayer', first_reading: '2 Reis 6', second_reading: 'Mateus 10' },
  { month: 5, day: 12, service_type: 'evening_prayer', first_reading: '2 Reis 7', second_reading: 'Romanos 11' },

  # DIA 13
  { month: 5, day: 13, service_type: 'morning_prayer', first_reading: '2 Reis 8', second_reading: 'Mateus 11' },
  { month: 5, day: 13, service_type: 'evening_prayer', first_reading: '2 Reis 9', second_reading: 'Romanos 12' },

  # DIA 14
  { month: 5, day: 14, service_type: 'morning_prayer', first_reading: '2 Reis 10', second_reading: 'Mateus 12' },
  { month: 5, day: 14, service_type: 'evening_prayer', first_reading: '2 Reis 11', second_reading: 'Romanos 13' },

  # DIA 15
  { month: 5, day: 15, service_type: 'morning_prayer', first_reading: '2 Reis 12', second_reading: 'Mateus 13' },
  { month: 5, day: 15, service_type: 'evening_prayer', first_reading: '2 Reis 13', second_reading: 'Romanos 14' },

  # DIA 16
  { month: 5, day: 16, service_type: 'morning_prayer', first_reading: '2 Reis 14', second_reading: 'Mateus 14' },
  { month: 5, day: 16, service_type: 'evening_prayer', first_reading: '2 Reis 15', second_reading: 'Romanos 15' },

  # DIA 17
  { month: 5, day: 17, service_type: 'morning_prayer', first_reading: '2 Reis 16', second_reading: 'Mateus 15' },
  { month: 5, day: 17, service_type: 'evening_prayer', first_reading: '2 Reis 17', second_reading: 'Romanos 16' },

  # DIA 18
  { month: 5, day: 18, service_type: 'morning_prayer', first_reading: '2 Reis 18', second_reading: 'Mateus 16' },
  { month: 5, day: 18, service_type: 'evening_prayer', first_reading: '2 Reis 19', second_reading: '1 Coríntios 1' },

  # DIA 19
  { month: 5, day: 19, service_type: 'morning_prayer', first_reading: '2 Reis 20', second_reading: 'Mateus 17' },
  { month: 5, day: 19, service_type: 'evening_prayer', first_reading: '2 Reis 21', second_reading: '1 Coríntios 2' },

  # DIA 20
  { month: 5, day: 20, service_type: 'morning_prayer', first_reading: '2 Reis 22', second_reading: 'Mateus 18' },
  { month: 5, day: 20, service_type: 'evening_prayer', first_reading: '2 Reis 23', second_reading: '1 Coríntios 3' },

  # DIA 21
  { month: 5, day: 21, service_type: 'morning_prayer', first_reading: '2 Reis 24', second_reading: 'Mateus 19' },
  { month: 5, day: 21, service_type: 'evening_prayer', first_reading: '2 Reis 25', second_reading: '1 Coríntios 4' },

  # DIA 22
  { month: 5, day: 22, service_type: 'morning_prayer', first_reading: 'Esdras 1', second_reading: 'Mateus 20' },
  { month: 5, day: 22, service_type: 'evening_prayer', first_reading: 'Esdras 3', second_reading: '1 Coríntios 5' },

  # DIA 23
  { month: 5, day: 23, service_type: 'morning_prayer', first_reading: 'Esdras 4', second_reading: 'Mateus 21' },
  { month: 5, day: 23, service_type: 'evening_prayer', first_reading: 'Esdras 5', second_reading: '1 Coríntios 6' },

  # DIA 24
  { month: 5, day: 24, service_type: 'morning_prayer', first_reading: 'Esdras 6', second_reading: 'Mateus 22' },
  { month: 5, day: 24, service_type: 'evening_prayer', first_reading: 'Esdras 7', second_reading: '1 Coríntios 7' },

  # DIA 25
  { month: 5, day: 25, service_type: 'morning_prayer', first_reading: 'Esdras 9', second_reading: 'Mateus 23' },
  { month: 5, day: 25, service_type: 'evening_prayer', first_reading: 'Neemias 1', second_reading: '1 Coríntios 8' },

  # DIA 26
  { month: 5, day: 26, service_type: 'morning_prayer', first_reading: 'Neemias 2', second_reading: 'Mateus 24' },
  { month: 5, day: 26, service_type: 'evening_prayer', first_reading: 'Neemias 4', second_reading: '1 Coríntios 9' },

  # DIA 27
  { month: 5, day: 27, service_type: 'morning_prayer', first_reading: 'Neemias 5', second_reading: 'Mateus 25' },
  { month: 5, day: 27, service_type: 'evening_prayer', first_reading: 'Neemias 6', second_reading: '1 Coríntios 10' },

  # DIA 28
  { month: 5, day: 28, service_type: 'morning_prayer', first_reading: 'Neemias 8', second_reading: 'Mateus 26' },
  { month: 5, day: 28, service_type: 'evening_prayer', first_reading: 'Neemias 9', second_reading: '1 Coríntios 11' },

  # DIA 29
  { month: 5, day: 29, service_type: 'morning_prayer', first_reading: 'Neemias 10', second_reading: 'Mateus 27' },
  { month: 5, day: 29, service_type: 'evening_prayer', first_reading: 'Neemias 13', second_reading: '1 Coríntios 12' },

  # DIA 30
  { month: 5, day: 30, service_type: 'morning_prayer', first_reading: 'Ester 1', second_reading: 'Mateus 28' },
  { month: 5, day: 30, service_type: 'evening_prayer', first_reading: 'Ester 2', second_reading: '1 Coríntios 13' },

  # DIA 31
  { month: 5, day: 31, service_type: 'morning_prayer', first_reading: 'Ester 3', second_reading: 'Marcos 1' },
  { month: 5, day: 31, service_type: 'evening_prayer', first_reading: 'Ester 4', second_reading: '1 Coríntios 14' },
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

Rails.logger.info "✅ Leituras de Maio carregadas!"
