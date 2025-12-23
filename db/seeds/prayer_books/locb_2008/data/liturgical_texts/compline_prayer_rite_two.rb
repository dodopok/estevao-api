# frozen_string_literal: true

Rails.logger.info "🌙 Carregando textos Ofício de Completas II (LOCB 2008)..."

prayer_book = PrayerBook.find_by!(code: 'locb_2008')

# ==============================================================================
# OFÍCIO DE COMPLETAS II - LOCB 2008 (páginas 117-122)
# Este Ofício serve de conclusão para as atividades do dia, induzindo à reflexão
# e à tranquilização antes do recolher. Uma vez concluído, todos se retiram em silêncio.
# ==============================================================================

# ============================================================================
# ABERTURA
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'compline_2_opening_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Estando todos de pé, o Ministro dirá:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_opening_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Abertura'
  text.content = 'O Senhor Onipotente nos conceda uma noite tranquila e a paz na derradeira hora.'
  text.category = 'opening_sentence'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_opening_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Amém.'
  text.category = 'opening_sentence'
end

# ============================================================================
# LIÇÃO BREVE
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'compline_2_brief_lesson_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Lição Breve'
  text.content = 'Lição Breve'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_brief_lesson_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = '1 Pedro 5:8'
  text.reference = '1 Pe 5:8'
  text.content = 'Irmãos, sede sóbrios e vigilantes, porque o vosso adversário, o diabo anda em derredor de vós, como leão que ruge. Resisti-lhe firmes na fé. Tu, porém, Senhor, tem misericórdia de nós.'
  text.category = 'brief_lesson'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_brief_lesson_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Graças rendamos a Deus.'
  text.category = 'brief_lesson'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_brief_lesson_minister_2', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'O nosso auxílio está em nome do Senhor.'
  text.category = 'brief_lesson'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_brief_lesson_all_2', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Que fez os Céus e a Terra.'
  text.category = 'brief_lesson'
end

# ============================================================================
# CONFISSÃO
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'compline_2_confession_title', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Confissão'
  text.content = 'Confissão'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_confession_invitation_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Confessamos a Deus Todo-poderoso,'
  text.category = 'confession'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_confession_prayer_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Pai, Filho e Espírito Santo, que temos pecado excessivamente, por pensamentos, palavras e ações, por nossa culpa, por nossa própria culpa, por nossa máxima culpa. Por isso rogamos a Deus que tenha misericórdia de nós. Deus Todo-poderoso tenha misericórdia de nós, perdoe os nossos pecados e nos conduza à vida eterna. Amém.'
  text.category = 'confession'
end

# ============================================================================
# DECLARAÇÃO DE PERDÃO
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'compline_2_absolution_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Declaração de Perdão'
  text.content = 'Declaração de Perdão'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_absolution_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'O Senhor Onipotente e misericordioso nos conceda o perdão, a absolvição e a remissão de todos os nossos pecados.'
  text.category = 'confession'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_absolution_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Amém.'
  text.category = 'confession'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_absolution_minister_2', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Converte-nos, ó Deus nosso Salvador.'
  text.category = 'confession'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_absolution_all_2', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E afasta de nós a tua ira.'
  text.category = 'confession'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_absolution_minister_3', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Ó Deus, vem em nosso auxílio.'
  text.category = 'confession'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_absolution_all_3', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Senhor, apressa-te em socorrer-nos.'
  text.category = 'confession'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_gloria_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Glória ao Pai, e ao Filho, e ao Espírito Santo.'
  text.category = 'gloria'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_gloria_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'gloria'
end

# ============================================================================
# SALMO 4 - Cum invocarem
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'compline_2_psalm_4', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Salmo 4 – Cum invocarem'
  text.reference = 'Salmo 4'
  text.category = 'psalm'
  text.content = <<~TEXT.strip
    Responde-me quando clamo, ó Deus da minha justiça; na angústia, me tens aliviado;
    **Tem misericórdia de mim e ouve a minha oração.**
    Ó homens, até quando tornareis a minha glória em vexame, e amareis a vaidade, e buscareis a mentira?
    **Sabei, porém, que o Senhor distingue para si o piedoso; o Senhor me ouve quando eu clamo por ele.**
    Irai-vos e não pequeis; consultai no travesseiro o coração e sossegai.
    **Oferecei sacrifícios de justiça e confiai no Senhor.**
    Há muitos que dizem: Quem nos dará a conhecer o bem? Senhor, levanta sobre nós a luz do teu rosto.
    **Mais alegria me puseste no coração do que a alegria deles, quando lhes há fartura de cereal e de vinho.**
    Em paz me deito e logo pego no sono, porque, Senhor, só tu me fazes repousar seguro.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_psalm_4_gloria_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Glória ao Pai, e ao Filho, e ao Espírito Santo.'
  text.category = 'gloria'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_psalm_4_gloria_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'gloria'
end

