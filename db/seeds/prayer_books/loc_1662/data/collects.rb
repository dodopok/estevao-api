# ================================================================================
# COLETAS - LOC 1662
# ================================================================================

Rails.logger.info "🙏 Carregando Coletas do LOC 1662..."

prayer_book = PrayerBook.find_by!(code: 'loc_1662')

collects = []

# ADVENTO

# 1º Domingo do Advento
collects << {
  celebration: "1st_sunday_of_advent",
  text: "Deus Todo-Poderoso, dá-nos a graça de rejeitar as obras das trevas e vestir-nos a armadura da luz prontamente durante esta vida mortal, em que teu Filho Jesus Cristo veio visitar-nos com grande humildade; a fim de que, no último dia, quando ele vier em sua gloriosa Majestade, para julgar os vivos e os mortos, ressuscitemos para a vida imortal por meio dEle, que vive e reina contigo e com o Espírito Santo, agora e sempre. Amém."
}

# 2º Domingo do Advento
collects << {
  celebration: "2nd_sunday_of_advent",
  text: "Bendito Senhor, que causou as Sagradas Escrituras serem escritas para nossa instrução; concede que as possamos ouvir, ler, ponderar, aprender e assimilar interiormente, para que, pela paciência e conforto da tua Santa Palavra, abracemos e mantenhamos para sempre a alegre esperança da vida eterna que Tu nos tens dado em nosso Salvador Jesus Cristo. Amém."
}

# 3º Domingo do Advento
collects << {
  celebration: "3rd_sunday_of_advent",
  text: "Senhor Jesus Cristo, que na tua primeira vinda mandaste teu mensageiro para preparar caminho para ti; concede que os ministros e servos da tua verdade possam igualmente assim preparar e dispor o teu caminho, tornando os corações de desobediência à sabedoria dos justos, para que em tua segunda vinda para julgar o mundo, possamos ser achados um povo aceitável aos teus olhos. Tu que vives e reinas com o Pai e o Espírito Santo, um só Deus, agora e para sempre. Amém."
}

# 4º Domingo do Advento
collects << {
  celebration: "4th_sunday_of_advent",
  text: "Ó Senhor, levanta-te, oramos, com teu poder e vem entre nós e ajuda-nos com tua grande força; visto que pelos nossos pecados e maldades, estejamos feridos e impedidos de fazer a corrida diante de nós; tua misericórdia e graça abundante possa nos ajudar rapidamente e livrar, pela satisfação do Teu Filho, nosso Senhor: a que contigo e o Espírito Santo seja dada a honra e a glória agora e para sempre. Amém."
}

# NATAL

# Dia de Natal
collects << {
  celebration: "christmas_day",
  text: "Deus Todo-Poderoso, que nos deste teu Filho Unigênito para que tomasse sobre si a nossa natureza e nascesse de uma virgem pura, e nós, que nascemos de novo nEle e somos feitos teus filhos por adoção e graça, possamos ser renovados diariamente pelo teu Espírito Santo, por nosso Senhor Jesus Cristo, que vive e reina contigo e o Espírito Santo, um só Deus, agora e para sempre. Amém."
}

# Dia de Santo Estevão
collects << {
  celebration: "saint_stephen",
  text: "CONCEDE, Senhor, que em todas as nossas aflições aqui na terra, pelo testemunho da tua verdade, possamos olhar firmemente para o céu e, pela fé, contemplar a glória que será revelada; e, cheios do Espírito Santo, aprendamos a amar e abençoar nossos perseguidores pelo exemplo do teu primeiro mártir, Santo Estevão, que orou por seus assassinos a ti, ó abençoado Jesus, que estás à direita de Deus para socorrer todos aqueles que sofrem por ti, nosso único mediador e advogado. Amém."
}

# Dia de São João Evangelista
collects << {
  celebration: "saint_john_apostle",
  text: "SENHOR misericordioso, rogamos que derrames tuas brilhantes luzes sobre tua igreja, para que, sendo iluminada pela doutrina de teu abençoado apóstolo e evangelista São João, possa caminhar na luz de tua verdade e, assim, alcance finalmente a luz da vida eterna, por Jesus Cristo nosso Senhor. Amém."
}

# Dia dos Santos Inocentes
collects << {
  celebration: "holy_innocents",
  text: "Ó Deus Todo-Poderoso, que da boca de crianças e bebês ordenaste força e fizeste com que os infantes te glorificassem por suas maravilhas: Mata e extingue em nós todos os vícios, e fortalece-nos com tua graça, para que, pela inocência de nossas vidas e constância de nossa fé, mesmo até a morte, possamos glorificar teu santo nome, por Jesus Cristo, nosso Senhor. Amém."
}

# O Domingo após o Natal
collects << {
  celebration: "1st_sunday_after_christmas",
  text: "Deus Todo-Poderoso, que nos deste teu Filho Unigênito para que tomasse sobre si a nossa natureza e nascesse de uma virgem pura, e nós, que nascemos de novo nEle e somos feitos teus filhos por adoção e graça, possamos ser renovados diariamente pelo teu Espírito Santo, por nosso Senhor Jesus Cristo, que vive e reina contigo e o Espírito Santo, um só Deus, agora e para sempre. Amém."
}

