# frozen_string_literal: true

def create_text(slug, category, content, reference: nil, title: nil)
  LiturgicalText.find_or_create_by!(
    prayer_book: PrayerBook.find_by(code: 'loc_2021'),
    slug: slug
  ) do |t|
    t.category = category
    t.content = content
    t.reference = reference
    t.title = title
  end
end

# ================================================================================
# ORAÇÃO DA MANHÃ E ORAÇÃO DA TARDE (OU NOITE)
# ================================================================================

# ACOLHIDA
create_text('opening_welcome_m', 'opening_sentence', "Estamos reunidos, como família de Deus, na presença de nosso Pai, para Lhe oferecer louvor e ações de graças, escutar e acolher a sua santa Palavra, implorar o perdão dos nossos pecados e pedir a Sua graça, a fim de que, mediante Seu Filho, Jesus Cristo, nos entreguemos ao Seu serviço.")

# CONVITE À CONFISSÃO
create_text('confession_invitation_m1', 'confession', "Se dissermos que não temos pecado enganamo-nos a nós mesmos e faltamos com a verdade; mas, se confessarmos os nossos pecados, Deus, que é fiel e justo, perdoará os nossos pecados e nos purificará de toda a injustiça.")
create_text('confession_invitation_m2', 'confession', "Confessemos ao Senhor os nossos pecados.")

# CONFISSÃO
create_text('confession_body', 'confession',
  "Deus todo-poderoso, nosso Pai celestial, confessamos, arrependidos, ter pecado contra Ti em pensamentos, palavras e atos, tanto no mal que fizemos como no bem que deixamos de fazer, por negligência, fraqueza e intenção. Por amor de Teu Filho, Jesus Cristo, que morreu por nós, perdoa-nos todo o passado e concede que Te sirvamos com vidas renovadas, para glória do Teu Nome. Amém.")

# DECLARAÇÃO DE PERDÃO
create_text('absolution_m', 'absolution', "Deus onipotente, que perdoa a todos os que verdadeiramente se arrependem, tenha misericórdia de vós, vos perdoe e liberte de todos os vossos pecados, vos confirme e fortaleça em todo o bem e vos guarde na vida eterna. Em nome de Jesus Cristo, nosso Senhor.")
create_text('absolution_r', 'absolution', "Amém.")

# ORAÇÃO DE AÇÃO DE GRAÇAS
create_text('thanksgiving_m', 'thanksgiving',
  "Bendito sejas, Senhor Nosso Deus, Criador e Redentor de todos e de tudo; a Ti seja o louvor e a glória para sempre. Do nada criastes o Universo e por Teu amor nos criaste à Tua imagem e semelhança. Agora, através do vale da sombra da morte, tens conduzido Teu povo ao Novo Nascimento para, através de Teu Filho, viver em triunfo. Possa Cristo sempre iluminar o nosso coração a fim de oferecermos sacrifícios de louvor e ações de graça. Bendito seja Deus, Pai, Filho e Espírito Santo:")
create_text('thanksgiving_r', 'thanksgiving',
  "Bendito seja Deus para sempre.")

# LEITURA DAS ESCRITURAS
create_text('reading_introduction', 'rubric', "Após a leitura, o leitor pode dizer:")
create_text('reading_v', 'reading', "Leitor: Esta é a Palavra do Senhor")
create_text('reading_r', 'reading', "Graças a Deus")

# A BÊNÇÃO
create_text('blessing_m', 'blessing', "A Graça de Nosso Senhor Jesus Cristo, o amor do Pai e a comunhão do Espírito Santo seja com todos nós.")
create_text('blessing_r', 'blessing', "Amém.")

# OFÍCIO ALTERNATIVO
create_text('alt_office_intro', 'rubric', "O Ministro dá as boas-vindas ao povo e anuncia o louvor de abertura")
create_text('alt_office_welcome_m', 'opening_sentence',
  "Juntos chegamos na presença de nosso Pai para oferecer por Jesus Cristo, louvor e ação de graças, para ouvirmos a Sua Santa Palavra, orar pelos outros como por nós mesmos e pedir perdão de nossos pecados. Confessemos os nossos pecados a Deus Todo-poderoso e oremos juntos:")

create_text('alt_confession_rubric', 'rubric', "O ministro declara o PERDÃO DE DEUS, dizendo")