# ============================================================================
# SALMO 91 - Qui habitat
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'compline_2_psalm_91', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Salmo 91 – Qui habitat'
  text.reference = 'Salmo 91'
  text.category = 'psalm'
  text.content = <<~TEXT.strip
    O que habita no esconderijo do Altíssimo e descansa à sombra do Onipotente,
    **Diz ao Senhor: meu refúgio e meu baluarte, Deus meu, em quem confio.**
    Pois ele te livrará do laço do passarinheiro e da peste perniciosa.
    **Cobrir-te-á com as suas penas, e, sob suas asas, estarás seguro; a sua verdade é pavês e escudo.**
    Não te assustarás do terror noturno, nem da seta que voa de dia,
    **nem da peste que se propaga nas trevas, nem da mortandade que assola ao meio-dia.**
    Caiam mil ao teu lado, e dez mil, à tua direita; tu não serás atingido.
    **Somente com os teus olhos contemplarás e verás o castigo dos ímpios.**
    Pois disseste: O Senhor é o meu refúgio. Fizeste do Altíssimo a tua morada.
    **Nenhum mal te sucederá, praga nenhuma chegará à tua tenda.**
    Porque aos seus anjos dará ordens a teu respeito, para que te guardem em todos os teus caminhos.
    **Eles te sustentarão nas suas mãos, para não tropeçares nalguma pedra.**
    Pisarás o leão e a áspide, calcarás aos pés o leãozinho e a serpente.
    **Porque a mim se apegou com amor, eu o livrarei; pô-lo-ei a salvo, porque conhece o meu nome.**
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_psalm_91_gloria_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Glória ao Pai, e ao Filho, e ao Espírito Santo.'
  text.category = 'gloria'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_psalm_91_gloria_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'gloria'
end

# ============================================================================
# SALMO 134 - Ecce nunc
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'compline_2_psalm_134', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Salmo 134 – Ecce nunc'
  text.reference = 'Salmo 134'
  text.category = 'psalm'
  text.content = <<~TEXT.strip
    Eis, bendizei ao Senhor,
    **Todos vós, servos do Senhor.**
    Bendizei ao Senhor, vós todos, servos do Senhor, que assistis na Casa do Senhor, nas horas da noite;
    **erguei as mãos para o santuário e bendizei ao Senhor.**
    De Sião te abençoe o Senhor, criador do céu e da terra!
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_psalm_134_gloria_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Glória ao Pai, e ao Filho, e ao Espírito Santo.'
  text.category = 'gloria'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_psalm_134_gloria_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'gloria'
end

# ============================================================================
# HINO - Te lucis ante terminum
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'compline_2_hymn_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Hino "Te lucis ante terminum"'
  text.content = '(todos de pé)'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_hymn_te_lucis', prayer_book_id: prayer_book.id) do |text|
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

    Vamos em paz adormecer;
    repousaremos nesta hora;
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
# LEITURA BÍBLICA
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'compline_2_reading_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Leitura Bíblica'
  text.content = 'O Ministro lerá: Jeremias 14:9 ou Mateus 11:28-30 ou Hebreus 13:20-21'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_reading_rubric_response', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Após a leitura dir-se-á:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_reading_response_reader', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Esta é a Palavra do Senhor!'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_reading_response_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Demos graças a Deus.'
  text.category = 'response'
end

# ============================================================================
# RESPONSÓRIO BREVE
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'compline_2_responsory_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Responsório Breve'
  text.content = 'Responsório Breve'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_responsory_1_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Nas tuas mãos, Senhor, entrego o meu espírito.'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_responsory_1_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Nas tuas mãos, Senhor, entrego o meu espírito.'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_responsory_2_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Pois tu me redimiste, Senhor, verdadeiro Deus.'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_responsory_2_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Entrego o meu espírito.'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_responsory_3_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Glória ao Pai, e ao Filho, e ao Espírito Santo.'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_responsory_3_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Nas tuas mãos, Senhor, entrego o meu espírito.'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_responsory_4_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Guarda-nos, Senhor, como a pupila dos olhos.'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_responsory_4_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Protege-nos à sombra de tuas asas.'
  text.category = 'responsory'
end

# ============================================================================
# KYRIE E PAI NOSSO
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'compline_2_kyrie_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Kyrie'
  text.content = 'Kyrie'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_kyrie_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Senhor, tem misericórdia de nós.'
  text.category = 'kyrie'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_kyrie_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Cristo, tem misericórdia de nós.'
  text.category = 'kyrie'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_kyrie_minister_2', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Senhor, tem misericórdia de nós.'
  text.category = 'kyrie'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_lords_prayer_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Pai nosso, que estás nos céus, santificado seja o teu nome. Venha o teu Reino, seja feita a tua vontade, assim na terra como no céu. O pão nosso de cada dia nos dá hoje. E perdoa-nos as nossas dívidas, assim como nós perdoamos aos nossos devedores. E não nos deixes cair em tentação, mas livra-nos do mal; pois teu é o Reino, e o poder, e a glória para sempre. Amém.'
  text.category = 'lords_prayer'
