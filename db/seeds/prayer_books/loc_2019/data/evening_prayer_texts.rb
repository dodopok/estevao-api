## Oração da Noite

# Sentenças de Abertura
create_text('evening_opening_sentence_1', 'opening_sentence', "Jesus lhes falou, dizendo: \"Eu sou a luz do mundo. Quem me segue não andará em trevas, mas terá a luz da vida.\"", reference: "JOÃO 8:12")
create_text('evening_opening_sentence_2', 'opening_sentence', "SENHOR, eu amo a habitação da tua casa e o lugar onde a tua honra habita.", reference: "SALMO 26:8")
create_text('evening_opening_sentence_3', 'opening_sentence', "Suba a minha oração perante a tua face como incenso, e seja o levantar das minhas mãos como o sacrifício da tarde.", reference: "SALMO 141:2")

# Sentenças de Abertura Sazonais (Noite)
create_text('evening_opening_sentence_advent', 'opening_sentence', "Vigiai, pois, porque não sabeis quando virá o senhor da casa; se à tarde, se à meia-noite, se ao cantar do galo, se pela manhã; para que, vindo ele de improviso, não vos ache dormindo.", reference: "MARCOS 13:35-36")
create_text('evening_opening_sentence_christmas', 'opening_sentence', "Eis aqui o tabernáculo de Deus com os homens, pois com eles habitará, e eles serão o seu povo, e o mesmo Deus estará com eles, e será o seu Deus.", reference: "APOCALIPSE 21:3")
create_text('evening_opening_sentence_epiphany', 'opening_sentence', "E as nações caminharão à tua luz, e os reis ao resplendor que te nasceu.", reference: "ISAÍAS 60:3")
create_text('evening_opening_sentence_lent', 'opening_sentence', "Se dissermos que não temos pecado, enganamo-nos a nós mesmos, e não há verdade em nós. Se confessarmos os nossos pecados, ele é fiel e justo para nos perdoar os pecados, e nos purificar de toda a injustiça.", reference: "1 JOÃO 1:8-9")
create_text('evening_opening_sentence_holy_week', 'opening_sentence', "Porque também Cristo padeceu uma vez pelos pecados, o justo pelos injustos, para levar-nos a Deus; mortificado, na verdade, na carne, mas vivificado pelo Espírito.", reference: "1 PEDRO 3:18")
create_text('evening_opening_sentence_easter', 'opening_sentence', "Mas graças a Deus que nos dá a vitória por nosso Senhor Jesus Cristo.", reference: "1 CORÍNTIOS 15:57")
create_text('evening_opening_sentence_ascension', 'opening_sentence', "Porque Cristo não entrou num santuário feito por mãos, figura do verdadeiro, mas no mesmo céu, para agora aparecer por nós diante da face de Deus.", reference: "HEBREUS 9:24")
create_text('evening_opening_sentence_pentecost', 'opening_sentence', "E o Espírito e a esposa dizem: \"Vem\". E quem ouve diga: \"Vem\". E quem tem sede, venha; e quem quiser, tome de graça da água da vida.", reference: "APOCALIPSE 22:17")
create_text('evening_opening_sentence_trinity', 'opening_sentence', "Santo, Santo, Santo, é o Senhor Deus, o Todo-Poderoso, que era, e que é, e que há de vir!", reference: "APOCALIPSE 4:8")

phos_hilaron = <<~TEXT
  **Ó luz radiante,
  puro brilho do Pai eterno e vivo no céu, *
    ó Jesus Cristo, santo e bendito!
  Agora, ao chegarmos ao pôr do sol,
  e nossos olhos contemplarem a luz da tarde, *
    cantamos os teus louvores, ó Deus: Pai, Filho e Espírito Santo.
  Tu és digno em todo o tempo de ser louvado por vozes alegres, *
    ó Filho de Deus, ó Dador da Vida,
    e de ser glorificado por todos os mundos.**
TEXT

# Invitatório
create_text('phos_hilaron', 'canticle', phos_hilaron, title: "PHOS HILARON", reference: "Ó Luz Radiante")

# Cânticos após as Lições
magnificat = <<~TEXT
  **A minha alma engrandece ao Senhor, *
    e o meu espírito se alegra em Deus, meu Salvador;
  Porque atentou *
    na humildade de sua serva.
  Pois eis que desde agora *
    todas as gerações me chamarão bem-aventurada;
  Porque me fez grandes coisas o Poderoso, *
    e santo é o seu Nome.
  E a sua misericórdia é de geração em geração *
    sobre os que o temem.
  Com o seu braço agiu valorosamente; *
    dispersou os soberbos no pensamento de seus corações.
  Depôs dos tronos os poderosos, *
    e elevou os humildes.
  Encheu de bens os famintos, *
    e despediu vazios os ricos.
  Auxiliou a Israel, seu servo, recordando-se da sua misericórdia, *
    como falara a nossos pais, para com Abraão e a sua posteridade para sempre.
  Glória ao Pai, e ao Filho, e ao Espírito Santo; *
    como era no princípio, agora e sempre,
    por todos os séculos dos séculos. Amém.**
