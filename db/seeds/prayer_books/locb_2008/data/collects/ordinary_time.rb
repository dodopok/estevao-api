# ================================================================================
# COLETAS DO TEMPO COMUM II (PRÓPRIOS 1-29) - LOCB 2008
# Domingos após Pentecostes
# Cor litúrgica: Verde
# ================================================================================

Rails.logger.info "🙏 Criando Coletas do Tempo Comum II (Próprios) - LOCB 2008..."

prayer_book = PrayerBook.find_by_code('locb_2008')

ordinary_time_collects = [
  # ================================================================================
  # PRÓPRIO 1 (entre 8 e 14 de maio)
  # ================================================================================
  {
    sunday_reference: "proper_1",
    text: "Lembra-te, Senhor, da graça que nos concedeste e não dos nossos merecimentos, e, assim como nos chamaste ao teu serviço, faze-nos dignos de nossa vocação; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PRÓPRIO 2 (entre 15 e 21 de maio)
  # ================================================================================
  {
    sunday_reference: "proper_2",
    text: "Onipotente e misericordioso Deus, fortalece-nos em tua misericórdia, em todas as adversidades, para que, tendo a disposição da mente e do corpo, realizemos com corações alegres tudo quanto pertence ao teu propósito. Por nosso Senhor Jesus Cristo que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PRÓPRIO 3 (entre 22 e 28 de maio)
  # ================================================================================
  {
    sunday_reference: "proper_3",
    text: "Concede, ó Senhor, que o curso deste mundo seja governado em paz pela tua providência; e que tua Igreja possa servir-te com alegria e confiança; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PRÓPRIO 4 (entre 29 de maio e 4 de junho)
  # ================================================================================
  {
    sunday_reference: "proper_4",
    text: "O Deus, cuja infalível providência ordena todas as coisas no céu e na terra, com humildade te imploramos que de nós afastes tudo o que nos possa causar dano e nos outorgues quanto nos seja proveitoso; mediante nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PRÓPRIO 5 (entre 5 e 11 de junho)
  # ================================================================================
  {
    sunday_reference: "proper_5",
    text: "Ó Senhor, de quem procede todo o bem, concede que, por tua santa inspiração, cogitemos o que é bom, e por tua orientação misericordiosa o executemos. Mediante nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PRÓPRIO 6 (entre 12 e 18 de junho)
  # ================================================================================
  {
    sunday_reference: "proper_6",
    text: "Guarda, ó Senhor, tua Família, a Igreja, firme na fé, para que, pela tua graça, proclame tua verdade com ousadia e ministre a tua justiça com amor. Mediante nosso Salvador Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PRÓPRIO 7 (entre 19 e 25 de junho)
  # ================================================================================
  {
    sunday_reference: "proper_7",
    text: "Ó Senhor, faze com que tenhamos amor e reverência constantes, porque nunca deixas de ajudar e governar os que colocaste sobre o fundamento seguro de tua bondade; mediante nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PRÓPRIO 8 (entre 26 de junho e 2 de julho)
  # ================================================================================
  {
    sunday_reference: "proper_8",
    text: "Deus Onipotente, que edificaste tua Igreja sobre o fundamento dos Apóstolos e Profetas, sendo Jesus Cristo mesmo a principal pedra angular; concede que sejamos unidos em espírito por meio de seu ensino e feitos um santo templo aceitável a teus olhos; mediante nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PRÓPRIO 9 (entre 3 e 9 de julho)
  # ================================================================================
  {
    sunday_reference: "proper_9",
    text: "Ó Deus, ensinaste-nos que amar a Ti e ao nosso próximo é guardar os teus mandamentos; concede-nos a graça do teu Espírito Santo para que sejamos consagrados a ti com todo o nosso coração e unidos uns aos outros com pura afeição; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PRÓPRIO 10 (entre 10 e 16 de julho)
  # ================================================================================
  {
    sunday_reference: "proper_10",
    text: "Ó Senhor, suplicamos-te que recebas, com piedade celestial, as orações do teu povo que te invoca: e concede que todos saibam e compreendam o que devem fazer e tenham a graça e poder para fielmente o realizar. Mediante nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PRÓPRIO 11 (entre 17 e 23 de julho)
  # ================================================================================
  {
    sunday_reference: "proper_11",
    text: "Deus Onipotente, fonte de toda a sabedoria, que tanto conheces de antemão as nossas necessidades, quanto nós ignoramos o que pedir; tem compaixão de nossas fraquezas, e concede-nos tudo o que, por indignidade ou cegueira nossa, não ousamos nem sabemos suplicar, senão pelos merecimentos de teu Filho Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PRÓPRIO 12 (entre 24 e 30 de julho)
  # ================================================================================
  {
    sunday_reference: "proper_12",
    text: "Ó Deus, protetor dos que em ti confiam, sem o qual nada é forte, nada é santo; acrescenta e multiplica a tua misericórdia para conosco, a fim de que, sob o teu governo e direção, vivamos esta vida de tal maneira que não percamos a vida eterna. Por nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PRÓPRIO 13 (entre 31 de julho e 6 de agosto)
  # ================================================================================
  {
    sunday_reference: "proper_13",
    text: "Permite, ó Senhor, que a tua contínua misericórdia purifique e defenda a tua Igreja; e, porquanto ela não pode continuar em segurança sem teu socorro, preserva-a sempre com teu auxílio e bondade; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PRÓPRIO 14 (entre 7 e 13 de agosto)
  # ================================================================================
  {
    sunday_reference: "proper_14",
    text: "Concede-nos, Senhor, te rogamos, a graça de pensar e executar sempre o que é justo e bom, para que nós, que sem ti nada podemos, por ti nos tornemos capazes de viver conforme a tua vontade; mediante nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PRÓPRIO 15 (entre 14 e 20 de agosto)
  # ================================================================================
  {
    sunday_reference: "proper_15",
    text: "Deus Onipotente, que deste teu único Filho não só em sacrifício pelo pecado, mas também para exemplo de santidade, dá-nos a graça de sempre receber com gratidão os frutos de sua obra redentora e de seguir diariamente os bem-aventurados passos de sua santíssima vida. Mediante nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PRÓPRIO 16 (entre 21 e 27 de agosto)
  # ================================================================================
  {
    sunday_reference: "proper_16",
    text: "Ó Misericordioso Deus, concede que a tua Igreja, unida pelo Espírito Santo, manifeste o teu poder entre todos os povos, para a glória do teu nome. Mediante Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PRÓPRIO 17 (entre 28 de agosto e 3 de setembro)
  # ================================================================================
  {
    sunday_reference: "proper_17",
    text: "Senhor de todo o poder e majestade, autor e dispensador de todo o bem; enxerta em nossos corações o amor do teu nome; aumenta em nós a verdadeira religião, nutre-nos com toda a bondade e frutifica em nós as boas obras; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PRÓPRIO 18 (entre 4 e 10 de setembro)
  # ================================================================================
  {
    sunday_reference: "proper_18",
    text: "Concede-nos, Senhor, que confiemos em ti com todo o nosso coração, porque assim como tu resistes aos orgulhosos, que se vangloriam de sua própria força, também nunca abandonas os que exaltam a tua misericórdia; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PRÓPRIO 19 (entre 11 e 17 de setembro)
  # ================================================================================
  {
    sunday_reference: "proper_19",
    text: "Ó Deus, visto que sem ti não te podemos agradar, misericordioso, permite que teu Santo Espírito dirija e governe os nossos corações; mediante nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PRÓPRIO 20 (entre 18 e 24 de setembro)
  # ================================================================================
  {
    sunday_reference: "proper_20",
    text: "Pai celestial, concede, ó Senhor, que não andemos ansiosos quanto às coisas terrenas, que são passageiras, mas que amemos as celestiais que permanecem para sempre. Por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PRÓPRIO 21 (entre 25 de setembro e 1 de outubro)
  # ================================================================================
  {
    sunday_reference: "proper_21",
    text: "Ó Deus, cuja onipotência se revela principalmente em misericórdia e compaixão; concede-nos a plenitude da tua graça, para que, esforçando-nos para alcançar as tuas promessas, sejamos feitos participantes do teu tesouro celestial; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PRÓPRIO 22 (entre 2 e 8 de outubro)
  # ================================================================================
  {
    sunday_reference: "proper_22",
    text: "Onipotente e sempiterno Deus, que sempre estás mais pronto a ouvir do que nós a suplicar, e nos dás mais do que desejamos ou merecemos; derrama sobre nós a tua misericórdia, perdoando o que nos pesa na consciência e dando-nos as bênçãos que não somos dignos de pedir, senão pelos merecimentos de Jesus Cristo teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PRÓPRIO 23 (entre 9 e 15 de outubro)
  # ================================================================================
  {
    sunday_reference: "proper_23",
    text: "Rogamos-te, Senhor, que a tua graça sempre nos preceda e acompanhe, inspirando-nos a perseverar na prática de boas obras; mediante Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PRÓPRIO 24 (entre 16 e 22 de outubro)
  # ================================================================================
  {
    sunday_reference: "proper_24",
    text: "Onipotente e sempiterno Deus, que em Cristo tens revelado tua glória entre as nações. Mantém viva esta obra, por tua misericórdia, para que a tua Igreja pelo mundo inteiro persevere com fé inabalável na confissão do teu nome; mediante Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PRÓPRIO 25 (entre 23 e 29 de outubro)
  # ================================================================================
  {
    sunday_reference: "proper_25",
    text: "Onipotente e eterno Deus, aumenta em nós a fé, a esperança e o amor; e para que alcancemos as tuas promessas, inclina-nos a amar o que nos ordenas; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PRÓPRIO 26 (entre 30 de outubro e 5 de novembro)
  # ================================================================================
  {
    sunday_reference: "proper_26",
    text: "Onipotente e misericordioso Deus, de quem procede a graça de teus servos te servirem bem e agradavelmente; permite que te sirvamos com tanta fidelidade nesta vida, que alcancemos finalmente as tuas promessas celestiais; pelos merecimentos de Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PRÓPRIO 27 (entre 6 e 12 de novembro)
  # ================================================================================
  {
    sunday_reference: "proper_27",
    text: "Ó Deus, cujo Filho, para sempre bendito, foi manifestado para destruir as obras do maligno e tornar-nos filhos de Deus e herdeiros da vida eterna; permite, nós te suplicamos, que nesta esperança nos purifiquemos, assim como Ele é puro; para que, quando vier outra vez com poder e grande glória, sejamos feitos semelhantes a Ele no seu eterno e glorioso reino, onde contigo, Pai, e com o Espírito Santo, vive e reina sempre, um só Deus, pelos séculos dos séculos. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PRÓPRIO 28 (entre 13 e 19 de novembro)
  # ================================================================================
  {
    sunday_reference: "proper_28",
    text: "Ó Deus Onipotente, que enviaste a tua Igreja até os confins da terra para reunir um povo agradável aos teus olhos; concede que permaneçamos vigilantes e fiéis nesta Missão, de tal maneira que, mesmo que se abalem as estruturas deste mundo, proclamemos que Jesus Cristo teu Filho, vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PRÓPRIO 29 - CRISTO REI (entre 20 e 26 de novembro)
  # Último domingo após Pentecostes
  # ================================================================================
  {
    sunday_reference: "proper_29",
    text: "Senhor soberano, Onipotente e sempiterno Deus, cuja vontade é restaurar todas as coisas em teu amado Filho, o Rei dos Reis, Senhor dos senhores; misericordiosamente concede que os povos da terra, divididos e escravizados pelo pecado, sejam libertados e reunidos em seu reino de amor; o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  }
]

# Criar coletas
count = 0
skipped = 0

ordinary_time_collects.each do |collect|
  existing = Collect.find_by(
    sunday_reference: collect[:sunday_reference],
    prayer_book_id: prayer_book&.id
  )

  if existing.nil?
    Collect.create!(collect.merge(prayer_book_id: prayer_book&.id))
    count += 1
    print "." if count % 5 == 0
  else
    skipped += 1
  end
end

Rails.logger.info "\n✅ Coletas do Tempo Comum criadas: #{count}"
Rails.logger.info "⏭️  Coletas já existentes: #{skipped}" if skipped > 0
