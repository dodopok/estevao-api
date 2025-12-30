## Completas

# Abertura
create_text('compline_opening_sentence', 'opening_sentence', "O Senhor Todo-Poderoso nos conceda uma noite tranquila e um fim perfeito. Amém.")
create_text('compline_inv_v1', 'invocation', "O nosso socorro está no Nome do Senhor;")
create_text('compline_inv_r1', 'invocation', "Que fez o céu e a terra.")

# Confissão
create_text('compline_confession_invitation', 'confession', "Confessemos humildemente nossos pecados a Deus Todo-Poderoso.")
create_text('compline_confession_body', 'confession',
  <<~TEXT
    **Deus Todo-Poderoso e Pai, confessamos a ti,
    uns aos outros e a toda a companhia do céu,
    que pecamos, por nossa própria culpa,
    em pensamento, palavra e obra,
    e no que deixamos de fazer.
    Por amor de teu Filho nosso Senhor Jesus Cristo,
    tem piedade de nós, perdoa os nossos pecados,
    e pelo poder do teu Santo Espírito
    levanta-nos para te servirmos em novidade de vida,
    para a glória do teu Nome. Amém.**
  TEXT
)
create_text('compline_absolution', 'absolution', "Que Deus Todo-Poderoso nos conceda o perdão de todos os nossos pecados, e a graça e o consolo do Espírito Santo. Amém.")

# Invitatório
create_text('compline_inv_v2', 'invocation', "Ó Deus, apressa-te em nos salvar;")
create_text('compline_inv_r2', 'invocation', "Ó Senhor, apressa-te em nos socorrer.")
create_text('compline_inv_v3', 'invocation', "Glória ao Pai, e ao Filho, e ao Espírito Santo;")
create_text('compline_inv_r3', 'invocation', "Como era no princípio, agora e sempre, por todos os séculos dos séculos. Amém.")

# Salmos
psalm_4 = <<~TEXT
  **1 Ouve-me quando eu clamo, ó Deus da minha justiça; *
    tu me livraste quando eu estava em angústia; tem piedade de mim
    e ouve a minha oração.
  2 Ó filhos dos homens, até quando convertereis
    a minha glória em infâmia? *
    Até quando amareis a vaidade e buscareis a mentira?
  3 Sabei, pois, que o SENHOR escolheu para si
    aquele que é piedoso; *
    o SENHOR ouvirá quando eu clamar a ele.
  4 Perturbai-vos e não pequeis; *
    falai com o vosso coração sobre a vossa cama e calai-vos.
  5 Oferecei sacrifícios de justiça *
    e confiai no SENHOR.
  6 Muitos dizem: “Quem nos mostrará o bem?” *
    SENHOR, levanta sobre nós a luz do teu rosto.
  7 Puseste alegria no meu coração, *
    mais do que no tempo em que se multiplicaram o seu trigo e o seu vinho.
  8 Em paz também me deitarei e dormirei, *
    porque só tu, SENHOR, me fazes habitar em segurança.**
TEXT
create_text('compline_psalm_4', 'psalm', psalm_4, title: "SALMO 4", reference: "Cum invocarem")

psalm_31 = <<~TEXT
  **1 Em ti, SENHOR, confio; *
    nunca me deixes confundido;
    livra-me pela tua justiça.
  2 Inclina para mim os teus ouvidos, *
    livra-me depressa;
  3 Sê a minha rocha forte e a minha fortaleza, *
    para me salvar.
  4 Porque tu és a minha rocha e a minha fortaleza; *
    guia-me e encaminha-me por amor do teu Nome.
  5 Tira-me da rede que ocultamente me prepararam, *
    pois tu és a minha força.
  6 Nas tuas mãos encomendo o meu espírito; *
    tu me remiste, SENHOR, Deus da verdade.**
TEXT
create_text('compline_psalm_31', 'psalm', psalm_31, title: "SALMO 31:1-6", reference: "In te, Domine, speravi")

