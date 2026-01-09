Rails.logger.info "📿 Carregando textos Ofício Matutino 2 (LOCB 2008)..."

prayer_book = PrayerBook.find_by!(code: 'locb_2008')

# Acolhida

# Convite à Adoração - Variações por tempo litúrgico
LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_rubric', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Convite à Adoração'
  text.content = 'Segundo as estações, são ditas pelo Ministro:'
  text.category = 'rubric'
end

# Geral (2 opções)
LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_general_1', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Convite - Geral'
  text.content = 'Adorai o Senhor na beleza da sua santidade; tremei diante dele, todas as terras. Sl 96:9'
  text.category = 'invitation'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_general_2', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Convite - Geral'
  text.content = 'Deus é espírito; e importa que os seus adoradores o adorem em espírito e em verdade. Jo 4:24'
  text.category = 'invitation'
end

# Advento
LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_advent', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Convite - Advento'
  text.content = 'Vai alta a noite, e vem chegando o dia. Deixemos, pois, as obras das trevas e revistamo-nos das armas da luz. Rm 13:12'
  text.category = 'invitation'
end

# Natal
LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_christmas', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Convite - Natal'
  text.content = 'O anjo, porém, lhes disse: Não temais; eis aqui vos trago boa-nova de grande alegria, que o será para todo o povo: é que hoje vos nasceu, na cidade de Davi, o Salvador, que é Cristo, o Senhor. Lc 2:10-11'
  text.category = 'invitation'
end

# Epifania
LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_epiphany', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Convite - Epifania'
  text.content = 'Mas, desde o nascente do sol até ao poente, é grande entre as nações o meu nome; e em todo lugar lhe é queimado incenso e trazidas ofertas puras, porque o meu nome é grande entre as nações, diz o Senhor dos Exércitos. Ml 1:11'
  text.category = 'invitation'
end

# Quaresma
LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_lent', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Convite - Quaresma'
  text.content = 'Sacrifícios agradáveis a Deus são o espírito quebrantado; coração compungido e contrito, não o desprezarás, ó Deus. Sl 51:17'
  text.category = 'invitation'
end

# Semana Santa
LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_holy_week', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Convite - Semana Santa'
  text.content = 'Não vos comove isto, a todos vós que passais pelo caminho? Considerai e vede se há dor igual à minha, que veio sobre mim, com que o Senhor me afligiu no dia do furor da sua ira. Lm 1:12'
  text.category = 'invitation'
end

# Sexta-feira Santa
LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_good_friday', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Convite - Sexta-feira Santa'
  text.content = 'Mas Deus prova o seu próprio amor para conosco pelo fato de ter Cristo morrido por nós, sendo nós ainda pecadores. Rm 5:8'
  text.category = 'invitation'
end

# Vigília Pascal
LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_easter_vigil', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Convite - Vigília Pascal'
  text.content = 'Descansa no Senhor e espera nele, não te irrites por causa do homem que prospera em seu caminho, por causa do que leva a cabo os seus maus desígnios. Agrada-te do Senhor, e ele satisfará os desejos do teu coração. Sl 37:7,4'
  text.category = 'invitation'
end

# Páscoa
LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_easter', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Convite - Páscoa'
  text.content = 'Bendito o Deus e Pai de nosso Senhor Jesus Cristo, que, segundo a sua muita misericórdia, nos regenerou para uma viva esperança, mediante a ressurreição de Jesus Cristo dentre os mortos. 1 Pe 1:3'
  text.category = 'invitation'
end

# Ascensão
LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_ascension', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Convite - Ascensão'
  text.content = 'Tendo, pois, a Jesus, o Filho de Deus, como grande Sumo Sacerdote que penetrou os céus, conservemos firmes a nossa confissão. Acheguemo-nos, portanto, confiadamente, junto ao trono da graça, a fim de recebermos misericórdia e acharmos graça para socorro em ocasião oportuna. Hb 4:14,16'
  text.category = 'invitation'
end

# Pentecostes
LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_pentecost', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Convite - Pentecostes'
  text.content = 'Ora, a esperança não confunde, porque o amor de Deus é derramado em nosso coração pelo Espírito Santo, que nos foi outorgado. Rm 5:5'
  text.category = 'invitation'
end

