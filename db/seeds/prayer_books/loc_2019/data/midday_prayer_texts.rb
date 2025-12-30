## Oração do Meio-Dia

# Abertura
create_text('midday_inv_v1', 'invocation', "Ó Deus, apressa-te em nos salvar;")
create_text('midday_inv_r1', 'invocation', "Ó Senhor, apressa-te em nos socorrer.")
create_text('midday_inv_v2', 'invocation', "Glória ao Pai, e ao Filho, e ao Espírito Santo;")
create_text('midday_inv_r2', 'invocation', "Como era no princípio, agora e sempre, por todos os séculos dos séculos. Amém.")
create_text('midday_opening_lent_rubric', 'rubric', "Exceto na Quaresma, acrescenta-se Aleluia.")
create_text('midday_hymn_rubric', 'rubric', "Um hino adequado pode ser cantado.")

# Salmos
create_text('midday_psalms_rubric', 'rubric', "Um ou mais dos seguintes, ou algum outro Salmo adequado, é cantado ou dito.")
create_text('midday_gloria_patri_rubric', 'rubric', "Ao final dos Salmos, o Gloria Patri (Glória ao Pai...) é cantado ou dito")

psalm_119 = <<~TEXT
  **105 Lâmpada para os meus pés é a tua palavra *
    e luz para o meu caminho.
  106 Jurei e cumprirei *
    que guardarei os teus justos juízos.
  107 Estou aflitíssimo; *
    vivifica-me, ó SENHOR, segundo a tua palavra.
  108 Aceita, SENHOR, as oferendas voluntárias da minha boca; *
    e ensina-me os teus juízos.
  109 A minha alma está continuamente na minha mão; *
    todavia não me esqueço da tua lei.
  110 Os ímpios me armaram laço; *
    contudo não me desviei dos teus preceitos.
  111 Os teus testemunhos tenho eu por herança para sempre, *
    pois são o gozo do meu coração.
  112 Inclinei o meu coração a cumprir os teus estatutos, para sempre, *
    até ao fim.**
TEXT
create_text('midday_psalm_119', 'psalm', psalm_119, title: "SALMO 119:105-112", reference: "Lucerna pedibus meis")

psalm_121 = <<~TEXT
  **1 Levantarei os meus olhos para os montes, *
    de onde vem o meu socorro?
  2 O meu socorro vem do SENHOR, *
    que fez o céu e a terra.
  3 Não deixará vacilar o teu pé; *
    aquele que te guarda não tosquenejará.
  4 Eis que não tosquenejará nem dormirá *
    o que guarda a Israel.
  5 O SENHOR é quem te guarda; *
    o SENHOR é a tua sombra à tua direita.
  6 O sol não te molestará de dia *
    nem a lua de noite.
  7 O SENHOR te guardará de todo o mal; *
    ele guardará a tua alma.
  8 O SENHOR guardará a tua saída e a tua entrada, *
    desde agora e para sempre.**
TEXT
create_text('midday_psalm_121', 'psalm', psalm_121, title: "SALMO 121", reference: "Levavi oculos")

psalm_124 = <<~TEXT
  **1 Se o SENHOR não tivesse estado por nós, diga agora Israel: *
    Se o SENHOR não tivesse estado por nós, quando os homens se levantaram contra nós,
  2 Eles nos teriam engolido vivos, *
    quando a sua ira se acendeu contra nós.
  3 Então as águas teriam passado sobre nós, e a torrente teria coberto a nossa alma; *
    então as águas impetuosas teriam passado sobre a nossa alma.
  4 Bendito seja o Senhor, *
    que não nos deu por presa aos seus dentes.
  5 A nossa alma escapou, como um pássaro do laço dos passarinheiros; *
    o laço quebrou-se, e nós escapamos.
  6 O nosso socorro está no Nome do SENHOR, *
    que fez o céu e a terra.**
TEXT
create_text('midday_psalm_124', 'psalm', psalm_124, title: "SALMO 124", reference: "Nisi quia Dominus")

psalm_126 = <<~TEXT
  **1 Quando o SENHOR trouxe do cativeiro os que voltaram a Sião, *
    estávamos como os que sonham.
  2 Então a nossa boca se encheu de riso *
    e a nossa língua de cânticos.
  3 Então se dizia entre as nações: *
    “Grandes coisas fez o SENHOR a estes.”
  4 Grandes coisas fez o SENHOR por nós, *
    pelas quais estamos alegres.
  5 Faze-nos regressar, ó SENHOR, do nosso cativeiro, *
    como as correntes no sul.
  6 Os que semeiam em lágrimas *
    ceifarão com alegria.
  7 Aquele que leva a preciosa semente, andando e chorando, *
    voltará, sem dúvida, com alegria, trazendo consigo os seus feixes.**
TEXT
create_text('midday_psalm_126', 'psalm', psalm_126, title: "SALMO 126", reference: "In convertendo")

