Rails.logger.info "📿 Carregando textos Ofício Matutino 2 (LOCB 2008)..."

prayer_book = PrayerBook.find_by!(slug: 'locb_2008')

# Acolhida
LiturgicalText.find_or_create_by!(slug: 'morning_2_welcome_title', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Acolhida'
  text.content = nil
  text.category = 'welcome'
  text.speaker = nil
end

# Convite à Adoração - Variações por tempo litúrgico
LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Convite à Adoração'
  text.content = 'Segundo as estações, são ditas pelo Ministro:'
  text.category = 'rubric'
  text.speaker = nil
end

# Geral (2 opções)
LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_general_1', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Convite - Geral'
  text.content = 'Adorai o Senhor na beleza da sua santidade; tremei diante dele, todas as terras. Sl 96:9'
  text.category = 'invitation'
  text.speaker = 'minister'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_general_2', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Convite - Geral'
  text.content = 'Deus é espírito; e importa que os seus adoradores o adorem em espírito e em verdade. Jo 4:24'
  text.category = 'invitation'
  text.speaker = 'minister'
end

# Advento
LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_advent', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Convite - Advento'
  text.content = 'Vai alta a noite, e vem chegando o dia. Deixemos, pois, as obras das trevas e revistamo-nos das armas da luz. Rm 13:12'
  text.category = 'invitation'
  text.speaker = 'minister'
end

# Natal
LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_christmas', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Convite - Natal'
  text.content = 'O anjo, porém, lhes disse: Não temais; eis aqui vos trago boa-nova de grande alegria, que o será para todo o povo: é que hoje vos nasceu, na cidade de Davi, o Salvador, que é Cristo, o Senhor. Lc 2:10-11'
  text.category = 'invitation'
  text.speaker = 'minister'
end

# Epifania
LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_epiphany', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Convite - Epifania'
  text.content = 'Mas, desde o nascente do sol até ao poente, é grande entre as nações o meu nome; e em todo lugar lhe é queimado incenso e trazidas ofertas puras, porque o meu nome é grande entre as nações, diz o Senhor dos Exércitos. Ml 1:11'
  text.category = 'invitation'
  text.speaker = 'minister'
end

# Quaresma
LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_lent', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Convite - Quaresma'
  text.content = 'Sacrifícios agradáveis a Deus são o espírito quebrantado; coração compungido e contrito, não o desprezarás, ó Deus. Sl 51:17'
  text.category = 'invitation'
  text.speaker = 'minister'
end

# Semana Santa
LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_holy_week', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Convite - Semana Santa'
  text.content = 'Não vos comove isto, a todos vós que passais pelo caminho? Considerai e vede se há dor igual à minha, que veio sobre mim, com que o Senhor me afligiu no dia do furor da sua ira. Lm 1:12'
  text.category = 'invitation'
  text.speaker = 'minister'
end

# Sexta-feira Santa
LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_good_friday', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Convite - Sexta-feira Santa'
  text.content = 'Mas Deus prova o seu próprio amor para conosco pelo fato de ter Cristo morrido por nós, sendo nós ainda pecadores. Rm 5:8'
  text.category = 'invitation'
  text.speaker = 'minister'
end

# Vigília Pascal
LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_easter_vigil', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Convite - Vigília Pascal'
  text.content = 'Descansa no Senhor e espera nele, não te irrites por causa do homem que prospera em seu caminho, por causa do que leva a cabo os seus maus desígnios. Agrada-te do Senhor, e ele satisfará os desejos do teu coração. Sl 37:7,4'
  text.category = 'invitation'
  text.speaker = 'minister'
end

# Páscoa
LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_easter', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Convite - Páscoa'
  text.content = 'Bendito o Deus e Pai de nosso Senhor Jesus Cristo, que, segundo a sua muita misericórdia, nos regenerou para uma viva esperança, mediante a ressurreição de Jesus Cristo dentre os mortos. 1 Pe 1:3'
  text.category = 'invitation'
  text.speaker = 'minister'
end

# Ascensão
LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_ascension', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Convite - Ascensão'
  text.content = 'Tendo, pois, a Jesus, o Filho de Deus, como grande Sumo Sacerdote que penetrou os céus, conservemos firmes a nossa confissão. Acheguemo-nos, portanto, confiadamente, junto ao trono da graça, a fim de recebermos misericórdia e acharmos graça para socorro em ocasião oportuna. Hb 4:14,16'
  text.category = 'invitation'
  text.speaker = 'minister'
end

# Pentecostes
LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_pentecost', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Convite - Pentecostes'
  text.content = 'Ora, a esperança não confunde, porque o amor de Deus é derramado em nosso coração pelo Espírito Santo, que nos foi outorgado. Rm 5:5'
  text.category = 'invitation'
  text.speaker = 'minister'
end

# Trindade
LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_trinity', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Convite - Trindade'
  text.content = 'E nós conhecemos e cremos no amor que Deus tem por nós. Deus é amor, e aquele que permanece no amor permanece em Deus, e Deus, nele. 1 Jo 4:16'
  text.category = 'invitation'
  text.speaker = 'minister'
end

# Penitenciais (8 opções)
LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_penitential_1', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Convite - Penitencial'
  text.content = 'Levantar-me-ei, e irei ter com o meu pai, e lhe direi: Pai, pequei contra o céu e diante de ti; já não sou digno de ser chamado teu filho; trata-me como um dos teus trabalhadores. Lc 15:18-19'
  text.category = 'invitation'
  text.speaker = 'minister'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_penitential_2', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Convite - Penitencial'
  text.content = 'Ao Senhor, nosso Deus, pertence a misericórdia e o perdão, pois nos temos rebelado contra ele e não obedecemos à voz do Senhor, nosso Deus, para andarmos nas suas leis, que nos deu por intermédio de seus servos, os profetas. Dn 9:9-10'
  text.category = 'invitation'
  text.speaker = 'minister'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_penitential_3', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Convite - Penitencial'
  text.content = 'Não entres em juízo com o teu servo, porque à tua vista não há justo nenhum vivente. Sl 143:2'
  text.category = 'invitation'
  text.speaker = 'minister'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_penitential_4', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Convite - Penitencial'
  text.content = 'Mas, convertendo-se o perverso da perversidade que cometeu e praticando o que é reto e justo, conservará ele a sua alma em vida. Ez 18:27'
  text.category = 'invitation'
  text.speaker = 'minister'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_penitential_5', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Convite - Penitencial'
  text.content = 'Pois eu conheço as minhas transgressões, e o meu pecado está sempre diante de mim. Sl 51:3'
  text.category = 'invitation'
  text.speaker = 'minister'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_penitential_6', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Convite - Penitencial'
  text.content = 'Esconde o rosto dos meus pecados e apaga todas as minhas iniquidades. Sl 51:9'
  text.category = 'invitation'
  text.speaker = 'minister'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_penitential_7', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Convite - Penitencial'
  text.content = 'Castiga-me, ó Senhor, mas em justa medida, não na tua ira, para que não me reduzas a nada. Jr 10:24'
  text.category = 'invitation'
  text.speaker = 'minister'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_penitential_8', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Convite - Penitencial'
  text.content = 'Senhor, não me repreendas na tua ira, nem me castigues no teu furor. Sl 6:1'
  text.category = 'invitation'
  text.speaker = 'minister'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_penitential_9', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Convite - Penitencial'
  text.content = 'Arrependei-vos, porque está próximo o reino dos céus. Mt 3:2'
  text.category = 'invitation'
  text.speaker = 'minister'
end

LiturgicalText.find_or_create_by!(slug: 'morning_2_invitation_penitential_10', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Convite - Penitencial'
  text.content = 'Rasgai o vosso coração, e não as vossas vestes, e convertei-vos ao Senhor, vosso Deus, porque ele é misericordioso, e compassivo, e tardio em irar-se, e grande em benignidade, e se arrepende do mal. Jl 2:13'
  text.category = 'invitation'
  text.speaker = 'minister'
end
