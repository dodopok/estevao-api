# frozen_string_literal: true

Rails.logger.info "🌙 Carregando textos Ofício Vespertino 2 (LOCB 2008)..."

prayer_book = PrayerBook.find_by!(code: 'locb_2008')

# ==============================================================================
# ORAÇÃO VESPERTINA II - Introdução
# ==============================================================================

# Rubrica inicial
LiturgicalText.find_or_create_by!(slug: 'evening_2_introduction_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'O Ministro pode usar uma Oração própria do tempo antes de usar uma ou mais das Orações penitenciais abaixo'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_introduction_rubric_2', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'O Ministro introduz o serviço'
  text.category = 'rubric'
end

# ==============================================================================
# CONVITE À CONFISSÃO - Opção 1
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_2_confession_invitation_1_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Convite à Confissão'
  text.content = 'Amados irmãos, a Escritura nos recomenda em vários lugares a reconhecer e confessar nossa maldade e muitos pecados. E que não devemos encobri-los ou fugir da face do Senhor, nosso Pai celestial; antes, temos que confessá-los com humildade e com um coração penitente e obediente, a fim de recebermos o perdão por sua infinita bondade e clemência. E embora devamos humildemente e a toda hora reconhecer os nossos pecados diante do Senhor, devemos fazê-lo especialmente agora, quando estamos juntos neste encontro de fé para agradecermos pelos grandes benefícios que recebemos de suas mãos, louvá-lo por suas tão preciosas bênçãos e entregar-lhe todo nosso corpo e alma. Portanto, eu oro e peço, junto com todos vocês aqui presentes, a me acompanhar com um coração puro e voz humilde, até o trono da graça, dizendo junto comigo:'
  text.category = 'confession'
end

# ==============================================================================
# CONVITE À CONFISSÃO - Opção 2
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_2_confession_invitation_2_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Convite à Confissão'
  text.content = 'Amados, estamos juntos na presença de Deus Todo-poderoso e da companhia inteira do céu, indo até Ele por intermédio de nosso Senhor Jesus Cristo, para prestar nossa adoração, louvor e ações de graça; fazermos a confissão de nossos muitos pecados; orarmos uns pelos outros e por nós mesmos, pois conhecemos a grandeza do seu amor e reconhecemos o fruto de sua graça em nós e sua bem-aventurança na vida daqueles que guardam teus mandamentos. Portanto, ajoelhemo-nos em silêncio, e lembremos de sua presença viva conosco aqui.'
  text.category = 'confession'
end

# ==============================================================================
# CONFISSÃO
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_2_confession_prayer_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Confissão'
  text.content = 'Todo-poderoso e Pai extremamente misericordioso, nós erramos e vagamos como ovelhas perdidas. Nós seguimos muito os dispositivos e desejos de nossos próprios corações. Nós transgredimos tuas leis santas. Fizemos o que não devíamos fazer e não fizemos o que devíamos. Por isso, estamos cansados e tristes. Mas tu, ó Deus, tenha compaixão de nós, pecadores miseráveis. Perdoa as nossas transgressões, pois a Ti as confessamos. Restaura o que é penitente, de acordo com promessas declaradas aos homens em Cristo Jesus, nosso Senhor. E concede, ó Pai, por Ele, que possamos viver uma vida santa, íntegra e sóbria daqui por diante, para a glória de teu santo e glorioso nome. Amém.'
  text.category = 'confession'
end

# ==============================================================================
# DECLARAÇÃO DE PERDÃO
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_2_absolution_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Um Ministro clérigo dirá'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_absolution_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Declaração de Perdão'
  text.content = 'Deus Todo-poderoso, Pai de nosso Senhor Jesus Cristo, que não desejas a morte do ímpio, mas a sua conversão; e que determinaste à tua Igreja seres a anunciadora desta graça aos arrependidos, perdoa e absolva os nossos pecados. Agora, em verdadeiro arrependimento, concede-nos o Espírito Santo para que possamos fazer tudo o que te agrade nesta vida. Tem compaixão de nós, perdoa as nossas ofensas, nos sustente na prática do bem e nos conduza, um dia, à glória da vida eterna.'
  text.category = 'absolution'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_absolution_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Amém.'
  text.category = 'absolution'
end

# Alternativa para outro Ministro
LiturgicalText.find_or_create_by!(slug: 'evening_2_absolution_local_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Ou outro Ministro poderá dizer'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_absolution_local_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Declaração de Perdão (Ministro Local)'
  text.content = 'Concede, nós pedimos a ti, Deus misericordioso, o perdão e paz aos teus filhos e que eles possam, purificados de todos seus pecados, servir-te com integridade de vida; por Jesus Cristo, nosso Senhor.'
  text.category = 'absolution'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_absolution_local_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Amém.'
  text.category = 'absolution'
end

# ==============================================================================
# ORAÇÃO VESPERTINA - Responsos
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_2_response_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Oração Vespertina'
  text.content = 'Estes responsos são usados'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_response_1_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Ó Senhor, abre os meus lábios,'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_response_1_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E minha boca anunciará os teus louvores.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_response_2_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Ó Deus, vem depressa salvar-nos!'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_response_2_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Ó Senhor, apressa-te em socorrer-nos!'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_response_3_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Glória ao Pai, ao Filho e ao Espírito Santo.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_response_3_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Como era no princípio, é agora e será sempre, por séculos sem fim. Amém.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_response_4_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Louvado seja nosso Senhor Jesus Cristo!'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_response_4_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Para sempre seja louvado!'
  text.category = 'response'
end

# ==============================================================================
# SALMODIA
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_2_psalms_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Salmodia'
  text.content = 'Cada Salmo ou grupo de Salmos deve terminar com a Doxologia que segue. Para os Ofícios diários, os Salmos são indicados no Lecionário, pp.347 a 358:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_psalms_gloria_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Glória ao Pai, ao Filho e ao Espírito Santo.'
  text.category = 'psalms'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_psalms_gloria_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'psalms'
end

# ==============================================================================
# LEITURA DO ANTIGO TESTAMENTO
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_2_ot_reading_response_reader', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Esta é a palavra do Senhor.'
  text.category = 'readings'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_ot_reading_response_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Graças a Deus.'
  text.category = 'readings'
end

# ==============================================================================
# MAGNIFICAT (Lucas 1:46-55) - Cântico da Virgem Maria
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_2_magnificat_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Cântico da Virgem Maria (Lc 1:46-55)'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_magnificat', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Magnificat'
  text.content = 'A minha alma engrandece ao Senhor, e o meu espírito se alegrou em Deus, meu Salvador,
**porque contemplou na humildade da sua serva. Pois, desde agora, todas as gerações me considerarão bem-aventurada, porque o poderoso me fez grandes coisas. Santo é o seu nome.**
A sua misericórdia vai de geração em geração sobre os que o temem. Agiu com o seu braço valorosamente; dispersou os que, no coração, alimentavam pensamentos soberbos.
**Derribou do seu trono os poderosos e exaltou os humildes.
Encheu de bens os famintos e despediu vazios os ricos.**
Amparou a Israel, seu servo, a fim de lembrar-se da sua misericórdia a favor de Abraão e de sua descendência, para sempre, como prometera aos nossos pais.'
  text.category = 'magnificat'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_magnificat_gloria_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Glória ao Pai, ao Filho e ao Espírito Santo.'
  text.category = 'magnificat'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_magnificat_gloria_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'magnificat'
end

# ==============================================================================
# CANTATE DOMINO (Salmo 98) - Alternativa "Ou"
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_2_cantate_domino_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = '(Salmo 98) ou outro Hino ou cântico de louvor'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_cantate_domino', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Cantate Domino'
  text.content = 'Cantai ao Senhor um cântico novo, porque ele tem feito maravilhas; a sua destra e o seu braço santo lhe alcançaram a vitória.
**O Senhor fez notória a sua salvação; manifestou a sua justiça perante os olhos das nações.**
Lembrou-se da sua misericórdia e da sua fidelidade para com a casa de Israel; todos os confins da terra viram a salvação do nosso Deus.
**Celebrai com júbilo ao Senhor, todos os confins da terra; aclamai, regozijai-vos e cantai louvores.**
Cantai com harpa louvores ao Senhor, com harpa e voz de canto; com trombetas e ao som de buzinas, exultai perante o Senhor, que é rei.
**Ruja o mar e a sua plenitude, o mundo e os que nele habitam.**
Os rios batam palmas, e juntos cantem de júbilo os montes,
**na presença do Senhor, porque ele vem julgar a terra; julgará o mundo com justiça e os povos, com equidade.**'
  text.category = 'cantate_domino'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_cantate_domino_gloria_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Glória ao Pai, ao Filho e ao Espírito Santo.'
  text.category = 'cantate_domino'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_cantate_domino_gloria_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'cantate_domino'
end

# ==============================================================================
# LEITURA DO NOVO TESTAMENTO
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_2_nt_reading_response_reader', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Esta é a palavra do Senhor.'
  text.category = 'readings'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_nt_reading_response_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Graças a Deus.'
  text.category = 'readings'
end

# ==============================================================================
# NUNC DIMITTIS (Lucas 2:29-32)
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_2_nunc_dimittis_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = '(Lucas 2:29-32)'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_nunc_dimittis', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Nunc dimittis'
  text.content = 'Agora, Senhor, podes despedir em paz o teu servo, segundo a tua palavra;
**porque os meus olhos já viram a tua salvação,**
a qual preparaste diante de todos os povos:
**luz para revelação aos gentios, e para glória do teu povo de Israel.**'
  text.category = 'nunc_dimittis'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_nunc_dimittis_gloria_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Glória ao Pai, ao Filho e ao Espírito Santo.'
  text.category = 'nunc_dimittis'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_nunc_dimittis_gloria_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'nunc_dimittis'
end

# ==============================================================================
# DEUS MISEREATUR (Salmo 67) - Alternativa "Ou"
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_2_deus_misereatur_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = '(Salmo 67) ou outro Hino ou cântico'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_deus_misereatur', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Deus misereatur'
  text.content = 'Seja Deus gracioso para conosco, e nos abençoe, e faça resplandecer sobre nós o rosto;
**para que se conheça na terra o teu caminho e, em todas as nações, a tua salvação.**
Louvem-te os povos, ó Deus; louvem-te os povos todos.
**Alegrem-se e exultem as gentes, pois julgas os povos com equidade e guias na terra as nações.**
Louvem-te os povos, ó Deus; louvem-te os povos todos.
**A terra deu o seu fruto, e Deus, o nosso Deus, nos abençoa.**
Abençoe-nos Deus, e todos os confins da terra o temerão.'
  text.category = 'deus_misereatur'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_deus_misereatur_gloria_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Glória ao Pai, ao Filho e ao Espírito Santo.'
  text.category = 'deus_misereatur'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_deus_misereatur_gloria_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'deus_misereatur'
end

# ==============================================================================
# AFIRMAÇÃO DE FÉ
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_2_creed_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Afirmação de Fé'
  text.content = '(p.612)'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_creed_apostolic', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Credo dos Apóstolos'
  text.content = 'Creio em Deus Pai Todo-poderoso, Criador do Céu e da Terra; e em Jesus Cristo seu único Filho, nosso Senhor: o qual foi concebido por obra do Espírito Santo, nasceu da Virgem Maria; padeceu sob o poder de Pôncio Pilatos, foi crucificado, morto e sepultado; desceu ao Hades; ressuscitou ao terceiro dia; subiu ao céu, e está sentado à mão direita de Deus Pai Todo-poderoso: donde há de vir a julgar os vivos e os mortos. Creio no Espírito Santo; na santa Igreja Católica; na comunhão dos santos; na remissão dos pecados; na ressurreição do corpo; e na Vida Eterna. Amém.'
  text.category = 'creed'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_creed_nicene', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Credo Niceno-Constantinopolitano'
  text.content = 'Creio em um só Deus, Pai Onipotente, Criador do céu e da terra, de todas as coisas visíveis e invisíveis. E em um só Senhor Jesus Cristo, Filho Unigênito de Deus, nascido do Pai antes de todos os séculos: Deus de Deus, Luz de Luz, Deus verdadeiro de Deus verdadeiro, gerado, não feito, consubstancial ao Pai; por quem todas as coisas foram feitas. O qual por nós homens e para nossa salvação desceu dos céus; e encarnou pelo Espírito Santo, no seio da Virgem Maria, e se fez homem. Também por nós foi crucificado sob Pôncio Pilatos; padeceu e foi sepultado. E ressuscitou ao terceiro dia, segundo as Escrituras; e subiu ao céu; e está sentado à direita do Pai. De novo há de vir com glória, para julgar os vivos e os mortos; e o seu reino não terá fim. Creio no Espírito Santo, Senhor e Vivificador, que procede do Pai e do Filho; e com o Pai e o Filho é juntamente adorado e glorificado; o qual falou pelos profetas. Creio na Igreja Una, Santa, Católica e Apostólica. Confesso um só batismo para remissão dos pecados. E espero a ressurreição dos mortos e a vida do mundo vindouro. Amém.'
  text.category = 'creed'
end

# ==============================================================================
# ORAÇÕES
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_2_prayers_1_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'O Senhor seja convosco.'
  text.category = 'prayers'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_prayers_1_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E com o teu espírito.'
  text.category = 'prayers'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_prayers_2_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Oremos. Senhor, tem piedade de nós.'
  text.category = 'prayers'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_prayers_2_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Cristo, tem piedade de nós.'
  text.category = 'prayers'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_prayers_3_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Senhor, tem piedade de nós.'
  text.category = 'prayers'
end

# Pai Nosso
LiturgicalText.find_or_create_by!(slug: 'evening_2_lords_prayer_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Pai Nosso'
  text.content = 'Pai nosso, que estás nos céus, santificado seja o teu nome. Venha o teu Reino, seja feita a tua vontade, assim na terra como no céu. O pão nosso de cada dia nos dá hoje. E perdoa-nos as nossas dívidas, assim como nós perdoamos aos nossos devedores. E não nos deixes cair em tentação, mas livra-nos do mal; pois teu é o Reino, e o poder, e a glória para sempre. Amém.'
  text.category = 'lords_prayer'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_prayers_4_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Ó Deus, tem compaixão de nós.'
  text.category = 'prayers'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_prayers_4_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E nos conceda a tua salvação.'
  text.category = 'prayers'
end

# Sufrágio
LiturgicalText.find_or_create_by!(slug: 'evening_2_suffrage_1_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Ó Deus, auxilie o Presidente.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_suffrage_1_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E misericordiosamente nos ouve quando nós chamarmos a ti.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_suffrage_2_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Dota os Ministros de tua retidão.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_suffrage_2_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E faz teus escolhidos felizes.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_suffrage_3_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Ó Deus, salve o teu povo.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_suffrage_3_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E abençoa a herança de Jacó.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_suffrage_4_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Dê paz em nosso tempo, ó Deus.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_suffrage_4_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Porque não há nenhum outro que nos salve, mas só tu, Senhor.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_suffrage_5_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Cria em nós um puro coração, ó Deus,'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_suffrage_5_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E não retires de nós teu Santo Espírito.'
  text.category = 'suffrage'
end

# ==============================================================================
# A COLETA DO DIA
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_2_collect_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'A Coleta do Dia'
  text.content = '(no Próprio do tempo, ver Lecionário pp.347 a 358)'
  text.category = 'rubric'
end

# ==============================================================================
# A COLETA PELA PAZ
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_2_collect_peace', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'A Coleta pela Paz'
  text.content = 'Ó Deus, Autor da paz e amante da concórdia, em cujo conhecimento se encontra a vida eterna, e a quem servir é ter perfeita liberdade, defende-nos, humildes servos teus, em todos os ataques de nossos inimigos, de tal forma que nós, seguros por Tua defesa, não temamos o poder de nossos adversários, mediante Jesus Cristo nosso Senhor. Amém.'
  text.category = 'collect'
end

# ==============================================================================
# A COLETA POR AJUDA CONTRA TODOS OS PERIGOS
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_2_collect_dangers', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'A Coleta Por Ajuda Contra Todos os Perigos'
  text.content = 'Ilumine a escuridão, nós te pedimos, ó Senhor e através de tua grande misericórdia nos defenda de todos os perigos da vida e dos perigos desta noite; por amor de teu Filho, nosso Senhor Jesus Cristo. Amém.'
  text.category = 'collect'
end

# ==============================================================================
# FIM DO SERVIÇO - Rubricas
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_2_end_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'A ordem para o fim do serviço pode incluir:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_hymn_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Hinos ou cânticos'
  text.content = 'Hinos ou cânticos'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_sermon_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Um Sermão'
  text.content = 'Um Sermão'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_other_prayers_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Outras Orações'
  text.content = 'Outras Orações'
  text.category = 'rubric'
end

# ==============================================================================
# CONCLUSÃO - A Graça
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_2_conclusion_grace_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'A Graça'
  text.content = 'A Graça de nosso Senhor Jesus Cristo, o amor do Pai e a comunhão do Espírito Santo seja com todos nós.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_conclusion_grace_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Amém.'
  text.category = 'conclusion'
end

# ==============================================================================
# CONCLUSÃO - A Despedida (Alternativa "Ou")
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_2_conclusion_dismissal_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Ou'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_conclusion_dismissal_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Despedida'
  text.content = 'Ide na paz de Cristo! Sede corajosos e fortes no testemunho do Evangelho entre todas as pessoas. Servi ao Senhor com a alegria.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_conclusion_dismissal_people', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'No poder do Espírito Santo.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'evening_2_conclusion_dismissal_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Aleluia!'
  text.category = 'conclusion'
end

Rails.logger.info 'LOCB 2008 Evening Prayer II liturgical texts created successfully!'
