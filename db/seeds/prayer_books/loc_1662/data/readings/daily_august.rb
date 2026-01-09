# ================================================================================
# LEITURAS DIÁRIAS - AGOSTO (LOC 1662)
# ================================================================================

prayer_book = PrayerBook.find_by!(code: 'loc_1662')

readings = [
  # DIA 1
  { month: 8, day: 1, service_type: 'morning_prayer', first_reading: 'Jeremias 29', second_reading: 'João 20' },
  { month: 8, day: 1, service_type: 'evening_prayer', first_reading: 'Jeremias 30', second_reading: 'Hebreus 4' },

  # DIA 2
  { month: 8, day: 2, service_type: 'morning_prayer', first_reading: 'Jeremias 31', second_reading: 'João 21' },
  { month: 8, day: 2, service_type: 'evening_prayer', first_reading: 'Jeremias 32', second_reading: 'Hebreus 5' },

  # DIA 3
  { month: 8, day: 3, service_type: 'morning_prayer', first_reading: 'Jeremias 33', second_reading: 'Atos 1' },
  { month: 8, day: 3, service_type: 'evening_prayer', first_reading: 'Jeremias 34', second_reading: 'Hebreus 6' },

  # DIA 4
  { month: 8, day: 4, service_type: 'morning_prayer', first_reading: 'Jeremias 35', second_reading: 'Atos 2' },
  { month: 8, day: 4, service_type: 'evening_prayer', first_reading: 'Jeremias 36', second_reading: 'Hebreus 7' },

  # DIA 5
  { month: 8, day: 5, service_type: 'morning_prayer', first_reading: 'Jeremias 37', second_reading: 'Atos 3' },
  { month: 8, day: 5, service_type: 'evening_prayer', first_reading: 'Jeremias 38', second_reading: 'Hebreus 8' },

  # DIA 6
  { month: 8, day: 6, service_type: 'morning_prayer', first_reading: 'Jeremias 39', second_reading: 'Atos 4' },
  { month: 8, day: 6, service_type: 'evening_prayer', first_reading: 'Jeremias 40', second_reading: 'Hebreus 9' },

  # DIA 7
  { month: 8, day: 7, service_type: 'morning_prayer', first_reading: 'Jeremias 41', second_reading: 'Atos 5' },
  { month: 8, day: 7, service_type: 'evening_prayer', first_reading: 'Jeremias 42', second_reading: 'Hebreus 10' },

  # DIA 8
  { month: 8, day: 8, service_type: 'morning_prayer', first_reading: 'Jeremias 43', second_reading: 'Atos 6' },
  { month: 8, day: 8, service_type: 'evening_prayer', first_reading: 'Jeremias 44', second_reading: 'Hebreus 11' },

  # DIA 9
  { month: 8, day: 9, service_type: 'morning_prayer', first_reading: 'Jeremias 45-46', second_reading: 'Atos 7' },
  { month: 8, day: 9, service_type: 'evening_prayer', first_reading: 'Jeremias 47', second_reading: 'Hebreus 12' },

  # DIA 10
  { month: 8, day: 10, service_type: 'morning_prayer', first_reading: 'Jeremias 48', second_reading: 'Atos 8' },
  { month: 8, day: 10, service_type: 'evening_prayer', first_reading: 'Jeremias 49', second_reading: 'Hebreus 13' },

  # DIA 11
  { month: 8, day: 11, service_type: 'morning_prayer', first_reading: 'Jeremias 50', second_reading: 'Atos 9' },
  { month: 8, day: 11, service_type: 'evening_prayer', first_reading: 'Jeremias 51', second_reading: 'Tiago 1' },

  # DIA 12
  { month: 8, day: 12, service_type: 'morning_prayer', first_reading: 'Jeremias 52', second_reading: 'Atos 10' },
  { month: 8, day: 12, service_type: 'evening_prayer', first_reading: 'Lamentações 1', second_reading: 'Tiago 2' },

  # DIA 13
  { month: 8, day: 13, service_type: 'morning_prayer', first_reading: 'Lamentações 2', second_reading: 'Atos 11' },
  { month: 8, day: 13, service_type: 'evening_prayer', first_reading: 'Lamentações 3', second_reading: 'Tiago 3' },

  # DIA 14
  { month: 8, day: 14, service_type: 'morning_prayer', first_reading: 'Lamentações 4', second_reading: 'Atos 12' },
  { month: 8, day: 14, service_type: 'evening_prayer', first_reading: 'Lamentações 5', second_reading: 'Tiago 4' },

  # DIA 15
  { month: 8, day: 15, service_type: 'morning_prayer', first_reading: 'Ezequiel 2', second_reading: 'Atos 13' },
  { month: 8, day: 15, service_type: 'evening_prayer', first_reading: 'Ezequiel 3', second_reading: 'Tiago 5' },

  # DIA 16
  { month: 8, day: 16, service_type: 'morning_prayer', first_reading: 'Ezequiel 6', second_reading: 'Atos 14' },
  { month: 8, day: 16, service_type: 'evening_prayer', first_reading: 'Ezequiel 7', second_reading: '1 Pedro 1' },

  # DIA 17
  { month: 8, day: 17, service_type: 'morning_prayer', first_reading: 'Ezequiel 13', second_reading: 'Atos 15' },
  { month: 8, day: 17, service_type: 'evening_prayer', first_reading: 'Ezequiel 14', second_reading: '1 Pedro 2' },

  # DIA 18
  { month: 8, day: 18, service_type: 'morning_prayer', first_reading: 'Ezequiel 18', second_reading: 'Atos 16' },
  { month: 8, day: 18, service_type: 'evening_prayer', first_reading: 'Ezequiel 33', second_reading: '1 Pedro 3' },

  # DIA 19
  { month: 8, day: 19, service_type: 'morning_prayer', first_reading: 'Ezequiel 34', second_reading: 'Atos 17' },
  { month: 8, day: 19, service_type: 'evening_prayer', first_reading: 'Daniel 1', second_reading: '1 Pedro 4' },

  # DIA 20
  { month: 8, day: 20, service_type: 'morning_prayer', first_reading: 'Daniel 2', second_reading: 'Atos 18' },
  { month: 8, day: 20, service_type: 'evening_prayer', first_reading: 'Daniel 3', second_reading: '1 Pedro 5' },

  # DIA 21
  { month: 8, day: 21, service_type: 'morning_prayer', first_reading: 'Daniel 4', second_reading: 'Atos 19' },
  { month: 8, day: 21, service_type: 'evening_prayer', first_reading: 'Daniel 5', second_reading: '2 Pedro 1' },

  # DIA 22
  { month: 8, day: 22, service_type: 'morning_prayer', first_reading: 'Daniel 6', second_reading: 'Atos 20' },
  { month: 8, day: 22, service_type: 'evening_prayer', first_reading: 'Daniel 7', second_reading: '2 Pedro 2' },

  # DIA 23
  { month: 8, day: 23, service_type: 'morning_prayer', first_reading: 'Daniel 8', second_reading: 'Atos 21' },
  { month: 8, day: 23, service_type: 'evening_prayer', first_reading: 'Daniel 9', second_reading: '2 Pedro 3' },

  # DIA 24 - São Bartolomeu (Proper)
  # Uses Daily 2nd readings
  { month: 8, day: 24, service_type: 'morning_prayer', first_reading: nil, second_reading: 'Atos 22' },
  { month: 8, day: 24, service_type: 'evening_prayer', first_reading: nil, second_reading: '1 João 1' },

  # DIA 25
  { month: 8, day: 25, service_type: 'morning_prayer', first_reading: 'Daniel 10', second_reading: 'Atos 23' },
  { month: 8, day: 25, service_type: 'evening_prayer', first_reading: 'Daniel 11', second_reading: '1 João 2' },

  # DIA 26
  { month: 8, day: 26, service_type: 'morning_prayer', first_reading: 'Daniel 12', second_reading: 'Atos 24' },
  { month: 8, day: 26, service_type: 'evening_prayer', first_reading: 'Oseias 1', second_reading: '1 João 3' },

  # DIA 27
  { month: 8, day: 27, service_type: 'morning_prayer', first_reading: 'Oseias 2-3', second_reading: 'Atos 25' },
  { month: 8, day: 27, service_type: 'evening_prayer', first_reading: 'Oseias 4', second_reading: '1 João 4' },

  # DIA 28
  { month: 8, day: 28, service_type: 'morning_prayer', first_reading: 'Oseias 5-6', second_reading: 'Atos 26' },
  { month: 8, day: 28, service_type: 'evening_prayer', first_reading: 'Oseias 7', second_reading: '1 João 5' },

  # DIA 29
  { month: 8, day: 29, service_type: 'morning_prayer', first_reading: 'Oseias 8', second_reading: 'Atos 27' },
  { month: 8, day: 29, service_type: 'evening_prayer', first_reading: 'Oseias 9', second_reading: '2 & 3 João' },

  # DIA 30
  { month: 8, day: 30, service_type: 'morning_prayer', first_reading: 'Oseias 10', second_reading: 'Atos 28' },
  { month: 8, day: 30, service_type: 'evening_prayer', first_reading: 'Oseias 11', second_reading: 'Judas' },

  # DIA 31
  { month: 8, day: 31, service_type: 'morning_prayer', first_reading: 'Oseias 12', second_reading: 'Mateus 1' },
  { month: 8, day: 31, service_type: 'evening_prayer', first_reading: 'Oseias 13', second_reading: 'Romanos 1' }
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

Rails.logger.info "✅ Leituras de Agosto carregadas!"
