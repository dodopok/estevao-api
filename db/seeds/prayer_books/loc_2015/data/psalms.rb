# Seeds for Psalms
# TODO: Replace with complete 150 psalms from LOC 2015
# This creates a few example psalms to demonstrate the structure

Rails.logger.info "Creating example Psalms..."
prayer_book = PrayerBook.find_by!(code: 'loc_2015')

# Psalm 1
Psalm.find_or_create_by!(number: 1, prayer_book_id: prayer_book.id) do |p|
  p.title = 'Os Dois Caminhos'
  p.verses = [
    { number: 1, text: 'Bem-aventurado o homem que não anda no conselho dos ímpios, não se detém no caminho dos pecadores, nem se assenta na roda dos escarnecedores.', hebrew_pointer: '1a' },
    { number: 2, text: 'Antes, o seu prazer está na lei do Senhor, e na sua lei medita de dia e de noite.', hebrew_pointer: '1b' },
    { number: 3, text: 'Ele é como árvore plantada junto a corrente de águas, que, no devido tempo, dá o seu fruto, e cuja folhagem não murcha; e tudo quanto ele faz será bem sucedido.', hebrew_pointer: '2' },
    { number: 4, text: 'Os ímpios não são assim; são, porém, como a palha que o vento dispersa.', hebrew_pointer: '3a' },
    { number: 5, text: 'Por isso, os perversos não prevalecerão no juízo, nem os pecadores, na congregação dos justos.', hebrew_pointer: '3b' },
    { number: 6, text: 'Pois o Senhor conhece o caminho dos justos, mas o caminho dos perversos perecerá.', hebrew_pointer: '4' }
  ]
end

# Psalm 23
Psalm.find_or_create_by!(number: 23, prayer_book_id: prayer_book.id) do |p|
  p.title = 'O Bom Pastor'
  p.verses = [
    { number: 1, text: 'O Senhor é o meu pastor; nada me faltará.', hebrew_pointer: '1' },
    { number: 2, text: 'Ele me faz repousar em pastos verdejantes. Leva-me para junto das águas de descanso;', hebrew_pointer: '2a' },
    { number: 3, text: 'refrigera-me a alma. Guia-me pelas veredas da justiça por amor do seu nome.', hebrew_pointer: '2b' },
    { number: 4, text: 'Ainda que eu ande pelo vale da sombra da morte, não temerei mal nenhum, porque tu estás comigo; o teu bordão e o teu cajado me consolam.', hebrew_pointer: '3' },
    { number: 5, text: 'Preparas-me uma mesa na presença dos meus adversários, unges-me a cabeça com óleo; o meu cálice transborda.', hebrew_pointer: '4' },
    { number: 6, text: 'Bondade e misericórdia certamente me seguirão todos os dias da minha vida; e habitarei na Casa do Senhor para todo o sempre.', hebrew_pointer: '5' }
  ]
end

# Psalm 95 (Venite)
Psalm.find_or_create_by!(number: 95, prayer_book_id: prayer_book.id) do |p|
  p.title = 'Venite'
  p.verses = [
    { number: 1, text: 'Vinde, cantemos ao Senhor, com júbilo, celebremos o Rochedo da nossa salvação.', hebrew_pointer: '1' },
    { number: 2, text: 'Saiamos ao seu encontro com ações de graças, vitoriemo-lo com salmos.', hebrew_pointer: '2' },
    { number: 3, text: 'Porque o Senhor é o Deus supremo e o grande Rei acima de todos os deuses.', hebrew_pointer: '3' },
    { number: 4, text: 'Nas suas mãos estão as profundezas da terra, e as alturas dos montes lhe pertencem.', hebrew_pointer: '4a' },
    { number: 5, text: 'Dele é o mar, pois ele o fez, e as suas mãos formaram a terra seca.', hebrew_pointer: '4b' },
    { number: 6, text: 'Vinde, adoremos e prostremo-nos; ajoelhemos-nos diante do Senhor, que nos criou.', hebrew_pointer: '5' },
    { number: 7, text: 'Ele é o nosso Deus, e nós, povo do seu pasto e ovelhas de sua mão.', hebrew_pointer: '6' }
  ]
end

