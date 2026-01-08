# ================================================================================
# COLETAS DA SEMANA SANTA - LOCB 2008
# ================================================================================

Rails.logger.info "🙏 Criando Coletas da Semana Santa - LOCB 2008..."

prayer_book = PrayerBook.find_by_code('locb_2008')

holy_week_collects = [
  # DOMINGO DE RAMOS - LITURGIA DE RAMOS
  {
    sunday_reference: "palm_sunday",
    text: "Onipotente e Eterno Deus, de tal modo amaste o mundo, que enviaste teu Filho, nosso Salvador Jesus Cristo, para tomar sobre si a nossa carne e sofrer morte na cruz, dando ao gênero humano exemplo de sua profunda humildade; concede, em tua misericórdia, que imitemos a sua paciência no sofrimento e possamos participar também de sua ressurreição; mediante o mesmo Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém." },
  # DOMINGO DE RAMOS - LITURGIA DA PAIXÃO
  {
    sunday_reference: "palm_sunday_passion",
    text: "Deus Todo-poderoso, o teu Filho querido não ascendeu à alegria sem que primeiro sofresse a dor, nem entrou na glória sem ser crucificado; concede-nos misericordioso que, andando nós no Caminho da Cruz, nele encontremos a vida e a paz. Mediante Jesus Cristo, nosso Senhor. Amém." },
  # SEGUNDA-FEIRA DA SEMANA SANTA
  {
    sunday_reference: "monday_of_holy_week",
    text: "Onipotente Deus, cujo Filho muito amado não gozou perfeita alegria, senão após o sofrimento, e só subiu à glória depois de crucificado; concede-nos misericordioso que, seguindo o caminho da cruz, seja este para nós vereda de vida e paz; por Jesus Cristo, teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém." },
  # TERÇA-FEIRA DA SEMANA SANTA
  {
    sunday_reference: "tuesday_of_holy_week",
    text: "Ó Deus, que pela paixão de teu bendito Filho, fizeste com que o instrumento da morte vergonhosa se tornasse para nós símbolo de vida; concede que nos glorifiquemos na cruz de Cristo, a fim de que alegremente suportemos infâmias e privações, por amor de teu Filho, nosso Salvador Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém." },
  # QUARTA-FEIRA DA SEMANA SANTA
  {
    sunday_reference: "wednesday_of_holy_week",
    text: "Ó Senhor Deus, cujo bendito Filho, nosso Salvador Jesus Cristo, teve o seu corpo torturado e seu rosto cuspido; concede-nos a graça de enfrentar com esperança os sofrimentos deste tempo e de confiar na glória que há de ser revelada; por Jesus Cristo teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém." },
  # QUINTA-FEIRA SANTA
  {
    sunday_reference: "maundy_thursday",
    text: "Ó Pai Onipotente, cujo amado Filho, na noite anterior à sua paixão, instituiu o Sacramento do seu Corpo e Sangue; concede-nos, misericordioso, que dele participemos agradecidos, em memória daquele que nestes santos mistérios nos dá o penhor da vida eterna, teu Filho Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém." },
  {
    sunday_reference: "maundy_thursday_alt1",
    text: "Deus Todo-poderoso, teu Filho nosso Senhor Jesus Cristo deu-nos o maravilhoso sacramento do seu Corpo e do seu Sangue para representarmos a sua morte e celebrarmos a sua ressurreição; aumenta em nós a devoção a Jesus nestes santos mistérios, e mediante os mesmos, renova a nossa unidade com Ele e de uns com os outros, para crescermos em graça e conhecimento da nossa salvação. Mediante Jesus Cristo, nosso Senhor. Amém." },
  {
    sunday_reference: "maundy_thursday_alt2",
    text: "Pai onipotente, teu Filho, Jesus Cristo, ensinou-nos que o que fizermos pelo menor dos nossos irmãos é por Ele que o fazemos; dá-nos a vontade de ser servos uns dos outros, tal como Ele foi servo de todos; o qual deu a sua vida e morreu por nós, mas vive e reina contigo e com o Espírito Santo, um só Deus, agora e para sempre. Amém." },
  # SEXTA-FEIRA SANTA
  {
    sunday_reference: "good_friday",
    text: "Deus Onipotente, nós te suplicamos olhes com misericórdia para esta família que é tua, e pela qual nosso Senhor Jesus Cristo não hesitou em entregar-se, traído, às mãos de homens iníquos, e sofrer morte de cruz; o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém." },
  {
    sunday_reference: "good_friday_alt1",
    text: "Onipotente e Eterno Deus, que por teu Espírito governas e santificas todo o corpo da Igreja; recebe as súplicas e orações que por todos os seus membros te oferecemos, para que estes, na sua vocação e ministério, te sirvam com verdadeira piedade e devoção; mediante nosso Senhor e Salvador Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém." },
  {
    sunday_reference: "good_friday_alt2",
    text: "Ó Misericordioso Deus, que criaste todo o gênero humano e não aborreces coisa alguma do que fizeste, nem desejas a morte do pecador, mas antes seu arrependimento e salvação; tem compaixão dos que não te conhecem, tal como te revelaste no Evangelho de teu Filho. Liberta-os de toda a ignorância, dureza de coração e desprezo de tua Palavra; conduze-os, pois, ó bendito Senhor, ao teu aprisco, a fim de que constituam um só rebanho sob um único Pastor, Jesus Cristo, Senhor nosso, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém." },
  # SÁBADO SANTO
  {
    sunday_reference: "holy_saturday",
    text: "Ó Deus, Criador do céu e da terra; concede que, assim como o corpo crucificado de teu amado Filho foi colocado no túmulo e descansou neste sábado santo, também sepultados com Ele aguardemos o terceiro dia e com Ele ressuscitemos para uma vida nova; o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém." }
]

holy_week_collects.each do |collect|
  Collect.create!(collect.merge(prayer_book_id: prayer_book&.id))
end

Rails.logger.info "  ✓ #{holy_week_collects.count} coletas da Semana Santa criadas"
