# frozen_string_literal: true

Rails.logger.info "🌙 Carregando textos Ofício Vespertino 4 - BCP 1928 (LOCB 2008)..."

prayer_book = PrayerBook.find_by!(code: 'locb_2008')

# ==============================================================================
# ORAÇÃO VESPERTINA IV (BCP, 1928)
# ==============================================================================

# Rubrica inicial
LiturgicalText.find_or_create_by!(slug: 'evening_4_opening_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'O Ministro principiará a Oração Vespertina lendo uma ou mais das seguintes Sentenças da Escritura; e depois dirá o que se seguir a elas. Pode, porém, à sua discrição, passar imediatamente das Sentenças para a Oração Dominical.'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_rubric_confession_omission', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E note-se que, quando forem omitidas a Confissão e a Absolvição, o Ministro pode passar das Sentenças para os Versículos: Abre, ó Senhor, os nossos lábios, etc., caso em que a Oração Dominical será dita com as outras Orações, logo depois de: O Senhor seja convosco, etc., e antes dos Versículos e Responsos subsequentes.'
  text.category = 'rubric'
end

# ==============================================================================
# SENTENÇAS DA ESCRITURA
# ==============================================================================

# Sentenças gerais
LiturgicalText.find_or_create_by!(slug: 'evening_4_sentence_general_1', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'O Senhor, porém, está no seu santo templo; cale-se diante dele toda a terra.'
  text.reference = 'Hab 2:20'
  text.category = 'scripture_sentence'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_sentence_general_2', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Eu amo, Senhor, a habitação de tua casa e o lugar onde tua glória assiste.'
  text.reference = 'Salmo 26:8'
  text.category = 'scripture_sentence'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_sentence_general_3', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Suba à tua presença a minha oração, como incenso, e seja o erguer de minhas mãos como oferenda vespertina.'
  text.reference = 'Salmo 141:2'
  text.category = 'scripture_sentence'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_sentence_general_4', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Adorai ao Senhor na beleza da sua santidade; tremei diante dele, todas as terras.'
  text.reference = 'Salmo 96:9'
  text.category = 'scripture_sentence'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_sentence_general_5', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'As palavras dos meus lábios e o meditar do meu coração sejam agradáveis na tua presença, Senhor, rocha minha e redentor meu!'
  text.reference = 'Salmo 19:14'
  text.category = 'scripture_sentence'
end

# Sentença do Advento
LiturgicalText.find_or_create_by!(slug: 'evening_4_sentence_advent', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Advento'
  text.content = 'Vigiai, pois, porque não sabeis quando virá o dono da casa: se à tarde, se à meia-noite, se ao cantar do galo, se pela manhã; para que, vindo ele inesperadamente, não vos ache dormindo.'
  text.reference = 'Marcos 13:35-36'
  text.category = 'scripture_sentence'
end

# Sentença do Natal
LiturgicalText.find_or_create_by!(slug: 'evening_4_sentence_christmas', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Natal'
  text.content = 'Eis o tabernáculo de Deus com os homens. Deus habitará com eles. Eles serão povos de Deus, e Deus mesmo estará com eles.'
  text.reference = 'Apoc 21:3'
  text.category = 'scripture_sentence'
end

# Sentença da Epifania
LiturgicalText.find_or_create_by!(slug: 'evening_4_sentence_epiphany', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Epifania'
  text.content = 'As nações se encaminham para a tua luz, e os reis, para o resplendor que te nasceu.'
  text.reference = 'Isaías 60:3'
  text.category = 'scripture_sentence'
end

# Sentença da Quaresma
LiturgicalText.find_or_create_by!(slug: 'evening_4_sentence_lent', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Quaresma'
  text.content = 'Pois eu conheço as minhas transgressões, e o meu pecado está sempre diante de mim.'
  text.reference = 'Salmo 51:3'
  text.category = 'scripture_sentence'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_sentence_lent_2', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Ao Senhor, nosso Deus, pertence a misericórdia e o perdão, pois nos temos rebelado contra ele e não obedecemos à voz do Senhor, nosso Deus, para andarmos nas suas leis, que nos deu por intermédio de seus servos, os profetas.'
  text.reference = 'Dan 9:9-10'
  text.category = 'scripture_sentence'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_sentence_lent_3', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Se dissermos que não temos pecado nenhum, a nós mesmos nos enganamos, e a verdade não está em nós. Se confessarmos os nossos pecados, ele é fiel e justo para nos perdoar os pecados e nos purificar de toda injustiça.'
  text.reference = '1 João 1:8-9'
  text.category = 'scripture_sentence'
end

# Sentença da Sexta-feira da Paixão
LiturgicalText.find_or_create_by!(slug: 'evening_4_sentence_good_friday', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Sexta-feira da Paixão'
  text.content = 'Todos nós andávamos desgarrados como ovelhas; cada um se desviava pelo caminho, mas o Senhor fez cair sobre ele a iniquidade de nós todos.'
  text.reference = 'Isaías 53:6'
  text.category = 'scripture_sentence'
end

# Sentença da Páscoa
LiturgicalText.find_or_create_by!(slug: 'evening_4_sentence_easter', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Páscoa'
  text.content = 'Graças a Deus, que nos dá a vitória por intermédio de nosso Senhor Jesus Cristo.'
  text.reference = '1 Cor 15:57'
  text.category = 'scripture_sentence'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_sentence_easter_2', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Portanto, se fostes ressuscitados juntamente com Cristo, buscai as coisas lá do alto, onde Cristo vive, assentado à direita de Deus.'
  text.reference = 'Col 3:1'
  text.category = 'scripture_sentence'
end

# Sentença da Ascensão
LiturgicalText.find_or_create_by!(slug: 'evening_4_sentence_ascension', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Ascensão'
  text.content = 'Porque Cristo não entrou em santuário feito por mãos, figura do verdadeiro, porém no mesmo céu, para comparecer, agora, por nós, diante de Deus.'
  text.reference = 'Heb 9:24'
  text.category = 'scripture_sentence'
end

# Sentenças de Pentecostes
LiturgicalText.find_or_create_by!(slug: 'evening_4_sentence_pentecost_1', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Pentecostes'
  text.content = 'Há um rio, cujas correntes alegram a cidade de Deus, o santuário das moradas do Altíssimo.'
  text.reference = 'Salmo 46:4'
  text.category = 'scripture_sentence'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_sentence_pentecost_2', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'O Espírito e a noiva dizem: Vem! Aquele que ouve, diga: Vem! Aquele que tem sede venha, e quem quiser receba de graça a água da vida.'
  text.reference = 'Apoc 22:17'
  text.category = 'scripture_sentence'
end

# Sentença do Domingo da Trindade
LiturgicalText.find_or_create_by!(slug: 'evening_4_sentence_trinity', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Domingo da Trindade'
  text.content = 'Santo, santo, santo é o Senhor dos Exércitos; toda a terra está cheia da sua glória.'
  text.reference = 'Isaías 6:3'
  text.category = 'scripture_sentence'
end

# ==============================================================================
# EXORTAÇÃO À CONFISSÃO
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_4_exhortation_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'O Ministro dirá:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_exhortation_short', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Confessemos humildemente os nossos pecados a Deus Todo-poderoso.'
  text.category = 'confession'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_exhortation_alternative_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Ou dirá o que segue:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_exhortation_long', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Exortação'
  text.content = 'Meus irmãos muito amados, a Escritura nos exorta em diversos lugares, a que reconheçamos e confessemos nossos muitos pecados e maldade, declarando que não devemos dissimulá-los nem encobri-los perante a face do Onipotente Deus, nosso Pai celeste; mas confessá-los com o coração humilde, submisso, contrito e obediente, a fim de alcançarmos perdão deles, por sua infinita bondade e misericórdia. E posto que, em todos os tempos, devamos fazer humilde confissão de nossos pecados diante de Deus, todavia, este dever se torna principalmente necessário, quando nos congregamos, a lhe dar graças pelos imensos benefícios que nos há feito, publicar os seus louvores, ouvir a sua Santíssima Palavra, e pedir-lhe o que havemos mister para nossos corpos e almas. Rogo, pois, e concito a todos vós aqui presentes que, com puro coração e voz humilde, me acompanheis ao trono da celeste graça, dizendo:'
  text.category = 'confession'
end

# ==============================================================================
# CONFISSÃO GERAL
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_4_confession_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Confissão Geral'
  text.content = 'Para ser dita pela Congregação, juntamente com o Ministro, estando todos ajoelhados'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_confession_prayer_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Ó Deus Onipotente e Pai misericordioso; temos errado e temo-nos apartado dos teus caminhos quais ovelhas desgarradas. Temos por demais seguido os caprichos e desejos de nossos corações. Pecamos contra as tuas santas leis. Deixamos de fazer o que devíamos ter feito, e temos feito o que não devíamos fazer. Nada há em nós que esteja são. Tu, porém, ó Senhor, tem misericórdia de nós, pobres pecadores. Perdoa, ó Deus, aos que confessam as suas culpas. Restaura os que são penitentes, segundo as tuas promessas declaradas ao gênero humano, em Cristo Jesus nosso Senhor. E concede por amor dele, ó Pai de misericórdia, que de hoje em diante levemos vida sóbria, justa e pia. À glória de teu santo nome. Amém.'
  text.category = 'confession'
end

# ==============================================================================
# DECLARAÇÃO DE ABSOLVIÇÃO OU REMISSÃO DE PECADOS
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_4_absolution_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Declaração de Absolvição ou Remissão de Pecados'
  text.content = 'Para ser pronunciado unicamente pelo Presbítero, estando este de pé e conservando-se o povo ajoelhado'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_absolution_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'O Senhor seja convosco. Deus Todo-poderoso, Pai de nosso Senhor Jesus Cristo, que não deseja a morte do pecador, porém que se converta da sua maldade e viva, deu a seus Ministros poder, e ordem, para declarar e pronunciar ao seu povo arrependido a Absolvição e a Remissão dos seus pecados. Deus, perdoa e absolve a todos os que verdadeiramente se arrependem e creem sinceros no seu santo Evangelho. Roguemos-lhe, pois, que nos dê um verdadeiro arrependimento, e o seu Santo Espírito, a fim de que as obras que ora fazemos lhe sejam agradáveis; seja a nossa vida, de hoje em diante, pura e santa; e assim alcancemos, finalmente, a bem-aventurança eterna; por Jesus Cristo nosso Senhor.'
  text.category = 'absolution'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_absolution_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Amém.'
  text.category = 'absolution'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_absolution_alternative_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Ou esta:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_absolution_alternative', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'O Senhor Onipotente e misericordioso vos dê a Absolvição e Remissão de todos os vossos pecados, verdadeiro arrependimento, emenda de vida e a graça e consolação de seu Santo Espírito.'
  text.category = 'absolution'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_absolution_alternative_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Amém.'
  text.category = 'absolution'
end

# ==============================================================================
# ORAÇÃO DOMINICAL
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_4_lords_prayer_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Ajoelhando-se, então, o Ministro dirá com o povo a Oração Dominical'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_lords_prayer_invitation', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Oremos.'
  text.category = 'minister'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_lords_prayer_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Oração Dominical'
  text.content = 'Pai nosso, que estás nos céus, santificado seja o teu nome. Venha o teu Reino, seja feita a tua vontade, assim na terra como no céu. O pão nosso de cada dia nos dá hoje. E perdoa-nos as nossas dívidas, assim como nós perdoamos aos nossos devedores. E não nos deixes cair em tentação, mas livra-nos do mal; pois teu é o Reino, e o poder, e a glória para sempre. Amém.'
  text.category = 'lords_prayer'
end

# ==============================================================================
# VERSÍCULOS E RESPONSOS
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_4_versicles_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Então dirá também:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_versicle_1_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Abre, ó Senhor, os nossos lábios.'
  text.category = 'versicle'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_versicle_1_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E a nossa boca anunciará os teus louvores.'
  text.category = 'versicle'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_versicles_rubric_2', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Aqui, levantam-se todos, e o Ministro dirá:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_versicle_2_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Glória ao Pai e ao Filho e ao Espírito Santo.'
  text.category = 'versicle'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_versicle_2_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'versicle'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_versicle_3_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Louvai ao Senhor.'
  text.category = 'versicle'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_versicle_3_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'O nome do Senhor seja louvado.'
  text.category = 'versicle'
end

# ==============================================================================
# SALMODIA
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_4_psalmody_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Salmodia'
  text.content = 'Então seguirá uma porção dos Salmos, conforme o uso desta Igreja. E no fim de cada Salmo, bem como no fim do Magnificat, Cantate Domino, Bonum est confiteri, Nunc dimittis, Deus misereatur, Benedic, anima mea, pode-se cantar ou dizer o Gloria Patri; e no fim da porção inteira, ou da seleção dos Salmos para o dia, se cantará ou dirá o Gloria Patri, ou o Gloria in excelsis, como segue'
  text.category = 'rubric'
end

# ==============================================================================
# GLORIA IN EXCELSIS
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_4_gloria_in_excelsis_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Glória a Deus nas alturas, e na terra paz, boa vontade entre os homens.'
  text.category = 'canticle'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_gloria_in_excelsis_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Nós te louvamos, bendizemos, adoramos, glorificamos e te damos graças por tua grande glória. Ó Senhor Deus, Rei do Céu, Deus Pai Onipotente. Ó Senhor, unigênito Filho, Jesus Cristo; ó Senhor Deus, Cordeiro de Deus, Filho do Eterno Pai, que tiras os pecados do mundo, tem misericórdia de nós. Tu que tiras os pecados do mundo, recebe a nossa deprecação. Tu que estás sentado à destra de Deus Pai, tem misericórdia de nós. Porque só tu és o Senhor; só tu, ó Cristo, com o Espírito Santo, és altíssimo na glória de Deus Pai. Amém.'
  text.category = 'canticle'
end

# ==============================================================================
# PRIMEIRA LEITURA
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_4_first_reading_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Primeira Leitura'
  text.content = 'Depois se cantará ou dirá o Magnificat, como segue. Note-se, porém, que o Ministro pode, à sua discrição omitir uma das Lições da Oração Vespertina, seguindo-se à leitura da Lição um dos Cânticos da Oração Vespertina'
  text.category = 'rubric'
end

# ==============================================================================
# MAGNIFICAT
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_4_magnificat', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Magnificat'
  text.reference = 'Lucas 1:46'
  text.content = 'A minha alma engrandece ao Senhor,
**e o meu espírito se alegrou em Deus, meu Salvador,**
porque contemplou na humildade da sua serva. Pois, desde agora, todas as gerações me considerarão bem-aventurada,
**porque o poderoso me fez grandes coisas. Santo é o seu nome.**
A sua misericórdia vai de geração em geração sobre os que o temem. Agiu com o seu braço valorosamente; dispersou os que, no coração, alimentavam pensamentos soberbos.
**Derribou do seu trono os poderosos e exaltou os humildes.**
Encheu de bens os famintos e despediu vazios os ricos.
**Amparou a Israel, seu servo, a fim de lembrar-se da sua misericórdia**
a favor de Abraão e de sua descendência, para sempre, como prometera aos nossos pais.'
  text.category = 'canticle'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_magnificat_alternative_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Ou este Salmo'
  text.category = 'rubric'
end

# ==============================================================================
# CANTATE DOMINO (Salmo 98)
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_4_cantate_domino', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Cantate Domino'
  text.reference = 'Salmo 98'
  text.content = 'Cantai ao Senhor um cântico novo, porque ele tem feito maravilhas; a sua destra e o seu braço santo lhe alcançaram a vitória.
**O Senhor fez notória a sua salvação; manifestou a sua justiça perante os olhos das nações.**
Lembrou-se da sua misericórdia e da sua fidelidade para com a casa de Israel; todos os confins da terra viram a salvação do nosso Deus.
**Celebrai com júbilo ao Senhor, todos os confins da terra; aclamai, regozijai-vos e cantai louvores.**
Cantai com harpa louvores ao Senhor, com harpa e voz de canto; com trombetas e ao som de buzinas, exultai perante o Senhor, que é rei.
**Ruja o mar e a sua plenitude, o mundo e os que nele habitam.**
Os rios batam palmas, e juntos cantem de júbilo os montes, na presença do Senhor, porque ele vem julgar a terra; julgará o mundo com justiça e os povos, com equidade.'
  text.category = 'canticle'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_cantate_domino_alternative_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Ou este'
  text.category = 'rubric'
end

# ==============================================================================
# BONUM EST CONFITERI (Salmo 92)
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_4_bonum_est_confiteri', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Bonum est confiteri'
  text.reference = 'Salmo 92'
  text.content = 'Bom é render graças ao Senhor e cantar louvores ao teu nome, ó Altíssimo, anunciar de manhã a tua misericórdia e, durante as noites, a tua fidelidade, com instrumentos de dez cordas, com saltério e com a solenidade da harpa.
Pois me alegraste, Senhor, com os teus feitos; exultarei nas obras das tuas mãos.'
  text.category = 'canticle'
end

# ==============================================================================
# SEGUNDA LEITURA
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_4_second_reading_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Segunda Leitura'
  text.content = 'E em seguida cantar-se-á ou ler-se-á o Nunc dimittis como segue'
  text.category = 'rubric'
end

# ==============================================================================
# NUNC DIMITTIS
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_4_nunc_dimittis', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Nunc dimittis'
  text.reference = 'Lucas 2:29'
  text.content = 'Agora, Senhor, podes despedir em paz o teu servo, segundo a tua palavra; porque os meus olhos já viram a tua salvação, a qual preparaste diante de todos os povos: luz para revelação aos gentios, e para glória do teu povo de Israel.'
  text.category = 'canticle'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_nunc_dimittis_alternative_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Ou este Salmo'
  text.category = 'rubric'
end

# ==============================================================================
# DEUS MISEREATUR (Salmo 67)
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_4_deus_misereatur', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Deus misereatur'
  text.reference = 'Salmo 67'
  text.content = 'Seja Deus gracioso para conosco, e nos abençoe, e faça resplandecer sobre nós o rosto;
**para que se conheça na terra o teu caminho e, em todas as nações, a tua salvação.**
Louvem-te os povos, ó Deus; louvem-te os povos todos.
**Alegrem-se e exultem as gentes, pois julgas os povos com equidade e guias na terra as nações.**
Louvem-te os povos, ó Deus; louvem-te os povos todos.
**A terra deu o seu fruto, e Deus, o nosso Deus, nos abençoa.**
Abençoe-nos, Deus, e todos os confins da terra o temerão.'
  text.category = 'canticle'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_deus_misereatur_alternative_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Ou este'
  text.category = 'rubric'
end

# ==============================================================================
# BENEDIC, ANIMA MEA (Salmo 103)
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_4_benedic_anima_mea', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Benedic, anima mea'
  text.reference = 'Salmo 103'
  text.content = 'Bendize, ó minha alma, ao Senhor, e tudo o que há em mim bendiga ao seu santo nome.
**Bendize, ó minha alma, ao Senhor, e não te esqueças de nem um só de seus benefícios.**
Ele é quem perdoa todas as tuas iniquidades; quem sara todas as tuas enfermidades;
**quem da cova redime a tua vida e te coroa de graça e misericórdia;**
quem farta de bens a tua velhice, de sorte que a tua mocidade se renova como a da águia.
**O Senhor faz justiça e julga a todos os oprimidos.**
Manifestou os seus caminhos a Moisés e os seus feitos aos filhos de Israel.
**O Senhor é misericordioso e compassivo; longânimo e assaz benigno.**
Não repreende perpetuamente, nem conserva para sempre a sua ira.
**Não nos trata segundo os nossos pecados, nem nos retribui consoante as nossas iniquidades.**
Pois quanto o céu se alteia acima da terra, assim é grande a sua misericórdia para com os que o temem.
**Quanto dista o Oriente do Ocidente, assim afasta de nós as nossas transgressões.**
Como um pai se compadece de seus filhos, assim o Senhor se compadece dos que o temem.
**Pois ele conhece a nossa estrutura e sabe que somos pó.**
Quanto ao homem, os seus dias são como a relva; como a flor do campo, assim ele floresce;
**pois, soprando nela o vento, desaparece; e não conhecerá, daí em diante, o seu lugar.**
Mas a misericórdia do Senhor é de eternidade a eternidade, sobre os que o temem, e a sua justiça, sobre os filhos dos filhos,
**para com os que guardam a sua aliança e para com os que se lembram dos seus preceitos e os cumprem.**
Nos céus, estabeleceu o Senhor o seu trono, e o seu reino domina sobre tudo.
**Bendizei ao Senhor, todos os seus anjos, valorosos em poder, que executais as suas ordens e lhe obedeceis à palavra.**
Bendizei ao Senhor, todos os seus exércitos, vós, ministros seus, que fazeis a sua vontade.
**Bendizei ao Senhor, vós, todas as suas obras, em todos os lugares do seu domínio. Bendize, ó minha alma, ao Senhor.**'
  text.category = 'canticle'
end

# ==============================================================================
# SÍMBOLO DOS APÓSTOLOS
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_4_creed_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Dir-se-á então o Símbolo dos Apóstolos, estando de pé o Ministro e o Povo'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_apostles_creed', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Símbolo dos Apóstolos'
  text.content = 'Creio em Deus Pai Todo-poderoso, Criador do Céu e da Terra; e em Jesus Cristo seu único Filho, nosso Senhor: o qual foi concebido por obra do Espírito Santo, nasceu da Virgem Maria; padeceu sob o poder de Pôncio Pilatos, foi crucificado, morto e sepultado; desceu ao Hades; ressuscitou ao terceiro dia; subiu ao céu, e está sentado à mão direita de Deus Pai Todo-poderoso: donde há de vir a julgar os vivos e os mortos. Creio no Espírito Santo; na santa Igreja Católica; na comunhão dos santos; na remissão dos pecados; na ressurreição do corpo; e na Vida Eterna. Amém.'
  text.category = 'creed'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_nicene_creed_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Ou o Credo comumente chamado Niceno'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_nicene_creed', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Credo Niceno'
  text.content = 'Creio em um só Deus Pai Onipotente, Criador do Céu e da Terra, e de todas as coisas visíveis e invisíveis.
E em um só Senhor Jesus Cristo, Filho unigênito de Deus; gerado de seu Pai antes de todos os mundos, Deus de Deus, Luz de Luz, Verdadeiro Deus de Verdadeiro Deus; gerado, não feito; consubstancial com o Pai; por quem todas as coisas foram feitas: o qual por nós homens e pela nossa salvação desceu do céu, e encarnou, por obra do Espírito Santo, da Virgem Maria, e foi feito homem; foi também crucificado por nós, sob o poder de Pôncio Pilatos; padeceu e foi sepultado; e ao terceiro dia ressuscitou, segundo as Escrituras; e subiu ao céu, e está sentado à mão direita do Pai; e virá outra vez com glória, a julgar os vivos e os mortos; e o seu reino não terá fim.
E creio no Espírito Santo, Senhor, e Doador da Vida, procedente do Pai e do Filho; o qual com o Pai e o Filho juntamente é adorado e glorificado; o qual falou pelos profetas;
E creio na Igreja Una, Santa, Católica e Apostólica; reconheço um só batismo para remissão de pecados; e espero a ressurreição dos mortos; e a vida do mundo vindouro. Amém.'
  text.category = 'creed'
end

# ==============================================================================
# SÚPLICAS
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_4_suffrages_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Far-se-ão depois as seguintes Súplicas, estando o povo devotamente ajoelhando. O Ministro dirá em primeiro lugar.'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_suffrage_1_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'O Senhor seja convosco.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_suffrage_1_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E com teu espírito.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_suffrage_2_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Oremos.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_suffrages_lords_prayer_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Pai nosso, que estás nos céus, santificado seja o teu nome. Venha o teu Reino, seja feita a tua vontade, assim na terra como no céu. O pão nosso de cada dia nos dá hoje. E perdoa-nos as nossas dívidas, assim como nós perdoamos aos nossos devedores. E não nos deixes cair em tentação, mas livra-nos do mal; pois teu é o Reino, e o poder, e a glória para sempre. Amém.'
  text.category = 'lords_prayer'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_suffrages_lords_prayer_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = '(se já não tiver sido dita)'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_suffrage_3_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Mostra-nos, Senhor, a tua misericórdia.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_suffrage_3_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E concede-nos a tua salvação.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_suffrage_4_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Protege nossa Pátria, ó Senhor.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_suffrage_4_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E ouve-nos misericordioso, quando te invocamos.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_suffrage_5_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Reveste de virtude os teus Ministros.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_suffrage_5_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E de alegria os teus fiéis.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_suffrage_6_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Salva, Senhor, o teu povo.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_suffrage_6_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E abençoa a tua herança.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_suffrage_7_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Dá-nos paz em nossos dias, ó Senhor.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_suffrage_7_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Porque só tu nos fazes habitar em segurança.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_suffrage_8_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Cria em nós, ó Deus, um coração puro.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_suffrage_8_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E não retires de nós o teu Espírito Santo.'
  text.category = 'suffrage'
end

# ==============================================================================
# COLETAS
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_4_collect_day_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Seguirá a Coleta do Dia (pp.280 a 333)'
  text.category = 'rubric'
end

# Coleta pela Paz
LiturgicalText.find_or_create_by!(slug: 'evening_4_collect_peace', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Coleta pela Paz'
  text.content = 'Ó Deus, de quem procedem os desejos santos, os retos conselhos e os atos de justiça; concede a nós, teus servos, a paz que o mundo não nos pode dar, a fim de que nossos corações se dediquem a cumprir teus mandamentos, e, livres do temor de nossos inimigos, vivamos em paz e tranquilidade; pelos merecimentos de Jesus Cristo, nosso Senhor. Amém.'
  text.category = 'collect'
end

# Coleta Contra os Perigos da Noite
LiturgicalText.find_or_create_by!(slug: 'evening_4_collect_night_dangers', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Coleta Contra os Perigos da Noite'
  text.content = 'Ilumina, suplicamos-te, Senhor Deus, as nossas trevas; e misericordioso, defende-nos de todos os perigos e ciladas desta noite; por amor de teu único Filho, nosso Salvador Jesus Cristo. Amém.'
  text.category = 'collect'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_antiphon_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Nos lugares onde for conveniente, segue-se aqui a Antífona. O Ministro pode terminar aqui a Oração Vespertina com Oração ou Orações, extraídas deste Livro, como julgar conveniente'
  text.category = 'rubric'
end

# ==============================================================================
# ORAÇÕES OPCIONAIS
# ==============================================================================

# Oração pelo Presidente da República
LiturgicalText.find_or_create_by!(slug: 'evening_4_prayer_president', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Oração pelo Presidente da República, e por Todas as Autoridades Civis'
  text.content = 'Ó Deus Onipotente, de quem o reino é sempiterno e o poder infinito; seja a tua misericórdia sobre a pátria que nos deste, e digna-te reger de tal modo o coração dos teus servos, o Presidente da República, o Governador deste Estado, e todas as outras autoridades, a fim de que, reconhecendo de quem são Ministros em tudo promovam tua honra e glória; e que nós e todo o povo, considerando a precedência do poder que exercem, saibamos honrá-los com fidelidade e obediência, em ti e por ti, segundo tua bendita Palavra e ordenança; mediante Jesus Cristo, nosso Senhor, que contigo, e com o Espírito Santo, vive e reina sempre, um só Deus, por todos os séculos. Amém.'
  text.category = 'prayer'
end

# Oração pelo Clero e Povo
LiturgicalText.find_or_create_by!(slug: 'evening_4_prayer_clergy_people', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Oração pelo Clero e Povo'
  text.content = 'Onipotente e sempiterno Deus, do qual mana toda boa dádiva e dom perfeito; envia lá do alto sobre os nossos Bispos, todo o Clero e as Congregações confiadas a seus cuidados, o salutar Espírito da tua graça; e, para que deveras te agradem, esparge continuamente sobre eles o orvalho de tua benção. Concede-nos isto, ó Senhor, à honra de nosso Advogado e Mediador Jesus Cristo. Amém.'
  text.category = 'prayer'
end

# Oração por Toda a Humanidade
LiturgicalText.find_or_create_by!(slug: 'evening_4_prayer_humanity', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Oração por Toda a Humanidade'
  text.content = 'Ó Deus, Criador e Preservador de todo o gênero humano, intercedemos humildemente pelos homens de todas as classes e condições; digna-te fazer-lhes conhecidos os teus caminhos; e manifesta a todas as nações a tua eterna salvação. Intercedemos especialmente a favor de tua santa Igreja universal; a fim de que ela seja de tal maneira guiada e governada por teu Santo Espírito, que todos os que professam a religião de teu Filho e se chamam cristãos, sejam conduzidos no caminho da verdade, e guardem a fé, em unidade de espírito, no vínculo da paz e em retidão de vida. Encomendamos finalmente à tua paternal bondade todos os que de qualquer modo se achem aflitos ou perturbados na consciência, no corpo ou na situação da vida; (*particularmente aqueles por quem as nossas orações são desejadas.*) Praza a ti confortá-los e aliviá-los, segundo as suas necessidades; dando-lhes paciência no sofrimento e termo feliz em suas aflições. E isto nós te rogamos por amor de Jesus Cristo. Amém.'
  text.category = 'prayer'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_prayer_humanity_note', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = '* Esta frase poderá ser usada quando alguém desejar as Orações da Congregação.'
  text.category = 'rubric'
end

# ==============================================================================
# GERAL AÇÃO DE GRAÇAS
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_4_thanksgiving_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Geral Ação de Graças'
  text.content = 'Note-se que a Geral Ação de Graças pode ser dita conjuntamente pela Congregação e o Ministro'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_thanksgiving', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Onipotente Deus, Pai de toda a misericórdia, nós, teus indignos servos, rendemos-te as mais humildes e sinceras graças por toda a tua benevolência e carinhosa bondade para conosco e para com todos os homens; (*particularmente para com aqueles que desejam agora oferecer seus louvores e ações de graças pelas últimas mercês que lhes tens concedido*) nós te bendizemos por nossa criação, preservação, e por todas as bênçãos desta vida; principalmente por teu inestimável amor na redenção do mundo por nosso Senhor Jesus Cristo, pelos meios de graça, e esperança da glória. A ti rogamos nos concedas tal apreciação de tuas misericórdias. Que nossos corações se encham de sincera gratidão e que publiquemos teus louvores não somente com os nossos lábios, mas com as nossas vidas, entregando-nos inteiramente ao teu serviço e andando perante ti em santidade e retidão todos nossos dias. Por Jesus Cristo nosso Senhor, a quem, contigo e o Espírito Santo, seja toda a honra e glória, por séculos sem fim. Amém.'
  text.category = 'thanksgiving'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_thanksgiving_note', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = '*Esta frase poderá ser usado quando alguém desejar render graças por alguma benção recebida.'
  text.category = 'rubric'
end

# ==============================================================================
# ORAÇÃO DE SÃO CRISÓSTOMO
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_4_chrysostom_prayer', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Oração de São Crisóstomo'
  text.content = 'Deus Todo-poderoso, que nos deste hoje a graça de, concordemente reunidos, te dirigirmos as nossas preces, prometendo que onde se congregassem dois ou três em teu nome atenderias aos seus rogos; cumpre agora, ó Senhor, os desejos e orações de teus servos, segundo a estes mais convier, concedendo-nos neste mundo conhecimento da tua verdade e, no vindouro, a vida eterna. Amém.'
  text.category = 'prayer'
end

# ==============================================================================
# GRAÇA FINAL
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_4_grace', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Graça'
  text.reference = '2 Cor 13:13'
  text.content = 'A Graça de nosso Senhor Jesus Cristo, e o amor de Deus, e a comunhão do Espírito Santo, seja com todos nós para sempre.'
  text.category = 'blessing'
end

LiturgicalText.find_or_create_by!(slug: 'evening_4_grace_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Amém.'
  text.category = 'blessing'
end

Rails.logger.info "✅ Textos do Ofício Vespertino 4 - BCP 1928 carregados com sucesso!"
