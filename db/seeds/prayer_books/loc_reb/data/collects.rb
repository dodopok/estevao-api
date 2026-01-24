# ================================================================================
# COLETAS DO ANO LITÚRGICO - LOC REB
# ================================================================================

Rails.logger.info "📿 Carregando coletas do ano litúrgico (LOC REB)..."

prayer_book = PrayerBook.find_by!(code: 'loc_reb')

collects_data = [
  {
    sunday_reference: "1st_sunday_of_advent",
    # 1º Domingo do Advento
    text: "Rocha eterna, dá-nos a graça de rejeitar as obras das trevas e vestir-nos das armas da luz durante esta vida mortal, em que teu Filho Jesus Cristo, com grande humildade veio visitar-nos; a fim de que, no último dia, quando ele vier em sua gloriosa majestade, ressuscitemos com ele para a vida imortal, mediante o mesmo Jesus Cristo, que vive e reina contigo e com o Espírito Santo, agora e sempre. Amém."
  },
  {
    sunday_reference: "2nd_sunday_of_advent",
    # 2º Domingo do Advento
    text: "Deus Misericordioso, que enviaste teus mensageiros, os profetas, para pregar o arrependimento e preparar o caminho da nossa salvação; concede-nos a graça, para ouvirmos suas advertências e para abandonarmos os nossos pecados, a fim de saudarmos com alegria a vinda de Jesus Cristo, nosso Redentor, o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "3rd_sunday_of_advent",
    # 3º Domingo do Advento
    text: "Senhor Jesus Cristo, assim como na tua primeira vinda enviaste o precursor para preparar o teu caminho, concede à tua Igreja a graça e o poder para converter muita gente ao caminho da justiça, a fim de que, na tua vinda gloriosa, encontres um povo agradável aos teus olhos, ó tu, que vives e reinas com o Pai e o Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "4th_sunday_of_advent",
    # 4º Domingo do Advento
    text: "Ó Deus Onipotente, purifica a nossa consciência com tua visitação diária, para que o teu Filho Jesus Cristo, na sua vinda em glória, encontre em nós a morada preparada para Si; o qual vive e reina contigo, na unidade do Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "first_sunday_after_christmas",
    # 1º Domingo de Natal
    text: "Deus amado, que derramaste sobre nós a nova luz do teu Verbo feito carne; concede que essa mesma luz, acesa em nossos corações, brilhe em nossas vidas; por Jesus Cristo, nosso Senhor, que vive e reina contigo, na unidade do Espírito Santo, um só Deus, agora e sempre. Amém. ou COLETA DA SAGRADA FAMÍLIA Deus triuno, unidade eterna do amor perfeito: que em teu amor venhas reunir todas nações da terra para que sejam uma só família e nos atraias para Tua Santa vida através do nascimento de Emanuel, teu Filho, Nosso Senhor Jesus Cristo, por quem tudo te pedimos. Amém"
  },
  {
    sunday_reference: "second_sunday_after_christmas",
    # 2º Domingo de Natal
    text: "Ó Deus, que maravilhosamente criaste e ainda mais maravilhosamente restauraste a dignidade da natureza humana; concede que participemos da vida divinal de teu Filho Jesus Cristo, que se humilhou para participar de nossa humanidade, o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "ash_wednesday",
    # Quarta-feira de Cinzas
    text: "E RESTANTE DA SEMANA Onipotente e eterno Deus, que amas tudo quanto criaste, e que perdoas a todas as pessoas penitentes; cria em nós corações novos e contritos, para que, lamentando os nossos pecados e confessando a nossa imperfeição, alcancemos de ti, Deus de suma piedade, perfeita remissão e perdão; por nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "1st_sunday_of_lent",
    # 1º Domingo da Quaresma
    text: "Deus que nos livras de todo mal, cujo bendito Filho foi conduzido pelo Espírito para ser tentado pelo demônio, apressa-te em socorrer a nós, que sofremos com muitas tentações, nós te rogamos. E, assim como conheces as nossas fraquezas, permite que cada qual encontre em ti o poder de salvação. Por Jesus Cristo, teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "2nd_sunday_of_lent",
    # 2º Domingo da Quaresma
    text: "Ó Deus, cuja glória é sempre ser misericordioso, sê benigno para com todos os que se afastaram dos teus caminhos, conduze-os de novo a ti, com corações penitentes e viva fé, para que se firmem na verdade imutável da tua Palavra, Jesus Cristo, teu Filho, que, contigo e com o Espírito Santo, vive e reina, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "3rd_sunday_of_lent",
    # 3º Domingo da Quaresma
    text: "Ó Deus, que sabes quão frágeis somos, guarda-nos a nós, teus servos e servas, defendendo exteriormente nossos corpos de toda a adversidade e purificando interiormente nossas almas de todo mau pensamento; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "4th_sunday_of_lent",
    # 4º Domingo da Quaresma
    text: "Misericordioso Senhor, absolve o teu povo de suas ofensas, para que, por tua bondosa generosidade, sejamos todos libertos das cadeias dos pecados que, por nossa fraqueza, cometemos; concede-nos isso, ó Pai celestial, por amor de Jesus Cristo, nosso bendito Senhor e Salvador, que vive e reina contigo, na unidade do Espírito Santo, um só Deus, agora e para sempre. Amém."
  },
  {
    sunday_reference: "5th_sunday_of_lent",
    # 5º Domingo da Quaresma
    text: "Deus de graça e perdão, tu somente podes colocar em ordem a vontade e as afeições desordenadas de quem peca. Concede ao teu povo a graça de amar o que ordenas e desejar o que prometes; para que, entre as inconstâncias do mundo, permaneçam nossos corações firmados lá onde se acha a verdadeira alegria, por nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "easter_day_morning",
    # Domingo de Páscoa - Celebração Matutina
    text: "ORAÇÃO MATUTINA Ó Deus, que para a nossa redenção entregaste o teu unigênito Filho à morte de cruz, e pela tua gloriosa ressurreição nos libertaste do poder de nosso inimigo; concede que morramos diariamente para o pecado, a fim de que vivamos sempre com Ele na alegria de sua ressurreição; mediante Jesus Cristo, teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém. ou Ó Pai Celestial, que fizeste com que a aurora santa brilhasse com a glória da ressurreição do Senhor; aviva em tua Igreja o Espírito de adoção, que nos é dado no Batismo, a fim de que nos renovemos tanto no corpo como na mente, e te adoremos com sinceridade e verdade; mediante Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém. Amém. ou Glorioso Deus, que por teu Unigênito Filho Jesus Cristo venceste a morte e nos abriste as portas da vida eterna; concede que nós, que celebramos com alegria o dia da ressurreição do Senhor, ressuscitemos da morte do pecado, pelo teu Espírito vivificador; mediante Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "easter_day_evening",
    # Domingo de Páscoa - Celebração Vespertina
    text: "ORAÇÃO VESPERTINA Senhor de toda a vida e de toda a força, pela poderosa ressurreição de teu Filho, venceste a velha ordem do pecado e da morte, e n’Ele renovaste todas as coisas; concede que, morrendo nós para o pecado, e estando vivos para Ti em Cristo Jesus, possamos participar com Ele de Sua eterna glória; mediante o mesmo, Teu Filho, nosso Senhor, a quem contigo e com o Espírito Santo, sejam dadas honra e glória, agora e para todo o sempre. Amém."
  },
  {
    sunday_reference: "2nd_sunday_of_easter",
    # 2º Domingo da Páscoa
    text: "Deus Todo-Poderoso, tu deste o teu único Filho para morrer por nossos pecados e ressuscitar para nossa justificação: concede-nos que afastemos o fermento da maldade e da perversidade, para que possamos sempre te servir com pureza de vida e verdade; pelos méritos de teu Filho Jesus Cristo, nosso Senhor, que vive e reina contigo, na unidade do Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "3rd_sunday_of_easter",
    # 3º Domingo da Páscoa
    text: "Pai Todo-Poderoso, que em tua grande misericórdia alegraste os discípulos com a visão do Senhor ressuscitado: dá-nos tal conhecimento da sua presença conosco, para que sejamos fortalecidos e sustentados por sua vida ressurreta e te sirvamos continuamente em justiça e verdade; por Jesus Cristo, teu Filho, nosso Senhor, que vive e reina contigo, na unidade do Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "4th_sunday_of_easter",
    # 4º Domingo da Páscoa
    text: "Ó Cristo Ressuscitado, fiel pastor das ovelhas de teu Pai: ensina-nos a ouvir tua voz e a seguir teu mandamento, para que todo o teu povo seja reunido em um só rebanho, para a glória de Deus Pai. Amém."
  },
  {
    sunday_reference: "5th_sunday_of_easter",
    # 5º Domingo da Páscoa
    text: "Deus Todo-Poderoso, que por teu Filho unigênito Jesus Cristo venceste a morte e nos abriste a porta da vida eterna: concede que, assim como pela tua graça preveniente inspiras em nós bons desejos, assim também, com tua ajuda contínua, possamos realizá-los plenamente; por Jesus Cristo, nosso Senhor ressuscitado, que vive e reina contigo, na unidade do Espírito Santo, um só Deus, agora e para sempre. Amém."
  },
  {
    sunday_reference: "6th_sunday_of_easter",
    # 6º Domingo da Páscoa
    text: "Pai eterno, o teu reino vai além do espaço e do tempo; concede que neste mundo de constantes mutações nos fixemos naquilo que permanece para sempre. Mediante Jesus Cristo, nosso Senhor. Amém."
  },
  {
    sunday_reference: "7th_sunday_of_easter",
    # 7º Domingo da Páscoa
    text: "Ó Deus, Rei da glória, que exaltaste o teu único Filho Jesus Cristo com grande triunfo ao teu celeste reino; suplicamos-te que não nos deixes desconsolados, mas nos envies o teu Santo Espírito para nos confortar e conduzir ao alto e santo lugar, onde nosso Senhor Jesus Cristo já nos precedeu, o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém."
  },
  {
    sunday_reference: "pentecost",
    # Domingo de Pentecostes
    text: "Ó Deus, que no dia de Pentecostes, ensinaste os fiéis, derramando em seus corações a luz do teu Santo Espírito; concede-nos, por meio do mesmo Espírito, um juízo acertado em todas as coisas, e perene regozijo em seu fortalecimento; pelos méritos de Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém."
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
