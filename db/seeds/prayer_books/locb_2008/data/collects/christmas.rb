# ================================================================================
# COLETAS DO NATAL - LOCB 2008
# Cor litúrgica: Branco
# ================================================================================

Rails.logger.info "🙏 Criando Coletas do Natal - LOCB 2008..."

prayer_book = PrayerBook.find_by_code('locb_2008')

christmas_collects = [
  # VIGÍLIA DO NATAL
  {
    sunday_reference: "christmas_eve",
    text: "Ó Deus, todos os anos nos alegras com a lembrança do nascimento de Teu Filho; ajuda-nos a recebê-lo pela fé como nosso redentor, e dá-nos a graça de o contemplarmos sem temor no dia em que vier como nosso juiz. Mediante o mesmo Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  # DIA DE NATAL
  {
    sunday_reference: "christmas_day",
    text: "Deus Onipotente, que nos deste teu unigênito Filho para que tomasse sobre si a nossa natureza, e nascesse neste tempo de uma Virgem pura; concede que nós, renascidos e feitos teus filhos por adoção e graça, sejamos de dia em dia renovados por teu Santo Espírito; mediante nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "christmas_day_alt",
    text: "Ó Deus, que fizeste esta noite santa brilhar com a verdadeira luz; concede a nós que conhecemos o mistério dessa luz sobre a terra, tenhamos no céu o gozo perfeito de sua presença, onde contigo e com o Espírito Santo vive e reina um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  # 1º DOMINGO DEPOIS DO NATAL
  {
    sunday_reference: "1st_sunday_after_christmas",
    text: "Onipotente Deus, que derramaste sobre nós a nova luz do teu Verbo feito carne; concede que essa mesma luz, acesa em nossos corações, brilhe em nossas vidas; por Jesus Cristo, nosso Senhor, que vive e reina contigo, na unidade do Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "1st_sunday_after_christmas_alt",
    text: "Ó Deus, nosso Pai, deste-nos um modelo de vida na sagrada Família de Nazaré: concede que imitemos as suas virtudes em nossas famílias vivendo agora no espírito da caridade, para que, reunidos depois na tua casa, ali gozemos as alegrias eternas. Mediante nosso Senhor Jesus Cristo, teu Filho, na unidade do Espírito Santo. Amém.",
    language: "pt-BR"
  },
  # 2º DOMINGO DEPOIS DO NATAL
  {
    sunday_reference: "2nd_sunday_after_christmas",
    text: "Ó Deus, que maravilhosamente criaste e ainda mais maravilhosamente restauraste a dignidade da natureza humana; concede que participemos da vida divina de teu Filho Jesus Cristo, que se humilhou para participar de nossa humanidade, o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  # EPIFANIA
  {
    sunday_reference: "epiphany",
    text: "Ó Deus, que pela Estrela manifestaste teu unigênito Filho a todos os povos da terra; guia-nos à tua presença, os que hoje te conhecemos pela fé; a fim de que desfrutemos de tua glória face a face; mediante Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  }
]

christmas_collects.each do |collect|
  Collect.create!(collect.merge(prayer_book_id: prayer_book&.id))
end

Rails.logger.info "  ✓ #{christmas_collects.count} coletas do Natal criadas"
