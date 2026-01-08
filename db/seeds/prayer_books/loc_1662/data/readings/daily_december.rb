# ================================================================================
# LEITURAS DIÁRIAS - DEZEMBRO (LOC 1662)
# ================================================================================

prayer_book = PrayerBook.find_by!(code: 'loc_1662')

readings = [
  # DIA 1
  { month: 12, day: 1, service_type: 'morning_prayer', first_reading: 'Isaías 14', second_reading: 'Atos 2' },
  { month: 12, day: 1, service_type: 'evening_prayer', first_reading: 'Isaías 15', second_reading: 'Hebreus 7' },

  # DIA 2
  { month: 12, day: 2, service_type: 'morning_prayer', first_reading: 'Isaías 16', second_reading: 'Atos 3' },
  { month: 12, day: 2, service_type: 'evening_prayer', first_reading: 'Isaías 17', second_reading: 'Hebreus 8' },

  # DIA 3
  { month: 12, day: 3, service_type: 'morning_prayer', first_reading: 'Isaías 18', second_reading: 'Atos 4' },
  { month: 12, day: 3, service_type: 'evening_prayer', first_reading: 'Isaías 19', second_reading: 'Hebreus 9' },

  # DIA 4
  { month: 12, day: 4, service_type: 'morning_prayer', first_reading: 'Isaías 20-21', second_reading: 'Atos 5' },
  { month: 12, day: 4, service_type: 'evening_prayer', first_reading: 'Isaías 22', second_reading: 'Hebreus 10' },

  # DIA 5
  { month: 12, day: 5, service_type: 'morning_prayer', first_reading: 'Isaías 23', second_reading: 'Atos 6' },
  { month: 12, day: 5, service_type: 'evening_prayer', first_reading: 'Isaías 24', second_reading: 'Hebreus 11' },

  # DIA 6
  { month: 12, day: 6, service_type: 'morning_prayer', first_reading: 'Isaías 25', second_reading: 'Atos 7:1-29' },
  { month: 12, day: 6, service_type: 'evening_prayer', first_reading: 'Isaías 26', second_reading: 'Hebreus 12' },

  # DIA 7
  { month: 12, day: 7, service_type: 'morning_prayer', first_reading: 'Isaías 27', second_reading: 'Atos 7:30-60' },
  { month: 12, day: 7, service_type: 'evening_prayer', first_reading: 'Isaías 28', second_reading: 'Hebreus 13' },

  # DIA 8
  { month: 12, day: 8, service_type: 'morning_prayer', first_reading: 'Isaías 29', second_reading: 'Atos 8' },
  { month: 12, day: 8, service_type: 'evening_prayer', first_reading: 'Isaías 30', second_reading: 'Tiago 1' },

  # DIA 9
  { month: 12, day: 9, service_type: 'morning_prayer', first_reading: 'Isaías 31', second_reading: 'Atos 9' },
  { month: 12, day: 9, service_type: 'evening_prayer', first_reading: 'Isaías 32', second_reading: 'Tiago 2' },

  # DIA 10
  { month: 12, day: 10, service_type: 'morning_prayer', first_reading: 'Isaías 33', second_reading: 'Atos 10' },
  { month: 12, day: 10, service_type: 'evening_prayer', first_reading: 'Isaías 34', second_reading: 'Tiago 3' },

  # DIA 11
  { month: 12, day: 11, service_type: 'morning_prayer', first_reading: 'Isaías 35', second_reading: 'Atos 11' },
  { month: 12, day: 11, service_type: 'evening_prayer', first_reading: 'Isaías 36', second_reading: 'Tiago 4' },

  # DIA 12
  { month: 12, day: 12, service_type: 'morning_prayer', first_reading: 'Isaías 37', second_reading: 'Atos 12' },
  { month: 12, day: 12, service_type: 'evening_prayer', first_reading: 'Isaías 38', second_reading: 'Tiago 5' },

  # DIA 13
  { month: 12, day: 13, service_type: 'morning_prayer', first_reading: 'Isaías 39', second_reading: 'Atos 13' },
  { month: 12, day: 13, service_type: 'evening_prayer', first_reading: 'Isaías 40', second_reading: '1 Pedro 1' },

  # DIA 14
  { month: 12, day: 14, service_type: 'morning_prayer', first_reading: 'Isaías 41', second_reading: 'Atos 14' },
  { month: 12, day: 14, service_type: 'evening_prayer', first_reading: 'Isaías 42', second_reading: '1 Pedro 2' },

  # DIA 15
  { month: 12, day: 15, service_type: 'morning_prayer', first_reading: 'Isaías 43', second_reading: 'Atos 15' },
  { month: 12, day: 15, service_type: 'evening_prayer', first_reading: 'Isaías 44', second_reading: '1 Pedro 3' },

  # DIA 16
  { month: 12, day: 16, service_type: 'morning_prayer', first_reading: 'Isaías 45', second_reading: 'Atos 16' },
  { month: 12, day: 16, service_type: 'evening_prayer', first_reading: 'Isaías 46', second_reading: '1 Pedro 4' },

  # DIA 17
  { month: 12, day: 17, service_type: 'morning_prayer', first_reading: 'Isaías 47', second_reading: 'Atos 17' },
  { month: 12, day: 17, service_type: 'evening_prayer', first_reading: 'Isaías 48', second_reading: '1 Pedro 5' },

  # DIA 18
  { month: 12, day: 18, service_type: 'morning_prayer', first_reading: 'Isaías 49', second_reading: 'Atos 18' },
  { month: 12, day: 18, service_type: 'evening_prayer', first_reading: 'Isaías 50', second_reading: '2 Pedro 1' },

  # DIA 19
  { month: 12, day: 19, service_type: 'morning_prayer', first_reading: 'Isaías 51', second_reading: 'Atos 19' },
  { month: 12, day: 19, service_type: 'evening_prayer', first_reading: 'Isaías 52', second_reading: '2 Pedro 2' },

  # DIA 20
  { month: 12, day: 20, service_type: 'morning_prayer', first_reading: 'Isaías 53', second_reading: 'Atos 20' },
  { month: 12, day: 20, service_type: 'evening_prayer', first_reading: 'Isaías 54', second_reading: '2 Pedro 3' },

  # DIA 21 - São Tomé (Proper)
  # Uses Daily 2nd readings
  { month: 12, day: 21, service_type: 'morning_prayer', first_reading: nil, second_reading: 'Atos 21' },
  { month: 12, day: 21, service_type: 'evening_prayer', first_reading: nil, second_reading: '1 João 1' },

  # DIA 22
  { month: 12, day: 22, service_type: 'morning_prayer', first_reading: 'Isaías 55', second_reading: 'Atos 22' },
  { month: 12, day: 22, service_type: 'evening_prayer', first_reading: 'Isaías 56', second_reading: '1 João 2' },

  # DIA 23
  { month: 12, day: 23, service_type: 'morning_prayer', first_reading: 'Isaías 57', second_reading: 'Atos 23' },
  { month: 12, day: 23, service_type: 'evening_prayer', first_reading: 'Isaías 58', second_reading: '1 João 3' },

  # DIA 24
  { month: 12, day: 24, service_type: 'morning_prayer', first_reading: 'Isaías 59', second_reading: 'Atos 24' },
  { month: 12, day: 24, service_type: 'evening_prayer', first_reading: 'Isaías 60', second_reading: '1 João 4' },

  # DIA 25 - Natal (Proper)
  { month: 12, day: 25, service_type: 'morning_prayer', first_reading: nil, second_reading: nil },
  { month: 12, day: 25, service_type: 'evening_prayer', first_reading: nil, second_reading: nil },

  # DIA 26 - Santo Estevão (Proper)
  { month: 12, day: 26, service_type: 'morning_prayer', first_reading: nil, second_reading: nil },
  { month: 12, day: 26, service_type: 'evening_prayer', first_reading: nil, second_reading: nil },

  # DIA 27 - São João (Proper)
  { month: 12, day: 27, service_type: 'morning_prayer', first_reading: nil, second_reading: nil },
  { month: 12, day: 27, service_type: 'evening_prayer', first_reading: nil, second_reading: nil },

  # DIA 28 - Santos Inocentes (Proper)
  # Uses Daily 2nd readings
  { month: 12, day: 28, service_type: 'morning_prayer', first_reading: nil, second_reading: 'Atos 25' },
  { month: 12, day: 28, service_type: 'evening_prayer', first_reading: nil, second_reading: '1 João 5' },

  # DIA 29
  { month: 12, day: 29, service_type: 'morning_prayer', first_reading: 'Isaías 61', second_reading: 'Atos 26' },
  { month: 12, day: 29, service_type: 'evening_prayer', first_reading: 'Isaías 62', second_reading: '2 João' },

  # DIA 30
  { month: 12, day: 30, service_type: 'morning_prayer', first_reading: 'Isaías 63', second_reading: 'Atos 27' },
  { month: 12, day: 30, service_type: 'evening_prayer', first_reading: 'Isaías 64', second_reading: '3 João' },

  # DIA 31
  { month: 12, day: 31, service_type: 'morning_prayer', first_reading: 'Isaías 65', second_reading: 'Atos 28' },
  { month: 12, day: 31, service_type: 'evening_prayer', first_reading: 'Isaías 66', second_reading: 'Judas' },
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

Rails.logger.info "✅ Leituras de Dezembro carregadas!"