end

# ============================================================================
# VERSÍCULOS E RESPOSTAS
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'compline_2_versicle_1_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Digna-te, ó Senhor, durante esta noite,'
  text.category = 'versicle'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_versicle_1_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Guardar-nos sem pecado.'
  text.category = 'versicle'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_versicle_2_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Ouve, ó Senhor, os nossos rogos.'
  text.category = 'versicle'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_versicle_2_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E a ti chegue o nosso clamor.'
  text.category = 'versicle'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_versicle_3_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'O Senhor seja convosco.'
  text.category = 'versicle'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_versicle_3_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E com teu espírito.'
  text.category = 'versicle'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_versicle_4_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Oremos.'
  text.category = 'versicle'
end

# ============================================================================
# ORAÇÕES FINAIS
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'compline_2_final_prayers_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Podem ser realizadas as seguintes Orações e Coletas'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_final_prayer_1', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Ilumina, suplicamos-te, Senhor Deus, as nossas trevas e, misericordioso, defende-nos de todos os perigos e ciladas desta noite; por amor de teu único Filho, nosso Salvador Jesus Cristo. Amém.'
  text.category = 'collect'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_final_prayer_2', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Visita, ó Senhor, este lugar, e afasta dele todas as armadilhas do inimigo; que teus santos anjos habitem conosco para preservar-nos a paz, e que tua bênção seja sempre sobre nós; por Jesus Cristo, nosso Senhor. Amém.'
  text.category = 'collect'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_final_prayer_3', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Sê presente conosco, ó Deus de misericórdia, e protege-nos no silêncio desta noite, de sorte que nós, afligidos pelas mudanças deste mundo inconstante, repousemos na confiança do teu amor imutável e eterno; por Jesus Cristo, nosso Senhor. Amém.'
  text.category = 'collect'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_final_prayer_4', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Vela, ó Senhor amado, com os que trabalham, vigiam ou choram esta noite. Manda que teus anjos guardem os que dormem. Cuida dos enfermos. Cristo Senhor, dá repouso aos cansados, abençoa os moribundos, consola os que sofrem, compadece-te dos aflitos, defende os alegres. Tudo isto te suplicamos somente por teu grande amor. Amém.'
  text.category = 'collect'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_final_prayer_5', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Ó Deus, tua Providência inesgotável sustenta o mundo em que vivemos e também a nossa própria vida. Vela, dia e noite, os que trabalham enquanto outros dormem, e concede que jamais esqueçamos que nossa vida comunitária depende do desempenho de nossas tarefas mútuas. Por Jesus Cristo nosso Senhor. Amém.'
  text.category = 'collect'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_final_prayers_response_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Salva-nos, Senhor, enquanto acordados, e guarda-nos quando dormimos; para que, acordados, vigiemos com Cristo, e, dormindo, repousemos em paz.'
  text.category = 'antiphon'
end

# ============================================================================
# NUNC DIMITTIS
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'compline_2_nunc_dimittis_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Nunc dimittis – (Cântico de Simeão)'
  text.content = 'Nunc dimittis – (Cântico de Simeão)'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_nunc_dimittis', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Nunc Dimittis'
  text.reference = 'Lucas 2:29-32'
  text.category = 'canticle'
  text.content = <<~TEXT.strip
    Agora, Senhor, podes despedir em paz o teu servo, segundo a tua palavra;
    porque os meus olhos já viram a tua salvação,
    a qual preparaste diante de todos os povos:
    luz para revelação aos gentios, e para glória do teu povo de Israel.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_nunc_dimittis_gloria_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Glória ao Pai, e ao Filho, e ao Espírito Santo.'
  text.category = 'gloria'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_nunc_dimittis_gloria_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'gloria'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_nunc_dimittis_antiphon_repeat_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Salva-nos, Senhor, enquanto acordados, e guarda-nos quando dormimos; para que, acordados, vigiemos com Cristo, e, dormindo, repousemos em paz.'
  text.category = 'antiphon'
end

# ============================================================================
# CONCLUSÃO
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'compline_2_conclusion_versicle_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Em paz me deitarei e descansarei.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_conclusion_versicle_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Pois só tu, Senhor, nos fazes habitar em segurança.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_conclusion_1_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'O Senhor seja convosco.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_conclusion_1_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E com teu espírito.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_conclusion_2_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Bendigamos ao Senhor.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_conclusion_2_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Demos graças a Deus.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_blessing_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'O Senhor Onipotente e misericordioso, Pai, Filho e Espírito Santo, nos abençoe e nos guarde.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_blessing_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Amém.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_final_blessing_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'A Divina proteção permaneça conosco para sempre.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'compline_2_final_blessing_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E com nossos irmãos ausentes. Amém.'
  text.category = 'conclusion'
end

Rails.logger.info "✅ Textos Ofício de Completas II (LOCB 2008) carregados com sucesso!"
