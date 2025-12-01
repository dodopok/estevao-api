# ================================================================================
# LEITURAS PARA OCASIÕES ESPECIAIS - LOCB 2008
# ================================================================================

Rails.logger.info "📖 Criando Leituras para Ocasiões Especiais - LOCB 2008..."

prayer_book = PrayerBook.find_by_code('locb_2008')

special_occasions_readings = [
  # ================================================================================
  # TÊMPORAS
  # ================================================================================
  {
    date_reference: "ember_days",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Is 61:1-6a",
    psalm: "Sl 132:1b-9",
    second_reading: "At 20:28-35",
    gospel: "Lc 4:16-21"
  },
  {
    date_reference: "ember_days_alt",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Is 40:1-11",
    psalm: "Sl 132:10-18",
    second_reading: "1 Pe 5:1-11",
    gospel: "Mt 9:35-38"
  },

  # ================================================================================
  # ROGAÇÕES
  # ================================================================================
  {
    date_reference: "rogation_monday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Dt 8:1-10",
    psalm: "Sl 104:14-26",
    second_reading: "2 Co 9:6-15",
    gospel: "Lc 11:5-13"
  },
  {
    date_reference: "rogation_tuesday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jó 28:1-11",
    psalm: "Sl 121",
    second_reading: "Fl 4:4-9",
    gospel: "Mt 6:25-34"
  },
  {
    date_reference: "rogation_wednesday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jl 2:21-27",
    psalm: "Sl 128",
    second_reading: "2 Ts 3:6-13",
    gospel: "Lc 5:1-11"
  },

  # ================================================================================
  # COLHEITAS
  # ================================================================================
  {
    date_reference: "harvest",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Dt 26:1-11",
    psalm: "Sl 65",
    second_reading: "Tg 5:7-11",
    gospel: "Mt 13:1-9"
  },

  # ================================================================================
  # SÍNODO, CONCÍLIO, CONSELHO, JUNTA, ASSEMBLÉIA
  # ================================================================================
  {
    date_reference: "synod",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Êx 18:13-27",
    psalm: "Sl 19:8-15",
    second_reading: "1 Co 12:7-11",
    gospel: "Jo 15:1-8"
  },
  {
    date_reference: "synod_alt",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Is 40:27-31",
    psalm: "Sl 25:1b-9",
    second_reading: "Ef 4:1-7",
    gospel: "Jo 13:12-17"
  },

  # ================================================================================
  # PELA DIREÇÃO DO ESPÍRITO SANTO
  # ================================================================================
  {
    date_reference: "guidance_holy_spirit",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jr 31:31-34",
    psalm: "Sl 139:1b-11",
    second_reading: "1 Co 12:4-13",
    gospel: "Jo 14:15-26"
  },

  # ================================================================================
  # PELA UNIDADE DA IGREJA
  # ================================================================================
  {
    date_reference: "church_unity",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Ez 37:15-28",
    psalm: "Sl 133",
    second_reading: "Ef 4:1-6",
    gospel: "Jo 17:11-23"
  },

  # ================================================================================
  # PELA MISSÃO DA IGREJA
  # ================================================================================
  {
    date_reference: "church_mission",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Is 49:1-6",
    psalm: "Sl 67",
    second_reading: "Ef 2:13-22",
    gospel: "Mt 28:16-20"
  },

  # ================================================================================
  # PELA JUSTIÇA E PELA PAZ
  # ================================================================================
  {
    date_reference: "justice_and_peace",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Is 42:1-7",
    psalm: "Sl 72:1b-14 ou Sl 85",
    second_reading: "Tg 2:5-17",
    gospel: "Mt 5:43-48"
  }
]

# Criar leituras
count = 0
skipped = 0

special_occasions_readings.each do |reading|
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

Rails.logger.info "✅ Leituras para Ocasiões Especiais criadas: #{count}"
Rails.logger.info "⏭️  Leituras já existentes: #{skipped}" if skipped > 0
