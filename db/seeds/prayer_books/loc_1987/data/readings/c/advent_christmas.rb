# ================================================================================
# LEITURAS DO LECIONÁRIO - LOC 1987 - ANO C
# ================================================================================

Rails.logger.info "📖 Carregando leituras do Lecionário (LOC 1987) - Ano C..."

prayer_book = PrayerBook.find_by!(code: 'loc_1987')

lectionary_c = [
  # Advento
  {
    date_reference: "1st_sunday_of_advent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Zacarias 14:4-9",
    psalm: "50 ou 50:1-6",
    second_reading: "I Tessalonicenses 3:9-13",
    gospel: "Lucas 21:25-31"
  },
  {
    date_reference: "2nd_sunday_of_advent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Baruc 5:1-9",
    psalm: "126",
    second_reading: "Filipenses 1:1-11",
    gospel: "Lucas 3:1-6"
  },
  {
    date_reference: "3rd_sunday_of_advent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Sofonias 3:14-20",
    psalm: "85 ou 85:7-13",
    second_reading: "Filipenses 4:4-7(8-9)",
    gospel: "Lucas 3:7-18"
  },
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Miquéias 5:1-4(5-14)",
    psalm: "80 ou 80:1-7",
    second_reading: "Hebreus 10:5-10",
    gospel: "Lucas 1:39-49(50-56)"
  },

  # Natal (Dias de Natal I-III)
  {
    date_reference: "christmas_day_i",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 9:2-4,6-7",
    psalm: "96 ou 96:1-4,11-12",
    second_reading: "Tito 2:11-14",
    gospel: "Lucas 2:1-14"
  },
  {
    date_reference: "christmas_day_ii",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 62:6-7,10-12",
    psalm: "97 ou 97:1-4,11-12",
    second_reading: "Tito 3:4-7",
    gospel: "Lucas 2:(1-14)15-20"
  },
  {
    date_reference: "christmas_day_iii",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 52:7-10",
    psalm: "98 ou 98:1-6",
    second_reading: "Hebreus 1:1-12",
    gospel: "João 1:1-14"
  },

  # 1º Domingo depois do Natal
  {
    date_reference: "1st_sunday_after_christmas",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 61:10-62:3",
    psalm: "147 ou 147:13-21",
    second_reading: "Gálatas 3:23-25,4:4-7",
    gospel: "João 1:1-18"
  },

  # Santo Nome (1º de janeiro)
  {
    date_reference: "holy_name",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Êxodo 3:1-8",
    psalm: "8",
    second_reading: "Romanos 1:1-7",
    gospel: "Lucas 2:15-21"
  },

  # 2º Domingo depois do Natal
  {
    date_reference: "2nd_sunday_after_christmas",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremias 31:7-14",
    psalm: "84 ou 84:1-18",
    second_reading: "Efésios 1:3-6,15-19a",
    gospel: "Mateus 2:13-15,19-23 ou Lucas 2:41-52 ou Mateus 2:1-12"
  },

  # Epifania (6 de janeiro)
  {
    date_reference: "epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 60:1-6,9",
    psalm: "72 ou 72:1-2,10-17",
    second_reading: "Efésios 3:1-12",
    gospel: "Mateus 2:1 12"
  },

  # 1º Domingo depois da Epifania
  {
    date_reference: "baptism_of_the_lord",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 42:1-9",
    psalm: "89:1-29 ou 89:20-29",
    second_reading: "Atos 10:34-38",
    gospel: "Lucas 3:15-16,21-22"
  }
]

# Create records if not present
count = 0
skipped = 0
lectionary_c.each do |r|
  r[:prayer_book_id] = prayer_book.id

  existing = LectionaryReading.find_by(
    date_reference: r[:date_reference],
    cycle: r[:cycle],
    service_type: r[:service_type],
    prayer_book_id: prayer_book.id
  )

  if existing.nil?
    LectionaryReading.create!(r)
    count += 1
    print "." if count % 5 == 0
  else
    skipped += 1
  end
end

Rails.logger.info "\n✅ #{count} leituras (Ano C) criadas para LOC 1987"
Rails.logger.info "⏭️  #{skipped} já existiam." if skipped > 0
