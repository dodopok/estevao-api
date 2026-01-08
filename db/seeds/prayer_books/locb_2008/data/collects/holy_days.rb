# ================================================================================
# COLETAS DOS DIAS SANTOS E FESTAS MAIORES - LOCB 2008
# ================================================================================

Rails.logger.info "🙏 Criando Coletas dos Dias Santos e Festas Maiores - LOCB 2008..."

prayer_book = PrayerBook.find_by_code('locb_2008')

holy_days_collects = [
  # ================================================================================
  # JANEIRO
  # ================================================================================
  {
    sunday_reference: "holy_name",
    text: "Pai misericordioso, ensinaste-nos não haver salvação noutro nome que não seja o de Jesus; ensina-nos a glorificar o seu nome e a tornar conhecida a sua salvação em todo o mundo. Mediante Jesus Cristo, nosso Senhor. Amém." },
  {
    sunday_reference: "conversion_of_paul",
    text: "Ó Deus, instruíste o mundo inteiro com a palavra do Apóstolo Paulo de quem celebramos hoje a conversão; concede-nos a graça de, imitando-o, caminharmos para ti e sermos no mundo testemunhas do teu Evangelho. Por nosso Senhor Jesus Cristo, teu Filho, na unidade do Espírito Santo. Amém." },

  # ================================================================================
  # FEVEREIRO
  # ================================================================================
  {
    sunday_reference: "presentation",
    text: "Pai onipotente, teu Filho Jesus Cristo foi apresentado no templo, sendo proclamado a glória de Israel e a luz das nações; concede-nos que por Ele sejamos apresentados a ti e possamos refletir a tua glória no mundo. Mediante Jesus Cristo, nosso Senhor. Amém." },

  # ================================================================================
  # MARÇO
  # ================================================================================
  {
    sunday_reference: "john_charles_wesley",
    text: "Recebe, Senhor, nós te rogamos, as preces da tua Igreja, hoje quando nos lembramos de teu servo N. e de sua luta em favor do cristianismo reformado. Concede a nós a coragem deste irmão do passado para que lutemos com fé e coragem pela fé uma vez dada aos santos. Mediante Jesus Cristo, nosso Salvador. Amém." },
  {
    sunday_reference: "joseph",
    text: "Deus onipotente, chamaste José a ser o esposo da Virgem Maria, e o guardião do teu único Filho; abre os nossos olhos e os nossos ouvidos às mensagens da tua santa vontade, e dá-nos a coragem de agir de acordo com ela. Mediante Jesus Cristo, nosso Senhor. Amém." },
  {
    sunday_reference: "thomas_cranmer",
    text: "Recebe, Senhor, nós te rogamos, as preces da tua Igreja, hoje quando nos lembramos de teu servo N. e de sua luta em favor do cristianismo reformado. Concede a nós a coragem deste irmão do passado para que lutemos com fé e coragem pela fé uma vez dada aos santos. Mediante Jesus Cristo, nosso Salvador. Amém." },
  {
    sunday_reference: "annunciation",
    text: "Suplicamos-te, Senhor, que derrames a tua graça nos nossos corações, para que assim como conhecemos a encarnação de teu Filho Jesus Cristo, também pela sua cruz e paixão alcancemos a glória da sua ressurreição. Mediante o mesmo Jesus Cristo, nosso Senhor. Amém." },

  # ================================================================================
  # ABRIL
  # ================================================================================
  {
    sunday_reference: "mark",
    text: "Deus onipotente, iluminaste a tua Igreja através do testemunho inspirado do teu evangelista Marcos; fundamenta-nos firmemente na verdade do Evangelho, e faz-nos fiéis ao seu ensino. Mediante Jesus Cristo, nosso Senhor. Amém." },

  # ================================================================================
  # MAIO
  # ================================================================================
  {
    sunday_reference: "labor_day",
    text: "Onipotente Deus, que tens unido de tal maneira as nossas vidas à vida de outras pessoas, que tudo o que fazemos influi, bem ou mal, na vida dos outros; guia-nos no trabalho que realizamos, para que o façamos não somente para nós, mas para o bem comum; e, à medida que procuramos o retorno do nosso próprio labor, faze-nos lembrados das aspirações justas de outros trabalhadores, e desperta a nossa preocupação pelos desempregados. Por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo. Amém." },
  {
    sunday_reference: "philip_and_james",
    text: "Pai eterno, os apóstolos Filipe e Tiago conheceram no teu Filho o caminho vivo e verdadeiro; concede-nos a graça de os seguirmos ao longo desse caminho que conduz à vida eterna. Mediante Jesus Cristo, nosso Senhor. Amém." },
  {
    sunday_reference: "matthias",
    text: "Senhor Deus, o teu servo Matias foi escolhido em substituição de Judas Iscariotes, para ser um dos apóstolos; preserva a tua Igreja de falsos apóstolos, e, pelo ministério de pastores e mestres fiéis, guarda-nos firmes na tua verdade. Mediante Jesus Cristo, nosso Senhor. Amém." },
  {
    sunday_reference: "visitation",
    text: "Pai misericordioso, inspiraste a bem-aventurada Virgem Maria a visitar Isabel, que com alegria a saudou como mãe do Senhor; enche-nos da tua graça para que aclamemos o seu Filho como nosso Senhor, o qual vive e reina, contigo e com o Espírito Santo, um só Deus para todo o sempre. Amém." },

  # ================================================================================
  # JUNHO
  # ================================================================================
  {
    sunday_reference: "barnabas",
    text: "Senhor Deus, teu Filho Jesus Cristo ensinou-nos ser coisa mais abençoada dar que receber; ajuda-nos, com o exemplo do teu apóstolo Barnabé, a ser magnânimos a julgar e generosos a servir. Mediante Jesus Cristo, nosso Senhor. Amém." },
  {
    sunday_reference: "nativity_of_john_the_baptist",
    text: "Senhor Deus, o teu servo João Batista nasceu maravilhosamente e preparou o caminho para o advento de teu Filho; ajuda-nos a conhecer Jesus Cristo como nosso Salvador e a obter por meio d'Ele o perdão dos nossos pecados. Ele que vive e reina, contigo e com o Espírito Santo, um só Deus, para todo o sempre. Amém." },
  {
    sunday_reference: "peter_and_paul",
    text: "Deus onipotente, os teus apóstolos Pedro e Paulo glorificaram-te tanto na vida como na morte; inspira a tua Igreja a seguir os seus exemplos e a permanecer firme no único fundamento que é Cristo, nosso Senhor, a quem, contigo e com o Espírito Santo, seja dada honra e glória, agora e para sempre. Amém." },

  # ================================================================================
  # JULHO
  # ================================================================================
  {
    sunday_reference: "thomas",
    text: "Deus eterno, o teu apóstolo Tomé duvidou da ressurreição do teu Filho até que a palavra e a vista o convenceram; concede-nos, a nós que não vimos, a graça de não sermos infiéis, mas crentes. Mediante Jesus Cristo, nosso Senhor. Amém." },
  {
    sunday_reference: "mary_magdalene",
    text: "Senhor misericordioso, teu Filho restituiu a Maria Madalena a saúde do corpo e da mente e chamou-a a ser testemunha da sua ressurreição; purifica-nos e renova-nos para te servirmos no poder da vida ressuscitada de Jesus, o qual, contigo e com o Espírito Santo, vive e reina, um só Deus, agora e sempre. Amém." },
  {
    sunday_reference: "james_the_apostle",
    text: "Senhor Deus, o teu apóstolo Tiago consentiu em deixar seu pai e tudo o que possuía e ainda em sofrer pelo nome do teu Filho; ajuda-nos misericordioso para que nenhum dos laços terrenos nos afastem do teu serviço. Mediante Jesus Cristo, nosso Senhor. Amém." },

  # ================================================================================
  # AGOSTO
  # ================================================================================
  {
    sunday_reference: "transfiguration",
    text: "Deus onipotente, teu Filho revelou-se em glória antes de sofrer na Cruz; concede-nos que pela fé na sua morte e ressurreição triunfemos no poder da sua vitória. Mediante Jesus Cristo, nosso Senhor. Amém." },
  {
    sunday_reference: "bartholomew",
    text: "Deus eterno, deste ao teu apóstolo Bartolomeu a graça de crer e de pregar a tua Palavra; permite que a tua Igreja ame a Palavra em que ele creu e fielmente lhe obedeça e a proclame. Mediante Jesus Cristo, nosso Senhor. Amém." },

  # ================================================================================
  # SETEMBRO
  # ================================================================================
  {
    sunday_reference: "independence_day",
    text: "Ó Onipotente Senhor, criaste todos os povos da terra para a tua glória, a fim de te servirem em liberdade e paz; concede ao povo de nosso País o zelo pela justiça e a virtude da moderação e da paciência, para que usemos a nossa liberdade conforme a tua benigna vontade; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém." },
  {
    sunday_reference: "blessed_virgin_mary",
    text: "Deus onipotente, escolheste a bem-aventurada Virgem Maria para ser a mãe do teu único Filho; concede-nos a nós, redimidos pelo Sangue de Jesus, a graça de estarmos com ela na glória do teu reino eterno. Mediante Jesus Cristo, nosso Senhor, que vive e reina, contigo e com o Espírito Santo. Amém." },
  {
    sunday_reference: "matthew",
    text: "Deus nosso Salvador, teu Filho chamou Mateus a ser apóstolo e evangelista; livra-nos de ser possessivos e amantes do dinheiro e inspira-nos a seguir Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém." },
  {
    sunday_reference: "michael_and_all_angels",
    text: "Senhor Deus das hostes celestiais, criaste os anjos para te adorarem e servirem; concede que, inspirando o nosso culto, eles nos socorram e fortaleçam na nossa luta contra o mal. Mediante Jesus Cristo, nosso Senhor. Amém." },

  # ================================================================================
  # OUTUBRO
  # ================================================================================
  {
    sunday_reference: "luke",
    text: "Pai de toda a graça, tu inspiraste o médico Lucas a anunciar o amor e o poder de cura do teu Filho; dá à tua Igreja, pela graça do Espírito, o mesmo amor e o mesmo poder de curar. Mediante Jesus Cristo, nosso Senhor. Amém." },
  {
    sunday_reference: "simon_and_jude",
    text: "Senhor Deus, edificaste a tua Igreja mediante apóstolos e profetas, sendo Jesus Cristo a sua pedra angular; permite que, auxiliados pela sua doutrina, nos reunamos na unidade do Espírito e nos tornemos templo santo aceitável por ti. Mediante Jesus Cristo, nosso Senhor. Amém." },
  {
    sunday_reference: "reformation_day",
    text: "Recebe, Senhor, nós te rogamos, as preces da tua Igreja, hoje quando nos lembramos de teu servo N. e de sua luta em favor do cristianismo reformado. Concede a nós a coragem deste irmão do passado para que lutemos com fé e coragem pela fé uma vez dada aos santos. Mediante Jesus Cristo, nosso Salvador. Amém." },

  # ================================================================================
  # NOVEMBRO
  # ================================================================================
  {
    sunday_reference: "all_saints",
    text: "Senhor de toda a graça, juntaste os teus santos na comunhão da tua Igreja e criaste para eles alegrias que ultrapassam o nosso entendimento; ajuda-nos a imitá-los na nossa vida diária e conduz-nos com eles à glória eterna. Mediante Jesus Cristo, nosso Senhor. Amém." },
  {
    sunday_reference: "thanksgiving_day",
    text: "Onipotente e benigno Pai, damos-te graças pelos frutos da terra em seu devido tempo e pelo trabalho daqueles que os colhem. Faze-nos, te pedimos, fiéis mordomos da tua grande generosidade para o suprimento de nossas necessidades e para o socorro de todos os carentes, para a glória do teu nome; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém." },
  {
    sunday_reference: "andrew",
    text: "Senhor Deus, pela tua graça o apóstolo André obedeceu à chamada do teu Filho Jesus Cristo e seguiu-o sem demora; concede-nos o dom de nos entregarmos a ti em alegre obediência. Mediante Jesus Cristo, nosso Senhor. Amém." },

  # ================================================================================
  # DEZEMBRO
  # ================================================================================
  {
    sunday_reference: "stephen",
    text: "Pai celestial, deste ao teu mártir Estevão a graça de orar por aqueles que o apedrejaram; concede que, ao sofrermos pela verdade, imitemos o seu exemplo de perdão. Mediante Jesus Cristo, nosso Senhor. Amém." },
  {
    sunday_reference: "john_evangelist",
    text: "Senhor misericordioso, iluminaste a tua Igreja com o ensino de João; lança sobre nós os brilhantes raios da tua luz para podermos caminhar na tua verdade e chegar finalmente ao teu eterno esplendor. Mediante Jesus Cristo, nosso Senhor. Amém." },
  {
    sunday_reference: "holy_innocents",
    text: "Pai celestial, crianças sofreram às mãos de Herodes, embora nenhum mal tivessem feito; dá-nos a graça de não sermos indiferentes perante a crueldade ou a opressão, mas prontos a defender os fracos da tirania dos fortes. Mediante Jesus Cristo, nosso Senhor. Amém." },
  {
    sunday_reference: "john_wycliff",
    text: "Recebe, Senhor, nós te rogamos, as preces da tua Igreja, hoje quando nos lembramos de teu servo N. e de sua luta em favor do cristianismo reformado. Concede a nós a coragem deste irmão do passado para que lutemos com fé e coragem pela fé uma vez dada aos santos. Mediante Jesus Cristo, nosso Salvador. Amém." }
]

# Criar coletas
count = 0
skipped = 0

holy_days_collects.each do |collect|
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

Rails.logger.info "✅ Coletas dos Dias Santos criadas: #{count}"
Rails.logger.info "⏭️  Coletas já existentes: #{skipped}" if skipped > 0