TEXT
create_text('magnificat', 'canticle', magnificat, title: "MAGNIFICAT", reference: "O Cântico de Maria (LUCAS 1:46-55)")

nunc_dimittis = <<~TEXT
  **Agora, Senhor, despedes em paz o teu servo, *
    segundo a tua palavra.
  Pois já os meus olhos viram a tua salvação, *
    a qual tu preparaste perante a face de todos os povos;
  Luz para iluminar as nações, *
    e para glória de teu povo Israel.
  Glória ao Pai, e ao Filho, e ao Espírito Santo; *
    como era no princípio, agora e sempre,
    por todos os séculos dos séculos. Amém.**
TEXT
create_text('nunc_dimittis', 'canticle', nunc_dimittis, title: "NUNC DIMITTIS", reference: "O Cântico de Simeão (LUCAS 2:29-32)")

# Sufrágios B
create_text('evening_suff_b_rubric', 'rubric', "Que esta noite seja santa, boa e pacífica,")
create_text('evening_suff_b_response', 'prayer', "Rogamos-te, Senhor.")
create_text('evening_suff_b_1', 'prayer', "Que os teus santos anjos nos guiem pelos caminhos da paz e da boa vontade,")
create_text('evening_suff_b_2', 'prayer', "Que sejamos perdoados e absolvidos de nossos pecados e ofensas,")
create_text('evening_suff_b_3', 'prayer', "Que haja paz na tua Igreja e em todo o mundo,")
create_text('evening_suff_b_4', 'prayer', "Que partamos desta vida na tua fé e temor, e não sejamos condenados perante o grande tribunal de Cristo,")
create_text('evening_suff_b_5', 'prayer', "Que sejamos unidos pelo teu Santo Espírito na comunhão de [ _________ e] todos os teus santos, confiando uns aos outros e toda a nossa vida a Cristo,")

# Coletas da Noite
create_text('evening_collect_sunday', 'prayer', "Senhor Deus, cujo Filho nosso Salvador Jesus Cristo triunfou sobre os poderes da morte e preparou para nós o nosso lugar na nova Jerusalém: Concede que nós, que neste dia demos graças por sua ressurreição, possamos louvar-te naquela Cidade da qual ele é a luz, e onde ele vive e reina para todo o sempre. Amém.", title: "UMA COLETA PELA ESPERANÇA DA RESSURREIÇÃO")
create_text('evening_collect_monday', 'prayer', "Ó Deus, de quem procedem todos os santos desejos, todos os bons conselhos e todas as obras justas: Dá aos teus servos aquela paz que o mundo não pode dar, para que nossos corações se disponham a obedecer aos teus mandamentos, e para que nós, sendo defendidos do temor de nossos inimigos, passemos o nosso tempo em descanso e sossego; pelos méritos de Jesus Cristo nosso Salvador. Amém.", title: "UMA COLETA PELA PAZ")
create_text('evening_collect_tuesday', 'prayer', "Ilumina as nossas trevas, suplicamos-te, ó Senhor; e por tua grande misericórdia defende-nos de todos os perigos e riscos desta noite; por amor do teu único Filho, nosso Salvador Jesus Cristo. Amém.", title: "UMA COLETA POR AUXÍLIO CONTRA OS PERIGOS")
create_text('evening_collect_wednesday', 'prayer', "Ó Deus, vida de todos os que vivem, luz dos fiéis, força dos que trabalham e repouso dos mortos: Agradecemos-te pelas bênçãos do dia que passou e humildemente pedimos a tua proteção durante a noite que chega. Traze-nos em segurança às horas da manhã; por aquele que morreu e ressuscitou por nós, teu Filho nosso Salvador Jesus Cristo. Amém.", title: "UMA COLETA PELA PROTEÇÃO")
create_text('evening_collect_thursday', 'prayer', "Senhor Jesus, fica conosco, pois a tarde se aproxima e o dia já declinou; sê nosso companheiro no caminho, inflama nossos corações e desperta a esperança, para que possamos conhecer-te como és revelado nas Escrituras e no partir do pão. Concede isto por amor do teu amor. Amém.", title: "UMA COLETA PELA PRESENÇA DE CRISTO")
create_text('evening_collect_friday', 'prayer', "Senhor Jesus Cristo, por tua morte tiraste o aguilhão da morte: Concede a nós, teus servos, seguir em fé por onde abriste o caminho, para que possamos, finalmente, dormir em paz em ti e acordar à tua semelhança; por amor de tuas ternas misericórdias. Amém.", title: "UMA COLETA PELA FÉ")
create_text('evening_collect_saturday', 'prayer', "Ó Deus, fonte de luz eterna: Derrama o teu dia sem fim sobre nós que vigiamos por ti, para que nossos lábios te louvem, nossas vidas te bendigam e nosso culto de amanhã te dê glória; por Jesus Cristo, nosso Senhor. Amém.", title: "UMA COLETA PELA VÉSPERA DO CULTO")