# O 2º Domingo após o Natal - TODO: verificar
collects << {
  celebration: "2nd_sunday_after_christmas",
  text: "Deus Todo-Poderoso, que nos deste teu Filho Unigênito para que tomasse sobre si a nossa natureza e nascesse de uma virgem pura, e nós, que nascemos de novo nEle e somos feitos teus filhos por adoção e graça, possamos ser renovados diariamente pelo teu Espírito Santo, por nosso Senhor Jesus Cristo, que vive e reina contigo e o Espírito Santo, um só Deus, agora e para sempre. Amém."
}

# A Circuncisão do Senhor - TODO: verificar
collects << {
  celebration: "circumcision_of_christ",
  text: "Deus Todo-Poderoso, que fizeste que teu bendito Filho fosse circuncidado e obediente à lei pela humanidade, concede-nos a verdadeira circuncisão do Espírito, para que tendo os nossos corações e corpos mortos para todos os desejos pecaminosos, possamos obedecer a tua santa vontade em todas as coisas por Teu Filho Jesus Cristo nosso Senhor. Amém."
}

# A Epifania
collects << {
  celebration: "epiphany",
  text: "Ó Deus, que revelastes o teu Filho Unigênito aos gentios através da direção de uma estrela, concede-nos misericordiosamente que, ao te conhecermos agora pela fé, possamos, depois desta vida, desfrutar o esplendor da tua gloriosa Divindade, por Jesus Cristo nosso Senhor. Amém."
}

# 1º Domingo Após a Epifania
collects << {
  celebration: "1st_sunday_after_epiphany",
  text: "Senhor misericordioso, ouça as orações do teu povo que te invoca e concede-nos o knowledge das coisas que devemos fazer, bem como a graça e o poder para realizá-las fielmente, por meio de Cristo Jesus nosso Senhor. Amém."
}

# 2º Domingo Após a Epifania - TODO: verificar
collects << {
  celebration: "2nd_sunday_after_epiphany",
  text: "Deus Todo-Poderoso e eterno, que governas todas as coisas no céu e na terra: ouve misericordiosamente as súplicas de teu povo e concede-nos a tua paz todos os dias da nossa vida, por Jesus Cristo nosso Senhor. Amém."
}

# 3º Domingo Após a Epifania
collects << {
  celebration: "3rd_sunday_after_epiphany",
  text: "Deus Todo-Poderoso e Eterno, olha com misericórdia para as nossas fraquezas e estende a tua mão direita para nos ajudar e defender em todos os perigos e necessidades, por Jesus Cristo nosso Senhor. Amém."
}

# 4º Domingo Após a Epifania
collects << {
  celebration: "4th_sunday_after_epiphany",
  text: "Senhor Deus, tu sabes que estamos em meio a tantos perigos e que, devido à fragilidade de nossa natureza, nem sempre conseguimos nos manter firmes. Concede-nos força e proteção para nos sustentarmos em todo perigo e guia-nos através de toda tentação, por Jesus Cristo nosso Senhor. Amém."
}

# 5º Domingo Após a Epifania
collects << {
  celebration: "5th_sunday_after_epiphany",
  text: "Pai Celestial, guarda tua família, a Igreja, Ó Senhor, continuamente em tua verdadeira religião, para que nós, que depositamos nossa esperança somente em tua graça celestial, sejamos sempre defendidos por teu grande poder, por Jesus Cristo, Nosso Senhor. Amém."
}

# 6º Domingo Após a Epifania
collects << {
  celebration: "6th_sunday_after_epiphany",
  text: "Ó Deus, cujo bendito Filho foi manifestado para destruir as obras do diabo e nos fazer filhos de Deus e herdeiros da vida eterna, concede-nos que, nós que temos esta esperança, nos purifiquemos, assim como Ele é puro. Que quando apareceres em poder e grande glória, sejamos feitos semelhantes a Ele em seu eterno e glorioso Reino, onde vives e reinas com o Pai e com o Espírito Santo, um só Deus, agora e para sempre. Amém."
}

# Septuagésima
collects << {
  celebration: "septuagesima",
  text: "Senhor, escuta com favor as orações do teu povo, para que nós, que merecemos ser punidos por nossas ofensas, possamos ser misericordiosamente libertos por tua bondade, para a glória do teu nome. Por Jesus Cristo nosso Salvador, que está vivo e reina contigo e o Espírito Santo, um só Deus, agora e para sempre. Amém."
}

# Sexagésima
collects << {
  celebration: "sexagesima",
  text: "Senhor Deus, tu sabes que não colocamos nossa confiança em nossas próprias obras; com piedade, defende-nos pelo teu poder de toda adversidade, por Jesus Cristo, Nosso Senhor. Amém."
}

# Quinquagesima
collects << {
  celebration: "quinquagesima",
  text: "Senhor, ensinaste-nos que qualquer coisa que fazemos sem caridade não tem valor; envia teu Espírito Santo e derrama em nossos corações o excelentíssimo dom do amor, o verdadeiro vínculo da paz e de todas as virtudes; pois sem caridade, qualquer que vive é considerado morto por ti. Concede-nos isto por amor do teu único Filho, Jesus Cristo, nosso Senhor. Amém."
}

# Quarta-feira de Cinzas
collects << {
  celebration: "ash_wednesday",
  text: "Deus Todo-Poderoso e eterno, que não detestas nada do que criaste e perdoas os pecados de todos os que se arrependem: Cria e faça em nós corações novos e contritos, para que, lamentando dignamente os nossos pecados e reconhecendo nossa miséria, possamos obter de Ti, Deus de toda misericórdia, plena remissão e perdão, por Jesus Cristo nosso Senhor. Amém."
}

