# ================================================================================
# LEITURAS DIÁRIAS - MARÇO (LOC 1662)
# ================================================================================

prayer_book = PrayerBook.find_by!(code: 'loc_1662')

readings = [
  # DIA 1
  { month: 3, day: 1, service_type: 'morning_prayer', first_reading: 'Deuteronômio 15', second_reading: 'Lucas 12' },
  { month: 3, day: 1, service_type: 'evening_prayer', first_reading: 'Deuteronômio 16', second_reading: 'Efésios 6' },

  # DIA 2
  { month: 3, day: 2, service_type: 'morning_prayer', first_reading: 'Deuteronômio 17', second_reading: 'Lucas 13' },
  { month: 3, day: 2, service_type: 'evening_prayer', first_reading: 'Deuteronômio 18', second_reading: 'Filipenses 1' },

  # DIA 3
  { month: 3, day: 3, service_type: 'morning_prayer', first_reading: 'Deuteronômio 19', second_reading: 'Lucas 14' },
  { month: 3, day: 3, service_type: 'evening_prayer', first_reading: 'Deuteronômio 20', second_reading: 'Filipenses 2' },

  # DIA 4
  { month: 3, day: 4, service_type: 'morning_prayer', first_reading: 'Deuteronômio 21', second_reading: 'Lucas 15' },
  { month: 3, day: 4, service_type: 'evening_prayer', first_reading: 'Deuteronômio 22', second_reading: 'Filipenses 3' },

  # DIA 5
  { month: 3, day: 5, service_type: 'morning_prayer', first_reading: 'Deuteronômio 24', second_reading: 'Lucas 16' },
  { month: 3, day: 5, service_type: 'evening_prayer', first_reading: 'Deuteronômio 25', second_reading: 'Filipenses 4' },

  # DIA 6
  { month: 3, day: 6, service_type: 'morning_prayer', first_reading: 'Deuteronômio 26', second_reading: 'Lucas 17' },
  { month: 3, day: 6, service_type: 'evening_prayer', first_reading: 'Deuteronômio 27', second_reading: 'Colossenses 1' },

  # DIA 7
  { month: 3, day: 7, service_type: 'morning_prayer', first_reading: 'Deuteronômio 28', second_reading: 'Lucas 18' },
  { month: 3, day: 7, service_type: 'evening_prayer', first_reading: 'Deuteronômio 29', second_reading: 'Colossenses 2' },

  # DIA 8
  { month: 3, day: 8, service_type: 'morning_prayer', first_reading: 'Deuteronômio 30', second_reading: 'Lucas 19' },
  { month: 3, day: 8, service_type: 'evening_prayer', first_reading: 'Deuteronômio 31', second_reading: 'Colossenses 3' },

  # DIA 9
  { month: 3, day: 9, service_type: 'morning_prayer', first_reading: 'Deuteronômio 32', second_reading: 'Lucas 20' },
  { month: 3, day: 9, service_type: 'evening_prayer', first_reading: 'Deuteronômio 33', second_reading: 'Colossenses 4' },

  # DIA 10
  { month: 3, day: 10, service_type: 'morning_prayer', first_reading: 'Deuteronômio 34', second_reading: 'Lucas 21' },
  { month: 3, day: 10, service_type: 'evening_prayer', first_reading: 'Josué 1', second_reading: '1 Tessalonicenses 1' },

  # DIA 11
  { month: 3, day: 11, service_type: 'morning_prayer', first_reading: 'Josué 2', second_reading: 'Lucas 22' },
  { month: 3, day: 11, service_type: 'evening_prayer', first_reading: 'Josué 3', second_reading: '1 Tessalonicenses 2' },

  # DIA 12
  { month: 3, day: 12, service_type: 'morning_prayer', first_reading: 'Josué 4', second_reading: 'Lucas 23' },
  { month: 3, day: 12, service_type: 'evening_prayer', first_reading: 'Josué 5', second_reading: '1 Tessalonicenses 3' },

  # DIA 13
  { month: 3, day: 13, service_type: 'morning_prayer', first_reading: 'Josué 6', second_reading: 'Lucas 24' },
  { month: 3, day: 13, service_type: 'evening_prayer', first_reading: 'Josué 7', second_reading: '1 Tessalonicenses 4' },

  # DIA 14
  { month: 3, day: 14, service_type: 'morning_prayer', first_reading: 'Josué 8', second_reading: 'João 1' },
  { month: 3, day: 14, service_type: 'evening_prayer', first_reading: 'Josué 9', second_reading: '1 Tessalonicenses 5' },

  # DIA 15
  { month: 3, day: 15, service_type: 'morning_prayer', first_reading: 'Josué 10', second_reading: 'João 2' },
  { month: 3, day: 15, service_type: 'evening_prayer', first_reading: 'Josué 23', second_reading: '2 Tessalonicenses 1' },

  # DIA 16
  { month: 3, day: 16, service_type: 'morning_prayer', first_reading: 'Josué 24', second_reading: 'João 3' },
  { month: 3, day: 16, service_type: 'evening_prayer', first_reading: 'Juízes 1', second_reading: '2 Tessalonicenses 2' },

  # DIA 17
  { month: 3, day: 17, service_type: 'morning_prayer', first_reading: 'Juízes 2', second_reading: 'João 4' },
  { month: 3, day: 17, service_type: 'evening_prayer', first_reading: 'Juízes 3', second_reading: '2 Tessalonicenses 3' },

  # DIA 18
  { month: 3, day: 18, service_type: 'morning_prayer', first_reading: 'Juízes 4', second_reading: 'João 5' },
  { month: 3, day: 18, service_type: 'evening_prayer', first_reading: 'Juízes 5', second_reading: '1 Timóteo 1' },

  # DIA 19
  { month: 3, day: 19, service_type: 'morning_prayer', first_reading: 'Juízes 6', second_reading: 'João 6' },
  { month: 3, day: 19, service_type: 'evening_prayer', first_reading: 'Juízes 7', second_reading: '1 Timóteo 2-3' },

  # DIA 20
  { month: 3, day: 20, service_type: 'morning_prayer', first_reading: 'Juízes 8', second_reading: 'João 7' },
  { month: 3, day: 20, service_type: 'evening_prayer', first_reading: 'Juízes 9', second_reading: '1 Timóteo 4' },

  # DIA 21
  { month: 3, day: 21, service_type: 'morning_prayer', first_reading: 'Juízes 10', second_reading: 'João 8' },
  { month: 3, day: 21, service_type: 'evening_prayer', first_reading: 'Juízes 11', second_reading: '1 Timóteo 5' },

  # DIA 22
  { month: 3, day: 22, service_type: 'morning_prayer', first_reading: 'Juízes 12', second_reading: 'João 9' },
  { month: 3, day: 22, service_type: 'evening_prayer', first_reading: 'Juízes 13', second_reading: '1 Timóteo 6' },

  # DIA 23
  { month: 3, day: 23, service_type: 'morning_prayer', first_reading: 'Juízes 14', second_reading: 'João 10' },
  { month: 3, day: 23, service_type: 'evening_prayer', first_reading: 'Juízes 15', second_reading: '2 Timóteo 1' },

  # DIA 24
  { month: 3, day: 24, service_type: 'morning_prayer', first_reading: 'Juízes 16', second_reading: 'João 11' },
  { month: 3, day: 24, service_type: 'evening_prayer', first_reading: 'Juízes 17', second_reading: '2 Timóteo 2' },

  # DIA 25 - Anunciação (Proper)
  { month: 3, day: 25, service_type: 'morning_prayer', first_reading: nil, second_reading: 'João 12' },
  { month: 3, day: 25, service_type: 'evening_prayer', first_reading: nil, second_reading: '2 Timóteo 3' },

  # DIA 26
  { month: 3, day: 26, service_type: 'morning_prayer', first_reading: 'Juízes 18', second_reading: 'João 13' },
  { month: 3, day: 26, service_type: 'evening_prayer', first_reading: 'Juízes 19', second_reading: '2 Timóteo 4' },

  # DIA 27
  { month: 3, day: 27, service_type: 'morning_prayer', first_reading: 'Juízes 20', second_reading: 'João 14' },
  { month: 3, day: 27, service_type: 'evening_prayer', first_reading: 'Juízes 21', second_reading: 'Tito 1' },

  # DIA 28
  { month: 3, day: 28, service_type: 'morning_prayer', first_reading: 'Rute 1', second_reading: 'João 15' },
  { month: 3, day: 28, service_type: 'evening_prayer', first_reading: 'Rute 2', second_reading: 'Tito 2-3' },

  # DIA 29
  { month: 3, day: 29, service_type: 'morning_prayer', first_reading: 'Rute 3', second_reading: 'João 16' },
  { month: 3, day: 29, service_type: 'evening_prayer', first_reading: 'Rute 4', second_reading: 'Filemom' },

  # DIA 30
  { month: 3, day: 30, service_type: 'morning_prayer', first_reading: '1 Samuel 1', second_reading: 'João 17' },
  { month: 3, day: 30, service_type: 'evening_prayer', first_reading: '1 Samuel 2', second_reading: 'Hebreus 1' },

  # DIA 31
  { month: 3, day: 31, service_type: 'morning_prayer', first_reading: '1 Samuel 3', second_reading: 'João 18' },
  { month: 3, day: 31, service_type: 'evening_prayer', first_reading: '1 Samuel 4', second_reading: 'Hebreus 2' }
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

Rails.logger.info "✅ Leituras de Março carregadas!"
