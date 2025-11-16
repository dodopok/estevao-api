# frozen_string_literal: true

namespace :import do
  desc "Importar coletas do ano litúrgico"
  task collects: :environment do
    puts "🙏 Importando coletas do Ano Litúrgico Anglicano..."

    # Limpar coletas existentes
    Collect.destroy_all

    collects_count = 0

    # ========== ADVENTO ==========
    advento = LiturgicalSeason.find_by(name: "Advento")

    [
      {
        sunday_reference: "1_domingo_advento",
        text: "Rocha eterna, dá-nos a graça de rejeitar as obras das trevas e vestir-nos das armas da luz durante esta vida mortal, em que teu Filho Jesus Cristo, com grande humildade veio visitar-nos; a fim de que, no último dia, quando ele vier em sua gloriosa majestade, ressuscitemos com ele para a vida imortal, mediante o mesmo Jesus Cristo, que vive e reina contigo e com o Espírito Santo, agora e sempre. Amém.",
        preface: "Prefácio para Quadra do Advento"
      },
      {
        sunday_reference: "2_domingo_advento",
        text: "Deus misericordioso, que enviaste vozes proféticas para pregar o arrependimento e preparar o caminho da nossa salvação; concede-nos a graça, para ouvirmos suas advertências e para abandonarmos os nossos pecados, a fim de saudarmos com alegria a vinda de Jesus Cristo, nosso Redentor, o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
        preface: "Prefácio para Quadra do Advento"
      },
      {
        sunday_reference: "3_domingo_advento",
        text: "Senhor Jesus Cristo, assim como na tua primeira vinda enviaste o precursor para preparar o teu caminho, concede à tua Igreja a graça e o poder para converter muita gente ao caminho da justiça, a fim de que, na tua vinda gloriosa, encontres um povo agradável aos teus olhos, ó tu, que vives e reinas com o Pai e o Espírito Santo, um só Deus, agora e sempre. Amém.",
        preface: "Prefácio para Quadra do Advento"
      },
      {
        sunday_reference: "4_domingo_advento",
        text: "Ó Deus onipotente, purifica a nossa consciência com tua visitação diária, para que o teu Filho Jesus Cristo, na sua gloriosa vinda, encontre em nós a morada preparada para si; o qual vive e reina contigo, na unidade do Espírito Santo, um só Deus, agora e sempre. Amém.",
        preface: "Prefácio para Quadra do Advento"
      }
    ].each do |collect_data|
      Collect.create!(
        season: advento,
        language: "pt-BR",
        **collect_data
      )
      collects_count += 1
    end

    # ========== NATAL ==========
    natal_celebration = Celebration.find_by(name: "Natividade de nosso Senhor Jesus Cristo")

    Collect.create!(
      celebration: natal_celebration,
      language: "pt-BR",
      text: "Pai materno, que nos deste teu unigênito Filho para que tomasse sobre si a nossa natureza, e nascesse, neste tempo, de uma Virgem pura; concede que nós, feitos teus filhos e filhas por adoção e graça, tenhamos de dia em dia a renovação do teu Santo Espírito; mediante nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
      preface: "Prefácio para Quadra do Natal"
    )
    collects_count += 1

    # ========== EPIFANIA ==========
    epifania_celebration = Celebration.find_by(name: "Epifania de nosso Senhor Jesus Cristo")

    Collect.create!(
      celebration: epifania_celebration,
      language: "pt-BR",
      text: "Luz das nações, que pela estrela manifestaste teu Unigênito Filho a todos os povos da terra; guia-nos à tua presença, a nós que hoje te conhecemos pela fé, a fim de que desfrutemos de tua glória face a face; mediante Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
      preface: "Prefácio para as Festas da Epifania, Apresentação, Anunciação e Transfiguração de Nosso Senhor Jesus Cristo"
    )
    collects_count += 1

    # ========== BATISMO DO SENHOR ==========
    batismo_celebration = Celebration.find_by(name: "Batismo de nosso Senhor Jesus Cristo")

    Collect.create!(
      celebration: batismo_celebration,
      language: "pt-BR",
      text: "Gracioso Deus, que no Batismo de Jesus, no Jordão, o proclamaste teu amado Filho e o ungiste com o Espírito Santo; concede que as pessoas batizadas em seu nome guardem constantes a aliança que estabeleceste e, com ousadia, o confessem Senhor e Salvador, o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
      preface: "Prefácio para as Festas da Epifania, Apresentação, Anunciação e Transfiguração de Nosso Senhor Jesus Cristo"
    )
    collects_count += 1

    # ========== TEMPO COMUM APÓS EPIFANIA ==========
    tempo_comum = LiturgicalSeason.find_by(name: "Tempo Comum")

    # Domingos 2 a 9 depois da Epifania (Tempo Comum 2-9)
    [
      {
        sunday_reference: "2_domingo_epifania",
        text: "Deus onipotente, cujo Filho, nosso Salvador Jesus Cristo, é a luz do mundo; concede que o teu povo, iluminado e fortalecido pela tua Palavra e Sacramentos, brilhe com o resplendor da glória de Cristo, para que ele seja conhecido, adorado e obedecido até os confins da terra; mediante Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
        preface: "Prefácio para as Festas da Epifania, Apresentação, Anunciação e Transfiguração de Nosso Senhor Jesus Cristo"
      },
      {
        sunday_reference: "3_domingo_epifania",
        text: "Concede-nos a graça, ó Deus, para responder prontamente ao chamado de nosso Senhor Jesus Cristo e proclamar a todos os povos as Boas Novas da sua salvação, para que nós e o mundo todo contemplemos a glória das suas maravilhosas obras; o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
        preface: "Prefácio para as Festas da Epifania, Apresentação, Anunciação e Transfiguração de Nosso Senhor Jesus Cristo"
      },
      {
        sunday_reference: "4_domingo_epifania",
        text: "Amoroso e sempiterno Deus, que governas todas as coisas no céu e na terra; ouve, com misericórdia, as súplicas de teu povo, e concede-nos tua paz todos os dias de nossa vida; mediante Jesus Cristo, nosso Senhor. Amém.",
        preface: "Prefácio para as Festas da Epifania, Apresentação, Anunciação e Transfiguração de Nosso Senhor Jesus Cristo"
      },
      {
        sunday_reference: "5_domingo_epifania",
        text: "Liberta-nos, ó Deus, da escravidão de nossos pecados e concede-nos a liberdade daquela vida abundante que nos fizeste conhecer em teu Filho Jesus Cristo, nosso Salvador, o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
        preface: "Prefácio para as Festas da Epifania, Apresentação, Anunciação e Transfiguração de Nosso Senhor Jesus Cristo"
      },
      {
        sunday_reference: "6_domingo_epifania",
        text: "Ó Deus, fortaleza de quem em ti confia; misericordiosamente aceita nossas orações; e porquanto sem ti nada pode a fraqueza humana, concede-nos o auxílio de tua graça, para que, na prática de teus preceitos, te agrademos com a vontade e com as obras; mediante Jesus Cristo, nosso Senhor. Amém.",
        preface: "Prefácio para as Festas da Epifania, Apresentação, Anunciação e Transfiguração de Nosso Senhor Jesus Cristo"
      },
      {
        sunday_reference: "7_domingo_epifania",
        text: "Ó Deus, que nos ensinaste que todas as nossas ações sem amor, de nada valem; envia-nos o teu Santo Espírito e derrama em nossos corações o excelente dom da caridade, que é o verdadeiro vínculo da paz e de todas as virtudes, pois as pessoas que sem ela vivem são consideradas mortas aos teus olhos; concede-nos essa graça, mediante o teu único Filho, Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
        preface: "Prefácio para as Festas da Epifania, Apresentação, Anunciação e Transfiguração de Nosso Senhor Jesus Cristo"
      },
      {
        sunday_reference: "8_domingo_epifania",
        text: "Amorosíssimo Deus, que desejas a nossa gratidão e zelas por nós, nada tememos senão a perda de tua presença; preserva-nos de infundados receios e ansiedades mundanas, e não permitas que nuvem alguma da vida terrenal esconda de nós a luz de teu eterno amor, que a nós manifestaste na pessoa de teu Filho, Jesus Cristo, nosso Senhor. Amém.",
        preface: "Prefácio para as Festas da Epifania, Apresentação, Anunciação e Transfiguração de Nosso Senhor Jesus Cristo"
      },
      {
        sunday_reference: "9_domingo_epifania",
        text: "Raiz de todo bem, deposita em nossos corações o temor a ti, para que possamos trabalhar pelo Evangelho, dar frutos da tua justiça neste mundo, e reconhecer que, acima de todas as leis humanas, está o teu inefável amor encarnado no nosso Salvador e Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
        preface: "Prefácio para as Festas da Epifania, Apresentação, Anunciação e Transfiguração de Nosso Senhor Jesus Cristo"
      },
      {
        sunday_reference: "ultimo_domingo_epifania",
        text: "Ó Deus, que, antes da Paixão de teu Unigênito Filho, revelaste a sua glória sobre o Monte, na Transfiguração; concede que nós, contemplando pela fé o resplendor de sua face, recebamos forças para carregar a nossa cruz e nos tornemos à sua semelhança de glória em glória; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
        preface: "Prefácio para as Festas da Epifania, Apresentação, Anunciação e Transfiguração de Nosso Senhor Jesus Cristo"
      }
    ].each do |collect_data|
      Collect.create!(
        season: tempo_comum,
        language: "pt-BR",
        **collect_data
      )
      collects_count += 1
    end

    # ========== QUARESMA ==========
    quaresma = LiturgicalSeason.find_by(name: "Quaresma")
    cinzas_celebration = Celebration.find_by(name: "Quarta-Feira de Cinzas")

    Collect.create!(
      celebration: cinzas_celebration,
      language: "pt-BR",
      text: "Onipotente e eterno Deus, que amas tudo quanto criaste, e que perdoas a todas as pessoas penitentes; cria em nós corações novos e contritos, para que, lamentando os nossos pecados e confessando a nossa imperfeição, alcancemos de ti, Deus de suma piedade, perfeita remissão e perdão; por nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
      preface: "Prefácio para Quadra da Quaresma"
    )
    collects_count += 1

    # Domingos da Quaresma (1º ao 5º)
    [
      {
        sunday_reference: "1_domingo_quaresma",
        text: "Deus que nos livras de todo mal, cujo bendito Filho foi conduzido pelo Espírito para ser tentado pelo demônio, apressa-te em socorrer a nós, que sofremos com muitas tentações, nós te rogamos. E, assim como conheces as nossas fraquezas, permite que cada qual encontre em ti o poder de salvação. Por Jesus Cristo, teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
        preface: "Prefácio para Quadra da Quaresma"
      },
      {
        sunday_reference: "2_domingo_quaresma",
        text: "Compassivo Deus, cuja glória é sempre ser misericordioso, sê benigno para com quem se afastou dos teus caminhos, conduzindo essas pessoas de novo a ti, com corações penitentes e viva fé, para que se firmem na verdade imutável da tua Palavra, Jesus Cristo, teu Filho, que, contigo e com o Espírito Santo, vive e reina, um só Deus, agora e sempre. Amém.",
        preface: "Prefácio para Quadra da Quaresma"
      },
      {
        sunday_reference: "3_domingo_quaresma",
        text: "Ó Deus, que sabes quão frágeis somos, guarda-nos a nós, teus servos e servas, defendendo exteriormente nossos corpos de toda a adversidade e purificando interiormente nossas almas de todo mau pensamento; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
        preface: "Prefácio para Quadra da Quaresma"
      },
      {
        sunday_reference: "4_domingo_quaresma",
        text: "Bendito Deus, cujo Filho Jesus Cristo desceu do céu para ser o verdadeiro Pão que vivifica o mundo; concede-nos sempre esse Pão, para que ele viva em nós e nós nele, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
        preface: "Prefácio para Quadra da Quaresma"
      },
      {
        sunday_reference: "5_domingo_quaresma",
        text: "Deus de graça e perdão, tu somente podes colocar em ordem a vontade e as afeições desordenadas de quem peca. Concede ao teu povo a graça de amar o que ordenas e desejar o que prometes; para que, entre as inconstâncias do mundo, permaneçam nossos corações firmados lá onde se acha a verdadeira alegria, por nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
        preface: "Prefácio para Quadra da Quaresma"
      }
    ].each do |collect_data|
      Collect.create!(
        season: quaresma,
        language: "pt-BR",
        **collect_data
      )
      collects_count += 1
    end

    # ========== SEMANA SANTA ==========

    # Domingo de Ramos - Liturgia das Palmas
    ramos_celebration = Celebration.find_by(name: "Domingo de Ramos")
    Collect.create!(
      celebration: ramos_celebration,
      language: "pt-BR",
      text: "Auxilia-nos, misericordiosamente, Senhor Deus de nossa salvação para que possamos contemplar com júbilo os poderosos eventos por meio dos quais nos concedeste vida e imortalidade, mediante o mesmo Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
      preface: "Prefácio para Semana Santa"
    ) if ramos_celebration
    collects_count += 1 if ramos_celebration

    # Domingo de Ramos - Liturgia da Paixão (segunda coleta)
    Collect.create!(
      celebration: ramos_celebration,
      sunday_reference: "domingo_ramos_paixao",
      language: "pt-BR",
      text: "Eterno Deus, de tal modo amaste o mundo, que enviaste teu Filho, nosso Salvador Jesus Cristo, para tomar sobre si a nossa carne e sofrer morte na cruz, dando ao gênero humano exemplo de sua profunda humildade; concede, em tua misericórdia, que imitemos a sua paciência no sofrimento e possamos participar também de sua ressurreição; mediante o mesmo Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
      preface: "Prefácio para Semana Santa"
    ) if ramos_celebration
    collects_count += 1 if ramos_celebration

    # Segunda-feira da Semana Santa
    Collect.create!(
      season: quaresma,
      sunday_reference: "segunda_semana_santa",
      language: "pt-BR",
      text: "Onipotente Deus, cujo Filho muito amado não desfrutou da perfeita alegria, senão após o sofrimento, e só subiu à glória depois de crucificado; concede-nos misericordioso que, seguindo o caminho da cruz, seja este para nós vereda de vida e paz; por Jesus Cristo, teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
      preface: "Prefácio para Semana Santa"
    )
    collects_count += 1

    # Terça-feira da Semana Santa
    Collect.create!(
      season: quaresma,
      sunday_reference: "terca_semana_santa",
      language: "pt-BR",
      text: "Ó Deus, que pela paixão de teu bendito Filho, fizeste com que o instrumento da morte vergonhosa se tornasse para nós símbolo de vida; concede que nos glorifiquemos na cruz de Cristo, a fim de que alegremente suportemos infâmias e privações, por amor de teu Filho, nosso Salvador Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
      preface: "Prefácio para Semana Santa"
    )
    collects_count += 1

    # Quarta-feira da Semana Santa
    Collect.create!(
      season: quaresma,
      sunday_reference: "quarta_semana_santa",
      language: "pt-BR",
      text: "Amado Deus, cujo bendito Filho, nosso Salvador Jesus Cristo, teve o seu corpo torturado e seu rosto cuspido; concede-nos a graça de enfrentar com esperança os sofrimentos deste tempo e de confiar na glória que há de ser revelada; por Jesus Cristo, teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
      preface: "Prefácio para Semana Santa"
    )
    collects_count += 1

    # Quinta-feira Santa - Renovação dos votos
    quinta_santa = Celebration.find_by(name: "Quinta-Feira Santa")
    Collect.create!(
      celebration: quinta_santa,
      sunday_reference: "quinta_santa_votos",
      language: "pt-BR",
      text: "Fonte de união e vida, que pelo poder do Espírito Santo ungiste teu Filho Messias e Sacerdote para todo o sempre; permite que as pessoas a quem chamaste para o teu serviço possam confessar a fé no Cristo crucificado, proclamar sua ressurreição e partilhar conosco do seu eterno sacerdócio, por meio de Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
      preface: "Prefácio para Festa de um(a) Apóstolo(a) e Ordenações"
    ) if quinta_santa
    collects_count += 1 if quinta_santa

    # Quinta-feira Santa - Liturgia da Última Ceia
    Collect.create!(
      celebration: quinta_santa,
      language: "pt-BR",
      text: "Ó Fonte de misericórdia, cujo amado Filho, na noite anterior à sua paixão, instituiu o Sacramento do seu Corpo e Sangue; concede-nos, misericordioso, que dele participemos com gratidão, em memória daquele que nestes santos mistérios nos dá o penhor da vida eterna, teu Filho Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém. Amém.",
      preface: "Prefácio para Semana Santa"
    ) if quinta_santa
    collects_count += 1 if quinta_santa

    # Sexta-feira da Paixão
    sexta_paixao = Celebration.find_by(name: "Sexta-Feira da Paixão")
    Collect.create!(
      celebration: sexta_paixao,
      language: "pt-BR",
      text: "Compassivo Deus, nós te suplicamos olhes com misericórdia para esta família que é tua, e pela qual nosso Senhor Jesus Cristo não hesitou em entregar-se, traído, às mãos de pessoas cruéis, e sofrer morte de cruz; o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
      preface: "Prefácio para Semana Santa"
    ) if sexta_paixao
    collects_count += 1 if sexta_paixao

    # Sábado Santo
    sabado_santo = Celebration.find_by(name: "Sábado Santo")
    Collect.create!(
      celebration: sabado_santo,
      language: "pt-BR",
      text: "Criador do céu e da terra; concede que, assim como o corpo crucificado de teu amado Filho foi colocado no túmulo e descansou neste sábado santo, também acompanhemos Cristo na sua morte, aguardemos o terceiro dia e, com ele, ressuscitemos para uma vida nova; o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
      preface: ""
    ) if sabado_santo
    collects_count += 1 if sabado_santo

    # ========== PÁSCOA ==========
    pascoa_celebration = Celebration.find_by(name: "Páscoa")
    pascoa_season = LiturgicalSeason.find_by(name: "Páscoa")

    # Vigília Pascal (Primeira Eucaristia da Páscoa)
    Collect.create!(
      celebration: pascoa_celebration,
      sunday_reference: "vigilia_pascal",
      language: "pt-BR",
      text: "Senhor Deus, tu fizeste resplandecer esta noite com a glória da ressurreição de Cristo; faz com que a sua luz brilhe na tua Igreja para que tenhamos renovação no corpo e na alma e nos entreguemos plenamente ao teu serviço, mediante Jesus Cristo, teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
      preface: "Prefácio para Festa da Páscoa até a Véspera da Ascenção"
    )
    collects_count += 1

    # Domingo de Páscoa - Coleta 1
    Collect.create!(
      celebration: pascoa_celebration,
      language: "pt-BR",
      text: "Luz resplandecente, que para a nossa redenção entregaste o teu Unigênito Filho à morte de cruz, e pela sua gloriosa ressurreição nos libertaste do poder da morte; concede que morramos diariamente para o pecado, a fim de que vivamos sempre com ele na alegria de sua ressurreição; mediante Jesus Cristo, teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
      preface: "Prefácio para Festa da Páscoa até a Véspera da Ascenção"
    )
    collects_count += 1

    # Domingo de Páscoa - Coleta 2
    Collect.create!(
      celebration: pascoa_celebration,
      sunday_reference: "pascoa_aurora",
      language: "pt-BR",
      text: "Ó Deus Celestial, que fizeste com que a aurora santa brilhasse com a glória da ressurreição do Senhor; aviva em tua Igreja o Espírito de adoção, que nos é dado no Batismo, a fim de que nos renovemos tanto no corpo como na mente, e te adoremos com sinceridade e verdade; mediante Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém. Amém.",
      preface: "Prefácio para Festa da Páscoa até a Véspera da Ascenção"
    )
    collects_count += 1

    # Domingo de Páscoa - Coleta 3
    Collect.create!(
      celebration: pascoa_celebration,
      sunday_reference: "pascoa_gloria",
      language: "pt-BR",
      text: "Glorioso Deus, que por teu Unigênito Filho Jesus Cristo venceste a morte e nos abriste as portas da vida eterna; concede que nós, que celebramos com alegria o dia da ressurreição do Senhor, ressuscitemos da morte do pecado, pelo teu Espírito vivificador; mediante Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
      preface: "Prefácio para Festa da Páscoa até a Véspera da Ascenção"
    )
    collects_count += 1

    # Segunda-feira da Semana da Páscoa
    Collect.create!(
      season: pascoa_season,
      sunday_reference: "segunda_semana_pascoa",
      language: "pt-BR",
      text: "Concede, nós te rogamos, ó Deus, que nós, que celebramos com reverência a festa pascal, tenhamos dignidade para alcançar as sempiternas alegrias; mediante Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
      preface: "Prefácio para Festa da Páscoa até a Véspera da Ascenção"
    )
    collects_count += 1

    # ========== PENTECOSTES ==========
    pentecostes_celebration = Celebration.find_by(name: "Pentecostes")

    Collect.create!(
      celebration: pentecostes_celebration,
      language: "pt-BR",
      text: "Ó Deus maravilhoso, neste dia abriste o caminho da vida eterna a toda raça e nação pela dádiva prometida do teu Santo Espírito, espalha este dom pelo mundo inteiro, mediante a proclamação do Evangelho, para que alcance os confins da terra; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
      preface: "Prefácio para Festa de Pentecostes, Concílios e Sínodos"
    )
    collects_count += 1

    # ========== TRINDADE ==========
    trindade_celebration = Celebration.find_by(name: "Santíssima Trindade")

    Collect.create!(
      celebration: trindade_celebration,
      language: "pt-BR",
      text: "Deus que transcende todo o entendimento, deste-nos a graça de reconhecer a glória da eterna Trindade na confissão da verdadeira fé, e no poder da majestade divina adorar a unidade; mantém-nos firmes nesta fé e adoração e leva-nos finalmente a contemplar-te na tua glória una e eterna, ó Pai, que com o Filho e o Espírito Santo vives e reinas um só Deus, agora e sempre. Amém.",
      preface: "Prefácio para Festa da Santíssima Trindade"
    )
    collects_count += 1

    # ========== TRANSFIGURAÇÃO ==========
    transfiguracao_celebration = Celebration.find_by(name: "Transfiguração de nosso Senhor Jesus Cristo")

    Collect.create!(
      celebration: transfiguracao_celebration,
      language: "pt-BR",
      text: "Ó Deus, que no monte revelaste a testemunhas escolhidas teu Unigênito Filho, aí maravilhosamente transfigurado, em vestidura alva e brilhante; concede que, livres das inquietações do mundo, nos seja dado contemplar pela fé, na sua beleza, o Rei; o qual, contigo e com o Espírito Santo, vive e reina um só Deus, agora e sempre. Amém.",
      preface: "Prefácio para as Festas da Epifania, Apresentação, Anunciação e Transfiguração de Nosso Senhor Jesus Cristo"
    )
    collects_count += 1

    # ========== TODOS OS SANTOS ==========
    todos_santos_celebration = Celebration.find_by(name: "Todos os Santos e Santas")

    Collect.create!(
      celebration: todos_santos_celebration,
      language: "pt-BR",
      text: "Graciosíssimo Deus, que no corpo místico de teu Filho, nosso Senhor, vinculaste todo o teu povo escolhido em uma só comunhão e irmandade; concede-nos graça para de tal modo imitarmos, em vida e virtude, teus bem-aventurados santos e santas, que cheguemos a desfrutar das alegrias inexprimíveis reservadas a quem te ama sinceramente; mediante Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
      preface: "Prefácio para Festa de Todos os Santos e Santas"
    )
    collects_count += 1

    # ========== APÓSTOLOS ==========

    # André
    andre = Celebration.find_by(name: "André, Apóstolo")
    Collect.create!(
      celebration: andre,
      language: "pt-BR",
      text: "Deus de luz, que deste tanta graça ao teu Apóstolo André, que ele prontamente obedeceu à voz de Jesus Cristo e levou consigo o seu irmão, concede a todas as pessoas, chamadas pelo teu nome, a graça de segui-lo sem demora, e levar à tua benigna presença as que lhe são próximas; mediante Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
      preface: "Prefácio para Festa de um(a) Apóstolo(a) e Ordenações"
    ) if andre
    collects_count += 1 if andre

    # Pedro e Paulo
    pedro_paulo = Celebration.find_by(name: "Pedro e Paulo, Apóstolos")
    Collect.create!(
      celebration: pedro_paulo,
      language: "pt-BR",
      text: "Deus fiel, cujos benditos Apóstolos Pedro e Paulo te glorificaram pelo seu martírio; concede que a tua Igreja, instruída pelo seu testemunho e ensinamento, e unida pelo teu Espírito, permaneça sempre firme num só fundamento, o qual é Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
      preface: "Prefácio para Festa de um(a) Apóstolo(a) e Ordenações"
    ) if pedro_paulo
    collects_count += 1 if pedro_paulo

    puts "✅ #{collects_count} coletas importadas com sucesso!"
    puts "\n📝 Nota: Este é apenas um conjunto inicial de coletas."
    puts "   Para importar TODAS as coletas do documento, execute:"
    puts "   rake import:all_collects"
  end
end