create_text('alt_confession_body', 'confession',
  "Todo-poderoso e misericordioso Pai, nós temos errado e andado como ovelhas perdidas. Seguimos demasiadamente os desejos e inclinações de nosso coração. Quebramos as Tuas santas leis. Temos feito o que não deveríamos e não fizemos o que deveríamos fazer. Tenha misericórdia de nós, ó Deus, pecadores arrependidos, que confessamos as nossas culpas. Restabelece aos que verdadeiramente se arrependem, como prometeste por Teu Filho Jesus Cristo, nosso Senhor, e concede, ó Pai misericordioso, por tua bondade, que vivamos de modo santo, reto e disciplinado para a glória do teu santo nome. Amém.")

create_text('alt_absolution_m', 'absolution', "Que o Pai das misericórdias nos purifique de nossos pecados e restaure em nós a Sua imagem para o louvor e glória de Seu nome, por Cristo Nosso Senhor.")
create_text('alt_absolution_r', 'absolution', "Amém.")

create_text('other_prayers_rubric', 'rubric', "Outras orações, incluindo pedidos em favor da Igreja, dos Bispos e pastores, das pessoas que tenham autoridade civil, e outros podem ser feitos aqui.")

# A GRAÇA
create_text('grace_m', 'blessing', "A Graça de Nosso Senhor Jesus Cristo, o amor do Pai e a comunhão do Espírito Santo seja com todos vós.")
create_text('grace_r', 'blessing', "Amém")

create_text('aaronic_blessing_m', 'blessing',
  "O Senhor te abençoe e te guarde; o Senhor faça resplandecer o rosto sobre ti e tenha misericórdia de ti; o Senhor sobre ti levante o rosto e te dê a paz.")

# CREDOS
create_text('credo_apostolico', 'creed',
  "Creio em Deus Pai Todo-poderoso, Criador do céu e da terra; E em Jesus Cristo, seu único Filho, nosso Senhor, o qual foi concebido por obra do Espírito Santo, nasceu da virgem Maria, padeceu sob o poder de Pôncio Pilatos, foi crucificado, morto e sepultado; desceu ao Hades, ressuscitou ao terceiro dia, subiu ao céu e está sentado à direita de Deus Pai Todo-poderoso, de onde há de vir a julgar os vivos e os mortos. Creio no Espírito Santo, na santa igreja católica, na comunhão dos santos, na remissão dos pecados, na ressurreição do corpo, na vida eterna. Amém.",
  title: "Credo Apostólico")

create_text('credo_niceno', 'creed',
  "Cremos em um só Deus, Pai todo-poderoso, criador do céu e da terra, de todas as coisas visíveis e invisíveis. Cremos em um só Senhor, Jesus Cristo, Filho Unigênito de Deus, gerado do Pai desde toda a eternidade, Deus de Deus, Luz de Luz, Deus verdadeiro de Deus verdadeiro, gerado, não criado, consubstancial ao Pai; por Ele todas as coisas foram feitas. Por nós e para nossa salvação, desceu dos céus; encarnou por obra do Espírito Santo, no seio da Virgem Maria, e fez-se verdadeiro homem. Por nós foi crucificado sob Pôncio Pilatos; sofreu a morte e foi sepultado. Ressuscitou ao terceiro dia, conforme as Escrituras; subiu aos céus, e está sentado à direita do Pai. De novo há de vir em glória, para julgar os vivos e os mortos; e o seu reino não terá fim. Cremos no Espírito Santo, o Senhor, a fonte da vida que procede do Pai e do Filho; com o Pai e o Filho é adorado e glorificado. Ele falou pelos profetas. Cremos na Igreja una, santa, católica e apostólica. Professamos um só Batismo para remissão dos pecados. Esperamos a ressurreição dos mortos, e a vinda do mundo que há de vir. Amém.",
  title: "Credo Niceno")

# ORAÇÃO DO SENHOR
create_text('lords_prayer_contemporary', 'prayer',
  "Pai Nosso que estás nos céus! Santificado seja o Teu Nome! Venha o Teu Reino! Seja feita a tua vontade, assim na terra como nos céus. O pão nosso de cada dia nos dá hoje! E perdoa as nossa dívidas, assim como nós perdoamos aos nossos devedores. E não nos deixes cair em tentação, mas livra-nos do mal! Pois teu é o Reino, o poder e a Glória para sempre. Amém.",
  title: "Oração do Senhor")