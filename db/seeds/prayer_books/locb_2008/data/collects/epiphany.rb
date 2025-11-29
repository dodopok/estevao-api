# ================================================================================
# COLETAS DO TEMPO COMUM I (Domingos após a Epifania) - LOCB 2008
# Cor litúrgica: Verde
# ================================================================================

puts "🙏 Criando Coletas do Tempo Comum I - LOCB 2008..."

prayer_book = PrayerBook.find_by_code('locb_2008')

epiphany_collects = [
  # 1º DOMINGO APÓS A EPIFANIA - Batismo do Senhor
  {
    sunday_reference: "baptism_of_the_lord",
    text: "Ó Pai Celestial, que, no Batismo de Jesus, no Jordão, o proclamaste teu amado Filho e o ungiste com o Espírito Santo; concede que todos os batizados em seu nome guardem constantes a aliança que estabeleceste e, com ousadia, o confessem Senhor e Salvador, o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  # 2º DOMINGO APÓS A EPIFANIA
  {
    sunday_reference: "2nd_sunday_after_epiphany",
    text: "Deus Onipotente, cujo Filho, nosso Salvador Jesus Cristo, é a luz do mundo; concede que o teu povo, iluminado e fortalecido pela tua Palavra e Sacramentos, brilhe com o resplendor da glória de Cristo, para que Ele seja conhecido, adorado e obedecido até os confins da terra; mediante Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  # 3º DOMINGO APÓS A EPIFANIA
  {
    sunday_reference: "3rd_sunday_after_epiphany",
    text: "Concede-nos a graça, ó Senhor, para responder prontamente ao chamado de nosso Senhor Jesus Cristo e proclamar a todos os povos as Boas Novas da sua salvação, para que nós e o mundo todo contemplemos a glória das suas maravilhosas obras; o qual vive e reina contigo e com o Espírito Santo, agora e sempre. Amém.",
    language: "pt-BR"
  },
  # 4º DOMINGO APÓS A EPIFANIA
  {
    sunday_reference: "4th_sunday_after_epiphany",
    text: "Onipotente e sempiterno Deus que governas todas as coisas no céu e na terra; ouve, misericordioso, as súplicas de teu povo, e concede-nos tua paz todos os dias de nossa vida; mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  # 5º DOMINGO APÓS A EPIFANIA
  {
    sunday_reference: "5th_sunday_after_epiphany",
    text: "Liberta-nos, ó Deus, da escravidão de nossos pecados e concede-nos a liberdade daquela vida abundante que nos fizeste conhecer em teu Filho Jesus Cristo, nosso Salvador, o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  # 6º DOMINGO APÓS A EPIFANIA
  {
    sunday_reference: "6th_sunday_after_epiphany",
    text: "Ó Deus, fortaleza dos que em Ti confiam; misericordioso aceita nossas orações; e porquanto sem ti nada pode a fraqueza humana, concede-nos o auxílio de tua graça, para que, na prática de teus preceitos, te agrademos com a vontade e com as obras; mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  # 7º DOMINGO APÓS A EPIFANIA
  {
    sunday_reference: "7th_sunday_after_epiphany",
    text: "Ó Senhor, que nos ensinaste que todas as nossas ações sem amor, de nada valem; envia-nos o teu Santo Espírito e derrama em nossos corações o excelente dom da caridade, que é o verdadeiro vínculo da paz e de todas as virtudes, pois os que sem ela vivem, são considerados mortos aos teus olhos; concede-nos essa graça, mediante o teu único Filho Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  # 8º DOMINGO APÓS A EPIFANIA
  {
    sunday_reference: "8th_sunday_after_epiphany",
    text: "Ó Amorosíssimo Pai, que desejas nos mostremos agradecidos e lancemos os nossos cuidados sobre ti, que zelas por nós, nada temendo senão a perda de tua presença; preserva-nos de infundados receios e ansiedades mundanas, e não permitas que nuvem alguma da vida terrenal esconda de nós a luz de teu eterno amor, que a nós manifestaste na pessoa de teu Filho Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  # 9º DOMINGO APÓS A EPIFANIA / Último Domingo antes da Quaresma (Transfiguração)
  {
    sunday_reference: "last_sunday_after_epiphany",
    text: "Ó Deus, que, antes da Paixão de teu unigênito Filho, revelaste a sua glória sobre o monte, na Transfiguração; concede que nós, contemplando pela fé o resplendor de sua face, sejamos fortalecidos para carregar a nossa cruz e transformados na sua semelhança de glória em glória; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  }
]

epiphany_collects.each do |collect|
  Collect.create!(collect.merge(prayer_book_id: prayer_book&.id))
end

puts "  ✓ #{epiphany_collects.count} coletas do Tempo Comum I criadas"