# 1º Domingo da Quaresma
collects << {
  celebration: "1st_sunday_in_lent",
  text: "Ó Senhor Jesus Cristo, que por amor a nós jejuaste quarenta dias e quarenta noites, concedei-nos graça para quê: disciplinando a nós mesmos, sempre obedeçamos tua vontade em justiça e em verdadeira santidade para a honra e glória do teu nome; que vives e reinas com o Pai e o Espírito Santo, um só Deus, agora e para sempre. Amém."
}

# 2º Domingo da Quaresma
collects << {
  celebration: "2nd_sunday_in_lent",
  text: "Deus Todo-Poderoso, que vês que não há em nós poder algum para ajudar-nos a nós mesmos: guarda-nos exteriormente nos nossos corpos e interiormente em nossas almas para que sejamos livres de todas as enfermidades que podem sobrevir ao corpo, e de todos os maus pensamentos que podem assaltar e prejudicar a alma, por Jesus Cristo, Nosso Senhor. Amém."
}

# 3º Domingo da Quaresma
collects << {
  celebration: "3rd_sunday_in_lent",
  text: "Imploramos-te, Deus Todo-Poderoso, olha para os sinceros desejos dos teus humildes servos e estende a mão direita da tua Majestade para ser nossa defesa contra todos os nossos inimigos, através de Jesus Cristo, nosso Senhor. Amém."
}

# 4º Domingo da Quaresma
collects << {
  celebration: "4th_sunday_in_lent",
  text: "Concede-nos, Deus Todo-Poderoso, que nós, que merecemos ser castigados por nossas más obras, possamos pela tua graça e misericórdia ser preservados por Jesus Cristo, Nosso Senhor. Amém."
}

# 5º Domingo da Quaresma
collects << {
  celebration: "5th_sunday_in_lent",
  text: "Imploramos-te, Deus Todo-Poderoso, que olhes misericordiosamente para o teu povo, para que, pela tua grande bondade, eles sejam governados e preservados sempre, tanto no corpo quanto na alma, através de Jesus Cristo nosso Senhor. Amém."
}

# O Domingo antes da Páscoa (Ramos)
collects << {
  celebration: "palm_sunday",
  text: "Deus Todo-Poderoso e eterno, que, por teu terno amor à humanidade, enviaste teu Filho, nosso Salvador Jesus Cristo, para assumir nossa carne e sofrer a morte na cruz, para que toda a humanidade possa seguir o exemplo de sua grande humildade: Concede misericordiosamente que possamos seguir o exemplo de sua paciência e também participar de sua ressurreição, por meio de Cristo Jesus nosso Senhor. Amém."
}

# Segunda-feira antes da Páscoa
collects << {
  celebration: "monday_in_holy_week",
  text: "Deus Todo-Poderoso e eterno, que, por teu terno amor à humanidade, enviaste teu Filho, nosso Salvador Jesus Cristo, para assumir nossa carne e sofrer a morte na cruz, para que toda a humanidade possa seguir o exemplo de sua grande humildade: Concede misericordiosamente que possamos seguir o exemplo de sua paciência e também participar de sua ressurreição, por meio de Cristo Jesus nosso Senhor. Amém."
}

# Terça-feira antes da Páscoa
collects << {
  celebration: "tuesday_in_holy_week",
  text: "Deus Todo-Poderoso e eterno, que, por teu terno amor à humanidade, enviaste teu Filho, nosso Salvador Jesus Cristo, para assumir nossa carne e sofrer a morte na cruz, para que toda a humanidade possa seguir o exemplo de sua grande humildade: Concede misericordiosamente que possamos seguir o exemplo de sua paciência e também participar de sua ressurreição, por meio do mesmo Jesus Cristo nosso Senhor. Amém."
}

# Quarta-feira antes da Páscoa
collects << {
  celebration: "wednesday_in_holy_week",
  text: "Deus Todo-Poderoso e eterno, que, por teu terno amor à humanidade, enviaste teu Filho, nosso Salvador Jesus Cristo, para assumir nossa carne e sofrer a morte na cruz, para que toda a humanidade possa seguir o exemplo de sua grande humildade: Concede misericordiosamente que possamos seguir o exemplo de sua paciência e também participar de sua ressurreição, por meio de Cristo Jesus nosso Senhor. Amém."
}

# Quinta-feira antes da Páscoa (Endoenças)
collects << {
  celebration: "maundy_thursday",
  text: "Deus Todo-Poderoso e eterno, que, por teu terno amor à humanidade, enviaste teu Filho, nosso Salvador Jesus Cristo, para assumir nossa carne e sofrer a morte na cruz, para que toda a humanidade possa seguir o exemplo de sua grande humildade: Concede misericordiosamente que possamos seguir o exemplo de sua paciência e também participar de sua ressurreição, por meio de Cristo Jesus nosso Senhor. Amém."
}

