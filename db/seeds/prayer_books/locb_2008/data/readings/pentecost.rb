# ================================================================================
# LEITURAS DE PENTECOSTES - LOCB 2008
# Cor litúrgica: Vermelho
# ================================================================================

Rails.logger.info "📖 Criando Leituras de Pentecostes - LOCB 2008..."

prayer_book = PrayerBook.find_by_code('locb_2008')

pentecost_readings = [
  # ================================================================================
  # VÉSPERA DE PENTECOSTES
  # Cor litúrgica: Vermelho
  # ================================================================================
  {
    date_reference: "pentecost_eve",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Êx 19:1-9a ou At 2:1-11",
    psalm: "Sl 33:12-22 ou Sl 130",
    second_reading: "Rm 8:14-17,22-27",
    gospel: "Jo 7:37-39a"
  },

  # ================================================================================
  # DIA DE PENTECOSTES
  # Cor litúrgica: Vermelho
  # Nota: Se a passagem do Antigo Testamento for escolhida como primeira leitura,
  #       a passagem de Atos deve ser usada como segunda leitura
  # ================================================================================
  {
    date_reference: "pentecost",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "At 2:1-21 ou Nm 11:24-30",
    psalm: "Sl 104:24-34, 35b",
    second_reading: "1 Co 12:3b-13 ou At 2:1-21",
    gospel: "Jo 20:19-23 ou Jo 7:37-39"
  },
  {
    date_reference: "pentecost",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "At 2:1-21 ou Ez 37:1-14",
    psalm: "Sl 104:24-34, 35b",
    second_reading: "Rm 8:22-27 ou At 2:1-21",
    gospel: "Jo 15:26-27; 16:4-15"
  },
  {
    date_reference: "pentecost",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "At 2:1-21 ou Gn 11:1-9",
    psalm: "Sl 104:24-34, 35b",
    second_reading: "Rm 8:14-17 ou At 2:1-21",
    gospel: "Jo 14:8-17"
  },

  # ================================================================================
  # DOMINGO APÓS PENTECOSTES - TRINDADE
  # Cor litúrgica: Branco
  # ================================================================================
  {
    date_reference: "trinity_sunday",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Gn 1:1-2.4a",
    psalm: "Sl 8",
    second_reading: "2 Co 13:11-13",
    gospel: "Mt 28:16-20"
  },
  {
    date_reference: "trinity_sunday",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Is 6:1-8",
    psalm: "Sl 29",
    second_reading: "Rm 8:12-17",
    gospel: "Jo 3:1-17"
  },
  {
    date_reference: "trinity_sunday",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Pv 8:1-4, 22-31",
    psalm: "Sl 8",
    second_reading: "Rm 5:1-5",
    gospel: "Jo 16:12-15"
  }
]

# Criar leituras
count = 0
skipped = 0

pentecost_readings.each do |reading|
  reading[:prayer_book_id] = prayer_book&.id
  existing = LectionaryReading.find_by(
    date_reference: reading[:date_reference],
    cycle: reading[:cycle],
    service_type: reading[:service_type],
    prayer_book_id: prayer_book&.id
  )

  if existing.nil?
    LectionaryReading.create!(reading)
    count += 1
  else
    skipped += 1
  end
end

Rails.logger.info "\n✅ Leituras de Pentecostes criadas: #{count}"
Rails.logger.info "⏭️  Leituras já existentes: #{skipped}" if skipped > 0