psalm_91 = <<~TEXT
  **1 Aquele que habita no esconderijo do Altíssimo, *
    à sombra do Onipotente descansará.
  2 Direi do SENHOR: “Ele é o meu refúgio e a minha fortaleza, *
    o meu Deus, em quem confiarei.”
  3 Porque ele te livrará do laço do passarinheiro *
    e da peste perniciosa.
  4 Ele te cobrirá com as suas penas, e debaixo das suas asas estarás seguro; *
    a sua verdade será o teu escudo e broquel.
  5 Não terás medo do terror de noite *
    nem da seta que voa de dia,
  6 Nem da peste que anda na escuridão, *
    nem da mortandade que assola ao meio-dia.
  7 Mil cairão ao teu lado, e dez mil
    à tua direita, *
    mas tu não serás atingido.
  8 Somente com os teus olhos contemplarás *
    e verás a recompensa dos ímpios.
  9 Porque tu disseste: “O SENHOR é o meu refúgio,” *
    e fizeste do Altíssimo a tua habitação,
  10 Nenhum mal te sucederá, *
    nem praga alguma chegará à tua tenda.
  11 Porque aos seus anjos dará ordem a teu respeito, *
    para te guardarem em todos os teus caminhos.
  12 Eles te sustentarão nas suas mãos, *
    para que não tropeces com o teu pé em pedra.
  13 Pisarás o leão e a áspide; *
    calcarás aos pés o filho do leão e a serpente.
  14 “Porquanto tão encarecidamente me amou, também eu o
    livrarei; *
    pô-lo-ei em retiro alto, porque conheceu o meu Nome.
  15 Ele me invocará, e eu lhe responderei; *
    estarei com ele na angústia; dela o retirarei
    e o glorificarei.
  16 Fartá-lo-ei com longura de dias, *
    e lhe mostrarei a minha salvação.”**
TEXT
create_text('compline_psalm_91', 'psalm', psalm_91, title: "SALMO 91", reference: "Qui habitat")

psalm_134 = <<~TEXT
  **1 Eis aqui, bendizei ao SENHOR, *
    todos vós, servos do SENHOR,
  2 Que assistis de noite na casa do SENHOR, *
    nos átrios da casa do nosso Deus.
  3 Levantai as vossas mãos no santuário *
    e bendizei ao SENHOR.
  4 O SENHOR que fez o céu e a terra *
    te abençoe desde Sião.**
TEXT
create_text('compline_psalm_134', 'psalm', psalm_134, title: "SALMO 134", reference: "Ecce nunc")

# Leituras
create_text('compline_reading_1', 'reading', "Tu, ó SENHOR, estás no meio de nós, e pelo teu nome somos chamados; não nos deixes.", reference: "JEREMIAS 14:9")
create_text('compline_reading_2', 'reading', "Vinde a mim, todos os que estais cansados e oprimidos, e eu vos aliviarei. Tomai sobre vós o meu jugo, e aprendei de mim, que sou manso e humilde de coração; e encontrareis descanso para as vossas almas. Porque o meu jugo é suave e o meu fardo é leve.", reference: "MATEUS 11:28-30")
create_text('compline_reading_3', 'reading', "Ora, o Deus de paz, que pelo sangue da aliança eterna tornou a trazer dos mortos a nosso Senhor Jesus Cristo, grande pastor das ovelhas, vos aperfeiçoe em toda a boa obra, para fazerdes a sua vontade, operando em nós o que perante ele é agradável por Jesus Cristo, ao qual seja glória para todo o sempre. Amém.", reference: "HEBREUS 13:20-21")
create_text('compline_reading_4', 'reading', "Sede sóbrios; vigiai. O vosso adversário, o diabo, anda em redor, bramando como leão, buscando a quem possa devorar; ao qual resisti firmes na fé.", reference: "1 PEDRO 5:8-9")

# Responsório
create_text('compline_resp_v1', 'prayer', "Nas tuas mãos, Senhor, encomendo o meu espírito;")
create_text('compline_resp_r1', 'prayer', "Pois tu me remiste, Senhor, Deus da verdade.")
create_text('compline_resp_v2', 'prayer', "Guarda-me, Senhor, como a menina dos teus olhos;")
create_text('compline_resp_r2', 'prayer', "Esconde-me à sombra das tuas asas.")

