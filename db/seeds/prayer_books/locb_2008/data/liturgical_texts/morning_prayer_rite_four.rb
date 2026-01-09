Rails.logger.info "📿 Carregando textos Ofício Matutino 4 - BCP 1928 (LOCB 2008)..."

prayer_book = PrayerBook.find_by!(code: 'locb_2008')

# ==============================================================================
# ORAÇÃO MATUTINA IV (BCP, 1928)
# ==============================================================================

# Rubrica inicial
LiturgicalText.find_or_create_by!(slug: 'morning_4_opening_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'O Ministro principiará a Oração Matutina lendo uma ou mais das seguintes Sentenças da Escritura.'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_rubric_fasting', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Em qualquer dia, exceto nos dias de Jejum ou de Abstinência, ou quando se seguir imediatamente a Litania ou a Santa Comunhão, pode o Ministro, à sua discrição, passar logo das Sentenças para a Oração Dominical, dizendo do primeiro: O Senhor seja convosco.'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_rubric_confession_omission', prayer_book_id: prayer_book.id) do |text|
    text.content = 'E note-se, quando forem omitidas a Confissão e a Absolvição, o Ministro pode passar das Sentenças para os Versículos: Abre, ó Senhor, os nossos lábios, etc., e neste caso a Oração Dominical será dito com as outras orações, logo depois de o Senhor seja convosco, etc., e antes dos Versículos e Responsos subsequentes, ou na Litania, como ali indicado.'
  text.category = 'rubric'
end

# ==============================================================================
# SENTENÇAS DA ESCRITURA
# ==============================================================================

# Sentença geral
LiturgicalText.find_or_create_by!(slug: 'morning_4_sentence_general_1', prayer_book_id: prayer_book.id) do |text|
    text.content = 'O Senhor, porém, está no seu santo templo; cale-se diante dele toda a terra.'
  text.reference = 'Hab 2:20'
  text.category = 'scripture_sentence'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_sentence_general_2', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Alegrei-me quando me disseram: Vamos à Casa do Senhor.'
  text.reference = 'Salmo 122:1'
  text.category = 'scripture_sentence'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_sentence_general_3', prayer_book_id: prayer_book.id) do |text|
    text.content = 'As palavras dos meus lábios e o meditar do meu coração sejam agradáveis na tua presença, Senhor, rocha minha e redentor meu!'
  text.reference = 'Salmo 19:14'
  text.category = 'scripture_sentence'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_sentence_general_4', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Envia a tua luz e a tua verdade, para que elas me guiem; e me levem ao teu santo monte e a teus tabernáculos.'
  text.reference = 'Salmo 43:3'
  text.category = 'scripture_sentence'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_sentence_general_5', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Porque assim diz o Alto, o Sublime, que habita a eternidade, o qual tem o nome de Santo: Habito no alto e santo lugar, mas habito também com o contrito e abatido de espírito, para vivificar o espírito dos abatidos e vivificar o coração dos contritos.'
  text.reference = 'Isaías 57:15'
  text.category = 'scripture_sentence'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_sentence_general_6', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Mas vem a hora e já chegou, em que os verdadeiros adoradores adorarão o Pai em espírito e em verdade; porque são estes que o Pai procura para seus adoradores.'
  text.reference = 'João 4:23'
  text.category = 'scripture_sentence'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_sentence_general_7', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Graça e paz a vós outros, da parte de Deus, nosso Pai, e do Senhor Jesus Cristo.'
  text.reference = 'Fil 1:2'
  text.category = 'scripture_sentence'
end

