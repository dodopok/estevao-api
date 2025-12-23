# frozen_string_literal: true

Rails.logger.info "🌙 Carregando textos Ofício de Completas I (LOCB 2008)..."

prayer_book = PrayerBook.find_by!(code: 'locb_2008')

# ==============================================================================
# OFÍCIO DE COMPLETAS I - LOCB 2008 (páginas 109-116)
# Este Ofício serve de conclusão para as atividades do dia, induzindo à reflexão
# e à tranquilização antes do recolher. É próprio para conclusão de reuniões de
# estudo bíblico, meditação e oração, que se realizem à noite, especialmente na
# Quaresma. Uma vez concluído, todos se retiram em silêncio.
# ==============================================================================

# ============================================================================
# ABERTURA
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'compline_1_opening_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Abertura'
  text.content = 'O Senhor Onipotente nos conceda uma noite tranquila e a paz na derradeira hora.'
  text.category = 'opening_sentence'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_opening_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Amém.'
  text.category = 'opening_sentence'
end

# ============================================================================
# FRASES DE ABERTURA (Brief Lessons)
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'compline_1_brief_lesson_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'O Ministro diz uma ou mais das seguintes frases:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_brief_lesson_1', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Jeremias 14:9'
  text.reference = 'Jr 14:9'
  text.content = 'Senhor, tu estás no nosso meio; e nós somos o teu povo. Não nos desampares.'
  text.category = 'brief_lesson'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_brief_lesson_2', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Mateus 11:28-30'
  text.reference = 'Mt 11:28-30'
  text.content = 'Vinde a Mim todos os que andais cansados e oprimidos, e Eu vos aliviarei. Tomai sobre vós o meu jugo, e aprendei de Mim, porque sou manso e humilde de coração. Assim achareis descanso para as vossas almas, porque o meu jugo é suave e o meu fardo é leve.'
  text.category = 'brief_lesson'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_brief_lesson_3', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = '1 Pedro 5:8-9'
  text.reference = '1 Pe 5:8-9'
  text.content = 'Sede prudentes e estai alerta, pois o vosso inimigo, o Diabo, anda em volta de vós a rugir como um leão, procurando a quem devorar. Resisti-lhe, firmes na vossa fé.'
  text.category = 'brief_lesson'
end

# ============================================================================
# CONFISSÃO
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'compline_1_confession_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Guarda-se silêncio e depois o Ministro diz:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_confession_invitation_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Confessemos os nossos pecados a Deus onipotente.'
  text.category = 'confession'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_confession_prayer_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Deus Todo-poderoso, nosso Pai celestial, pecamos contra Ti, por nossa própria culpa, em pensamentos, palavras e ações, e no bem que deixamos de fazer. Por amor de teu Filho, nosso Senhor Jesus Cristo, perdoa-nos todo o passado e concede que te sirvamos com vidas renovadas, para glória do teu nome. Amém.'
  text.category = 'confession'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_absolution_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Deus onipotente tenha misericórdia de nós; perdoe os nossos pecados; e nos guarde na vida eterna.'
  text.category = 'confession'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_absolution_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Amém.'
  text.category = 'confession'
end

# ============================================================================
# HINO - Te lucis ante terminum
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'compline_1_hymn_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Canta-se o Hino seguinte ou outro apropriado'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_hymn_te_lucis', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Te lucis ante terminum'
  text.content = <<~TEXT.strip
    Antes que a luz chegue ao fim,
    Ó Criador, te pedimos
    Fiel à tua bondade
    Guardai-nos e protegei-nos.

    Habita em nossos corações,
    ao longo duma noite calma;
    restaura as nossas energias,
    e purifica a nossa alma.

    Vamos em paz adormecer,
    repousaremos nesta hora,
    e cantaremos teus louvores
    quando romper a nova aurora.

    Ouve-nos, Pai onipotente,
    por Jesus Cristo, o Salvador,
    com teu Espírito docente,
    Trindade santa, Deus de amor.
  TEXT
  text.category = 'hymn'
end

# ============================================================================
# SALMODIA
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'compline_1_psalmody_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Salmodia'
  text.content = 'Salmodia'
  text.category = 'rubric'
end