# Sexta-feira Santa
# Note: 1662 has 3 collects for Good Friday
collects << {
  celebration: "good_friday",
  text: "Deus Todo-Poderoso, rogamos que olhes com bondade para esta tua família, pela qual nosso Senhor Jesus Cristo consentiu em ser traído e entregue nas mãos de homens maus, e sofrer a morte na cruz, e que agora vive e reina contigo e com o Espírito Santo, um só Deus, pelos séculos dos séculos. Amém."
}
collects << {
  celebration: "good_friday",
  text: "Deus Todo-Poderoso e eterno, pelo teu Espírito, governas e santificas todo o corpo da igreja: aceita nossas súplicas e orações, que oferecemos diante de ti por todas as pessoas em tua santa igreja, para que cada membro dela, em sua vocação e ministério, possa servir-te verdadeira e piedosamente, por nosso Senhor e Salvador Jesus Cristo. Amém."
}
collects << {
  celebration: "good_friday",
  text: "Ó Deus Misericordioso, que fizeste todos os homens e não detestas nada do que fizeste, e não desejas a morte do pecador, mas sim; que ele se converta e viva: Tem misericórdia de todos os judeus, muçulmanos, descrentes e hereges, e tira deles toda ignorância, dureza de coração e desprezo pela tua palavra; e assim traze-os de volta, Senhor abençoado, ao teu rebanho, para que sejam salvos entre os remanescentes dos verdadeiros israelitas, e sejam feitos um só rebanho sob um único pastor, Jesus Cristo nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, pelos séculos sem fim. Amém."
}

# Vigília Pascal (Sábado Santo)
collects << {
  celebration: "holy_saturday",
  text: "Concede, ó Senhor, que assim como fomos batizados na morte do teu abençoado Filho, nosso Salvador Jesus Cristo, assim também o Senhor possa conceder que continuamente mortifiquemos nossos afetos corrompidos, e possamos ser sepultados com eles, e por meio do túmulo e da porta da morte, possamos passar para a nossa alegre ressurreição, pelos méritos de quem morreu, foi sepultado e ressuscitou por nós, teu amado Filho Jesus Cristo nosso Senhor. Amém."
}

# Dia da Páscoa
collects << {
  celebration: "easter_day",
  text: "Deus Todo-Poderoso, que por meio do teu único Filho Jesus Cristo venceste a morte e nos abristes a porta da vida eterna: humildemente te rogamos que, assim como pela tua graça especial nos inspiras bons desejos, também, com a tua ajuda contínua, possamos colocá-los em prática, por Jesus Cristo nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, pelos séculos dos séculos. Amém."
}

# Segunda-feira da Semana da Páscoa
collects << {
  celebration: "monday_in_easter_week",
  text: "Deus Todo-Poderoso, que por meio do teu único Filho Jesus Cristo venceste a morte e nos abristes a porta da vida eterna: humildemente te rogamos que, assim como pela tua graça especial nos inspiras bons desejos, também, com a tua ajuda contínua, possamos colocá-los em prática, por Jesus Cristo nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, pelos séculos dos séculos. Amém."
}

# Terça-feira da Semana da Páscoa
collects << {
  celebration: "tuesday_in_easter_week",
  text: "Deus Todo-Poderoso, que por meio do teu único Filho Jesus Cristo venceste a morte e nos abristes a porta da vida eterna: humildemente te rogamos que, assim como pela tua graça especial nos inspiras bons desejos, também, com a tua ajuda contínua, possamos colocá-los em prática, por Jesus Cristo nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, pelos séculos dos séculos. Amém."
}

# 1º Domingo após a Páscoa
collects << {
  celebration: "1st_sunday_after_easter",
  text: "Pai Todo-Poderoso, que deste teu único Filho para morrer por nossos pecados e ressuscitar para nossa justificação: Concede-nos que possamos afastar o fermento da malícia e da maldade, para que possamos sempre te servir com pureza de vida e verdade, pelos méritos do teu Filho, Jesus Cristo nosso Senhor. Amém."
}

# 2º Domingo após a Páscoa
collects << {
  celebration: "2nd_sunday_after_easter",
  text: "Deus Todo-Poderoso, que destes o Teu único Filho para ser tanto um sacrifício pelos pecados quanto um exemplo de vida piedosa para nós: Concede-nos graça para que possamos sempre receber com agradecimento o Seu inestimável benefício, e também nos esforcemos diariamente para seguir os abençoados passos de Sua vida santíssima, por meio de Cristo Jesus, nosso Senhor. Amém."
}

# 3º Domingo após a Páscoa
collects << {
  celebration: "3rd_sunday_after_easter",
  text: "Deus Todo-Poderoso, que mostras a luz da tua verdade a aqueles que andam no erro para que possam voltar ao caminho da justiça: concede a todos os que são admitidos na fraternidade da religião de Cristo que rejeitem todas as coisas que são contrárias a sua profissão e sigam qualquer coisa que esteja de acordo com ela, por Jesus Cristo, Nosso Senhor. Amém."
}

# 4º Domingo após a Páscoa
collects << {
  celebration: "4th_sunday_after_easter",
  text: "Deus Todo-Poderoso, só tu podes controlar as vontades insubmissas e as paixões dos pecadores: concede que o teu povo ame os teus mandamentos e deseje as tuas promessas para que em meio das muitas e diversas mudanças deste mundo, nossos corações estejam firmes onde os verdadeiros deleites são encontrados, por Jesus Cristo, Nosso Senhor. Amém."
}

# 5º Domingo após a Páscoa
collects << {
  celebration: "5th_sunday_after_easter",
  text: "Ó Senhor, de quem provêm todas as coisas boas: Concedenos, teus humildes servos, que, pela tua santa inspiração, possamos pensar nas coisas que são boas e, pelo teu piedoso direcionamento, possamos realizá-las, através de nosso Senhor Jesus Cristo. Amém."
}

# Dia da Ascensão
collects << {
  celebration: "ascension_day",
  text: "Concede-nos, nós te rogamos, Deus Todo-Poderoso, que assim como cremos que teu Filho unigênito, nosso Senhor Jesus Cristo, ascendeu aos céus, também possamos em nosso coração e mente ascender até lá e habitar continuamente com ele, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e para sempre. Amém."
}

