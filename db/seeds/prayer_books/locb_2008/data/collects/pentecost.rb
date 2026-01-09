# ================================================================================
# COLETAS DE PENTECOSTES - LOCB 2008
# Cor litúrgica: Vermelho
# ================================================================================

Rails.logger.info "🙏 Criando Coletas de Pentecostes - LOCB 2008..."

prayer_book = PrayerBook.find_by_code('locb_2008')

pentecost_collects = [
  # VÉSPERA DE PENTECOSTES
  {
    sunday_reference: "pentecost_eve",
    text: "Deus Onipotente, neste dia abriste o caminho da vida eterna a toda raça e nação pela dádiva prometida do teu Santo Espírito, espalha este dom pelo mundo inteiro, mediante a proclamação do Evangelho, para que alcance os confins da terra; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém." },
  # DIA DE PENTECOSTES
  {
    sunday_reference: "pentecost",
    text: "Ó Deus, que no dia de Pentecostes, ensinaste os fiéis, derramando em seus corações a luz do teu Espírito Santo; concede-nos, por meio do mesmo Espírito, um juízo acertado em todas as coisas, e perene regozijo em seu fortalecimento; pelos méritos de Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém." },
  {
    sunday_reference: "pentecost_alt",
    text: "Ó Deus, que instruístes os corações dos vossos fiéis com a luz do Espírito Santo, fazei com que apreciemos retamente todas as coisas segundo o mesmo Espírito e gozemos sempre da sua consolação. Por Cristo, Senhor nosso. Amém." },
  # DOMINGO APÓS PENTECOSTES - TRINDADE
  {
    sunday_reference: "trinity_sunday",
    text: "Deus nosso Pai, enviaste ao mundo a Palavra da verdade e o Espírito da santidade para revelar aos homens o mistério admirável do teu Ser: concede-nos que na profissão da verdadeira fé reconheçamos a glória da eterna Trindade e adoremos a Unidade na sua onipotência. Mediante nosso Senhor Jesus Cristo. Amém." }
]

# Criar coletas
count = 0
skipped = 0

pentecost_collects.each do |collect|
  existing = Collect.find_by(
    sunday_reference: collect[:sunday_reference],
    prayer_book_id: prayer_book&.id
  )

  if existing.nil?
    Collect.create!(collect.merge(prayer_book_id: prayer_book&.id))
    count += 1
  else
    skipped += 1
  end
end

Rails.logger.info "✅ Coletas de Pentecostes criadas: #{count}"
Rails.logger.info "⏭️  Coletas já existentes: #{skipped}" if skipped > 0
