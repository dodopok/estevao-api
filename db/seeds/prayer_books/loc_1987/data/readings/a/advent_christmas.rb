# ================================================================================
# LEITURAS DO LECIONÁRIO - LOC 1987 - ANO A
# ================================================================================

Rails.logger.info "📖 Carregando leituras do Lecionário (LOC 1987) - Ano A..."

prayer_book = PrayerBook.find_by!(code: 'loc_1987')

lectionary_a = [
  # Advento
  {
    date_reference: "1st_sunday_of_advent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 2:1-5",
    psalm: "122",
    second_reading: "Romanos 13:8-14",
    gospel: "Mateus 24:36-44"
  },
  {
    date_reference: "2nd_sunday_of_advent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 11:1-10",
    psalm: "72 ou 72:1-8",
    second_reading: "Romanos 15:4-13",
    gospel: "Mateus 3:1-12"
  },
  {
    date_reference: "3rd_sunday_of_advent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 35:1-10",
    psalm: "146 ou 146:1-9",
    second_reading: "Tiago 5:7-10",
    gospel: "Mateus 11:2-11"
  },
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 7:10-17",
    psalm: "24 ou 24:1-7",
    second_reading: "Romanos 1:1-7",
    gospel: "Mateus 1:18-25"
  },

  # Natal (Dias de Natal I-III)
  {
    date_reference: "christmas_day_i",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 9:2-4,6-7",
    psalm: "96 ou 96:1-4,11-12",
    second_reading: "Tito 2:11-14",
    gospel: "Lucas 2:1-14 (15-20)"
  },
  {
    date_reference: "christmas_day_ii",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 62:6-7,10-12",
    psalm: "97 ou 97:1-4,11-12",
    second_reading: "Tito 3:4-7",
    gospel: "Lucas 2(1-14) 15-20"
  },
  {
    date_reference: "christmas_day_iii",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 52:7-10",
    psalm: "98 ou 98:1-6",
    second_reading: "Hebreus 1:1-12",
    gospel: "João 1:1-14"
  },

  # 1º Domingo depois do Natal
  {
    date_reference: "1st_sunday_after_christmas",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 61:10-62:3",
    psalm: "147 ou 147:13-21",
    second_reading: "Gálatas 3:23-25,4:4-7",
    gospel: "João 1:1-18"
  },

  # Santo Nome (1º de janeiro)
  {
    date_reference: "holy_name",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Êxodo 34:1-8",
    psalm: "8",
    second_reading: "Romanos 1:1-7 ou Filipenses 2:9-13",
    gospel: "Lucas 2:15-21"
  },

  # 2º Domingo depois do Natal
  {
    date_reference: "2nd_sunday_after_christmas",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Jeremias 31:7-14",
    psalm: "84 ou 84:1-18",
    second_reading: "Efésios 1:3-16,19a",
    gospel: "Mateus 2:13-15,19-23 ou Lucas 2:41-52 ou Mateus 2:1-12"
  },

  # Epifania (6 de janeiro)
  {
    date_reference: "epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 60:1-6,9",
    psalm: "72 ou 72:1-2,10-17",
    second_reading: "Efésios 3:1-12",
    gospel: "Mateus 2:1-12"
  },

  # 1º Domingo depois da Epifania
  {
    date_reference: "baptism_of_the_lord",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 42:1-9",
    psalm: "89:1-29 ou 89:20-29",
    second_reading: "Atos 10:34-38",
    gospel: "Mateus 3:13-17"
  }
]

# Create records if not present
count = 0
skipped = 0
lectionary_a.each do |r|
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

Rails.logger.info "\n✅ #{count} leituras (Ano A) criadas para LOC 1987"
Rails.logger.info "⏭️  #{skipped} já existiam." if skipped > 0
