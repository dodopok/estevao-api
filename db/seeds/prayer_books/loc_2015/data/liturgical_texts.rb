# Seeds for Liturgical Texts
prayer_book = PrayerBook.find_by!(code: 'loc_2015')
# TODO: Replace these example texts with actual texts from LOC 2015

puts "Creating Liturgical Texts..."

# Opening Sentences for each season
[
  { slug: 'opening_sentence_advent', category: 'opening_sentence', content: 'Eis que vem o Senhor, o poderoso, e o seu reino está em suas mãos. Aleluia!', reference: 'Malaquias 3:1' },
  { slug: 'opening_sentence_christmas', category: 'opening_sentence', content: 'Glória a Deus nas alturas, e paz na terra aos homens de boa vontade. Aleluia!', reference: 'Lucas 2:14' },
  { slug: 'opening_sentence_epiphany', category: 'opening_sentence', content: 'Do nascente ao poente seja louvado o nome do Senhor. Aleluia!', reference: 'Salmo 113:3' },
  { slug: 'opening_sentence_lent', category: 'opening_sentence', content: 'Arrependei-vos e crede no Evangelho, porque o reino de Deus está próximo.', reference: 'Marcos 1:15' },
  { slug: 'opening_sentence_easter', category: 'opening_sentence', content: 'Cristo ressuscitou dos mortos, aleluia! Primícias dos que dormem, aleluia!', reference: '1 Coríntios 15:20' },
  { slug: 'opening_sentence_ordinary', category: 'opening_sentence', content: 'Senhor, abre os meus lábios, e a minha boca proclamará o teu louvor.', reference: 'Salmo 51:15' },
  { slug: 'opening_sentence_midday', category: 'opening_sentence', content: 'Deus, vem em meu auxílio. Senhor, apressa-te em socorrer-me.', reference: 'Salmo 70:1' },
  { slug: 'opening_sentence_compline', category: 'opening_sentence', content: 'O Senhor Todo-Poderoso nos conceda uma noite tranquila e um fim perfeito. Amém.', reference: nil }
].each do |text|
  LiturgicalText.find_or_create_by!(slug: text[:slug], prayer_book_id: prayer_book.id) do |lt|
    lt.category = text[:category]
    lt.content = text[:content]
    lt.reference = text[:reference]
    lt.language = 'pt-BR'
  end
end

