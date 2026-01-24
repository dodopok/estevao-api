# ================================================================================
# COLETAS DO ANO LITÚRGICO - LOC REB
# ================================================================================

Rails.logger.info "📿 Carregando coletas do ano litúrgico (LOC REB)..."

# Buscar o prayer book
prayer_book = PrayerBook.find_by!(code: 'loc_reb')

collects_data = [
  {
    sunday_reference: "1st_sunday_of_advent",
    text: "Rocha eterna, dá-nos a graça de rejeitar as obras das trevas e vestir-nos das armas da luz durante esta vida mortal, em que teu Filho Jesus Cristo, com grande humildade veio visitar-nos; a fim de que, no último dia, quando ele vier em sua gloriosa majestade, ressuscitemos com ele para a vida imortal, mediante o mesmo Jesus Cristo, que vive e reina contigo e com o Espírito Santo, agora e sempre. Amém."
  },
  {
    sunday_reference: "2nd_sunday_of_advent",
    text: "Deus Misericordioso, que enviaste teus mensageiros, os profetas, para pregar o arrependimento e preparar o caminho da nossa salvação; concede-nos a graça, para ouvirmos suas advertências e para abandonarmos os nossos pecados, a fim de saudarmos com alegria a vinda de Jesus Cristo, nosso Redentor, o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "3rd_sunday_of_advent",
    text: "Senhor Jesus Cristo, assim como na tua primeira vinda enviaste o precursor para preparar o teu caminho, concede à tua Igreja a graça e o poder para converter muita gente ao caminho da justiça, a fim de que, na tua vinda gloriosa, encontres um povo agradável aos teus olhos, ó tu, que vives e reinas com o Pai e o Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "4th_sunday_of_advent",
    text: "Ó Deus Onipotente, purifica a nossa consciência com tua visitação diária, para que o teu Filho Jesus Cristo, na sua vinda em glória, encontre em nós a morada preparada para Si; o qual vive e reina contigo, na unidade do Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "3rd_sunday_of_advent",
    text: "COLETA DA VIGÍLIA DE NATAL Fonte de vida, que nos alegras com a lembrança anual do nascimento de teu único Filho Jesus Cristo; concede que, assim como nós jubilosamente o recebemos como nosso Redentor, assim também o contemplemos com inteira confiança, quando vier para ser nosso justo juiz, o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "2nd_sunday_after_epiphany",
    text: "Deus onipotente, cujo Filho, nosso Salvador Jesus Cristo, é a luz do mundo; concede que o teu povo, iluminado e fortalecido pela tua Palavra e Sacramentos, brilhe com o resplendor da glória de Cristo, para que ele seja conhecido, adorado e obedecido até os confins da terra; mediante Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "3rd_sunday_after_epiphany",
    text: "Concede-nos a graça, ó Senhor, para responder prontamente ao chamado de nosso Senhor Jesus Cristo e proclamar a todos os povos as Boas Novas da sua salvação, para que nós e o mundo todo contemplemos a glória de tuas maravilhosas obras; por aquele que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "4th_sunday_after_epiphany",
    text: "Amoroso e sempiterno Deus, que governas todas as coisas no céu e na terra; ouve, com misericórdia, as súplicas de teu povo, e concede-nos tua paz todos os dias de nossa vida; mediante Jesus Cristo, nosso Senhor. Amém."
  },
  {
    sunday_reference: "5th_sunday_after_epiphany",
    text: "Liberta-nos, ó Deus, da escravidão de nossos pecados e concede-nos a liberdade daquela vida abundante que nos fizeste conhecer em teu Filho Jesus Cristo, nosso Salvador, o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "6th_sunday_after_epiphany",
    text: "(Se depois de Pentecostes) Lembra-te, Senhor, da graça que nos concedeste e não dos nossos merecimentos, e, assim como nos chamaste ao teu serviço, faze-nos dignos de nossa vocação; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "7th_sunday_after_epiphany",
    text: "(Se depois de Pentecostes) Onipotente e misericordioso Deus, fortalece-nos em tua misericórdia, em todas as adversidades, para que, tendo a disposição da mente e do corpo, realizemos com corações alegres tudo quanto pertence ao teu propósito. Por nosso Senhor Jesus Cristo que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "1st_sunday_of_lent",
    text: "Deus que nos livras de todo mal, cujo bendito Filho foi conduzido pelo Espírito para ser tentado pelo demônio, apressa-te em socorrer a nós, que sofremos com muitas tentações, nós te rogamos. E, assim como conheces as nossas fraquezas, permite que cada qual encontre em ti o poder de salvação. Por Jesus Cristo, teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "2nd_sunday_of_lent",
    text: "Ó Deus, cuja glória é sempre ser misericordioso, sê benigno para com todos os que se afastaram dos teus caminhos, conduze-os de novo a ti, com corações penitentes e viva fé, para que se firmem na verdade imutável da tua Palavra, Jesus Cristo, teu Filho, que, contigo e com o Espírito Santo, vive e reina, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "3rd_sunday_of_lent",
    text: "Ó Deus, que sabes quão frágeis somos, guarda-nos a nós, teus servos e servas, defendendo exteriormente nossos corpos de toda a adversidade e purificando interiormente nossas almas de todo mau pensamento; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "4th_sunday_of_lent",
    text: "Misericordioso Senhor, absolve o teu povo de suas ofensas, para que, por tua bondosa generosidade, sejamos todos libertos das cadeias dos pecados que, por nossa fraqueza, cometemos; concede-nos isso, ó Pai celestial, por amor de Jesus Cristo, nosso bendito Senhor e Salvador, que vive e reina contigo, na unidade do Espírito Santo, um só Deus, agora e para sempre. Amém."
  },
  {
    sunday_reference: "5th_sunday_of_lent",
    text: "Deus de graça e perdão, tu somente podes colocar em ordem a vontade e as afeições desordenadas de quem peca. Concede ao teu povo a graça de amar o que ordenas e desejar o que prometes; para que, entre as inconstâncias do mundo, permaneçam nossos corações firmados lá onde se acha a verdadeira alegria, por nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "2nd_sunday_of_easter",
    text: "Deus Todo-Poderoso, tu deste o teu único Filho para morrer por nossos pecados e ressuscitar para nossa justificação: concede-nos que afastemos o fermento da maldade e da perversidade, para que possamos sempre te servir com pureza de vida e verdade; pelos méritos de teu Filho Jesus Cristo, nosso Senhor, que vive e reina contigo, na unidade do Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "3rd_sunday_of_easter",
    text: "Pai Todo-Poderoso, que em tua grande misericórdia alegraste os discípulos com a visão do Senhor ressuscitado: dá-nos tal conhecimento da sua presença conosco, para que sejamos fortalecidos e sustentados por sua vida ressurreta e te sirvamos continuamente em justiça e verdade; por Jesus Cristo, teu Filho, nosso Senhor, que vive e reina contigo, na unidade do Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "4th_sunday_of_easter",
    text: "Ó Cristo Ressuscitado, fiel pastor das ovelhas de teu Pai: ensina-nos a ouvir tua voz e a seguir teu mandamento, para que todo o teu povo seja reunido em um só rebanho, para a glória de Deus Pai. Amém."
  },
  {
    sunday_reference: "5th_sunday_of_easter",
    text: "Deus Todo-Poderoso, que por teu Filho unigênito Jesus Cristo venceste a morte e nos abriste a porta da vida eterna: concede que, assim como pela tua graça preveniente inspiras em nós bons desejos, assim também, com tua ajuda contínua, possamos realizá-los plenamente; por Jesus Cristo, nosso Senhor ressuscitado, que vive e reina contigo, na unidade do Espírito Santo, um só Deus, agora e para sempre. Amém."
  },
  {
    sunday_reference: "6th_sunday_of_easter",
    text: "Pai eterno, o teu reino vai além do espaço e do tempo; concede que neste mundo de constantes mutações nos fixemos naquilo que permanece para sempre. Mediante Jesus Cristo, nosso Senhor. Amém."
  },
  {
    sunday_reference: "7th_sunday_of_easter",
    text: "Ó Deus, Rei da glória, que exaltaste o teu único Filho Jesus Cristo com grande triunfo ao teu celeste reino; suplicamos-te que não nos deixes desconsolados, mas nos envies o teu Santo Espírito para nos confortar e conduzir ao alto e santo lugar, onde nosso Senhor Jesus Cristo já nos precedeu, o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "pentecost",
    text: "Ó Deus, que no dia de Pentecostes, ensinaste os fiéis, derramando em seus corações a luz do teu Santo Espírito; concede-nos, por meio do mesmo Espírito, um juízo acertado em todas as coisas, e perene regozijo em seu fortalecimento; pelos méritos de Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "palm_sunday",
    text: "COLETA DA VIGÍLIA DE PÁSCOA Senhor Deus, Tu fizeste resplandecer esta noite com a glória da ressurreição de Cristo; faz com que a sua luz brilhe na tua Igreja para que sejamos renovados no corpo e na alma e nos entreguemos plenamente ao teu serviço. Por aquele que generosamente ofereceu a sua vida pela salvação de toda a humanidade, Jesus Cristo, teu Filho, nosso Senhor, o qual vive e reina contigo, na unidade do Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "pentecost",
    text: "Ó Deus, que no dia de Pentecostes, ensinaste os fiéis, derramando em seus corações a luz do teu Santo Espírito; concede-nos, por meio do mesmo Espírito, um juízo acertado em todas as coisas, e perene regozijo em seu fortalecimento; pelos méritos de Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "trinity_sunday",
    text: "Deus nosso Pai, enviaste ao mundo a Palavra da verdade e o Espírito da santidade para revelar aos homens o mistério admirável do teu Ser: concede-nos que na profissão da verdadeira fé reconheçamos a glória da eterna Trindade e adoremos a Unidade na sua onipotência. Mediante nosso Senhor Jesus Cristo. Amém."
  },
  {
    sunday_reference: "4th_sunday_after_epiphany",
    text: "Pai Eterno, cujo Filho Jesus Cristo ascendeu ao trono do céu para governar todas as coisas como Senhor e Rei: mantém tua Igreja na unidade do Espírito e no vínculo da paz, trazei toda a ordem criada para adorar aos pés daquele que vive e reina contigo, na unidade do Espírito Santo, um só Deus, agora e para sempre Amém."
  },
  {
    sunday_reference: "2nd_sunday_of_easter",
    text: "Suplicamos-te, Senhor, que, derrames a tua graça nos nossos corações, para que assim como conhecemos a encarnação de teu Filho Jesus Cristo por meio da mensagem angelical, também por sua cruz e paixão alcancemos a glória da sua ressurreição. Mediante o mesmo Jesus Cristo, nosso Senhor, que vive e reina contigo, na unidade do Espírito Santo, um só Deus, agora e para sempre. Amém"
  },
  {
    sunday_reference: "2nd_sunday_of_easter",
    text: "Deus Todo-Poderoso, que iluminaste a tua santa Igreja através do testemunho inspirado do teu evangelista São Marcos: concede que nós, firmemente alicerçados na verdade do Evangelho, sejamos fiéis ao seu ensinamento tanto em palavras como em obras; por Jesus Cristo, teu Filho, nosso Senhor, que vive e reina contigo, na unidade do Espírito Santo, um só Deus, agora e para sempre. Amém."
  },
]

count = 0
collects_data.each do |data|
  Collect.create!(
    prayer_book: prayer_book,
    **data
  )
  count += 1
end

Rails.logger.info "✓ Coletas carregadas: #{count}"