# Orações de Missão da Noite
create_text('evening_prayer_for_mission_1', 'prayer', "Ó Deus e Pai de todos, a quem todos os céus adoram: Faze que toda a terra também te adore, todas as nações te obedeçam, todas as línguas te confesse e te bendigam, e homens, mulheres e crianças em todos os lugares te amem e te sirvam em paz; por Jesus Cristo, nosso Senhor. Amém.")
create_text('evening_prayer_for_mission_2', 'prayer', "Vela, querido Senhor, com aqueles que trabalham, ou vigiam, ou choram esta noite, e dá aos teus anjos encargo sobre os que dormem. Cuida dos doentes, Senhor Cristo; dá descanso aos cansados, abençoa os moribundos, acalma os sofredores, compadece-te dos aflitos, protege os alegres; e tudo por amor do teu amor. Amém.")
create_text('evening_prayer_for_mission_3', 'prayer', "Ó Deus, tu manifestas em teus servos os sinais da tua presença: Envia sobre nós o Espírito de amor, para que, em companhia uns dos outros, a tua graça abundante aumente entre nós; por Jesus Cristo, nosso Senhor. Amém.")

# Rubricas da Noite
create_text('evening_opening_rubric', 'rubric', "O Oficiante pode começar a Oração da Noite lendo uma sentença de abertura das Escrituras. Uma das seguintes, ou uma sentença entre aquelas fornecidas ao final do Ofício (páginas 54–56), é costumeira.")
create_text('evening_confession_rubric', 'rubric', "O Oficiante diz ao Povo")
create_text('evening_suffrages_rubric', 'rubric', "Segue-se um destes conjuntos de Sufrágios")
create_text('evening_collects_rubric', 'rubric', "O Oficiante então ora uma ou mais das seguintes Coletas, começando sempre com a Coleta do Dia (geralmente a Coleta do Domingo ou Festa Principal e de quaisquer dos dias de semana seguintes, ou do Dia Santo que está sendo observado) encontrada nas páginas 598–640. É tradicional orar as Coletas pela Paz e Auxílio contra Perigos diariamente. Alternativamente, pode-se orar as Coletas em uma rotação semanal, usando as sugestões em itálico.")
create_text('evening_mission_rubric', 'rubric', "A menos que a Grande Ladainha ou a Eucaristia se sigam, uma das seguintes orações pela missão é acrescentada. Se a Grande Ladainha for usada, segue-se aqui, ou após um hino ou antífona, e conclui o Ofício.")
create_text('evening_thanksgiving_rubric', 'rubric', "Antes do encerramento do Ofício, uma ou ambas as seguintes orações podem ser usadas.")
create_text('evening_conclusion_rubric', 'rubric', "O Oficiante diz uma destas sentenças conclusivas (e o Povo pode ser convidado a se juntar)")
create_text('evening_reading_first_rubric', 'rubric', "Uma ou mais Lições, conforme designadas, são lidas, o Leitor dizendo primeiro")
create_text('evening_reading_citation_rubric', 'rubric', "Uma citação dando capítulo e versículo pode ser acrescentada.")
create_text('evening_reading_after_rubric', 'rubric', "Após cada Lição, o Leitor pode dizer")
create_text('evening_reading_end_rubric', 'rubric', "Ou o Leitor pode dizer")
create_text('evening_canticle_rubric', 'rubric', "Os seguintes Cânticos são normalmente cantados ou ditos após cada uma das lições. O Oficiante também pode usar um Cântico extraído dos Cânticos Suplementares (páginas 79–88) ou uma canção de louvor apropriada.")
create_text('evening_phos_hilaron_rubric', 'rubric', "O seguinte ou algum outro hino ou Salmo adequado pode ser cantado ou dito.")

Rails.logger.info "✅ LOC 2019 Portuguese liturgical texts (Evening Prayer) updated!"
