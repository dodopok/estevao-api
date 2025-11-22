# ================================================================================
# LEITURAS DA SEMANA SANTA E PÁSCOA
# Revised Common Lectionary (RCL)
# ================================================================================
#
# Conteúdo:
# - Segunda, Terça e Quarta-feira da Semana Santa
# - Quinta-feira Santa (Maundy Thursday)
# - Sexta-feira da Paixão (Good Friday)
# - Sábado de Aleluia / Vigília Pascal
# - Domingo de Páscoa (Ciclos A, B, C)
# - Semana de Páscoa (Segunda a Sábado)
#
# ================================================================================

puts "📖 Carregando leituras da Semana Santa e Páscoa..."

holy_week_easter_readings = [
  # ============================================================================
  # SEMANA SANTA - DIAS DA SEMANA
  # ============================================================================

  # ----------------------------------------------------------------------------
  # SEGUNDA-FEIRA DA SEMANA SANTA
  # ----------------------------------------------------------------------------
  {
    date_reference: "holy_monday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaías 42:1-9",
    psalm: "Salmo 36:5-11",
    second_reading: "Hebreus 9:11-15",
    gospel: "João 12:1-11"
  },

  # ----------------------------------------------------------------------------
  # TERÇA-FEIRA DA SEMANA SANTA
  # ----------------------------------------------------------------------------
  {
    date_reference: "holy_tuesday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaías 49:1-7",
    psalm: "Salmo 71:1-14",
    second_reading: "1 Coríntios 1:18-31",
    gospel: "João 12:20-36"
  },

  # ----------------------------------------------------------------------------
  # QUARTA-FEIRA DA SEMANA SANTA
  # ----------------------------------------------------------------------------
  {
    date_reference: "holy_wednesday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaías 50:4-9a",
    psalm: "Salmo 70",
    second_reading: "Hebreus 12:1-3",
    gospel: "João 13:21-32"
  },

  # ============================================================================
  # TRÍDUO PASCAL
  # ============================================================================

  # ----------------------------------------------------------------------------
  # QUINTA-FEIRA SANTA
  # ----------------------------------------------------------------------------
  {
    date_reference: "maundy_thursday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Êxodo 12:1-4, (5-10), 11-14",
    psalm: "Salmo 116:1-2, 12-19",
    second_reading: "1 Coríntios 11:23-26",
    gospel: "João 13:1-17, 31b-35"
  },

  # ----------------------------------------------------------------------------
  # SEXTA-FEIRA DA PAIXÃO (Good Friday)
  # ----------------------------------------------------------------------------
  {
    date_reference: "good_friday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaías 52:13-53:12",
    psalm: "Salmo 22",
    second_reading: "Hebreus 10:16-25 or Hebreus 4:14-16; 5:7-9",
    gospel: "João 18:1-19:42"
  },

  # ----------------------------------------------------------------------------
  # SÁBADO DE ALELUIA / VIGÍLIA PASCAL
  # Série de leituras do Antigo Testamento
  # ----------------------------------------------------------------------------
  {
    date_reference: "holy_saturday_vigil",
    cycle: "all",
    service_type: "vigil",
    first_reading: "Gênesis 1:1-2:4a (Creation)",
    psalm: "Salmo 136:1-9, 23-26",
    second_reading: "Gênesis 7:1-5, 11-18; 8:6-18; 9:8-13 (Flood)",
    gospel: "Romanos 6:3-11"
  },
  {
    date_reference: "holy_saturday_vigil_2",
    cycle: "all",
    service_type: "vigil",
    first_reading: "Gênesis 22:1-18 (Abraham and Isaac)",
    psalm: "Salmo 16",
    second_reading: "Êxodo 14:10-31; 15:20-21 (Red Sea)",
    gospel: "Mateus 28:1-10"
  },
  {
    date_reference: "holy_saturday_vigil_3",
    cycle: "all",
    service_type: "vigil",
    first_reading: "Isaías 55:1-11 (Salvation offered)",
    psalm: "Isaías 12:2-6",
    second_reading: "Ezequiel 36:24-28 (New heart)",
    gospel: "Marcos 16:1-8"
  },
  {
    date_reference: "holy_saturday_vigil_4",
    cycle: "all",
    service_type: "vigil",
    first_reading: "Ezequiel 37:1-14 (Valley of dry bones)",
    psalm: "Salmo 143",
    second_reading: "Romanos 6:3-11",
    gospel: "Lucas 24:1-12"
  },

  # ============================================================================
  # DOMINGO DE PÁSCOA
  # ============================================================================
  {
    date_reference: "easter_sunday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Atos 10:34-43 or Jeremias 31:1-6",
    psalm: "Salmo 118:1-2, 14-24",
    second_reading: "Colossenses 3:1-4 or Atos 10:34-43",
    gospel: "João 20:1-18 or Mateus 28:1-10"
  },

  # ============================================================================
  # SEMANA DE PÁSCOA (Oitava de Páscoa)
  # ============================================================================

  # ----------------------------------------------------------------------------
  # SEGUNDA-FEIRA DA PÁSCOA
  # ----------------------------------------------------------------------------
  {
    date_reference: "easter_monday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Atos 2:14, 22-32",
    psalm: "Salmo 16:1-2, 5-11",
    second_reading: "Mateus 28:8-15",
    gospel: "Mateus 28:8-15"
  },

  # ----------------------------------------------------------------------------
  # TERÇA-FEIRA DA PÁSCOA
  # ----------------------------------------------------------------------------
  {
    date_reference: "easter_tuesday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Atos 2:36-41",
    psalm: "Salmo 33:4-5, 18-20, 22",
    second_reading: "João 20:11-18",
    gospel: "João 20:11-18"
  },

  # ----------------------------------------------------------------------------
  # QUARTA-FEIRA DA PÁSCOA
  # ----------------------------------------------------------------------------
  {
    date_reference: "easter_wednesday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Atos 3:1-10",
    psalm: "Salmo 105:1-9",
    second_reading: "Lucas 24:13-35",
    gospel: "Lucas 24:13-35"
  },

  # ----------------------------------------------------------------------------
  # QUINTA-FEIRA DA PÁSCOA
  # ----------------------------------------------------------------------------
  {
    date_reference: "easter_thursday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Atos 3:11-26",
    psalm: "Salmo 8:2, 5-9",
    second_reading: "Lucas 24:35-48",
    gospel: "Lucas 24:35-48"
  },

  # ----------------------------------------------------------------------------
  # SEXTA-FEIRA DA PÁSCOA
  # ----------------------------------------------------------------------------
  {
    date_reference: "easter_friday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Atos 4:1-12",
    psalm: "Salmo 118:1-2, 4, 22-27",
    second_reading: "João 21:1-14",
    gospel: "João 21:1-14"
  },

  # ----------------------------------------------------------------------------
  # SÁBADO DA PÁSCOA
  # ----------------------------------------------------------------------------
  {
    date_reference: "easter_saturday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Atos 4:13-21",
    psalm: "Salmo 118:1, 14-21",
    second_reading: "Marcos 16:9-15",
    gospel: "Marcos 16:9-15"
  }
]

# Criar leituras (evita duplicatas)
count = 0
skipped = 0

holy_week_easter_readings.each do |reading|
  existing = LectionaryReading.find_by(
    date_reference: reading[:date_reference],
    cycle: reading[:cycle],
    service_type: reading[:service_type]
  )

  if existing.nil?
    LectionaryReading.create!(reading)
    count += 1
    print "." if count % 5 == 0
  else
    skipped += 1
  end
end

puts "\n✅ #{count} leituras da Semana Santa e Páscoa criadas!"
puts "⏭️  #{skipped} já existiam." if skipped > 0