# O Domingo depois da Ascensão
collects << {
  celebration: "sunday_after_ascension",
  text: "Ó Deus, Rei da glória, que exaltaste teu único Filho Jesus Cristo com grande triunfo ao teu reino nos céus: Rogamos-te, não nos deixes desamparados, mas envia-nos teu Espírito Santo para nos consolar e exaltar-nos até o mesmo lugar para onde nosso Salvador Cristo foi antes, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e para sempre. Amém."
}

# Domingo de Pentecostes
collects << {
  celebration: "pentecost_sunday",
  text: "Deus, que neste momento ensinaste os corações de teus fiéis, enviando-lhes a luz do teu Espírito Santo: Concede-nos, pelo mesmo Espírito, ter um juízo correto em todas as coisas e sempre nos alegrarmos com o seu santo conforto, pelos méritos de Cristo Jesus, nosso Salvador, que vive e reina contigo, na unidade do Espírito Santo, um só Deus, agora e para sempre. Amém."
}

# Segunda-feira da Semana de Pentecostes
collects << {
  celebration: "monday_in_whitsun_week",
  text: "Deus, que neste momento ensinaste os corações de teus fiéis, enviando-lhes a luz do teu Espírito Santo: Concede-nos, pelo mesmo Espírito, ter um juízo correto em todas as coisas e sempre nos alegrarmos com o seu santo conforto, pelos méritos de Cristo Jesus, nosso Salvador, que vive e reina contigo, na unidade do Espírito Santo, um só Deus, agora e para sempre. Amém."
}

# Terça-feira da Semana de Pentecostes
collects << {
  celebration: "tuesday_in_whitsun_week",
  text: "Deus, que neste momento ensinaste os corações de teus fiéis, enviando-lhes a luz do teu Espírito Santo: Concede-nos, pelo mesmo Espírito, ter um juízo correto em todas as coisas e sempre nos alegrarmos com o seu santo conforto, pelos méritos de Cristo Jesus, nosso Salvador, que vive e reina contigo, na unidade do Espírito Santo, um só Deus, agora e para sempre. Amém."
}

# Domingo da Trindade
collects << {
  celebration: "trinity_sunday",
  text: "Deus Todo-Poderoso e eterno, que concedestes a teus servos, pela confissão de uma fé verdadeira, reconhecer a glória da Trindade eterna e, na força da Majestade Divina, adorar a Unidade: Rogamos-te que nos mantenhas firmes nesta fé e nos defendas de todas as adversidades, que vives e reinas, um só Deus, por séculos sem fim. Amém."
}

# 1º Domingo depois da Trindade
collects << {
  celebration: "1st_sunday_after_trinity",
  text: "Ó Deus, a força de todos aqueles que confiam em ti: Aceita misericordiosamente as nossas orações, porque através da fraqueza da nossa natureza mortal não podemos fazer coisa alguma boa sem ti, concede-nos a ajuda da tua graça, para que, ao obedecer aos teus mandamentos, possamos agradar-te tanto em vontade como em ação, por Jesus Cristo nosso Senhor. Amém."
}

# 2º Domingo depois da Trindade
collects << {
  celebration: "2nd_sunday_after_trinity",
  text: "Ó Senhor, que nunca deixas de ajudar e governar aqueles a quem crias no teu firme temor e amor: Mantenha-nos, nós te rogamos, sob a proteção de tua boa providência, e faznos ter um temor e amor perpétuos pelo teu santo nome, por Jesus Cristo nosso Senhor. Amém."
}

# 3º Domingo depois da Trindade
collects << {
  celebration: "3rd_sunday_after_trinity",
  text: "Ó Senhor, te suplicamos que nos ouças misericordiosamente e concedas que nós, a quem destes um desejo sincero de orar, possamos ser defendidos e consolados em todos os perigos e adversidades pelo teu poderoso auxílio, por Jesus Cristo nosso Senhor. Amém."
}

# 4º Domingo depois da Trindade
collects << {
  celebration: "4th_sunday_after_trinity",
  text: "Ó Deus, protetor de todos que confiam em ti, pois, sem ti nada é forte, nada é santo: Aumenta e multiplica sobre nós a tua misericórdia, para que, sendo tu o nosso governante e guia, possamos passar de tal maneira pelas coisas temporais e enfim, não percamos as coisas eternas. Concede isso, ó Pai celestial, por amor de Jesus Cristo, nosso Senhor. Amém."
}

# 5º Domingo depois da Trindade
collects << {
  celebration: "5th_sunday_after_trinity",
  text: "Concede, ó Senhor, nós te suplicamos, que o curso deste mundo possa ser tão pacificamente ordenado pela tua governança, que a tua igreja possa te servir alegremente em toda a piedosa tranquilidade, por Jesus Cristo, nosso Senhor. Amém."
}

# 6º Domingo depois da Trindade
collects << {
  celebration: "6th_sunday_after_trinity",
  text: "Ó Deus, que preparaste para aqueles que te amam coisas tão boas que superam a compreensão humana: Derrama em nossos corações um amor tão profundo por ti, para que, amando-te acima de todas as coisas, possamos obter as tuas promessas, que excedem tudo o que podemos desejar e imaginar, por Jesus Cristo, nosso Senhor. Amém."
}

# 7º Domingo depois da Trindade
collects << {
  celebration: "7th_sunday_after_trinity",
  text: "Senhor de todo o poder e força, que és o autor e doador de todas as coisas boas: Implanta em nossos corações o amor pelo teu nome, aumenta em nós a verdadeira religião, nos alimenta com toda a bondade e, pela tua grande misericórdia, mantenha-nos nela, por Jesus Cristo, nosso Senhor. Amém."
}

