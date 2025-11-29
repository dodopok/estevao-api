# ================================================================================
# COLETAS DO ADVENTO - LOCB 2008
# Cor litúrgica: Roxo
# ================================================================================

puts "🙏 Criando Coletas do Advento - LOCB 2008..."

prayer_book = PrayerBook.find_by_code('locb_2008')

advent_collects = [
  # 1º DOMINGO DO ADVENTO
  {
    sunday_reference: "1st_sunday_of_advent",
    text: "Deus Onipotente, dá-nos a graça de rejeitar as obras das trevas e vestir-nos das armas da luz, durante esta vida mortal, em que teu Filho Jesus Cristo, com grande humildade, veio visitar-nos; a fim de que, no último dia, quando ele vier em sua gloriosa majestade, para julgar os vivos e os mortos, ressuscitemos para a vida imortal, mediante Jesus Cristo, que vive e reina contigo e com o Espírito Santo, agora e sempre. Amém.",
    language: "pt-BR"
  },
  # Dia da Bíblia (2º Domingo do Advento)
  {
    sunday_reference: "bible_sunday",
    text: "Bendito Senhor, que fizeste com que a tua Santa Palavra se escrevesse para nossa instrução; permite que a possamos de tal modo ouvir, ler, ponderar, aprender e assimilar interiormente, para que, pela paciência e consolação das Santas Escrituras, mantenhamos inabalável a bem-aventurada esperança da vida eterna, que tu nos tens dado em nosso Salvador Jesus Cristo. Amém.",
    language: "pt-BR"
  },
  # 2º DOMINGO DO ADVENTO
  {
    sunday_reference: "2nd_sunday_of_advent",
    text: "Deus Misericordioso, que enviaste teus mensageiros, os profetas, para pregar o arrependimento e preparar o caminho da nossa salvação; concede-nos a graça, para ouvirmos suas advertências e para abandonarmos os nossos pecados, a fim de saudarmos com alegria a vinda de Jesus Cristo, nosso Redentor, o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  # 3º DOMINGO DO ADVENTO
  {
    sunday_reference: "3rd_sunday_of_advent",
    text: "Senhor Jesus Cristo que, na tua primeira vinda, enviaste o precursor para preparar o teu caminho, concede à tua Igreja a graça e o poder para converter muitos ao caminho da justiça, a fim de que, na tua segunda vinda em glória, encontres um povo agradável aos teus olhos, ó Tu, que vives e reinas com o Pai e o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  # 4º DOMINGO DO ADVENTO
  {
    sunday_reference: "4th_sunday_of_advent",
    text: "Ó Deus Onipotente, purifica a nossa consciência com tua visitação diária, para que o teu Filho Jesus Cristo, na sua vinda em glória, encontre em nós a morada preparada para Si; o qual vive e reina contigo, na unidade do Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  }
]

advent_collects.each do |collect|
  Collect.create!(collect.merge(prayer_book_id: prayer_book&.id))
end

puts "  ✓ #{advent_collects.count} coletas do Advento criadas"
