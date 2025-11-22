# ================================================================================
# LEITURAS DE PENTECOSTES E TRINDADE
# Revised Common Lectionary (RCL)
# ================================================================================
#
# Conteúdo:
# - Pentecostes (Ciclos A, B, C)
# - Santíssima Trindade / Trinity Sunday (Ciclos A, B, C)
#
# Nota: Estas são as grandes festas que marcam a transição do Tempo Pascal
#       para o Tempo Comum (Ordinary Time)
#
# ================================================================================

puts "📖 Carregando leituras de Pentecostes e Trindade..."

pentecost_readings = [
  # ============================================================================
  # PENTECOSTES
  # (50 dias após a Páscoa)
  # ============================================================================
  {
    date_reference: "pentecost",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Atos 2:1-21 or Números 11:24-30",
    psalm: "Salmo 104:24-34, 35b",
    second_reading: "1 Coríntios 12:3b-13 or Atos 2:1-21",
    gospel: "João 20:19-23 or João 7:37-39"
  },

  # ============================================================================
  # SANTÍSSIMA TRINDADE (TRINITY SUNDAY)
  # (Domingo após Pentecostes)
  # ============================================================================

  # ----------------------------------------------------------------------------
  # TRINDADE - CICLO A
  # ----------------------------------------------------------------------------
  {
    date_reference: "trinity_sunday",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Gênesis 1:1-2:4a",
    psalm: "Salmo 8",
    second_reading: "2 Coríntios 13:11-13",
    gospel: "Mateus 28:16-20"
  },

  # ----------------------------------------------------------------------------
  # TRINDADE - CICLO B
  # ----------------------------------------------------------------------------
  {
    date_reference: "trinity_sunday",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 6:1-8",
    psalm: "Salmo 29",
    second_reading: "Romanos 8:12-17",
    gospel: "João 3:1-17"
  },

  # ----------------------------------------------------------------------------
  # TRINDADE - CICLO C
  # ----------------------------------------------------------------------------
  {
    date_reference: "trinity_sunday",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Provérbios 8:1-4, 22-31",
    psalm: "Salmo 8",
    second_reading: "Romanos 5:1-5",
    gospel: "João 16:12-15"
  }
]

# Criar leituras (evita duplicatas)
count = 0
skipped = 0

pentecost_readings.each do |reading|
  existing = LectionaryReading.find_by(
    date_reference: reading[:date_reference],
    cycle: reading[:cycle],
    service_type: reading[:service_type]
  )

  if existing.nil?
    LectionaryReading.create!(reading)
    count += 1
    print "." if count % 2 == 0
  else
    skipped += 1
  end
end

puts "\n✅ #{count} leituras de Pentecostes e Trindade criadas!"
puts "⏭️  #{skipped} já existiam." if skipped > 0