# Psalm 100 (Jubilate)
Psalm.find_or_create_by!(number: 100, prayer_book_id: prayer_book.id) do |p|
  p.title = 'Jubilate'
  p.verses = [
    { number: 1, text: 'Celebrai com júbilo ao Senhor, todas as terras.', hebrew_pointer: '1' },
    { number: 2, text: 'Servi ao Senhor com alegria, apresentai-vos diante dele com cântico.', hebrew_pointer: '2' },
    { number: 3, text: 'Sabei que o Senhor é Deus; foi ele quem nos fez, e dele somos; somos o seu povo e rebanho do seu pasto.', hebrew_pointer: '3' },
    { number: 4, text: 'Entrai por suas portas com ações de graça e nos seus átrios, com hinos de louvor; rendei-lhe graças e bendizei o seu nome.', hebrew_pointer: '4' },
    { number: 5, text: 'Porque o Senhor é bom, a sua misericórdia dura para sempre, e, de geração em geração, a sua fidelidade.', hebrew_pointer: '5' }
  ]
end

# Compline Psalms
# Psalm 4
Psalm.find_or_create_by!(number: 4, prayer_book_id: prayer_book.id) do |p|
  p.title = 'Oração Vespertina'
  p.verses = [
    { number: 1, text: 'Responde-me quando clamo, ó Deus da minha justiça; na angústia, me deste alívio; tem misericórdia de mim e ouve a minha oração.', hebrew_pointer: '1' },
    { number: 2, text: 'Filhos dos homens, até quando será a minha glória ultrajada? Até quando amareis a vaidade e buscareis a mentira?', hebrew_pointer: '2' },
    { number: 3, text: 'Sabei, pois, que o Senhor distingue para si o piedoso; o Senhor me ouvirá quando eu clamar por ele.', hebrew_pointer: '3' },
    { number: 4, text: 'Tremei e não pequeis; refletí no coração, sobre a cama, e sossegai.', hebrew_pointer: '4' },
    { number: 5, text: 'Oferecei sacrifícios de justiça e confiai no Senhor.', hebrew_pointer: '5' },
    { number: 6, text: 'Muitos dizem: Quem nos dará a conhecer o bem? Senhor, levanta sobre nós a luz do teu rosto.', hebrew_pointer: '6' },
    { number: 7, text: 'Puseste alegria no meu coração, alegria maior do que a daqueles cujos cereais e vinho são abundantes.', hebrew_pointer: '7' },
    { number: 8, text: 'Em paz me deito e logo pego no sono, porque, Senhor, só tu me fazes repousar seguro.', hebrew_pointer: '8' }
  ]
end

# Psalm 91
Psalm.find_or_create_by!(number: 91, prayer_book_id: prayer_book.id) do |p|
  p.title = 'Segurança do que Confia em Deus'
  p.verses = [
    { number: 1, text: 'Aquele que habita no esconderijo do Altíssimo e descansa à sombra do Onipotente', hebrew_pointer: '1' },
    { number: 2, text: 'diz ao Senhor: Meu refúgio e meu baluarte, Deus meu, em quem confio.', hebrew_pointer: '2' },
    { number: 3, text: 'Pois ele te livrará do laço do passarinheiro e da peste perniciosa.', hebrew_pointer: '3' },
    { number: 4, text: 'Cobrir-te-á com as suas penas, e, sob suas asas, estarás seguro; a sua verdade é pavês e escudo.', hebrew_pointer: '4' },
    { number: 5, text: 'Não te assustarás do terror noturno, nem da seta que voa de dia,', hebrew_pointer: '5' },
    { number: 6, text: 'nem da peste que se propaga nas trevas, nem da mortandade que assola ao meio-dia.', hebrew_pointer: '6' }
  ]
end

# Psalm 134
Psalm.find_or_create_by!(number: 134, prayer_book_id: prayer_book.id) do |p|
  p.title = 'Exortação ao Louvor Noturno'
  p.verses = [
    { number: 1, text: 'Vinde, bendizei ao Senhor, vós todos os servos do Senhor, que assistis na Casa do Senhor durante a noite.', hebrew_pointer: '1' },
    { number: 2, text: 'Levantai as mãos para o santuário e bendizei ao Senhor.', hebrew_pointer: '2' },
    { number: 3, text: 'O Senhor te abençoe desde Sião, ele que fez os céus e a terra.', hebrew_pointer: '3' }
  ]
end

Rails.logger.info "Created #{Psalm.count} example psalms"
Rails.logger.info "NOTE: You need to add all 150 psalms from LOC 2015. These are just examples."
