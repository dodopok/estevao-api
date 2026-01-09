# ================================================================================
# LEITURAS DIÁRIAS - ABRIL (LOC 1662)
# ================================================================================

prayer_book = PrayerBook.find_by!(code: 'loc_1662')

readings = [
  # DIA 1
  { month: 4, day: 1, service_type: 'morning_prayer', first_reading: '1 Samuel 5', second_reading: 'João 19' },
  { month: 4, day: 1, service_type: 'evening_prayer', first_reading: '1 Samuel 6', second_reading: 'Hebreus 3' },

  # DIA 2
  { month: 4, day: 2, service_type: 'morning_prayer', first_reading: '1 Samuel 7', second_reading: 'João 20' },
  { month: 4, day: 2, service_type: 'evening_prayer', first_reading: '1 Samuel 8', second_reading: 'Hebreus 4' },

  # DIA 3
  { month: 4, day: 3, service_type: 'morning_prayer', first_reading: '1 Samuel 9', second_reading: 'João 21' },
  { month: 4, day: 3, service_type: 'evening_prayer', first_reading: '1 Samuel 10', second_reading: 'Hebreus 5' },

  # DIA 4
  { month: 4, day: 4, service_type: 'morning_prayer', first_reading: '1 Samuel 11', second_reading: 'Atos 1' },
  { month: 4, day: 4, service_type: 'evening_prayer', first_reading: '1 Samuel 12', second_reading: 'Hebreus 6' },

  # DIA 5
  { month: 4, day: 5, service_type: 'morning_prayer', first_reading: '1 Samuel 13', second_reading: 'Atos 2' },
  { month: 4, day: 5, service_type: 'evening_prayer', first_reading: '1 Samuel 14', second_reading: 'Hebreus 7' },

  # DIA 6
  { month: 4, day: 6, service_type: 'morning_prayer', first_reading: '1 Samuel 15', second_reading: 'Atos 3' },
  { month: 4, day: 6, service_type: 'evening_prayer', first_reading: '1 Samuel 16', second_reading: 'Hebreus 8' },

  # DIA 7
  { month: 4, day: 7, service_type: 'morning_prayer', first_reading: '1 Samuel 17', second_reading: 'Atos 4' },
  { month: 4, day: 7, service_type: 'evening_prayer', first_reading: '1 Samuel 18', second_reading: 'Hebreus 9' },

  # DIA 8
  { month: 4, day: 8, service_type: 'morning_prayer', first_reading: '1 Samuel 19', second_reading: 'Atos 5' },
  { month: 4, day: 8, service_type: 'evening_prayer', first_reading: '1 Samuel 20', second_reading: 'Hebreus 10' },

  # DIA 9
  { month: 4, day: 9, service_type: 'morning_prayer', first_reading: '1 Samuel 21', second_reading: 'Atos 6' },
  { month: 4, day: 9, service_type: 'evening_prayer', first_reading: '1 Samuel 22', second_reading: 'Hebreus 11' },

  # DIA 10
  { month: 4, day: 10, service_type: 'morning_prayer', first_reading: '1 Samuel 23', second_reading: 'Atos 7' },
  { month: 4, day: 10, service_type: 'evening_prayer', first_reading: '1 Samuel 24', second_reading: 'Hebreus 12' },

  # DIA 11
  { month: 4, day: 11, service_type: 'morning_prayer', first_reading: '1 Samuel 25', second_reading: 'Atos 8' },
  { month: 4, day: 11, service_type: 'evening_prayer', first_reading: '1 Samuel 26', second_reading: 'Hebreus 13' },

  # DIA 12
  { month: 4, day: 12, service_type: 'morning_prayer', first_reading: '1 Samuel 27', second_reading: 'Atos 9' },
  { month: 4, day: 12, service_type: 'evening_prayer', first_reading: '1 Samuel 28', second_reading: 'Tiago 1' },

  # DIA 13
  { month: 4, day: 13, service_type: 'morning_prayer', first_reading: '1 Samuel 29', second_reading: 'Atos 10' },
  { month: 4, day: 13, service_type: 'evening_prayer', first_reading: '1 Samuel 30', second_reading: 'Tiago 2' },

  # DIA 14
  { month: 4, day: 14, service_type: 'morning_prayer', first_reading: '1 Samuel 31', second_reading: 'Atos 11' },
  { month: 4, day: 14, service_type: 'evening_prayer', first_reading: '2 Samuel 1', second_reading: 'Tiago 3' },

  # DIA 15
  { month: 4, day: 15, service_type: 'morning_prayer', first_reading: '2 Samuel 2', second_reading: 'Atos 12' },
  { month: 4, day: 15, service_type: 'evening_prayer', first_reading: '2 Samuel 3', second_reading: 'Tiago 4' },

  # DIA 16
  { month: 4, day: 16, service_type: 'morning_prayer', first_reading: '2 Samuel 4', second_reading: 'Atos 13' },
  { month: 4, day: 16, service_type: 'evening_prayer', first_reading: '2 Samuel 5', second_reading: 'Tiago 5' },

  # DIA 17
  { month: 4, day: 17, service_type: 'morning_prayer', first_reading: '2 Samuel 6', second_reading: 'Atos 14' },
  { month: 4, day: 17, service_type: 'evening_prayer', first_reading: '2 Samuel 7', second_reading: '1 Pedro 1' },

  # DIA 18
  { month: 4, day: 18, service_type: 'morning_prayer', first_reading: '2 Samuel 8', second_reading: 'Atos 15' },
  { month: 4, day: 18, service_type: 'evening_prayer', first_reading: '2 Samuel 9', second_reading: '1 Pedro 2' },

  # DIA 19
  { month: 4, day: 19, service_type: 'morning_prayer', first_reading: '2 Samuel 10', second_reading: 'Atos 16' },
  { month: 4, day: 19, service_type: 'evening_prayer', first_reading: '2 Samuel 11', second_reading: '1 Pedro 3' },

  # DIA 20
  { month: 4, day: 20, service_type: 'morning_prayer', first_reading: '2 Samuel 12', second_reading: 'Atos 17' },
  { month: 4, day: 20, service_type: 'evening_prayer', first_reading: '2 Samuel 13', second_reading: '1 Pedro 4' },

  # DIA 21
  { month: 4, day: 21, service_type: 'morning_prayer', first_reading: '2 Samuel 14', second_reading: 'Atos 18' },
  { month: 4, day: 21, service_type: 'evening_prayer', first_reading: '2 Samuel 15', second_reading: '1 Pedro 5' },

  # DIA 22
  { month: 4, day: 22, service_type: 'morning_prayer', first_reading: '2 Samuel 16', second_reading: 'Atos 19' },
  { month: 4, day: 22, service_type: 'evening_prayer', first_reading: '2 Samuel 17', second_reading: '2 Pedro 1' },

  # DIA 23
  { month: 4, day: 23, service_type: 'morning_prayer', first_reading: '2 Samuel 18', second_reading: 'Atos 20' },
  { month: 4, day: 23, service_type: 'evening_prayer', first_reading: '2 Samuel 19', second_reading: '2 Pedro 2' },

  # DIA 24
  { month: 4, day: 24, service_type: 'morning_prayer', first_reading: '2 Samuel 20', second_reading: 'Atos 21' },
  { month: 4, day: 24, service_type: 'evening_prayer', first_reading: '2 Samuel 21', second_reading: '2 Pedro 3' },

  # DIA 25 - São Marcos (Proper)
  { month: 4, day: 25, service_type: 'morning_prayer', first_reading: nil, second_reading: 'Atos 22' },
  { month: 4, day: 25, service_type: 'evening_prayer', first_reading: nil, second_reading: '1 João 1' },

  # DIA 26
  { month: 4, day: 26, service_type: 'morning_prayer', first_reading: '2 Samuel 22', second_reading: 'Atos 23' },
  { month: 4, day: 26, service_type: 'evening_prayer', first_reading: '2 Samuel 23', second_reading: '1 João 2' },

  # DIA 27
  { month: 4, day: 27, service_type: 'morning_prayer', first_reading: '2 Samuel 24', second_reading: 'Atos 24' },
  { month: 4, day: 27, service_type: 'evening_prayer', first_reading: '1 Reis 1', second_reading: '1 João 3' },

  # DIA 28
  { month: 4, day: 28, service_type: 'morning_prayer', first_reading: '1 Reis 2', second_reading: 'Atos 25' },
  { month: 4, day: 28, service_type: 'evening_prayer', first_reading: '1 Reis 3', second_reading: '1 João 4' },

  # DIA 29
  { month: 4, day: 29, service_type: 'morning_prayer', first_reading: '1 Reis 4', second_reading: 'Atos 26' },
  { month: 4, day: 29, service_type: 'evening_prayer', first_reading: '1 Reis 5', second_reading: '1 João 5' },

  # DIA 30
  { month: 4, day: 30, service_type: 'morning_prayer', first_reading: '1 Reis 6', second_reading: 'Atos 27' },
  { month: 4, day: 30, service_type: 'evening_prayer', first_reading: '1 Reis 7', second_reading: '2 & 3 João' },
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

Rails.logger.info "✅ Leituras de Abril carregadas!"