# Trindade
LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_trinity', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Convite - Trindade'
  text.content = 'E nós conhecemos e cremos no amor que Deus tem por nós. Deus é amor, e aquele que permanece no amor permanece em Deus, e Deus, nele. 1 Jo 4:16'
  text.category = 'invitation'
end

# Penitenciais (8 opções)
LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_penitential_1', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Convite - Penitencial'
  text.content = 'Levantar-me-ei, e irei ter com o meu pai, e lhe direi: Pai, pequei contra o céu e diante de ti; já não sou digno de ser chamado teu filho; trata-me como um dos teus trabalhadores. Lc 15:18-19'
  text.category = 'invitation'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_penitential_2', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Convite - Penitencial'
  text.content = 'Ao Senhor, nosso Deus, pertence a misericórdia e o perdão, pois nos temos rebelado contra ele e não obedecemos à voz do Senhor, nosso Deus, para andarmos nas suas leis, que nos deu por intermédio de seus servos, os profetas. Dn 9:9-10'
  text.category = 'invitation'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_penitential_3', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Convite - Penitencial'
  text.content = 'Não entres em juízo com o teu servo, porque à tua vista não há justo nenhum vivente. Sl 143:2'
  text.category = 'invitation'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_penitential_4', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Convite - Penitencial'
  text.content = 'Mas, convertendo-se o perverso da perversidade que cometeu e praticando o que é reto e justo, conservará ele a sua alma em vida. Ez 18:27'
  text.category = 'invitation'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_penitential_5', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Convite - Penitencial'
  text.content = 'Pois eu conheço as minhas transgressões, e o meu pecado está sempre diante de mim. Sl 51:3'
  text.category = 'invitation'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_penitential_6', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Convite - Penitencial'
  text.content = 'Esconde o rosto dos meus pecados e apaga todas as minhas iniquidades. Sl 51:9'
  text.category = 'invitation'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_penitential_7', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Convite - Penitencial'
  text.content = 'Castiga-me, ó Senhor, mas em justa medida, não na tua ira, para que não me reduzas a nada. Jr 10:24'
  text.category = 'invitation'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_penitential_8', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Convite - Penitencial'
  text.content = 'Senhor, não me repreendas na tua ira, nem me castigues no teu furor. Sl 6:1'
  text.category = 'invitation'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_penitential_9', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Convite - Penitencial'
  text.content = 'Arrependei-vos, porque está próximo o reino dos céus. Mt 3:2'
  text.category = 'invitation'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_penitential_10', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Convite - Penitencial'
  text.content = 'Rasgai o vosso coração, e não as vossas vestes, e convertei-vos ao Senhor, vosso Deus, porque ele é misericordioso, e compassivo, e tardio em irar-se, e grande em benignidade, e se arrepende do mal. Jl 2:13'
  text.category = 'invitation'
end

# ==============================================================================
# CONVITE À CONFISSÃO
# ==============================================================================