# Salmo 4
LiturgicalText.find_or_create_by!(slug: 'compline_1_psalm_4', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Salmo 4'
  text.reference = 'Salmo 4'
  text.category = 'psalm'
  text.content = <<~TEXT.strip
    Responde-me quando clamo, ó Deus da minha justiça; na angústia, me tens aliviado; tem misericórdia de mim e ouve a minha oração.
    **Ó homens, até quando tornareis a minha glória em vexame, e amareis a vaidade, e buscareis a mentira?**
    Sabei, porém, que o Senhor distingue para si o piedoso; o Senhor me ouve quando eu clamo por ele.
    **Irai-vos e não pequeis; consultai no travesseiro o coração e sossegai. Oferecei sacrifícios de justiça e confiai no Senhor.**
    Há muitos que dizem: Quem nos dará a conhecer o bem? Senhor, levanta sobre nós a luz do teu rosto.
    **Mais alegria me puseste no coração do que a alegria deles, quando lhes há fartura de cereal e de vinho.**
    Em paz me deito e logo pego no sono, porque, Senhor, só tu me fazes repousar seguro.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_psalm_4_gloria_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Glória ao Pai, e ao Filho, e ao Espírito Santo.'
  text.category = 'gloria'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_psalm_4_gloria_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'gloria'
end

# Salmo 16:7-fim
LiturgicalText.find_or_create_by!(slug: 'compline_1_psalm_16', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Salmo 16:7 – fim'
  text.reference = 'Salmo 16:7-fim'
  text.category = 'psalm'
  text.content = <<~TEXT.strip
    Bendigo o Senhor, que me aconselha; pois até durante a noite o meu coração me ensina.
    **O Senhor, tenho-o sempre à minha presença; estando ele à minha direita, não serei abalado.**
    Alegra-se, pois, o meu coração, e o meu espírito exulta; até o meu corpo repousará seguro.
    **Pois não deixarás a minha alma na morte, nem permitirás que o teu Santo veja corrupção.**
    Tu me farás ver os caminhos da vida; na tua presença há plenitude de alegria, na tua destra, delícias perpetuamente.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_psalm_16_gloria_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Glória ao Pai, e ao Filho, e ao Espírito Santo.'
  text.category = 'gloria'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_psalm_16_gloria_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'gloria'
end

# Salmo 17:1b-8
LiturgicalText.find_or_create_by!(slug: 'compline_1_psalm_17', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Salmo 17:1b-8'
  text.reference = 'Salmo 17:1b-8'
  text.category = 'psalm'
  text.content = <<~TEXT.strip
    Atende ao meu clamor, dá ouvidos à minha oração, que procede de lábios não fraudulentos.
    **Baixe de tua presença o julgamento a meu respeito; os teus olhos veem com equidade.**
    Sondas-me o coração, de noite me visitas, provas-me no fogo e iniquidade nenhuma encontras em mim; a minha boca não transgride.
    **Quanto às ações dos homens, pela palavra dos teus lábios, eu me tenho guardado dos caminhos do violento.**
    Os meus passos se afizeram às tuas veredas, os meus pés não resvalaram.
    **Eu te invoco, ó Deus, pois tu me respondes; inclina-me os ouvidos e acode às minhas palavras.**
    Mostra as maravilhas da tua bondade, ó Salvador, dos que à tua destra buscam refúgio dos que se levantam contra eles.
    **Guarda-me como a menina dos olhos, esconde-me à sombra das tuas asas.**
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_psalm_17_gloria_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Glória ao Pai, e ao Filho, e ao Espírito Santo.'
  text.category = 'gloria'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_psalm_17_gloria_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'gloria'
end

# Salmo 31:2-6
LiturgicalText.find_or_create_by!(slug: 'compline_1_psalm_31', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Salmo 31:2-6'
  text.reference = 'Salmo 31:2-6'
  text.category = 'psalm'
  text.content = <<~TEXT.strip
    Inclina-me os ouvidos, livra-me depressa; sê o meu castelo forte, cidadela fortíssima que me salve.
    **Porque tu és a minha rocha e a minha fortaleza; por causa do teu nome, tu me conduzirás e me guiarás.**
    Tirar-me-ás do laço que, às ocultas, me armaram, pois tu és a minha fortaleza.
    **Nas tuas mãos, entrego o meu espírito; tu me remiste, Senhor, Deus da verdade.**
    Aborreces os que adoram ídolos vãos; eu, porém, confio no Senhor.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_psalm_31_gloria_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Glória ao Pai, e ao Filho, e ao Espírito Santo.'
  text.category = 'gloria'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_psalm_31_gloria_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'gloria'
end

# Salmo 91
LiturgicalText.find_or_create_by!(slug: 'compline_1_psalm_91', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Salmo 91'
  text.reference = 'Salmo 91'
  text.category = 'psalm'
  text.content = <<~TEXT.strip
    O que habita no esconderijo do Altíssimo e descansa à sombra do Onipotente diz ao Senhor: meu refúgio e meu baluarte, Deus meu, em quem confio.
    **Pois ele te livrará do laço do passarinheiro e da peste perniciosa.**
    Cobrir-te-á com as suas penas, e, sob suas asas, estarás seguro; a sua verdade é pavês e escudo.
    **Não te assustarás do terror noturno, nem da seta que voa de dia, nem da peste que se propaga nas trevas, nem da mortandade que assola ao meio-dia.**
    Caiam mil ao teu lado, e dez mil, à tua direita; tu não serás atingido.
    **Somente com os teus olhos contemplarás e verás o castigo dos ímpios.**
    Pois disseste: O Senhor é o meu refúgio. Fizeste do Altíssimo a tua morada.
    **Nenhum mal te sucederá, praga nenhuma chegará à tua tenda.**
    Porque aos seus anjos dará ordens a teu respeito, para que te guardem em todos os teus caminhos.
    **Eles te sustentarão nas suas mãos, para não tropeçares nalguma pedra.**
    Pisarás o leão e a áspide, calcarás aos pés o leãozinho e a serpente.
    **Porque a mim se apegou com amor, eu o livrarei; pô-lo-ei a salvo, porque conhece o meu nome.**
    Ele me invocará, e eu lhe responderei; na sua angústia eu estarei com ele, livrá-lo-ei e o glorificarei.
    **Saciá-lo-ei com longevidade e lhe mostrarei a minha salvação.**
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_psalm_91_gloria_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Glória ao Pai, e ao Filho, e ao Espírito Santo.'
  text.category = 'gloria'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_psalm_91_gloria_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'gloria'
end

# Salmo 134
LiturgicalText.find_or_create_by!(slug: 'compline_1_psalm_134', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Salmo 134'
  text.reference = 'Salmo 134'
  text.category = 'psalm'
  text.content = <<~TEXT.strip
    Bendizei ao Senhor, vós todos, servos do Senhor, que assistis na Casa do Senhor, nas horas da noite;
    **erguei as mãos para o santuário e bendizei ao Senhor.**
    De Sião te abençoe o Senhor, criador do céu e da terra!
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_psalm_134_gloria_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Glória ao Pai, e ao Filho, e ao Espírito Santo.'
  text.category = 'gloria'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_psalm_134_gloria_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'gloria'
end

# Salmo 139:1-12, 23-24
LiturgicalText.find_or_create_by!(slug: 'compline_1_psalm_139', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Salmo 139:1-12, 23-24'
  text.reference = 'Salmo 139:1-12, 23-24'
  text.category = 'psalm'
  text.content = <<~TEXT.strip
    Senhor, tu me sondas e me conheces.
    **Sabes quando me assento e quando me levanto; de longe penetras os meus pensamentos.**
    Esquadrinhas o meu andar e o meu deitar e conheces todos os meus caminhos.
    **Ainda a palavra me não chegou à língua, e tu, Senhor, já a conheces toda.**
    Tu me cercas por trás e por diante e sobre mim pões a mão.
    **Tal conhecimento é maravilhoso demais para mim: é sobremodo elevado, não o posso atingir.**
    Para onde me ausentarei do teu Espírito? Para onde fugirei da tua face?
    **Se subo aos céus, lá estás; se faço a minha cama no mais profundo abismo, lá estás também;**
    se tomo as asas da alvorada e me detenho nos confins dos mares,
    **ainda lá me haverá de guiar a tua mão, e a tua destra me susterá.**
    Se eu digo: as trevas, com efeito, me encobrirão, e a luz ao redor de mim se fará noite,
    **até as próprias trevas não te serão escuras: as trevas e a luz são a mesma coisa.**
    Sonda-me, ó Deus, e conhece o meu coração, prova-me e conhece os meus pensamentos;
    **vê se há em mim algum caminho mau e guia-me pelo caminho eterno.**
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_psalm_139_gloria_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Glória ao Pai, e ao Filho, e ao Espírito Santo.'
  text.category = 'gloria'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_psalm_139_gloria_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'gloria'
end

# ============================================================================
# A PALAVRA DE DEUS
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'compline_1_word_of_god_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'A Palavra de Deus'
  text.content = 'Lê-se uma das seguintes passagens bíblicas, ou outra apropriada'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_word_of_god_references', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Isaías 26:3-5, 7-9; Isaías 35:8-10; Jeremias 31:33-34; Habacuque 3:17-19; Deuteronômio 6:4-7; João 3:19-21; 1 Coríntios 1:26-31; 1 Coríntios 2:10b-13; Efésios 4:26-27; Filipenses 4:6-9.'
  text.category = 'reading'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_word_of_god_response_reader', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'No fim da leitura'
  text.content = 'Esta é a Palavra do Senhor!'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_word_of_god_response_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Demos graças a Deus'
  text.category = 'response'
end

# ============================================================================
# NUNC DIMITTIS
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'compline_1_nunc_dimittis_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Canta-se o Nunc Dimittis com a Antífona seguinte, a que no tempo pascal se acrescenta Aleluia! Aleluia!'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_nunc_dimittis_antiphon_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Antífona'
  text.content = 'Salva-nos, Senhor, enquanto acordados, e guarda-nos quando dormimos; para que, acordados, vigiemos com Cristo, e, dormindo, repousemos em paz.'
  text.category = 'antiphon'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_nunc_dimittis', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Nunc Dimittis'
  text.reference = 'Lucas 2:29-32'
  text.category = 'canticle'
  text.content = <<~TEXT.strip
    Agora, Senhor, podes despedir em paz o teu servo, segundo a tua palavra; porque os meus olhos já viram a tua salvação, a qual preparaste diante de todos os povos: luz para revelação aos gentios, e para glória do teu povo de Israel.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_nunc_dimittis_gloria_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Glória ao Pai, e ao Filho, e ao Espírito Santo.'
  text.category = 'gloria'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_nunc_dimittis_gloria_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'gloria'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_nunc_dimittis_antiphon_repeat_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Salva-nos, Senhor, enquanto acordados, e guarda-nos quando dormimos; para que, acordados, vigiemos com Cristo, e, dormindo, repousemos em paz.'
  text.category = 'antiphon'
end

# ============================================================================
# KYRIE E PAI NOSSO
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'compline_1_kyrie_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Senhor, tem misericórdia de nós.'
  text.category = 'kyrie'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_kyrie_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Cristo, tem misericórdia de nós.'
  text.category = 'kyrie'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_kyrie_minister_2', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Senhor, tem misericórdia de nós.'
  text.category = 'kyrie'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_lords_prayer_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Pai nosso, que estás nos céus, santificado seja o teu nome. Venha o teu Reino, seja feita a tua vontade, assim na terra como no céu. O pão nosso de cada dia nos dá hoje. E perdoa-nos as nossas dívidas, assim como nós perdoamos aos nossos devedores. E não nos deixes cair em tentação, mas livra-nos do mal; pois teu é o Reino, e o poder, e a glória para sempre. Amém.'
  text.category = 'lords_prayer'
end

# ============================================================================
# RESPONSO
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'compline_1_responsory_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Diz-se o responsório seguinte'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_responsory_1_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Em paz, nos deitaremos e dormiremos;'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_responsory_1_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Porque só Tu, Senhor, nos fazes habitar em segurança.'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_responsory_2_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Nas tuas mãos, Senhor, entrego o meu espírito;'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_responsory_2_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Tu nos redimirás, Senhor, Deus da verdade.'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_responsory_3_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Durante a noite, guarda-nos de todo o pecado,'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_responsory_3_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'tem misericórdia de nós, Senhor, tem misericórdia.'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_responsory_4_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Senhor, ouve a nossa oração;'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_responsory_4_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'e chegue a Ti a nossa prece.'
  text.category = 'responsory'
end

# ============================================================================
# ORAÇÕES FINAIS
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'compline_1_final_prayers_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Pode-se dizer uma ou mais das seguintes Orações'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_final_prayer_1', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Visita, Senhor, esta morada, e afasta dela as ciladas do inimigo. Habitem aqui os teus santos anjos para nos guardarem em paz. E a tua bênção esteja sempre conosco. Por Jesus Cristo, nosso Senhor. Amém.'
  text.category = 'collect'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_final_prayer_2', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Senhor, sê Tu a nossa luz durante a noite e concede-nos um descanso tranquilo; para que amanhã nos levantemos em teu nome, e contemplemos alegres e felizes o novo dia. Por Jesus Cristo, nosso Senhor. Amém.'
  text.category = 'collect'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_final_prayer_3', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Sê conosco, bondoso Deus, e protege-nos durante as horas silenciosas da noite; para que nós, que estamos fatigados das incertezas e perigos deste mundo fugaz, descansemos seguros na constância do teu amor eterno. Mediante Jesus Cristo, nosso Senhor. Amém.'
  text.category = 'collect'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_final_prayer_4', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Senhor nosso Deus, concede-nos um descanso tranquilo que restaure as nossas forças exaustas pelo trabalho do dia; a fim de que, fortalecidos pela tua ajuda, te sirvamos sempre com generosidade de corpo e alma. Mediante Jesus Cristo, nosso Senhor. Amém.'
  text.category = 'collect'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_final_prayer_5', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Senhor, olha-nos complacente do teu trono celestial: ilumina a noite com teu divino esplendor e dos filhos da luz afasta as obras das trevas. Mediante Jesus Cristo, nosso Senhor. Amém.'
  text.category = 'collect'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_final_prayer_6', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Senhor Jesus Cristo, Filho do Deus vivo, que a esta hora da noite descansaste no sepulcro e santificaste o túmulo a fim de ser leito de esperança para o teu povo; dá-nos o arrependimento dos nossos pecados – causa da tua Paixão – para que, quando os nossos corpos descerem ao pó, as nossas almas possam viver contigo; que, com o Pai e o Espírito Santo, vives e reinas para sempre. Amém.'
  text.category = 'collect'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_easter_prayer_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'A Oração seguinte é apropriada para Domingos e desde o Dia de Páscoa até ao Pentecostes'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_easter_prayer', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Ó Senhor, triunfando sobre o poder das trevas, preparaste o nosso lugar na nova Jerusalém. Concede a nós, que celebremos gratos a tua ressurreição, a graça de te adorar na cidade em que Tu és a luz, e onde, com o Pai e o Espírito Santo, vives e reinas, agora e para sempre. Amém.'
  text.category = 'collect'
end

# ============================================================================
# CONCLUSÃO
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'compline_1_conclusion_1_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Conclusão'
  text.content = 'O Senhor esteja convosco.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_conclusion_1_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E contigo também.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_conclusion_1_minister_2', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Bendigamos o Senhor.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_conclusion_1_all_2', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Graças a Deus.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_conclusion_easter_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Da Páscoa ao Pentecostes diz-se Aleluia! Aleluia! depois de cada versículo e resposta'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_conclusion_blessing_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'O Senhor, onipotente e misericordioso, o Pai e o Filho e o Espírito Santo, nos abençoe e nos guarde, esta noite e para sempre.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_conclusion_blessing_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Amém.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_conclusion_or_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Ou'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_conclusion_2_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Ide na paz de Cristo! Sede corajosos e fortes no testemunho do Evangelho entre todas as pessoas. Servi o Senhor com a alegria.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_conclusion_2_people', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'No poder do Espírito Santo.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'compline_1_conclusion_2_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Aleluia!'
  text.category = 'conclusion'
end

Rails.logger.info "✅ Textos Ofício de Completas I (LOCB 2008) carregados com sucesso!"
