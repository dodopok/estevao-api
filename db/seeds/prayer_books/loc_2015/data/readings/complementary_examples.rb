# frozen_string_literal: true

# Exemplos de leituras complementares para o LOC 2015
# Estas são leituras alternativas às semicontínuas para alguns domingos do Tempo Comum
#
# NOTA: Este é apenas um exemplo demonstrativo com algumas leituras.
# Para implementação completa, seria necessário adicionar leituras complementares
# para todos os domingos onde o LOC oferece essa opção.

Rails.logger.info "📖 Carregando leituras complementares de exemplo (LOC 2015)..."

complementary_readings = [
  # Primeiro Domingo após Pentecostes - Trindade (Ano A)
  {
    date_reference: "santissima_trindade",
    cycle: "A",
    service_type: "eucharist",
    reading_type: "complementary",
    first_reading: "Gênesis 1:1-2:4a",
    psalm: "Salmo 8",
    second_reading: "2 Coríntios 13:11-13",
    gospel: "Mateus 28:16-20",
    notes: "Leitura complementar focando na criação e na grande comissão"
  },

  # Segundo Domingo do Tempo Comum (Ano A)
  {
    date_reference: "segundo_domingo_do_tempo_comum",
    cycle: "A",
    service_type: "eucharist",
    reading_type: "complementary",
    first_reading: "Isaías 49:1-7",
    psalm: "Salmo 40:1-12",
    second_reading: "1 Coríntios 1:1-9",
    gospel: "João 1:29-42",
    notes: "Leitura complementar enfatizando o chamado e testemunho"
  },

  # Terceiro Domingo do Tempo Comum (Ano A)
  {
    date_reference: "terceiro_domingo_do_tempo_comum",
    cycle: "A",
    service_type: "eucharist",
    reading_type: "complementary",
    first_reading: "Isaías 9:1-4",
    psalm: "Salmo 27:1, 5-13",
    second_reading: "1 Coríntios 1:10-18",
    gospel: "Mateus 4:12-23",
    notes: "Leitura complementar sobre luz nas trevas e chamado dos discípulos"
  },

  # Quarto Domingo do Tempo Comum (Ano A)
  {
    date_reference: "quarto_domingo_do_tempo_comum",
    cycle: "A",
    service_type: "eucharist",
    reading_type: "complementary",
    first_reading: "Miqueias 6:1-8",
    psalm: "Salmo 15",
    second_reading: "1 Coríntios 1:18-31",
    gospel: "Mateus 5:1-12",
    notes: "Leitura complementar com ênfase em justiça e bem-aventuranças"
  },

  # Quinto Domingo do Tempo Comum (Ano A)
  {
    date_reference: "quinto_domingo_do_tempo_comum",
    cycle: "A",
    service_type: "eucharist",
    reading_type: "complementary",
    first_reading: "Isaías 58:1-9a",
    psalm: "Salmo 112:1-9",
    second_reading: "1 Coríntios 2:1-12",
    gospel: "Mateus 5:13-20",
    notes: "Leitura complementar sobre jejum verdadeiro e sal da terra"
  }
]

prayer_book = PrayerBook.find_by(code: "loc_2015")

complementary_readings.each do |reading_data|
  LectionaryReading.create!(
    prayer_book: prayer_book,
    date_reference: reading_data[:date_reference],
    cycle: reading_data[:cycle],
    service_type: reading_data[:service_type],
    reading_type: reading_data[:reading_type],
    first_reading: reading_data[:first_reading],
    psalm: reading_data[:psalm],
    second_reading: reading_data[:second_reading],
    gospel: reading_data[:gospel],
    notes: reading_data[:notes]
  )
end

Rails.logger.info "✅ #{complementary_readings.count} leituras complementares de exemplo criadas!"
Rails.logger.info "   (Estas são apenas exemplos para demonstração do sistema)"