# Leituras
create_text('midday_reading_rubric', 'rubric', "Uma das seguintes, ou alguma outra passagem adequada das Escrituras, é lida")
create_text('midday_reading_end_rubric', 'rubric', "Ao final da leitura diz-se")
create_text('midday_meditation_rubric', 'rubric', "Uma meditação, silenciosa ou falada, pode seguir-se.")

create_text('midday_reading_1', 'reading', "Jesus disse: “Agora é o juízo deste mundo; agora será expulso o príncipe deste mundo. E eu, quando for levantado da terra, todos atrairei a mim.”", reference: "JOÃO 12:31-32")
create_text('midday_reading_2', 'reading', "Assim que, se alguém está em Cristo, nova criatura é; as coisas velhas já passaram; eis que tudo se fez novo. E tudo isto provém de Deus, que nos reconciliou consigo mesmo por Jesus Cristo, e nos deu o ministério da reconciliação.", reference: "2 CORÍNTIOS 5:17-18")
create_text('midday_reading_3', 'reading', "Pois, desde o nascente do sol até ao poente, é grande entre as nações o meu nome; e em todo o lugar se oferecerá ao meu nome incenso e uma oferta pura; porque o meu nome é grande entre as nações, diz o SENHOR dos Exércitos.", reference: "MALAQUIAS 1:11")

# Orações
create_text('midday_prayers_rubric', 'rubric', "O Oficiante então começa as Orações")
create_text('midday_officiant_people_rubric', 'rubric', "Oficiante e Povo")

create_text('midday_pre_v', 'prayer', "Bendirei o Senhor em todo o tempo.")
create_text('midday_pre_r', 'prayer', "O seu louvor estará continuamente na minha boca.")

create_text('midday_kyrie_v1', 'prayer', "Senhor, tem piedade de nós.")
create_text('midday_kyrie_r1', 'prayer', "Cristo, tem piedade de nós.")
create_text('midday_kyrie_v2', 'prayer', "Senhor, tem piedade de nós.")

create_text('midday_kyrie_short_v1', 'prayer', "Senhor, tem piedade.")
create_text('midday_kyrie_short_r1', 'prayer', "Cristo, tem piedade.")
create_text('midday_kyrie_short_v2', 'prayer', "Senhor, tem piedade.")

create_text('midday_post_v', 'prayer', "Ó Senhor, ouve a nossa oração;")
create_text('midday_post_r', 'prayer', "E chegue a ti o nosso clamor.")

# Coletas
create_text('midday_collects_rubric', 'rubric', "O Oficiante então diz uma ou mais das seguintes Coletas. Outras Coletas apropriadas também podem ser usadas.")
create_text('midday_collect_1', 'prayer', "Bendito Salvador, que nesta hora estiveste pendurado na Cruz, estendendo teus braços amorosos: Concede que todos os povos da terra olhem para ti e sejam salvos; por amor de tuas ternas misericórdias. Amém.")
create_text('midday_collect_2', 'prayer', "Onipotente Salvador, que ao meio-dia chamaste o teu servo São Paulo para ser apóstolo dos gentios: Rogamos-te que ilumines o mundo com o esplendor da tua glória, para que todas as nações venham e te adorem; pois vives e reinas com o Pai e o Espírito Santo, um só Deus, agora e para sempre. Amém.")
create_text('midday_collect_3', 'prayer', "Pai de toda a misericórdia, revelaste a tua compaixão ilimitada ao teu apóstolo São Pedro em uma visão tríplice: Perdoa a nossa incredulidade, rogamos-te, e assim fortalece os nossos corações e inflama o nosso zelo, para que desejemos fervorosamente a salvação de todas as pessoas e trabalhemos diligentemente na extensão do teu reino; por aquele que se deu a si mesmo pela vida do mundo, teu Filho, nosso Salvador Jesus Cristo. Amém.")
create_text('midday_collect_4', 'prayer', "Derrrama a tua graça em nossos corações, ó Senhor, para que nós, que conhecemos a encarnação de teu Filho Jesus Cristo, anunciada por um anjo à Virgem Maria, possamos por sua Cruz e paixão ser levados à glória da sua ressurreição; que vive e reina contigo, na unidade do Espírito Santo, um só Deus, agora e para sempre. Amém.")

create_text('midday_intercessions_rubric', 'rubric', "Pode-se guardar silêncio e outras intercessões e ações de graças podem ser oferecidas.")

create_text('midday_conclusion_rubric', 'rubric', "O Oficiante pode concluir com esta, ou uma das outras sentenças conclusivas da Oração da Manhã e da Noite.")
create_text('midday_dismissal_alleluia', 'rubric', "Do Dia de Páscoa até o Dia de Pentecostes, “Aleluia, aleluia” pode ser acrescentado ao versículo e resposta precedentes.")

Rails.logger.info "✅ LOC 2019 Portuguese liturgical texts (Midday Prayer) updated!"