# 8º Domingo depois da Trindade
collects << {
  celebration: "8th_sunday_after_trinity",
  text: "Ó Deus, cuja providência infalível ordena todas as coisas tanto no céu como na terra: humildemente te suplicamos que afastes de nós tudo o que é prejudicial e nos concedas aquilo que é proveitoso para nós, por Jesus Cristo, nosso Senhor. Amém."
}

# 9º Domingo depois da Trindade
collects << {
  celebration: "9th_sunday_after_trinity",
  text: "Concede-nos, Senhor, nós te rogamos, o espírito de pensar e fazer sempre aquilo que é justo, para que nós, que não podemos fazer nada de bom sem ti, sejamos capacitados por ti a viver de acordo com a tua vontade, por Jesus Cristo, nosso Senhor. Amém."
}

# 10º Domingo depois da Trindade
collects << {
  celebration: "10th_sunday_after_trinity",
  text: "Que os teus ouvidos misericordiosos, ó Senhor, estejam abertos às orações dos teus humildes servos, para que possam obter as suas petições, faz com que eles peçam coisas que sejam do teu agrado, mediante Jesus Cristo, nosso Senhor. Amém."
}

# 11º Domingo depois da Trindade
collects << {
  celebration: "11th_sunday_after_trinity",
  text: "Ó Deus, que revela o teu poder supremo principalmente ao mostrar misericórdia e compaixão: Concede-nos misericordiosamente a medida da tua graça, para que, seguindo o caminho dos teus mandamentos, possamos obter as tuas promessas graciosas e nos tornar participantes do teu tesouro celestial, por Jesus Cristo, nosso Senhor. Amém."
}

# 12º Domingo depois da Trindade
collects << {
  celebration: "12th_sunday_after_trinity",
  text: "Deus Todo-Poderoso e eterno, que estás sempre pronto para ouvir do que nós estamos para orar, e tens o costume de conceder mais do que desejamos ou merecemos: Derrama sobre nós a abundância da tua misericórdia, perdoando-nos aquelas coisas das quais nossa consciência teme, e concedendo-nos aqueles bens que não somos dignos de pedir, através dos méritos e mediação de Jesus Cristo, teu Filho, nosso Senhor. Amém."
}

# 13º Domingo depois da Trindade
collects << {
  celebration: "13th_sunday_after_trinity",
  text: "Deus Todo-Poderoso e misericordioso, cujo dom único faz com que o teu povo fiel preste a ti um serviço verdadeiro e louvável: Conceda-nos, rogamos-te, que possamos te servir tão fielmente nesta vida, que não falhemos em alcançar finalmente tuas promessas celestiais, através dos méritos de Jesus Cristo, nosso Senhor. Amém."
}

# 14º Domingo depois da Trindade
collects << {
  celebration: "14th_sunday_after_trinity",
  text: "Deus Todo-Poderoso e eterno, concede-nos o aumento da fé, esperança e caridade; para que possamos obter o que tu prometes, fazendo-nos amar o que tu ordenas, por Jesus Cristo, nosso Senhor. Amém."
}

# 15º Domingo depois da Trindade
collects << {
  celebration: "15th_sunday_after_trinity",
  text: "Guarda, nós te rogamos, ó Senhor, a tua igreja com a tua misericórdia perpétua, porque na nossa fragilidade não permanecemos de pé sem ti, mantenha-nos sempre pelo teu auxílio longe de todas as coisas prejudiciais e conduze-nos a todas as coisas proveitosas para a nossa salvação, por Jesus Cristo, nosso Senhor. Amém."
}

# 16º Domingo depois da Trindade
collects << {
  celebration: "16th_sunday_after_trinity",
  text: "Ó Senhor, nós te imploramos, que a tua piedade contínua purifique e defenda a tua igreja e, visto que ela não pode continuar em segurança sem o teu auxílio, preserva-a sempre pela tua ajuda e bondade, por Jesus Cristo, nosso Senhor. Amém."
}

# 17º Domingo depois da Trindade
collects << {
  celebration: "17th_sunday_after_trinity",
  text: "Senhor, nós te rogamos que a tua graça possa sempre nos anteceder e nos guiar, e que nos torne continuamente dedicados a todas as boas obras, por Jesus Cristo, nosso Senhor. Amém."
}

# 18º Domingo depois da Trindade
collects << {
  celebration: "18th_sunday_after_trinity",
  text: "Senhor, nós te rogamos, concede à teu povo a graça de resistir às tentações do mundo, da carne e do diabo, e com corações e mentes puras seguir somente a ti, o único Deus, por Jesus Cristo, nosso Senhor. Amém."
}

# 19º Domingo depois da Trindade
collects << {
  celebration: "19th_sunday_after_trinity",
  text: "Ó Deus, visto que sem ti não somos capazes de te agradar, concede misericordiosamente que teu Espírito Santo possa dirigir e governar nossos corações em todas as coisas, por Jesus Cristo, nosso Senhor. Amém."
}

# 20º Domingo depois da Trindade
collects << {
  celebration: "20th_sunday_after_trinity",
  text: "Ó Deus onipotente e misericordioso, pela tua generosa bondade, pedimos que nos protejas de todas as coisas que possam nos prejudicar, para que, estando prontos tanto no corpo quanto na alma, possamos realizar alegremente aquilo que desejas que façamos, por Jesus Cristo, nosso Senhor. Amém."
}