# Confessions
LiturgicalText.find_or_create_by!(slug: 'confession_long', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'confession'
  lt.content = <<~TEXT
    Todo-Poderoso e misericordiosíssimo Pai,
    Desviamo-nos e nos afastamos dos teus caminhos como ovelhas desgarradas.
    Temos seguido demasiadamente os desejos e propósitos de nossos corações.
    Temos transgredido os teus santos mandamentos.
    Temos deixado de fazer o que devíamos ter feito,
    e temos feito o que não devíamos ter feito.
    Não há saúde em nós.
    Mas tu, ó Senhor, tem misericórdia de nós, miseráveis pecadores.
    Poupa aos que confessam as suas faltas.
    Restaura aos que estão arrependidos,
    Segundo as tuas promessas declaradas aos homens em Cristo Jesus, nosso Senhor.
    E concede, ó Pai misericordiosíssimo, por amor dele,
    Que daqui em diante vivamos uma vida santa, justa e sóbria,
    Para a glória do teu santo Nome. Amém.
  TEXT
  lt.language = 'pt-BR'
end

# Absolution
LiturgicalText.find_or_create_by!(slug: 'absolution', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'absolution'
  lt.content = <<~TEXT
    O Deus Todo-Poderoso tenha misericórdia de vós, perdoe-vos todos os vossos pecados,
    por meio de nosso Senhor Jesus Cristo, fortaleça-vos em todo bem,
    e pelo poder do Espírito Santo vos conserve na vida eterna. Amém.
  TEXT
  lt.language = 'pt-BR'
end

# Invocation
LiturgicalText.find_or_create_by!(slug: 'invocation', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'invocation'
  lt.content = 'Oficiante: Senhor, abre os nossos lábios.\nPovo: E a nossa boca anunciará o teu louvor.'
  lt.language = 'pt-BR'
end

# Canticles
LiturgicalText.find_or_create_by!(slug: 'venite', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Vinde, cantemos ao Senhor,
    aclamemos a Rocha da nossa salvação.
    Apresentemo-nos diante dele com ações de graça,
    e celebremo-lo com salmos de louvor.

    Porque o Senhor é Deus grande
    e Rei supremo acima de todos os deuses.
    Nas suas mãos estão as profundezas da terra,
    e as alturas dos montes são suas.

    Seu é o mar, pois ele o fez,
    e as suas mãos formaram a terra seca.

    Vinde, adoremos e prostremo-nos,
    ajoelhemo-nos diante do Senhor que nos fez.
    Porque ele é o nosso Deus,
    e nós somos o povo do seu pasto e as ovelhas da sua mão.

    Glória ao Pai, e ao Filho, e ao Espírito Santo;
    como era no princípio, é agora e sempre será,
    pelos séculos dos séculos. Amém.
  TEXT
  lt.reference = 'Salmo 95:1-7'
  lt.language = 'pt-BR'
end

LiturgicalText.find_or_create_by!(slug: 'jubilate', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Celebrai com júbilo ao Senhor, todas as terras!
    Servi ao Senhor com alegria,
    apresentai-vos diante dele com cântico.

    Sabei que o Senhor é Deus;
    foi ele quem nos fez, e dele somos;
    somos o seu povo e rebanho do seu pasto.

    Entrai por suas portas com ações de graça,
    e nos seus átrios com louvor;
    rendei-lhe graças e bendizei o seu nome.

    Porque o Senhor é bom, a sua misericórdia dura para sempre,
    e a sua fidelidade, de geração em geração.

    Glória ao Pai, e ao Filho, e ao Espírito Santo;
    como era no princípio, é agora e sempre será,
    pelos séculos dos séculos. Amém.
  TEXT
  lt.reference = 'Salmo 100'
  lt.language = 'pt-BR'
end

# Creeds
LiturgicalText.find_or_create_by!(slug: 'apostles_creed', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'creed'
  lt.content = <<~TEXT
    Creio em Deus Pai, Todo-Poderoso,
    Criador do céu e da terra.

    Creio em Jesus Cristo, seu único Filho, nosso Senhor,
    o qual foi concebido por obra do Espírito Santo;
    nasceu da Virgem Maria;
    padeceu sob o poder de Pôncio Pilatos,
    foi crucificado, morto e sepultado;
    desceu ao Hades;
    ressurgiu dos mortos ao terceiro dia;
    subiu ao céu;
    está sentado à direita de Deus Pai Todo-Poderoso,
    donde há de vir para julgar os vivos e os mortos.

    Creio no Espírito Santo;
    na santa Igreja universal;
    na comunhão dos santos;
    na remissão dos pecados;
    na ressurreição do corpo;
    na vida eterna. Amém.
  TEXT
  lt.language = 'pt-BR'
end

# Lord's Prayer
LiturgicalText.find_or_create_by!(slug: 'lords_prayer_traditional', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Pai nosso, que estás nos céus,
    santificado seja o teu Nome,
    venha o teu Reino,
    faça-se a tua vontade,
    assim na terra como no céu.
    O pão nosso de cada dia dá-nos hoje.
    Perdoa-nos as nossas ofensas,
    assim como nós perdoamos aos que nos ofenderam.
    E não nos deixes cair em tentação,
    mas livra-nos do mal.
    Porque teu é o Reino, o poder e a glória,
    para sempre. Amém.
  TEXT
  lt.language = 'pt-BR'
end

# Collects
LiturgicalText.find_or_create_by!(slug: 'collect_peace', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Ó Deus, fonte de toda santa aspiração, de todo bom conselho e de toda obra justa:
    Dá aos teus servos aquela paz que o mundo não pode dar,
    para que os nossos corações se disponham a guardar os teus mandamentos,
    e removido de nós o temor dos inimigos,
    os nossos dias, pela tua proteção, sejam de paz;
    por Jesus Cristo, nosso Senhor. Amém.
  TEXT
  lt.language = 'pt-BR'
end

LiturgicalText.find_or_create_by!(slug: 'collect_grace', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Ó Senhor, nosso Deus celestial, que afastaste de nós as trevas da noite
    e nos iluminaste com a luz do dia:
    Assim como nós te glorificamos pelo brilho desta luz criada,
    Concede-nos a graça para que, iluminados pela luz do teu Santo Espírito,
    possamos glorificar-te para sempre;
    por Jesus Cristo, nosso Senhor. Amém.
  TEXT
  lt.language = 'pt-BR'
end

# General Thanksgiving
LiturgicalText.find_or_create_by!(slug: 'general_thanksgiving', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Pai Todo-Poderoso, doador de todo bem,
    Nós, teus indignos servos, te damos graças muito humildes
    por toda a tua bondade e amorável bondade para conosco e para com todos os homens.
    Bendizemos-te pela nossa criação, preservação,
    e por todas as bênçãos desta vida;
    mas acima de tudo, pelo teu incomensurável amor
    na redenção do mundo por nosso Senhor Jesus Cristo,
    pelos meios da graça e pela esperança da glória.
    E oramos, dá-nos aquele devido senso de todas as tuas misericórdias,
    para que os nossos corações possam ser sinceramente gratos;
    e para que mostremos o nosso louvor, não somente com os nossos lábios,
    mas nas nossas vidas,
    dedicando-nos ao teu serviço,
    e andando diante de ti em santidade e retidão todos os nossos dias;
    por Jesus Cristo, nosso Senhor,
    a quem contigo e com o Espírito Santo seja toda honra e glória,
    pelos séculos dos séculos. Amém.
  TEXT
  lt.language = 'pt-BR'
end

# Prayer of St. Chrysostom
LiturgicalText.find_or_create_by!(slug: 'chrysostom_prayer', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Deus Todo-Poderoso, que nos deste a graça de, em uníssono,
    apresentarmos as nossas comuns súplicas;
    e prometeste que quando dois ou três se ajuntarem em teu Nome,
    atenderás aos seus pedidos:
    Realiza agora, ó Senhor, os desejos e petições dos teus servos,
    como for melhor para eles,
    concedendo-nos neste mundo o conhecimento da tua verdade,
    e no mundo vindouro a vida eterna. Amém.
  TEXT
  lt.language = 'pt-BR'
end

# Dismissal
LiturgicalText.find_or_create_by!(slug: 'dismissal', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'dismissal'
  lt.content = 'A graça de nosso Senhor Jesus Cristo, e o amor de Deus, e a comunhão do Espírito Santo seja com todos vós.'
  lt.reference = '2 Coríntios 13:13'
  lt.language = 'pt-BR'
end

puts "Created #{LiturgicalText.count} liturgical texts"
