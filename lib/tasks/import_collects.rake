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

    # ========== QUARESMA ==========
    cinzas_celebration = Celebration.find_by(name: "Quarta-Feira de Cinzas")

    Collect.create!(
      celebration: cinzas_celebration,
      language: "pt-BR",
      text: "Onipotente e eterno Deus, que amas tudo quanto criaste, e que perdoas a todas as pessoas penitentes; cria em nós corações novos e contritos, para que, lamentando os nossos pecados e confessando a nossa imperfeição, alcancemos de ti, Deus de suma piedade, perfeita remissão e perdão; por nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
      preface: "Prefácio para Quadra da Quaresma"
    )
    collects_count += 1

    # ========== PÁSCOA ==========
    pascoa_celebration = Celebration.find_by(name: "Páscoa")

    Collect.create!(
      celebration: pascoa_celebration,
      language: "pt-BR",
      text: "Luz resplandecente, que para a nossa redenção entregaste o teu Unigênito Filho à morte de cruz, e pela sua gloriosa ressurreição nos libertaste do poder da morte; concede que morramos diariamente para o pecado, a fim de que vivamos sempre com ele na alegria de sua ressurreição; mediante Jesus Cristo, teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
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
