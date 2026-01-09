# ================================================================================
# LEITURAS DIÁRIAS - SETEMBRO (LOC 1662)
# ================================================================================

prayer_book = PrayerBook.find_by!(code: 'loc_1662')

readings = [
  # DIA 1
  { month: 9, day: 1, service_type: 'morning_prayer', first_reading: 'Oseias 14', second_reading: 'Mateus 2' },
  { month: 9, day: 1, service_type: 'evening_prayer', first_reading: 'Joel 1', second_reading: 'Romanos 2' },

  # DIA 2
  { month: 9, day: 2, service_type: 'morning_prayer', first_reading: 'Joel 2', second_reading: 'Mateus 3' },
  { month: 9, day: 2, service_type: 'evening_prayer', first_reading: 'Joel 3', second_reading: 'Romanos 3' },

  # DIA 3
  { month: 9, day: 3, service_type: 'morning_prayer', first_reading: 'Amós 1', second_reading: 'Mateus 4' },
  { month: 9, day: 3, service_type: 'evening_prayer', first_reading: 'Amós 2', second_reading: 'Romanos 4' },

  # DIA 4
  { month: 9, day: 4, service_type: 'morning_prayer', first_reading: 'Amós 3', second_reading: 'Mateus 5' },
  { month: 9, day: 4, service_type: 'evening_prayer', first_reading: 'Amós 4', second_reading: 'Romanos 5' },

  # DIA 5
  { month: 9, day: 5, service_type: 'morning_prayer', first_reading: 'Amós 5', second_reading: 'Mateus 6' },
  { month: 9, day: 5, service_type: 'evening_prayer', first_reading: 'Amós 6', second_reading: 'Romanos 6' },

  # DIA 6
  { month: 9, day: 6, service_type: 'morning_prayer', first_reading: 'Amós 7', second_reading: 'Mateus 7' },
  { month: 9, day: 6, service_type: 'evening_prayer', first_reading: 'Amós 8', second_reading: 'Romanos 7' },

  # DIA 7
  { month: 9, day: 7, service_type: 'morning_prayer', first_reading: 'Amós 9', second_reading: 'Mateus 8' },
  { month: 9, day: 7, service_type: 'evening_prayer', first_reading: 'Obadias', second_reading: 'Romanos 8' },

  # DIA 8
  { month: 9, day: 8, service_type: 'morning_prayer', first_reading: 'Jonas 1', second_reading: 'Mateus 9' },
  { month: 9, day: 8, service_type: 'evening_prayer', first_reading: 'Jonas 2-3', second_reading: 'Romanos 9' },

  # DIA 9
  { month: 9, day: 9, service_type: 'morning_prayer', first_reading: 'Jonas 4', second_reading: 'Mateus 10' },
  { month: 9, day: 9, service_type: 'evening_prayer', first_reading: 'Miqueias 1', second_reading: 'Romanos 10' },

  # DIA 10
  { month: 9, day: 10, service_type: 'morning_prayer', first_reading: 'Miqueias 2', second_reading: 'Mateus 11' },
  { month: 9, day: 10, service_type: 'evening_prayer', first_reading: 'Miqueias 3', second_reading: 'Romanos 11' },

  # DIA 11
  { month: 9, day: 11, service_type: 'morning_prayer', first_reading: 'Miqueias 4', second_reading: 'Mateus 12' },
  { month: 9, day: 11, service_type: 'evening_prayer', first_reading: 'Miqueias 5', second_reading: 'Romanos 12' },

  # DIA 12
  { month: 9, day: 12, service_type: 'morning_prayer', first_reading: 'Miqueias 6', second_reading: 'Mateus 13' },
  { month: 9, day: 12, service_type: 'evening_prayer', first_reading: 'Miqueias 7', second_reading: 'Romanos 13' },

  # DIA 13
  { month: 9, day: 13, service_type: 'morning_prayer', first_reading: 'Naum 1', second_reading: 'Mateus 14' },
  { month: 9, day: 13, service_type: 'evening_prayer', first_reading: 'Naum 2', second_reading: 'Romanos 14' },

  # DIA 14
  { month: 9, day: 14, service_type: 'morning_prayer', first_reading: 'Naum 3', second_reading: 'Mateus 15' },
  { month: 9, day: 14, service_type: 'evening_prayer', first_reading: 'Habacuque 1', second_reading: 'Romanos 15' },

  # DIA 15
  { month: 9, day: 15, service_type: 'morning_prayer', first_reading: 'Habacuque 2', second_reading: 'Mateus 16' },
  { month: 9, day: 15, service_type: 'evening_prayer', first_reading: 'Habacuque 3', second_reading: 'Romanos 16' },

  # DIA 16
  { month: 9, day: 16, service_type: 'morning_prayer', first_reading: 'Sofonias 1', second_reading: 'Mateus 17' },
  { month: 9, day: 16, service_type: 'evening_prayer', first_reading: 'Sofonias 2', second_reading: '1 Coríntios 1' },

  # DIA 17
  { month: 9, day: 17, service_type: 'morning_prayer', first_reading: 'Sofonias 3', second_reading: 'Mateus 18' },
  { month: 9, day: 17, service_type: 'evening_prayer', first_reading: 'Ageu 1', second_reading: '1 Coríntios 2' },

  # DIA 18
  { month: 9, day: 18, service_type: 'morning_prayer', first_reading: 'Ageu 2', second_reading: 'Mateus 19' },
  { month: 9, day: 18, service_type: 'evening_prayer', first_reading: 'Zacarias 1', second_reading: '1 Coríntios 3' },

  # DIA 19
  { month: 9, day: 19, service_type: 'morning_prayer', first_reading: 'Zacarias 2-3', second_reading: 'Mateus 20' },
  { month: 9, day: 19, service_type: 'evening_prayer', first_reading: 'Zacarias 4-5', second_reading: '1 Coríntios 4' },

  # DIA 20
  { month: 9, day: 20, service_type: 'morning_prayer', first_reading: 'Zacarias 6', second_reading: 'Mateus 21' },
  { month: 9, day: 20, service_type: 'evening_prayer', first_reading: 'Zacarias 7', second_reading: '1 Coríntios 5' },

  # DIA 21 - São Mateus (Proper)
  # Uses Daily 2nd readings
  { month: 9, day: 21, service_type: 'morning_prayer', first_reading: nil, second_reading: 'Mateus 22' },
  { month: 9, day: 21, service_type: 'evening_prayer', first_reading: nil, second_reading: '1 Coríntios 6' },

  # DIA 22
  { month: 9, day: 22, service_type: 'morning_prayer', first_reading: 'Zacarias 8', second_reading: 'Mateus 23' },
  { month: 9, day: 22, service_type: 'evening_prayer', first_reading: 'Zacarias 9', second_reading: '1 Coríntios 7' },

  # DIA 23
  { month: 9, day: 23, service_type: 'morning_prayer', first_reading: 'Zacarias 10', second_reading: 'Mateus 24' },
  { month: 9, day: 23, service_type: 'evening_prayer', first_reading: 'Zacarias 11', second_reading: '1 Coríntios 8' },

  # DIA 24
  { month: 9, day: 24, service_type: 'morning_prayer', first_reading: 'Zacarias 12', second_reading: 'Mateus 25' },
  { month: 9, day: 24, service_type: 'evening_prayer', first_reading: 'Zacarias 13', second_reading: '1 Coríntios 9' },

  # DIA 25
  { month: 9, day: 25, service_type: 'morning_prayer', first_reading: 'Zacarias 14', second_reading: 'Mateus 26' },
  { month: 9, day: 25, service_type: 'evening_prayer', first_reading: 'Malaquias 1', second_reading: '1 Coríntios 10' },

  # DIA 26
  { month: 9, day: 26, service_type: 'morning_prayer', first_reading: 'Malaquias 2', second_reading: 'Mateus 27' },
  { month: 9, day: 26, service_type: 'evening_prayer', first_reading: 'Malaquias 3', second_reading: '1 Coríntios 11' },

  # DIA 27
  { month: 9, day: 27, service_type: 'morning_prayer', first_reading: 'Malaquias 4', second_reading: 'Mateus 28' },
  { month: 9, day: 27, service_type: 'evening_prayer', first_reading: 'Tobias 1', second_reading: '1 Coríntios 12' },

  # DIA 28
  { month: 9, day: 28, service_type: 'morning_prayer', first_reading: 'Tobias 2', second_reading: 'Marcos 1' },
  { month: 9, day: 28, service_type: 'evening_prayer', first_reading: 'Tobias 3', second_reading: '1 Coríntios 13' },

  # DIA 29 - São Miguel (Proper)
  # Uses Daily 2nd readings
  { month: 9, day: 29, service_type: 'morning_prayer', first_reading: nil, second_reading: 'Marcos 2' },
  { month: 9, day: 29, service_type: 'evening_prayer', first_reading: nil, second_reading: '1 Coríntios 14' },

  # DIA 30
  { month: 9, day: 30, service_type: 'morning_prayer', first_reading: 'Tobias 4', second_reading: 'Marcos 3' },
  { month: 9, day: 30, service_type: 'evening_prayer', first_reading: 'Tobias 6', second_reading: '1 Coríntios 15' },
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

Rails.logger.info "✅ Leituras de Setembro carregadas!"