# Sentenças do Advento
LiturgicalText.find_or_create_by!(slug: 'morning_4_sentence_advent_1', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Advento'
  text.content = 'Preparai o caminho do Senhor; endireitai no ermo vereda a nosso Deus.'
  text.reference = 'Isaías 40:3'
  text.category = 'scripture_sentence'
end

# Sentenças do Natal
LiturgicalText.find_or_create_by!(slug: 'morning_4_sentence_christmas', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Natal'
  text.content = 'Não temais; eis aqui vos trago boa-nova de grande alegria, que o será para todo o povo: é que hoje vos nasceu, na cidade de Davi, o Salvador, que é Cristo, o Senhor.'
  text.reference = 'Lucas 2:10-11'
  text.category = 'scripture_sentence'
end

# Sentenças da Epifania
LiturgicalText.find_or_create_by!(slug: 'morning_4_sentence_epiphany_1', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Epifania'
  text.content = 'Mas, desde o nascente do sol até ao poente, é grande entre as nações o meu nome; e em todo lugar lhe é queimado incenso e trazidas ofertas puras, porque o meu nome é grande entre as nações, diz o Senhor dos Exércitos.'
  text.reference = 'Mal 1:11'
  text.category = 'scripture_sentence'
end

# Sentenças Penitenciais
LiturgicalText.find_or_create_by!(slug: 'morning_4_sentence_penitential_1', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Desperta, desperta, reveste-te da tua fortaleza, ó Sião; veste-te das tuas roupagens formosas, ó Jerusalém, cidade santa.'
  text.reference = 'Isaías 52:1'
  text.category = 'scripture_sentence'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_sentence_penitential_2', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Rasgai o vosso coração, e não as vossas vestes, e convertei-vos ao Senhor, vosso Deus, porque ele é misericordioso, e compassivo, e tardio em irar-se, e grande em benignidade, e se arrepende do mal.'
  text.reference = 'Joel 2:13'
  text.category = 'scripture_sentence'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_sentence_penitential_3', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Sacrifícios agradáveis a Deus são o espírito quebrantado; coração compungido e contrito, não o desprezarás, ó Deus.'
  text.reference = 'Salmo 51:17'
  text.category = 'scripture_sentence'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_sentence_penitential_4', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Levantar-me-ei, e irei ter com o meu pai, e lhe direi: Pai, pequei contra o céu e diante de ti; já não sou digno de ser chamado teu filho.'
  text.reference = 'Lucas 15:18-19'
  text.category = 'scripture_sentence'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_sentence_penitential_5', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Não vos comove isto, a todos vós que passais pelo caminho? Considerai e vede se há dor igual à minha, que veio sobre mim, com que o Senhor me afligiu no dia do furor da sua ira.'
  text.reference = 'Lam 1:12'
  text.category = 'scripture_sentence'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_sentence_penitential_6', prayer_book_id: prayer_book.id) do |text|
    text.content = 'No qual temos a redenção, pelo seu sangue, a remissão dos pecados, segundo a riqueza da sua graça.'
  text.reference = 'Ef 1:7'
  text.category = 'scripture_sentence'
end

# Sentenças da Páscoa
LiturgicalText.find_or_create_by!(slug: 'morning_4_sentence_easter', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Não vos atemorizeis; buscais a Jesus, o Nazareno, que foi crucificado; ele ressuscitou, não está aqui; Realmente, o Senhor ressurgiu. Realmente o Senhor ressurgiu.'
  text.reference = 'Marcos 16:6; Lucas 24:34'
  text.category = 'scripture_sentence'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_sentence_easter_2', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Este é o dia que o Senhor fez; regozijemo-nos e alegremo-nos nele.'
  text.reference = 'Salmo 118:24'
  text.category = 'scripture_sentence'
end

# Sentenças da Ascensão e Pentecostes
LiturgicalText.find_or_create_by!(slug: 'morning_4_sentence_ascension', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Tendo, pois, a Jesus, o Filho de Deus, como grande Sumo Sacerdote que penetrou os céus, conservemos firmes a nossa confissão. Acheguemo-nos, portanto, confiadamente, junto ao trono da graça, a fim de recebermos misericórdia e acharmos graça para socorro em ocasião oportuna.'
  text.reference = 'Heb 4:14,16'
  text.category = 'scripture_sentence'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_sentence_pentecost_1', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Mas recebereis poder, ao descer sobre vós o Espírito Santo, e sereis minhas testemunhas tanto em Jerusalém como em toda a Judéia e Samaria e até aos confins da terra.'
  text.reference = 'Atos 1:8'
  text.category = 'scripture_sentence'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_sentence_pentecost_2', prayer_book_id: prayer_book.id) do |text|
    text.content = 'E, porque vós sois filhos, enviou Deus ao nosso coração o Espírito de seu Filho, que clama: Aba, Pai!'
  text.reference = 'Gal 4:6'
  text.category = 'scripture_sentence'
end

# Sentença da Trindade
LiturgicalText.find_or_create_by!(slug: 'morning_4_sentence_trinity', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Santo, Santo, Santo é o Senhor Deus, o Todo-poderoso, aquele que era, que é e que há de vir.'
  text.reference = 'Apoc 4:8'
  text.category = 'scripture_sentence'
end

# Sentença de Ação de Graças
LiturgicalText.find_or_create_by!(slug: 'morning_4_sentence_thanksgiving', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Honra ao Senhor com os teus bens e com as primícias de toda a tua renda; e se encherão fartamente os teus celeiros, e transbordarão de vinho os teus lagares.'
  text.reference = 'Prov 3:9-10'
  text.category = 'scripture_sentence'
end

# ==============================================================================
# EXORTAÇÃO À CONFISSÃO
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_4_exhortation_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Então o Ministro dirá:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_exhortation_long', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Exortação'
  text.content = 'Meus irmãos muito amados, a Escritura nos exorta em diversos lugares, a que reconheçamos e confessemos nossos muitos pecados e maldade, declarando que não devemos dissimulá-los nem encobri-los perante a face do Onipotente Deus, nosso Pai celeste; mas confessá-los com o coração humilde, submisso, contrito e obediente, a fim de alcançarmos perdão deles, por sua infinita bondade e misericórdia. E posto que, em todos os tempos, devamos fazer humilde confissão de nossos pecados diante de Deus, todavia, este dever se torna principalmente necessário, quando nos congregamos, a lhe dar graças pelos imensos benefícios nos há feito, publicar os seus louvores, ouvir a sua Santíssima Palavra, e pedir-lhe o que havemos mister para nossos corpos e almas. Rogo, pois, e concito a todos vós aqui presentes que, com puro coração e voz humilde, me acompanheis ao trono da celeste graça, dizendo:'
  text.category = 'confession'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_exhortation_short_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Ou dirá:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_exhortation_short', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Confessemos humildemente os nossos pecados a Deus Todo-poderoso.'
  text.category = 'confession'
end

# ==============================================================================
# CONFISSÃO GERAL
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_4_confession_rubric', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Confissão Geral'
  text.content = 'Para ser dita pela Congregação, juntamente com o Ministro, estando todos ajoelhados'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_confession_prayer_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Ó Deus Onipotente e Pai misericordioso; temos errado e temo-nos apartado dos teus caminhos quais ovelhas desgarradas. Temos por demais seguido os caprichos e desejos de nossos corações. Pecamos contra as tuas santas leis. Deixamos de fazer o que devíamos ter feito, e temos feito o que não devíamos fazer. Nada há em nós que esteja são. Tu, porém, ó Senhor, tem misericórdia de nós, pobres pecadores. Perdoa, ó Deus, aos que confessam as suas culpas. Restaura os que são penitentes, segundo as tuas promessas declaradas ao gênero humano. Em Cristo Jesus nosso Senhor. E concede por amor dele, ó Pai de misericórdia, que de hoje em diante levemos vida sóbria, justa e pia. À glória de teu santo nome. Amém.'
  text.category = 'confession'
end

# ==============================================================================
# DECLARAÇÃO DE ABSOLVIÇÃO OU REMISSÃO DE PECADOS
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_4_absolution_rubric', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Declaração de Absolvição ou Remissão de Pecados'
  text.content = 'Para ser pronunciado unicamente pelo Presbítero, estando este de pé e conservando-se o povo ajoelhado. O Presbítero, à sua discrição, pode usar, em lugar da que segue, a Absolvição que se acha na Ordem para a Santa Comunhão'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_absolution_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Deus Todo-poderoso, Pai de nosso Senhor Jesus Cristo, que não deseja a morte do pecador, porém que se converta da sua maldade e viva, deu a seus Ministros poder, e ordem, para declarar e pronunciar ao seu povo arrependido a Absolvição e a Remissão dos seus pecados. Deus perdoa e absolve a todos os que verdadeiramente se arrependem e creem sinceros no seu santo Evangelho. Roguemos-lhe, pois, que nos dê um verdadeiro arrependimento, e o seu Santo Espírito, a fim de que as obras que ora fazemos lhe sejam agradáveis; seja a nossa vida, de hoje em diante, pura e santa; e assim alcancemos, finalmente, a bem-aventurança eterna; por Jesus Cristo nosso Senhor. Amém.'
  text.category = 'absolution'
end

# ==============================================================================
# ORAÇÃO DOMINICAL
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_4_lords_prayer_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Ajoelhando-se, então, o Ministro dirá com o povo a Oração Dominical; e o povo a repetirá com ele, não só aqui, mas em qualquer outro lugar em que for usada no Ofício Divino'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_lords_prayer_all', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Oração Dominical'
  text.content = 'Pai nosso, que estás nos céus, santificado seja o teu nome. Venha o teu Reino, seja feita a tua vontade, assim na terra como no céu. O pão nosso de cada dia nos dá hoje. E perdoa-nos as nossas dívidas, assim como nós perdoamos aos nossos devedores. E não nos deixes cair em tentação, mas livra-nos do mal; pois teu é o Reino, e o poder, e a glória para sempre. Amém.'
  text.category = 'lords_prayer'
end

# ==============================================================================
# VERSÍCULOS E RESPONSOS
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_4_versicles_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Então dirá também:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_versicle_1_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Abre, ó Senhor, os nossos lábios.'
  text.category = 'versicle'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_versicle_1_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'E a nossa boca anunciará os teus louvores.'
  text.category = 'versicle'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_versicles_rubric_2', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Aqui, levantam-se todos, e o Ministro dirá:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_versicle_2_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Glória ao Pai, e ao Filho, e ao Espírito Santo.'
  text.category = 'versicle'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_versicle_2_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'versicle'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_versicle_3_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Louvai ao Senhor.'
  text.category = 'versicle'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_versicle_3_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'O nome do Senhor seja louvado.'
  text.category = 'versicle'
end

# ==============================================================================
# VENITE / CÂNTICO
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_4_venite_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Então se dirá ou se entoará o Cântico seguinte; exceto nos dias para os quais estiverem designados outros cânticos; ou quando se usar o Salmo 95 neste lugar; na quarta-feira da Paixão se pode omitir o Venite.'
  text.category = 'rubric'
end

# ==============================================================================
# ANTÍFONAS DO VENITE
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_4_venite_antiphon_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Nos dias abaixo indicados, logo antes do Venite pode ser contado ou dito:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_venite_antiphon_advent', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Advento'
  text.content = 'Nosso Rei e Salvador aproxima-se; *Vinde, adoremo-lo.'
  text.category = 'antiphon'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_venite_antiphon_christmas', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Natal e até Epifania'
  text.content = 'Aleluia. Porque a nós nos é nascido um menino; *Vinde, adoremo-lo. Aleluia.'
  text.category = 'antiphon'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_venite_antiphon_epiphany', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Epifania e até sete dias depois, e na Festa da Transfiguração'
  text.content = 'O Senhor manifestou a sua glória; *Vinde, adoremo-lo.'
  text.category = 'antiphon'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_venite_antiphon_easter', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Segunda-feira da Semana da Páscoa, e até o dia da Ascensão'
  text.content = 'Aleluia. Ressuscitou verdadeiramente o Senhor; *Vinde adoremo-lo. Aleluia.'
  text.category = 'antiphon'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_venite_antiphon_ascension', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Dia da Ascensão e até Pentecostes'
  text.content = 'Aleluia. Cristo Senhor subiu ao céu; *Vinde, adoremo-lo. Aleluia.'
  text.category = 'antiphon'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_venite_antiphon_pentecost', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Dia de Pentecostes e até seis dias depois'
  text.content = 'Aleluia. O Espírito do Senhor enche o mundo; *Vinde, adoremo-lo. Aleluia.'
  text.category = 'antiphon'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_venite_antiphon_trinity', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Domingo da Trindade'
  text.content = 'O Pai, o Filho, o Espírito Santo, um só Deus; *Vinde, adoremo-lo.'
  text.category = 'antiphon'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_venite_antiphon_purification', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Dias da Purificação e da Anunciação'
  text.content = 'O Verbo se fez carne e habitou entre nós; *Vinde adoremo-lo.'
  text.category = 'antiphon'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_venite_antiphon_feasts', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Outras Festas para as quais há Epístola e Evangelho próprios'
  text.content = 'O Senhor é glorioso nos seus santos; *Vinde, adoremo-lo.'
  text.category = 'antiphon'
end

# ==============================================================================
# VENITE, EXULTEMOS DOMINO
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_4_venite', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Venite, exultemos Domino'
  text.content = 'Vinde, cantemos ao Senhor; *jubilemos à rocha da nossa salvação.
**Cheguemos ante a sua face com ação de graças; e celebremos em salmos o seu louvor.**
Porque o Senhor é Deus supremo, *e Rei de excelsa majestade.
**Guarda em sua mão os abismos da terra, *e as alturas dos montes são suas.**
Seu é o mar, pois ele o fez, *e a terra firme suas mãos formaram.
**Ó vinde adoremos e prostremo-nos; *ajoelhemos ante o Senhor, que nos criou.**
Porque ele é o nosso Deus, *e nós, o povo que ele pastoreia, o rebanho que sua mão conduz.
**Adorai ao Senhor na beleza da santidade; *trema à sua presença toda a terra.**
Porque ele vem, sim vem julgar a terra; *julgará o mundo com justiça, e os povos com a sua verdade.'
  text.category = 'canticle'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_venite_gloria_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Então seguirá uma porção dos Salmos, conforme o uso desta Igreja. E no fim de cada Salmo, como também ao fim do Venite, Benedictus es, Benedictus, Jubilate, pode-se cantar ou dizer o Gloria Patri, o qual é de rigor ao fim da porção inteira ou da Seleção do Saltério.'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_gloria_patri_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Glória ao Pai, e ao Filho, *e ao Espírito Santo.'
  text.category = 'canticle'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_gloria_patri_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'canticle'
end

# ==============================================================================
# LEITURAS - RUBRICAS
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_4_first_reading_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Ler-se-á então a Primeira Lição, segundo o Calendário. E note-se que antes da cada Lição o Ministro deverá dizer:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_reading_introduction', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Aqui começa o capítulo {{chapter}} (ou o versículo {{verse}} do capítulo {{chapter}}) do Livro de {{book_name}}; e depois de cada Lição: Aqui termina a Primeira (ou a Segunda) Lição.'
  text.category = 'minister'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_canticle_after_first_reading_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Dir-se-á ou cantar-se-á aqui o Hino que segue. Note-se, porém, que em qualquer dia em que se celebre a Santa Comunhão, poderá o Ministro, à sua discrição, depois de se dizer ou entoar qualquer dos seguintes Cânticos da Oração Matutina, passar imediatamente ao Ofício da Comunhão.'
  text.category = 'rubric'
end

# ==============================================================================
# TE DEUM LAUDAMUS
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_4_te_deum', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Te Deum laudamus'
  text.content = 'A Ti, ó Deus, louvamos, e por Senhor nosso confessamos.
A Ti, ó eterno Pai, adora toda a terra.
A Ti os Anjos todos, a ti clamam os Céus e todas as Potestades.
A Ti os Querubins e os Serafins proclamam com incessante voz;
Santo, Santo, Santo, Senhor Deus das Celestes hostes;
Os céus e a terra estão plenos da Majestade da tua glória.
A Ti louva o glorioso coro dos Apóstolos,
A Ti louva o triunfante exército dos Mártires.
A Ti confessa pela amplidão do orbe a santa Igreja:
Pai da infinita majestade;
A Teu Filho unigênito, vero e adorável;
E ao Espírito Santo, o Consolador.
Tu és o Rei da glória, ó Cristo.
Tu és do Pai o sempiterno Filho.
Tu, ao empreender a redenção do homem, te humilhaste a nascer duma Virgem.
Tu, vencido o aguilhão da morte, abriste aos crentes o Reino dos céus.
Tu, à destra de Deus te assentas na glória do Pai.
Cremos seres tu o Juiz vindouro.
Eis porque te rogamos socorras a teus servos, os quais com sangue precioso redimiste.
Conta-os com os teus santos na glória sempiterna.
Salva o teu povo, ó Senhor, e abençoa a tua herança.
Governa-o e exalta-o eternamente.
De dia em dia te bendizemos;
E louvamos teu nome pelos séculos sem fim.
Digna-te, ó Senhor, guardar-nos hoje sem pecado.
Tem misericórdia de nós, Senhor, tem misericórdia de nós.
Seja sobre nós, Senhor, a tua misericórdia, assim como em ti confiamos.
Em ti, Senhor, tenho esperado; não me deixes nunca ser confundido.'
  text.category = 'canticle'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_te_deum_alternative_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Ou este Cântico'
  text.category = 'rubric'
end

# ==============================================================================
# BENEDICTUS ES, DOMINE
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_4_benedictus_es', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Benedictus es, Domine'
  text.content = 'Bendito és tu, Senhor Deus de nossos pais; *digno de louvor e de glória para sempre.
**Bendito o santo nome de tua Majestade; *digno de louvor e de glória para sempre.**
Bendito és tu no templo de tua santidade; *digno de louvor e de glória para sempre.
**Bendito és tu que sondas os abismos, e presides acima dos Querubins; *digno de louvor e de glória para sempre.**
Bendito és tu sobre o glorioso trono do teu reino; *digno de louvor e de glória para sempre.
**Bendito és tu no firmamento dos céus; *digno de louvor e de glória para sempre.**'
  text.category = 'canticle'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_benedicite_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Ou este'
  text.category = 'rubric'
end

# ==============================================================================
# BENEDICITE, OMNIA OPERA DOMINI
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_4_benedicite', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Benedicite, omnia opera Domini'
  text.content = 'Bendigam ao Senhor todas as suas Obras: *louvem-no e magnifiquem-no para sempre.
**Bendigam ao Senhor os seus Anjos: *louvem-no e magnifiquem-no para sempre.**
Bendigam os Céus ao Senhor: *louvem-no e magnifiquem-no para sempre.
**Bendigam ao Senhor as Águas acima do firmamento: louvem-no e magnifiquem-no para sempre.**
Bendigam ao Senhor as suas Potestades: *louvem-no e magnifiquem-no para sempre.
**Bendigam ao Senhor o Sol e a Lua: *louvem-no e magnifiquem-no para sempre.**
Bendigam ao Senhor as Estrelas do céu: *louvem-no e magnifiquem-no para sempre.
**Bendigam ao Senhor a Chuva e o Orvalho: *louvem-no e magnifiquem-no para sempre.**
Bendigam ao Senhor os Ventos, ministros seus: *louvem-no e magnifiquem-no para sempre.
**Bendigam ao Senhor o Fogo e o Calor: *louvem-no e magnifiquem-no para sempre.**
Bendigam ao Senhor o Inverno e o Verão: *louvem-no e magnifiquem-no para sempre.
**Bendigam ao Senhor os Orvalhos e a Geada: *louvem-no e magnifiquem-no para sempre.**
Bendigam ao Senhor o Gelo e o Frio: *louvem-no e magnifiquem-no para sempre.
**Bendigam ao Senhor os Gelos e a Neve: *louvem-no e magnifiquem-no para sempre.**
Bendigam ao Senhor as Noites e os Dias: *louvem-no e magnifiquem-no para sempre.
**Bendigam ao Senhor a Luz e as Trevas: *louvem-no e magnifiquem-no para sempre.**
Bendigam ao Senhor os Relâmpagos e as Nuvens: *louvem-no e magnifiquem-no para sempre.
**Bendigam a Terra ao Senhor: *louvem-no e magnifiquem-no para sempre.**
Bendigamos ao Senhor os Montes e os Outeiros: *louvem-no e magnifiquem-no para sempre.
**Bendigam ao Senhor a Vegetação da terra: *louvem-no e magnifiquem-no para sempre.**
Bendigam as Fontes ao Senhor: *louvem-no e magnifiquem-no para sempre.
**Bendigam ao Senhor os Mares e os Rios: *louvem-no e magnifiquem-no para sempre.**
Bendigam ao Senhor os Seres que se movem nas águas: *louvem-no e magnifiquem-no para sempre.
**Bendigam ao Senhor as Aves do céu: *louvem-no e magnifiquem-no para sempre.**
Bendigam ao Senhor as Alimárias (Animais) da terra: *louvem-no e magnifiquem-no para sempre.
**Bendigam os Filhos dos homens ao Senhor: *louvem-no e magnifiquem-no para sempre.**
Bendiga Israel ao Senhor: *louvem-no e magnifiquem-no para sempre.
**Bendigam ao Senhor os seus Ministros: *louvem-no e magnifiquem-no para sempre.**
Bendigam ao Senhor os seus Servos: *louvem-no e magnifiquem-no para sempre.
**Bendigam ao Senhor os Espíritos e as Almas dos justos: *louvem-no e magnifiquem-no para sempre.**
Bendigam ao Senhor os Santos e os de humilde coração: *louvem-no e magnifiquem-no para sempre.
**Bendigamos ao Pai, e ao Filho, e ao Espírito Santo: * louvem-no e magnifiquem-no para sempre.**'
  text.category = 'canticle'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_second_reading_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Ler-se-á, de igual modo, a Segunda Lição, do Novo Testamento, conforme o Lecionário. Dir-se-á, ou cantar-se-á depois o cântico seguinte, podendo, exceto nos domingos do Advento, omitir-se a última parte dele'
  text.category = 'rubric'
end

# ==============================================================================
# BENEDICTUS
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_4_benedictus', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Benedictus'
  text.reference = 'Lucas 1:68'
  text.content = 'Bendito seja o Senhor, Deus de Israel, porque visitou e redimiu o seu povo,
e nos suscitou plena e poderosa salvação na casa de Davi, seu servo,
como prometera, desde a antiguidade, por boca dos seus santos profetas,
para nos libertar dos nossos inimigos e das mãos de todos os que nos odeiam;
para usar de misericórdia com os nossos pais e lembrar-se da sua santa aliança
e do juramento que fez a Abraão, o nosso pai,
de conceder-nos que, livres das mãos de inimigos, o adorássemos sem temor,
em santidade e justiça perante ele, todos os nossos dias.
Tu, menino, serás chamado profeta do Altíssimo, porque precederás o Senhor, preparando-lhe os caminhos,
para dar ao seu povo conhecimento da salvação, no redimi-lo dos seus pecados,
graças à entranhável misericórdia de nosso Deus, pela qual nos visitará o sol nascente das alturas,
para alumiar os que jazem nas trevas e na sombra da morte, e dirigir os nossos pés pelo caminho da paz.'
  text.category = 'canticle'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_jubilate_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Ou este Salmo'
  text.category = 'rubric'
end

# ==============================================================================
# JUBILATE DEO
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_4_jubilate', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Jubilate Deo'
  text.reference = 'Salmo 100'
  text.content = 'Celebrai com júbilo ao Senhor, todas as terras.
**Servi ao Senhor com alegria, apresentai-vos diante dele com cântico.**
Sabei que o Senhor é Deus; foi ele quem nos fez, e dele somos; somos o seu povo e rebanho do seu pastoreio.
**Entrai por suas portas com ações de graças e nos seus átrios, com hinos de louvor; rendei-lhe graças e bendizei-lhe o nome.**
Porque o Senhor é bom, a sua misericórdia dura para sempre, e, de geração em geração, a sua fidelidade.'
  text.category = 'canticle'
end

# ==============================================================================
# CREDO DOS APÓSTOLOS
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_4_creed_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Dir-se-á então o Símbolo dos Apóstolos, estando de pé o Ministro e povo:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_creed_all', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Credo dos Apóstolos'
  text.content = 'Creio em Deus Pai Todo-poderoso, Criador do Céu e da Terra; e em Jesus Cristo seu único Filho, nosso Senhor: o qual foi concebido por obra do Espírito Santo, nasceu da Virgem Maria; padeceu sob o poder de Pôncio Pilatos, foi crucificado, morto e sepultado; desceu ao Hades; ressuscitou ao terceiro dia; subiu ao céu, e está sentado à mão direita de Deus Pai Todo-poderoso: donde há de vir a julgar os vivos e os mortos. Creio no Espírito Santo; na santa Igreja Católica; na comunhão dos santos; na remissão dos pecados; na ressurreição do corpo; e na Vida Eterna. Amém.'
  text.category = 'creed'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_nicene_creed_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Ou o Credo comumente chamado Niceno'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_nicene_creed_all', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Credo Niceno'
  text.content = 'Creio em um só Deus Pai Onipotente, Criador do céu e da terra, e de todas as coisas visíveis e invisíveis. E em um só Senhor Jesus Cristo, Filho unigênito de Deus; gerado de seu Pai antes de todos os mundos, Deus de Deus, Luz de Luz, Verdadeiro Deus de Verdadeiro Deus; gerado, não feito; consubstancial com o Pai; por quem todas as coisas foram feitas: o qual por nós homens e pela nossa salvação desceu do céu, e encarnou, por obra do Espírito Santo, da Virgem Maria, e foi feito homem: foi também crucificado por nós, sob o poder de Pôncio Pilatos; padeceu e foi sepultado; e ao terceiro dia ressuscitou, segundo as Escrituras; e subiu ao céu, e está sentado à mão direita do Pai; e virá outra vez com glória, a julgar os vivos e os mortos; e o seu reino não terá fim. E creio no Espírito Santo, Senhor, e Doador da Vida, procedente do Pai e do Filho; o qual com o Pai e o Filho juntamente é adorado e glorificado; O qual falou pelos profetas; e creio na Igreja Una, Santa, Católica e Apostólica; reconheço um só batismo para remissão de pecados; e espero a ressurreição dos mortos; e a vida do mundo vindouro. Amém.'
  text.category = 'creed'
end

# ==============================================================================
# SÚPLICAS
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_4_suffrages_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Far-se-ão depois as Súplicas seguintes, estando o povo devotamente ajoelhado. Dirá o Ministro em primeiro lugar:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_suffrage_1_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'O Senhor seja convosco.'
  text.category = 'suffrages'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_suffrage_1_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'E com teu espírito.'
  text.category = 'suffrages'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_suffrage_2_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Oremos.'
  text.category = 'suffrages'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_lords_prayer_suffrage_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Dir-se-á aqui a Oração Dominical, se ainda não se tiver dito'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_suffrage_3_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Mostra-nos, Senhor, a tua misericórdia.'
  text.category = 'suffrages'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_suffrage_3_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'E concede-nos a tua salvação.'
  text.category = 'suffrages'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_suffrage_4_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Cria em nós, ó Deus, um coração puro.'
  text.category = 'suffrages'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_suffrage_4_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'E não retires de nós o teu Espírito Santo.'
  text.category = 'suffrages'
end

# ==============================================================================
# COLETA DO DIA
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_4_collect_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Seguir-se-á a Coleta do Dia (pp.280 a 333), exceto quando se ler o Ofício da Comunhão'
  text.category = 'rubric'
end

# ==============================================================================
# COLETA PELA PAZ
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_4_collect_peace', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Coleta pela Paz'
  text.content = 'Ó Deus, que és da paz o autor e amigo, a quem conhecer é possuir a vida eterna e a quem servir é reinar; protege de todos os assaltos aos que, humildes, te invocam; a fim de que, confiados na tua defesa, não tenhamos de recear as forças de hostilidade alguma; mediante o poder de Jesus Cristo nosso Senhor. Amém.'
  text.category = 'collect'
end

# ==============================================================================
# COLETA PELA GRAÇA
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_4_collect_grace', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Coleta pela Graça'
  text.content = 'Ó Senhor, nosso Pai celestial, Todo-poderoso e eterno Deus, que nos trouxeste em segurança até o começo deste dia; defende-nos hoje com teu grande poder, não permitindo que caiamos em pecados ou nos exponhamos, descuidados, a qualquer perigo; e concede que nossos pensamentos e ações, ordenados por tua providência, sejam retos a teus olhos; mediante Jesus Cristo, nosso Senhor. Amém.'
  text.category = 'collect'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_optional_prayers_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'As seguintes Orações serão omitidos aqui quando se disser a Litania; e podem omitir-se quando imediatamente seguir a Santa Comunhão. E note-se que o Ministro pode terminar aqui a Oração Matutina com as intercessões gerais tiradas deste Livro que julgar apropriadas, ou com a Graça.'
  text.category = 'rubric'
end

# ==============================================================================
# ORAÇÃO PELO PRESIDENTE DA REPÚBLICA E AUTORIDADES CIVIS
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_4_prayer_president', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Oração pelo Presidente da República e por todas as Autoridades Civis'
  text.content = 'Ó Senhor, nosso Pai celeste, alto e poderoso Governador do universo, que do teu trono vês todos os que habitam na terra; de todo o coração te suplicamos que contemples com favor e abençoes teu servo, o Presidente da República e as demais autoridades; supre-os de tal maneira com a graça de teu Santo Espírito, que sempre se inclinem a fazer a tua vontade e andar nas tuas veredas. Reveste-os abundantemente de dons celestiais; concede-lhes um longo viver com saúde e prosperidade; e que, finalmente, depois desta existência, alcancem perene alegria e felicidade; por Jesus Cristo nosso Senhor. Amém.'
  text.category = 'prayers'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_prayer_president_alt_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Ou esta'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_prayer_president_alt', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Ó Senhor, que nos governas, e de quem a glória enche toda a terra; ao teu misericordioso cuidado encomendamos nossa Pátria, a fim de que, guiados por tua Providência, habitemos em tua paz e em segurança. Concede ao Presidente da República e a todas as outras Autoridades, sabedoria e força para conhecer e praticar a tua vontade. Enche-os de amor à verdade e à justiça. Faze-os sempre zelosos de sua missão para servirem este povo no temor do teu santo nome; mediante Jesus Cristo nosso Senhor, que vive e reina contigo e o Espírito Santo, um só Deus, pelos séculos sem fim. Amém.'
  text.category = 'prayers'
end

# ==============================================================================
# ORAÇÃO PELO CLERO E POVO
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_4_prayer_clergy', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Oração pelo Clero e Povo'
  text.content = 'Onipotente e sempiterno Deus, do qual mana toda boa dádiva e dom perfeito; envia lá do alto sobre os nossos Bispos, todo o Clero e as Congregações confiadas a seus cuidados, o salutar Espírito da tua graça; e, para que deveras te agradem, esparge continuamente sobre eles o orvalho de tua benção. Concede-nos isto, ó Senhor, à honra de nosso Advogado e Mediador Jesus Cristo. Amém.'
  text.category = 'prayers'
end

# ==============================================================================
# ORAÇÃO POR TODA A HUMANIDADE
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_4_prayer_humanity', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Oração por toda a Humanidade'
  text.content = 'Ó Deus, Criador e Preservador de todo o gênero humano, intercedemos humildemente pelos homens de todas as classes e condições; digna-te fazer-lhes conhecidos os teus caminhos; e manifesta a todas as nações a tua eterna salvação. E oramos especialmente a favor de tua santa Igreja universal; a fim de que ela seja de tal maneira guiada e governada por teu Santo Espírito, que todos os que professam a religião de teu Filho e se chamam cristãos, sejam conduzidos no caminho da verdade, e guardem a fé, em unidade de espírito, no vínculo da paz e em retidão de vida. Encomendamos finalmente à tua paternal bondade todos os que de qualquer modo se achem aflitos ou perturbados na consciência, no corpo ou na situação da vida; (*particularmente aqueles por quem as nossas orações são desejadas). Praza a ti confortá-los e aliviá-los, segundo as suas necessidades; dando-lhes paciência no sofrimento e termo feliz em suas aflições. E isto nós te rogamos por amor de Jesus Cristo. Amém.'
  text.category = 'prayers'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_prayer_humanity_note', prayer_book_id: prayer_book.id) do |text|
    text.content = '*Esta frase poderá ser usada quando alguém desejar as orações da Congregação'
  text.category = 'rubric'
end

# ==============================================================================
# GERAL DE AÇÃO DE GRAÇAS
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_4_general_thanksgiving', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Geral de Ação de Graças'
  text.content = 'Onipotente Deus, Pai de toda a misericórdia, nós, teus indignos servos, rendemos-te as mais humildes e sinceras graças por toda a tua benevolência e carinhosa bondade para conosco e para com todos os homens; (*particularmente para com aqueles que desejam agora oferecer seus louvores e ações de graças pelas últimas mercês que lhes tens concedido). Nós te bendizemos por nossa criação, preservação, e por todas as bênçãos desta vida: principalmente pelo teu inestimável amor na redenção do mundo por nosso Senhor Jesus Cristo, pelos meios de graça, e esperança da glória. A ti rogamos nos concedas tal apreciação de tuas misericórdias, que nossos corações se encham de sincera gratidão e que publiquemos teus louvores não somente com os nossos lábios, mas com as nossas vidas, entregando-nos inteiramente ao teu serviço e andando perante ti em santidade e retidão todos os nossos dias. Por Jesus Cristo nosso Senhor, a quem, contigo e o Espírito Santo, seja toda a honra e glória, por séculos sem fim. Amém.'
  text.category = 'prayers'
end

LiturgicalText.find_or_create_by!(slug: 'morning_4_general_thanksgiving_note', prayer_book_id: prayer_book.id) do |text|
    text.content = '*Esta frase poderá ser usada quando alguém desejar render graças por alguma bênção recebida'
  text.category = 'rubric'
end

# ==============================================================================
# ORAÇÃO DE SÃO CRISÓSTOMO
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_4_prayer_chrysostom', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Oração de São Crisóstomo'
  text.content = 'Deus Todo-poderoso, que nos deste hoje a graça de, concordemente reunidos, te dirigirmos as nossas preces, prometendo que onde se congregassem dois ou três em teu nome atenderias aos seus rogos; cumpre agora, ó Senhor, os desejos e orações de teus servos, segundo a estes mais convier, concedendo-nos neste mundo conhecimento da tua verdade e, no vindouro, a vida eterna. Amém.'
  text.category = 'prayers'
end

# ==============================================================================
# GRAÇA (CONCLUSÃO)
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_4_grace', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Graça'
  text.reference = '2 Cor 13:13'
  text.content = 'A Graça de nosso Senhor Jesus Cristo, e o amor de Deus, e a comunhão do Espírito Santo, seja com todos nós para sempre. Amém.'
  text.category = 'conclusion'
end

Rails.logger.info 'LOCB 2008 Morning Prayer IV (BCP 1928) liturgical texts created successfully!'