# Coletas
create_text('compline_collect_1', 'prayer', "Visita este lugar, Senhor, e afasta dele todas as ciladas do inimigo; habitem conosco os teus santos anjos para nos guardarem em paz; e esteja a tua bênção sempre sobre nós; por Jesus Cristo, nosso Senhor. Amém.")
create_text('compline_collect_2', 'prayer', "Ilumina as nossas trevas, suplicamos-te, ó Senhor; e por tua grande misericórdia defende-nos de todos os perigos e riscos desta noite; por amor do teu único Filho, nosso Salvador Jesus Cristo. Amém.")
create_text('compline_collect_3', 'prayer', "Sê presente, ó Deus misericordioso, e protege-nos através das horas desta noite, para que nós, que estamos cansados pelas mudanças e acasos desta vida, possamos descansar em tua eterna imutabilidade; por Jesus Cristo, nosso Senhor. Amém.")
create_text('compline_collect_4', 'prayer', "Olha, Senhor, do teu trono celestial, ilumina esta noite com o teu brilho celeste, e afasta dos filhos da luz as obras das trevas; por Jesus Cristo, nosso Senhor. Amém.")
create_text('compline_collect_saturday', 'prayer', "Agradecemos-te, ó Deus, por nos revelares teu Filho Jesus Cristo pela luz da sua ressurreição: Concede que, ao cantarmos a tua glória no encerramento deste dia, a nossa alegria abunde pela manhã ao celebrarmos o mistério pascal; por Jesus Cristo, nosso Senhor. Amém.", title: "UMA COLETA PARA OS SÁBADOS")

# Missão
create_text('compline_mission_1', 'prayer', "Vela, querido Senhor, com aqueles que trabalham, ou vigiam, ou choram esta noite, e dá aos teus anjos encargo sobre os que dormem. Cuida dos doentes, Senhor Cristo; dá descanso aos cansados, abençoa os moribundos, acalma os sofredores, compadece-te dos aflitos, protege os alegres; e tudo por amor do teu amor. Amém.")
create_text('compline_mission_2', 'prayer', "Ó Deus, tua infalível providência sustenta o mundo em que vivemos e a vida que levamos: Vigia sobre aqueles que, tanto de dia como de noite, trabalham enquanto outros dormem, e concede que nunca nos esqueçamos de que a nossa vida comum depende do trabalho uns dos outros; por Jesus Cristo, nosso Senhor. Amém.")

# Antífona do Nunc Dimittis
create_text('compline_nunc_antiphon', 'antiphon', "Guia-nos ao despertar, Senhor, e guarda-nos ao dormir; para que despertos vigiemos com Cristo e adormecidos descansemos em paz.")
create_text('compline_nunc_antiphon_easter', 'antiphon', "Guia-nos ao despertar, Senhor, e guarda-nos ao dormir; para que despertos vigiemos com Cristo e adormecidos descansemos em paz. Aleluia, aleluia, aleluia.")

# Conclusão
create_text('compline_conclusion', 'dismissal', "O Senhor onipotente e misericordioso, Pai, Filho e Espírito Santo, nos abençoe e nos guarde, nesta noite e para sempre. Amém.")

# Rubricas
create_text('compline_opening_rubric', 'rubric', "O Oficiante começa")
create_text('compline_confession_rubric', 'rubric', "O Oficiante continua")
create_text('compline_silence_rubric', 'rubric', "Pode-se guardar silêncio. O Oficiante e o Povo dizem então")
create_text('compline_absolution_rubric', 'rubric', "O Oficiante sozinho diz")
create_text('compline_psalms_rubric', 'rubric', "Um ou mais dos seguintes, ou algum outro Salmo adequado, é cantado ou dito.")
create_text('compline_reading_rubric', 'rubric', "Uma das seguintes, ou alguma outra passagem adequada das Escrituras, é lida")
create_text('compline_meditation_rubric', 'rubric', "Um período de silêncio pode seguir-se. Um hino adequado pode ser cantado.")
create_text('compline_prayers_rubric', 'rubric', "O Povo se ajoelha ou fica em pé.")
create_text('compline_collects_rubric', 'rubric', "O Oficiante diz então uma ou mais das seguintes Coletas. Outras Coletas apropriadas também podem ser usadas.")
create_text('compline_mission_rubric', 'rubric', "Uma das seguintes orações pode ser acrescentada")
create_text('compline_intercessions_rubric', 'rubric', "Pode-se guardar silêncio, e outras intercessões e ações de graças podem ser oferecidas.")
create_text('compline_nunc_rubric', 'rubric', "O Oficiante e o Povo dizem ou cantam o Cântico de Simeão com esta Antífona")
create_text('compline_nunc_easter_rubric', 'rubric', "No Tempo Pascal, acrescenta-se Aleluia, aleluia, aleluia.")
create_text('compline_conclusion_rubric', 'rubric', "O Oficiante conclui com o seguinte")

Rails.logger.info "✅ LOC 2019 Portuguese liturgical texts (Compline) updated!"