# Opção 1
LiturgicalText.find_or_create_by!(slug: 'morning_2_confession_invitation_1_minister', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Convite à Confissão'
  text.content = 'Amados irmãos, as Escrituras nos recomendam reconhecermos e confessarmos nossos pecados e ofensas e que nós não deveríamos escondê-los diante do Todo-poderoso Deus, nosso Pai Celestial, mas humildemente confessar, tendo um coração penitente e obediente a fim de que possamos obter perdão por sua imensa misericórdia e bondade. E que devemos, em todo o tempo, humildemente reconhecer os nossos pecados diante do Senhor. Devemos fazer isso, principalmente, quando nos congregamos e nos encontramos para a ação de graças pelos grandes benefícios que recebemos de suas mãos, para orar, ouvir sua santa palavra e aprender todas as coisas necessárias para o bem do corpo e alma. Portanto, eu oro e peço ao Senhor, como muitos que estão aqui presentes, que me acompanhem com puro coração e com voz humilde até o trono da graça, dizendo depois de mim:'
  text.category = 'confession'
end

# Opção 2 (alternativa "Ou")
LiturgicalText.find_or_create_by!(slug: 'morning_2_confession_invitation_2_minister', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Convite à Confissão'
  text.content = 'Amados, nós nos aproximamos da presença de Deus Todo-poderoso e da companhia da corte celestial para oferecer a ele, por meio de nosso Senhor Jesus Cristo, nossa adoração, louvor e ações de graças; fazer confissão de nossos pecados, orar intercedendo por outros e por nós mesmos, pois sabemos que tudo o que temos é fruto de seu amor para conosco; e para orientar-nos sobre qual é a sua vontade em nossa vida, para o nosso bem-estar. Portanto, ajoelhemo-nos e em silêncio, lembremos da presença de Deus Conosco.'
  text.category = 'confession'
end

# Silêncio
LiturgicalText.find_or_create_by!(slug: 'morning_2_confession_silence', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Silêncio'
  text.content = 'Silêncio por alguns instantes'
  text.category = 'rubric'
end

# Confissão
LiturgicalText.find_or_create_by!(slug: 'morning_2_confession_prayer_all', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Confissão'
  text.content = 'Todo-poderoso e amantíssimo Pai, nós erramos e nos desviamos como ovelhas perdidas. Seguimos excessivamente os desejos e inclinações de nosso coração. Nós transgredimos tuas santas leis. Fizemos coisas que não devíamos fazer e não fizemos o que devíamos ter feito. Não há nenhum bem em nós. Mas Tu, ó Deus, tem misericórdia de nós, miseráveis pecadores. Sê próximo daqueles que confessam seus pecados. Restaura, Senhor, aqueles que estão arrependidos, de acordo com tuas promessas aos homens através de Jesus Cristo, nosso Salvador. E concede, Pai misericordioso, por ele, que andemos uma vida santa, reta e sóbria daqui por diante, para a Glória de teu nome. Amém.'
  text.category = 'confession'
end

# Declaração de Perd

LiturgicalText.find_or_create_by!(slug: 'morning_2_absolution_minister', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Declaração de Perdão'
  text.content = 'O Deus Todo-poderoso, Pai de nosso Senhor Jesus Cristo, que deseja não a morte de um pecador, mas que se arrependa da maldade e viva; que determinou aos Ministros dele declarar e pronunciar aos que são dele, quando se arrependem, a Declaração de Perdão de seus pecados. Que Ele os perdoe e absolva de todos os pecados, pois creem no Seu santo Evangelho. Portanto, Ele nos deixou uma segurança eterna que, a todos que sinceramente se arrependem de seus pecados, ele dá nova vida pelo seu Espírito Santo, para sermos santos e puros de forma que gozemos de plena alegria, eternamente. Por Jesus Cristo, nosso Deus.'
  text.category = 'absolution'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_absolution_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Amém.'
  text.category = 'absolution'
end

# Alternativa para Ministros Locais
LiturgicalText.find_or_create_by!(slug: 'morning_2_absolution_local_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'ou Ministros Locais podem dizer'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_absolution_local_minister', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Declaração de Perdão (Ministro Local)'
  text.content = 'Concede, nós te pedimos, ó Deus de misericórdia, o perdão a teus fiéis e dá-lhes paz, livrando-os de todos os seus pecados, para que te sirvam com uma mente tranquila e um coração santificado. Por Jesus Cristo, nosso Deus.'
  text.category = 'absolution'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_absolution_local_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Amém.'
  text.category = 'absolution'
end

# ==============================================================================
# ORAÇÃO DO SENHOR
# ==============================================================================


# ==============================================================================
# ORAÇÃO MATUTINA
# ==============================================================================


LiturgicalText.find_or_create_by!(slug: 'morning_2_morning_prayer_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'A introdução para o serviço é usada nos domingos, e pode ser usada em qualquer ocasião'
  text.category = 'rubric'
end

# Responso

LiturgicalText.find_or_create_by!(slug: 'morning_2_response_1_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Ó Senhor, abre os meus lábios.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_response_1_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'E nossa boca anunciará os teus louvores.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_response_2_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Ó Deus, apressa-te em nos salvar.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_response_2_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Senhor, vem e nos ajuda.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_response_3_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Glória ao Pai, ao Filho e ao Espírito Santo.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_response_3_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_response_4_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Louvemos ao Senhor.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_response_4_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Demos Graças a Deus.'
  text.category = 'response'
end

# ==============================================================================
# VENITE, EXULTEMUS DOMINO (Sl 95)
# ==============================================================================


LiturgicalText.find_or_create_by!(slug: 'morning_2_venite', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Venite'
  text.content = 'Vinde, cantemos ao Senhor, com júbilo, celebremos o Rochedo da nossa salvação.
**Saiamos ao seu encontro, com ações de graças, vitoriemo-lo com salmos.**
Porque o Senhor é o Deus supremo e o grande Rei acima de todos os deuses.
**Nas suas mãos estão as profundezas da terra, e as alturas dos montes lhe pertencem.**
Dele é o mar, pois ele o fez; obra de suas mãos, os continentes. Vinde, adoremos e prostremo-nos; ajoelhemos diante do Senhor, que nos criou.
**Ele é o nosso Deus, e nós, povo do seu pasto e ovelhas de sua mão. Hoje, se ouvirdes a sua voz,**
não endureçais o coração, como em Meribá, como no dia de Massá, no deserto,
**quando vossos pais me tentaram, pondo-me à prova, não obstante terem visto as minhas obras.**
Durante quarenta anos, estive desgostado com essa geração e disse: é povo de coração transviado, não conhece os meus caminhos.
**Por isso, jurei na minha ira: não entrarão no meu descanso.**'
  text.category = 'venite'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_venite_gloria_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Glória ao Pai, ao Filho e ao Espírito Santo.'
  text.category = 'venite'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_venite_gloria_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'venite'
end

# ==============================================================================
# SALMODIA
# ==============================================================================


LiturgicalText.find_or_create_by!(slug: 'morning_2_psalms_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Cada Salmo ou grupo de Salmos deve terminar com a Doxologia que segue. Para os Ofícios diários, os Salmos são indicados no Lecionário, pp.347 a 358:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_psalms_gloria_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Glória ao Pai, ao Filho e ao Espírito Santo.'
  text.category = 'psalms'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_psalms_gloria_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'psalms'
end

# ==============================================================================
# LEITURA DO ANTIGO TESTAMENTO
# ==============================================================================


# ==============================================================================
# TE DEUM LAUDAMUS
# ==============================================================================


LiturgicalText.find_or_create_by!(slug: 'morning_2_te_deum_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'O Te Deum Laudamus (a seguir) é dito ou cantado'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_te_deum', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Te Deum Laudamus'
  text.content = 'A Ti, ó Deus, louvamos e, por Senhor nosso, confessamos.
A Ti, ó Eterno Pai, adora toda a terra.
A Ti clamam os anjos todos, os céus, e todas as potestades.
A Ti clamam, continuamente, os querubins e os serafins, dizendo:
Santo, Santo, Santo é o Senhor, Deus dos Exércitos;
os céus e a terra estão plenos da tua glória.
A Ti louva a gloriosa companhia dos apóstolos.
A Ti louva a santa comunhão dos profetas.
A Ti louva o nobre exército dos mártires.
A Ti confessa a santa Igreja espalhada pela terra.
A Ti, Pai de infinita majestade.
A Teu adorável, verdadeiro e único Filho.
Também ao Espírito Santo, o Consolador.
Tu és o Rei da glória, ó Cristo. Tu és o Filho Eterno do Pai.
Quando Tu empreendeste a redenção do gênero humano, te humilhaste ao nascer de uma virgem.
Quando Tu venceste o agulhão da morte, abriste o Reino dos Céus a todos os crentes.
Tu te assentas à destra de Deus, na glória do Pai.
Nós cremos que Tu virás para seres nosso juiz.
Por isso, oramos, que socorras a teus servos, aos quais redimiste com teu precioso sangue.
Conta-os com os teus santos na glória eterna.
Ó Senhor, salva o teu povo, e abençoa a tua herança.
Governa-o e exalta-o eternamente.
De dia em dia te magnificamos; e louvamos teu nome para sempre.
Digna-te, Senhor, guardar-nos hoje sem pecado.
Tem misericórdia de nós.
Ó Senhor, seja sobre nós, a tua misericórdia, assim como em ti confiamos.
Em ti, Senhor, eu confio; não me deixes nunca ser confundido.'
  text.category = 'te_deum'
end

# ==============================================================================
# LEITURA DO NOVO TESTAMENTO
# ==============================================================================


# ==============================================================================
# SERMÃO
# ==============================================================================


# ==============================================================================
# BENEDICTUS
# ==============================================================================


LiturgicalText.find_or_create_by!(slug: 'morning_2_benedictus_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = '(Lucas 1:68-79) é dito ou cantado'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_benedictus', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Benedictus'
  text.content = 'Bendito seja o Senhor, Deus de Israel, porque visitou e redimiu o seu povo,
**e nos suscitou plena e poderosa salvação na casa de Davi, seu servo,**
como prometera, desde a antiguidade, por boca dos seus santos profetas,
**para nos libertar dos nossos inimigos e das mãos de todos os que nos odeiam;**
para usar de misericórdia com os nossos pais e lembrar-se da sua santa aliança e do juramento que fez a Abraão, o nosso pai, de conceder-nos que, livres das mãos de inimigos, o adorássemos sem temor,
**em santidade e justiça perante ele, todos os nossos dias.**
Tu, menino, serás chamado profeta do Altíssimo, porque precederás o Senhor, preparando-lhe os caminhos,
**para dar ao seu povo conhecimento da salvação, no redimi-lo dos seus pecados,**
graças à entranhável misericórdia de nosso Deus, pela qual nos visitará o sol nascente das alturas,
**para alumiar os que jazem nas trevas e na sombra da morte, e dirigir os nossos pés pelo caminho da paz.**'
  text.category = 'benedictus'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_benedictus_gloria_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Glória ao Pai, ao Filho e ao Espírito Santo.'
  text.category = 'benedictus'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_benedictus_gloria_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'benedictus'
end

# ==============================================================================
# JUBILATE DEO (Salmo 100) - Alternativa "Ou"
# ==============================================================================


LiturgicalText.find_or_create_by!(slug: 'morning_2_jubilate_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = '(Salmo 100) é dito ou cantado'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_jubilate', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Jubilate Deo'
  text.content = 'Celebrai com júbilo ao Senhor, todas as terras.
**Servi ao Senhor com alegria, apresentai-vos diante dele com cântico.**
Sabei que o Senhor é Deus; foi ele quem nos fez, e dele somos; somos o seu povo e rebanho do seu pastoreio.
**Entrai por suas portas com ações de graças e nos seus átrios, com hinos de louvor; rendei-lhe graças e bendizei-lhe o nome.**
Porque o Senhor é bom, a sua misericórdia dura para sempre, e, de geração em geração, a sua fidelidade.'
  text.category = 'jubilate'
end

# ==============================================================================
# O CREDO DOS APÓSTOLOS
# ==============================================================================


LiturgicalText.find_or_create_by!(slug: 'morning_2_creed_all', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Credo dos Apóstolos'
  text.content = 'Creio em Deus Pai Todo-poderoso, Criador do Céu e da Terra; e em Jesus Cristo seu único Filho, nosso Senhor: o qual foi concebido por obra do Espírito Santo, nasceu da Virgem Maria; padeceu sob o poder de Pôncio Pilatos, foi crucificado, morto e sepultado; desceu ao Hades; ressuscitou ao terceiro dia; subiu ao céu, e está sentado à mão direita de Deus Pai Todo-poderoso: donde há de vir a julgar os vivos e os mortos. Creio no Espírito Santo; na santa Igreja Católica; na comunhão dos santos; na remissão dos pecados; na ressurreição do corpo; e na Vida Eterna. Amém.'
  text.category = 'creed'
end

# ==============================================================================
# ORAÇÕES
# ==============================================================================


LiturgicalText.find_or_create_by!(slug: 'morning_2_prayers_1_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'O Senhor seja contigo.'
  text.category = 'prayers'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_prayers_1_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'E com teu espírito.'
  text.category = 'prayers'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_prayers_2_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Senhor, tem piedade de nós.'
  text.category = 'prayers'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_prayers_2_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Cristo, tem piedade de nós.'
  text.category = 'prayers'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_prayers_3_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Senhor, tem piedade de nós.'
  text.category = 'prayers'
end

# Pai Nosso
LiturgicalText.find_or_create_by!(slug: 'morning_2_lords_prayer_all', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Pai Nosso'
  text.content = 'Pai nosso, que estás nos céus, santificado seja o teu nome. Venha o teu Reino, seja feita a tua vontade, assim na terra como no céu. O pão nosso de cada dia nos dá hoje. E perdoa-nos as nossas dívidas, assim como nós perdoamos aos nossos devedores. E não nos deixes cair em tentação, mas livra-nos do mal; pois teu é o Reino, e o poder, e a glória para sempre. Amém.'
  text.category = 'lords_prayer'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_prayers_4_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Ó Deus, tem compaixão de nós.'
  text.category = 'prayers'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_prayers_4_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'E nos conceda a tua salvação.'
  text.category = 'prayers'
end

# Sufrágio

LiturgicalText.find_or_create_by!(slug: 'morning_2_suffrage_1_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Ó Deus, auxilie o Presidente.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_suffrage_1_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'E misericordiosamente nos ouve quando nós clamarmos a ti.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_suffrage_2_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Dote os Ministros de tua retidão.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_suffrage_2_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'E faz teus escolhidos felizes.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_suffrage_3_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Ó Deus, salve o teu povo.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_suffrage_3_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'E abençoa a herança de Jacó.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_suffrage_4_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Dê paz em nosso tempo, ó Deus.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_suffrage_4_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Porque não há nenhum outro que nos salve, mas só tu, Senhor.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_suffrage_5_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Cria em nós um puro coração, ó Deus.'
  text.category = 'suffrage'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_suffrage_5_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'E não retires de nós teu Santo Espírito.'
  text.category = 'suffrage'
end

# ==============================================================================
# A COLETA DO DIA
# ==============================================================================


LiturgicalText.find_or_create_by!(slug: 'morning_2_collect_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = '(no Próprio do tempo, ver Lecionário pp.347 a 358)'
  text.category = 'rubric'
end

# ==============================================================================
# A COLETA PELA PAZ
# ==============================================================================


LiturgicalText.find_or_create_by!(slug: 'morning_2_collect_peace', prayer_book_id: prayer_book.id) do |text|
    text.title = 'A Coleta pela Paz'
  text.content = 'Ó Deus, autor da paz e amante da concórdia, em cujo conhecimento se encontra a vida eterna, e a quem servir é ter perfeita liberdade, defende-nos, humildes servos teus, em todos os ataques de nossos inimigos, de tal forma que nós, seguros por tua defesa, não temamos o poder de nossos adversários, mediante Jesus Cristo nosso Senhor. Amém.'
  text.category = 'collect'
end

# ==============================================================================
# A COLETA PELA GRAÇA
# ==============================================================================


LiturgicalText.find_or_create_by!(slug: 'morning_2_collect_grace', prayer_book_id: prayer_book.id) do |text|
    text.title = 'A Coleta pela Graça'
  text.content = 'Ó Senhor, nosso Pai Celestial, Todo-poderoso e Eterno Deus, que nos trouxeste em segurança até o começo deste dia, defende-nos hoje com teu grande poder, não permitindo que caiamos em pecados ou nos exponhamos, descuidados, a qualquer perigo. Concede que nossos pensamentos e ações, ordenados por tua providência, sejam retos aos teus olhos, mediante Jesus Cristo, nosso Senhor. Amém.'
  text.category = 'collect'
end

# ==============================================================================
# HINO
# ==============================================================================


# ==============================================================================
# OUTRAS ORAÇÕES (opcional)
# ==============================================================================


LiturgicalText.find_or_create_by!(slug: 'morning_2_other_prayers_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = '(opcional)'
  text.category = 'rubric'
end

# ==============================================================================
# CONCLUSÃO
# ==============================================================================


LiturgicalText.find_or_create_by!(slug: 'morning_2_conclusion_grace_minister', prayer_book_id: prayer_book.id) do |text|
    text.title = 'A Graça'
  text.content = 'A Graça de nosso Senhor Jesus Cristo, o amor do Pai e a comunhão do Espírito Santo seja com todos nós.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_conclusion_grace_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Amém.'
  text.category = 'conclusion'
end

# Alternativa "Ou"
LiturgicalText.find_or_create_by!(slug: 'morning_2_conclusion_dismissal_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Ou'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_conclusion_dismissal_minister', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Despedida'
  text.content = 'Ide na paz de Cristo! Sede corajosos e fortes no testemunho do Evangelho entre todas as pessoas. Servi ao Senhor com a alegria.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_conclusion_dismissal_people', prayer_book_id: prayer_book.id) do |text|
    text.content = 'No poder do Espírito Santo.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_conclusion_dismissal_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Amém.'
  text.category = 'conclusion'
end

Rails.logger.info 'LOCB 2008 Morning Prayer II liturgical texts created successfully!'
