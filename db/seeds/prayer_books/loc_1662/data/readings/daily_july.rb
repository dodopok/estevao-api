# ================================================================================
# LEITURAS DIÁRIAS - JULHO (LOC 1662)
# ================================================================================

prayer_book = PrayerBook.find_by!(code: 'loc_1662')

readings = [
  # DIA 1
  { month: 7, day: 1, service_type: 'morning_prayer', first_reading: 'Provérbios 11', second_reading: 'Lucas 13' },
  { month: 7, day: 1, service_type: 'evening_prayer', first_reading: 'Provérbios 12', second_reading: 'Filipenses 1' },

  # DIA 2
  { month: 7, day: 2, service_type: 'morning_prayer', first_reading: 'Provérbios 13', second_reading: 'Lucas 14' },
  { month: 7, day: 2, service_type: 'evening_prayer', first_reading: 'Provérbios 14', second_reading: 'Filipenses 2' },

  # DIA 3
  { month: 7, day: 3, service_type: 'morning_prayer', first_reading: 'Provérbios 15', second_reading: 'Lucas 15' },
  { month: 7, day: 3, service_type: 'evening_prayer', first_reading: 'Provérbios 16', second_reading: 'Filipenses 3' },

  # DIA 4
  { month: 7, day: 4, service_type: 'morning_prayer', first_reading: 'Provérbios 17', second_reading: 'Lucas 16' },
  { month: 7, day: 4, service_type: 'evening_prayer', first_reading: 'Provérbios 18', second_reading: 'Filipenses 4' },

  # DIA 5
  { month: 7, day: 5, service_type: 'morning_prayer', first_reading: 'Provérbios 19', second_reading: 'Lucas 17' },
  { month: 7, day: 5, service_type: 'evening_prayer', first_reading: 'Provérbios 20', second_reading: 'Colossenses 1' },

  # DIA 6
  { month: 7, day: 6, service_type: 'morning_prayer', first_reading: 'Provérbios 21', second_reading: 'Lucas 18' },
  { month: 7, day: 6, service_type: 'evening_prayer', first_reading: 'Provérbios 22', second_reading: 'Colossenses 2' },

  # DIA 7
  { month: 7, day: 7, service_type: 'morning_prayer', first_reading: 'Provérbios 23', second_reading: 'Lucas 19' },
  { month: 7, day: 7, service_type: 'evening_prayer', first_reading: 'Provérbios 24', second_reading: 'Colossenses 3' },

  # DIA 8
  { month: 7, day: 8, service_type: 'morning_prayer', first_reading: 'Provérbios 25', second_reading: 'Lucas 20' },
  { month: 7, day: 8, service_type: 'evening_prayer', first_reading: 'Provérbios 26', second_reading: 'Colossenses 4' },

  # DIA 9
  { month: 7, day: 9, service_type: 'morning_prayer', first_reading: 'Provérbios 27', second_reading: 'Lucas 21' },
  { month: 7, day: 9, service_type: 'evening_prayer', first_reading: 'Provérbios 28', second_reading: '1 Tessalonicenses 1' },

  # DIA 10
  { month: 7, day: 10, service_type: 'morning_prayer', first_reading: 'Provérbios 29', second_reading: 'Lucas 22' },
  { month: 7, day: 10, service_type: 'evening_prayer', first_reading: 'Provérbios 31', second_reading: '1 Tessalonicenses 2' },

  # DIA 11
  { month: 7, day: 11, service_type: 'morning_prayer', first_reading: 'Eclesiastes 1', second_reading: 'Lucas 23' },
  { month: 7, day: 11, service_type: 'evening_prayer', first_reading: 'Eclesiastes 2', second_reading: '1 Tessalonicenses 3' },

  # DIA 12
  { month: 7, day: 12, service_type: 'morning_prayer', first_reading: 'Eclesiastes 3', second_reading: 'Lucas 24' },
  { month: 7, day: 12, service_type: 'evening_prayer', first_reading: 'Eclesiastes 4', second_reading: '1 Tessalonicenses 4' },

  # DIA 13
  { month: 7, day: 13, service_type: 'morning_prayer', first_reading: 'Eclesiastes 5', second_reading: 'João 1' },
  { month: 7, day: 13, service_type: 'evening_prayer', first_reading: 'Eclesiastes 6', second_reading: '1 Tessalonicenses 5' },

  # DIA 14
  { month: 7, day: 14, service_type: 'morning_prayer', first_reading: 'Eclesiastes 7', second_reading: 'João 2' },
  { month: 7, day: 14, service_type: 'evening_prayer', first_reading: 'Eclesiastes 8', second_reading: '2 Tessalonicenses 1' },

  # DIA 15
  { month: 7, day: 15, service_type: 'morning_prayer', first_reading: 'Eclesiastes 9', second_reading: 'João 3' },
  { month: 7, day: 15, service_type: 'evening_prayer', first_reading: 'Eclesiastes 10', second_reading: '2 Tessalonicenses 2' },

  # DIA 16
  { month: 7, day: 16, service_type: 'morning_prayer', first_reading: 'Eclesiastes 11', second_reading: 'João 4' },
  { month: 7, day: 16, service_type: 'evening_prayer', first_reading: 'Eclesiastes 12', second_reading: '2 Tessalonicenses 3' },

  # DIA 17
  { month: 7, day: 17, service_type: 'morning_prayer', first_reading: 'Jeremias 1', second_reading: 'João 5' },
  { month: 7, day: 17, service_type: 'evening_prayer', first_reading: 'Jeremias 2', second_reading: '1 Timóteo 1' },

  # DIA 18
  { month: 7, day: 18, service_type: 'morning_prayer', first_reading: 'Jeremias 3', second_reading: 'João 6' },
  { month: 7, day: 18, service_type: 'evening_prayer', first_reading: 'Jeremias 4', second_reading: '1 Timóteo 2-3' },

  # DIA 19
  { month: 7, day: 19, service_type: 'morning_prayer', first_reading: 'Jeremias 5', second_reading: 'João 7' },
  { month: 7, day: 19, service_type: 'evening_prayer', first_reading: 'Jeremias 6', second_reading: '1 Timóteo 4' },

  # DIA 20
  { month: 7, day: 20, service_type: 'morning_prayer', first_reading: 'Jeremias 7', second_reading: 'João 8' },
  { month: 7, day: 20, service_type: 'evening_prayer', first_reading: 'Jeremias 8', second_reading: '1 Timóteo 5' },

  # DIA 21
  { month: 7, day: 21, service_type: 'morning_prayer', first_reading: 'Jeremias 9', second_reading: 'João 9' },
  { month: 7, day: 21, service_type: 'evening_prayer', first_reading: 'Jeremias 10', second_reading: '1 Timóteo 6' },

  # DIA 22
  { month: 7, day: 22, service_type: 'morning_prayer', first_reading: 'Jeremias 11', second_reading: 'João 10' },
  { month: 7, day: 22, service_type: 'evening_prayer', first_reading: 'Jeremias 12', second_reading: '2 Timóteo 1' },

  # DIA 23
  { month: 7, day: 23, service_type: 'morning_prayer', first_reading: 'Jeremias 13', second_reading: 'João 11' },
  { month: 7, day: 23, service_type: 'evening_prayer', first_reading: 'Jeremias 14', second_reading: '2 Timóteo 2' },

  # DIA 24
  { month: 7, day: 24, service_type: 'morning_prayer', first_reading: 'Jeremias 15', second_reading: 'João 12' },
  { month: 7, day: 24, service_type: 'evening_prayer', first_reading: 'Jeremias 16', second_reading: '2 Timóteo 3' },

  # DIA 25 - São Tiago (Proper)
  # Uses Daily 2nd readings
  { month: 7, day: 25, service_type: 'morning_prayer', first_reading: nil, second_reading: 'João 13' },
  { month: 7, day: 25, service_type: 'evening_prayer', first_reading: nil, second_reading: '2 Timóteo 4' },

  # DIA 26
  { month: 7, day: 26, service_type: 'morning_prayer', first_reading: 'Jeremias 17', second_reading: 'João 14' },
  { month: 7, day: 26, service_type: 'evening_prayer', first_reading: 'Jeremias 18', second_reading: 'Tito 1' },

  # DIA 27
  { month: 7, day: 27, service_type: 'morning_prayer', first_reading: 'Jeremias 19', second_reading: 'João 15' },
  { month: 7, day: 27, service_type: 'evening_prayer', first_reading: 'Jeremias 20', second_reading: 'Tito 2-3' },

  # DIA 28
  { month: 7, day: 28, service_type: 'morning_prayer', first_reading: 'Jeremias 21', second_reading: 'João 16' },
  { month: 7, day: 28, service_type: 'evening_prayer', first_reading: 'Jeremias 22', second_reading: 'Filemom' },

  # DIA 29
  { month: 7, day: 29, service_type: 'morning_prayer', first_reading: 'Jeremias 23', second_reading: 'João 17' },
  { month: 7, day: 29, service_type: 'evening_prayer', first_reading: 'Jeremias 24', second_reading: 'Hebreus 1' },

  # DIA 30
  { month: 7, day: 30, service_type: 'morning_prayer', first_reading: 'Jeremias 25', second_reading: 'João 18' },
  { month: 7, day: 30, service_type: 'evening_prayer', first_reading: 'Jeremias 26', second_reading: 'Hebreus 2' },

  # DIA 31
  { month: 7, day: 31, service_type: 'morning_prayer', first_reading: 'Jeremias 27', second_reading: 'João 19' },
  { month: 7, day: 31, service_type: 'evening_prayer', first_reading: 'Jeremias 28', second_reading: 'Hebreus 3' },
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

Rails.logger.info "✅ Leituras de Julho carregadas!"