# 21º Domingo depois da Trindade
collects << {
  celebration: "21st_sunday_after_trinity",
  text: "Concede, te rogamos, misericordioso Senhor, ao teu povo fiel perdão e paz, para que sejam purificados de todos os seus pecados e te sirvam com uma mente tranquila, por Jesus Cristo, nosso Senhor. Amém."
}

# 22º Domingo depois da Trindade
collects << {
  celebration: "22nd_sunday_after_trinity",
  text: "Senhor, te rogamos que mantenhas tua casa, a igreja, em contínua piedade, para que, através de tua proteção, ela possa estar livre de todas as adversidades e dedicada a te servir em boas obras, para a glória do teu nome, por Jesus Cristo, nosso Senhor. Amém."
}

# 23º Domingo depois da Trindade
collects << {
  celebration: "23rd_sunday_after_trinity",
  text: "Ó Deus, nossa força e refugio, que és o autor de toda a piedade: Estejas pronto, nós te rogamos, para ouvir as orações devotas da tua igreja, e concede que aquelas coisas que pedimos com fé, possamos obtê-las eficazmente, por Jesus Cristo, nosso Senhor. Amém."
}

# 24º Domingo depois da Trindade
collects << {
  celebration: "24th_sunday_after_trinity",
  text: "Ó Senhor, nós te suplicamos, absolve o teu povo das suas ofensas, para que através da tua bondosa generosidade todos possamos ser libertados das amarras do pecado que pela nossa fragilidade cometemos. Concede isso, ó Pai celestial, por amor de Jesus Cristo, nosso abençoado Senhor e Salvador. Amém."
}

# 25º Domingo depois da Trindade
collects << {
  celebration: "25th_sunday_after_trinity",
  text: "Revive, nós te suplicamos, ó Senhor, a vontade do teu povo fiel, para que eles, abundantemente produzindo fruto das boas obras, possam ser abundantemente recompensados por ti, por Jesus Cristo, nosso Senhor. Amém."
}

# Santo André
collects << {
  celebration: "saint_andrew",
  text: "Deus Todo-Poderoso, que concedeste tamanha graça ao teu apóstolo Santo André, que prontamente obedeceu ao chamado do teu Filho Jesus Cristo e o seguiu sem demora: Concede-nos a todos que, sendo chamados pela tua santa palavra, possamos imediatamente nos entregar obedientemente para cumprir os teus santos mandamentos, por Jesus Cristo nosso Senhor. Amém."
}

# São Tomé
collects << {
  celebration: "saint_thomas_apostle",
  text: "Deus Todo-Poderoso e eterno, que para uma confirmação maior da fé permitiste que teu apóstolo São Tomé duvidasse da ressurreição de teu Filho: Concede-nos crer tão perfeitamente e sem qualquer dúvida em teu Filho Jesus Cristo, que nossa fé em tua presença nunca seja reprovada. Ouve-nos, Senhor, através de Jesus Cristo, a quem, contigo e com o Espírito Santo, seja toda honra e glória, agora e para sempre. Amém."
}

# Conversão de São Paulo
collects << {
  celebration: "conversion_of_saint_paulo",
  text: "Ó Deus, que, através da pregação do abençoado apóstolo São Paulo, fizeste brilhar a luz do evangelho por todo o mundo: Concedei-nos, nós te imploramos, que, tendo a maravilhosa conversão dele em memória, possamos expressar nossa gratidão a ti, pelo seu abençoado exemplo, seguindo a doutrina santa que ele ensinou, por Jesus Cristo nosso Senhor. Amém."
}

# Purificação de Maria
collects << {
  celebration: "purification_of_mary",
  text: "Deus Todo-Poderoso e sempiterno, humildemente te imploramos a Tua Majestade, para que assim como Teu Filho Unigênito foi apresentado neste dia no templo na substância da nossa carne, possamos ser apresentados a Ti com corações puros e limpos, por Teu Filho Jesus Cristo, nosso Senhor. Amém."
}

# São Matias
collects << {
  celebration: "saint_matthias",
  text: "Ó Deus Todo-Poderoso, que no lugar do traidor Judas Iscariotes escolheste teu fiel servo São Matias para ser um dos doze apóstolos: Concede que a tua igreja, sempre preservada de falsos apóstolos, possa ser ordenada e guiada por pastores fiéis e verdadeiros, por Jesus Cristo nosso Senhor. Amém."
}

# Anunciação de Maria
collects << {
  celebration: "annunciation_of_mary",
  text: "Nós te imploramos, ó Senhor, derrama tua graça em nossos corações, para que assim como conhecemos a encarnação de teu Filho Jesus Cristo através da mensagem de um anjo, possamos, por sua cruz e paixão, ser conduzidos à glória de sua ressurreição, por Jesus Cristo nosso Senhor. Amém."
}

# São Marcos
collects << {
  celebration: "saint_mark",
  text: "Ó Deus Todo-Poderoso, que instruíste tua santa igreja com a doutrina celestial do teu evangelista São Marcos: Concede-nos graça, para que, não sendo como crianças levadas por qualquer vento de doutrina vã, possamos ser firmados na verdade do teu santo evangelho, por Jesus Cristo nosso Senhor. Amém."
}

# São Filipe e São Tiago
collects << {
  celebration: "saints_philip_and_james",
  text: "Ó Deus Todo-Poderoso, a quem verdadeiramente conhecer é própria vida eterna: Concede-nos conhecer perfeitamente o teu Filho Jesus Cristo como caminho, a verdade e a vida, para que, seguindo os passos dos teus apóstolos, São Filipe e São Tiago, possamos andar firmemente no caminho que conduz à vida eterna, através do teu Filho Jesus Cristo nosso Senhor. Amém."
}

# São Barnabé
collects << {
  celebration: "saint_barnabas",
  text: "Ó Deus Senhor Todo-Poderoso, que dotaste o teu santo apóstolo Barnabé com dons singulares do Espírito Santo: Não nos deixes, te suplicamos, desprovidos dos teus diversos dons, nem tampouco da graça de sempre usá-los para a tua honra e glória, por Jesus Cristo nosso Senhor. Amém."
}

# São João Batista
collects << {
  celebration: "nativity_of_john_baptist",
  text: "Deus Todo-Poderoso, cuja providência o teu servo João Batista nasceu de maneira maravilhosa e foi enviado para preparar o caminho do teu Filho, nosso Salvador, pregando o arrependimento: Faz-nos seguir tão bem a sua doutrina e vida santa, que possamos verdadeiramente nos arrepender de acordo com a sua pregação; e, seguindo o seu exemplo, falar a verdade constantemente, repreender corajosamente o vício e sofrer pacientemente pela causa da verdade, por Jesus Cristo nosso Senhor. Amém"
}

# São Pedro
collects << {
  celebration: "saint_pedro",
  text: "Ó Deus Todo-Poderoso, que pelo teu Filho Jesus Cristo deste ao teu apóstolo São Pedro muitos dons excelentes e lhe ordenaste que alimentasse com zelo teu rebanho: Faz, nós te imploramos, com que todos os bispos e pastores preguem diligentemente a tua santa palavra, e que o povo ouça obedientemente a mesma, para que possam receber a coroa da glória eterna, por Jesus Cristo nosso Senhor. Amém."
}

# São Tiago
collects << {
  celebration: "saint_james",
  text: "CONCEDE, ó Deus misericordioso, que assim como o teu apóstolo São Tiago, deixando seu pai e tudo o que tinha, sem demora foi obediente ao chamado do teu Filho Jesus Cristo e o seguiu, assim também nós, abandonando todas as afeições mundanas e carnais, estejamos sempre prontos a seguir os teus santos mandamentos, por Jesus Cristo nosso Senhor. Amém."
}

# São Bartolomeu
collects << {
  celebration: "saint_bartholomew",
  text: "Ó DEUS Todo-Poderoso e eterno, que deste ao teu apóstolo São Bartolomeu a graça de crer verdadeiramente e pregar a tua palavra: Concede, te rogamos, à tua igreja, amar aquela palavra que ele creu, e tanto pregou quanto receber a mesma, por Jesus Cristo nosso Senhor. Amém."
}

# São Mateus
collects << {
  celebration: "saint_matthew",
  text: "Ó DEUS Todo-Poderoso, que pelo teu bendito Filho chamaste São Mateus de coletor de impostos para ser apóstolo e evangelista: Concede-nos graça para abandonar todos os desejos cobiçosos e amor desordenado pelas riquezas, e seguir ao teu Filho Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, pelos séculos dos séculos. Amém."
}

# São Miguel e Todos os Anjos
collects << {
  celebration: "saint_michael_and_all_angels",
  text: "Ó DEUS eterno, que ordenaste e constituíste os serviços dos anjos e dos homens em uma ordem maravilhosa: Concede-nos misericordiosamente que, assim como teus santos anjos sempre te servem no céu, assim por teu comando eles possam nos socorrer e defender na terra, por Jesus Cristo nosso Senhor. Amém."
}

# São Lucas
collects << {
  celebration: "saint_luke",
  text: "Deus Onipotente, que chamaste São Lucas, o médico, cujo louvor está no evangelho, para ser evangelista e médico da alma: Manifesta em tua igreja esse mesmo amor pelas saudáveis medicinas da doutrina por ele transmitida, para que todas as doenças de nossas almas possam ser curadas, pelos méritos de teu Filho Jesus Cristo nosso Senhor. Amém"
}

# São Simão e São Judas
collects << {
  celebration: "saints_simon_and_jude",
  text: "Deus Todo-Poderoso, que edificaste a tua igreja sobre o fundamento dos apóstolos e profetas, sendo Jesus Cristo ele mesmo a pedra angular principal: Concede-nos que sejamos unidos em espírito por meio da sua doutrina, de modo que possamos ser feitos um templo santo, aceitável a ti, por Jesus Cristo nosso Senhor. Amém."
}

# Todos os Santos
collects << {
  celebration: "all_saints",
  text: "Deus Todo-Poderoso, que reuniste os teus eleitos em uma comunhão e irmandade, no corpo místico de teu Filho Cristo nosso Senhor: Concede-nos graça para seguirmos os teus abençoados santos em uma vida virtuosa e piedosa, para que possamos alcançar as alegrias indescritíveis que preparaste para aqueles que te amam sinceramente, por Jesus Cristo nosso Senhor. Amém."
}

collects.each do |c|
  celebration = Celebration.find_by(name: c[:celebration], prayer_book_id: prayer_book.id)

  Collect.find_or_create_by!(
    prayer_book_id: prayer_book.id,
    celebration_id: celebration&.id,
    sunday_reference: celebration ? nil : c[:celebration]
  ) do |col|
    col.text = c[:text]
  end
end

Rails.logger.info "✅ Coletas carregadas!"
