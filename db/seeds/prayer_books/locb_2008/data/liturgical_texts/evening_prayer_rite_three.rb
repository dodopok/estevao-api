# frozen_string_literal: true

Rails.logger.info "🌙 Carregando textos Ofício Vespertino 3 (LOCB 2008)..."

prayer_book = PrayerBook.find_by!(code: 'locb_2008')

# ==============================================================================
# ORAÇÃO VESPERTINA III - Introdução/Acolhida
# ==============================================================================

# Acolhida
LiturgicalText.find_or_create_by!(slug: 'evening_3_welcome_minister', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Acolhida'
  text.content = 'Estamos reunidos, como família de Deus, na presença de nosso Pai, para lhe oferecer louvor e ações de graças, escutar e acolher a sua santa Palavra, apresentar-lhe as carências do mundo, implorar-lhe o perdão dos nossos pecados e pedir a sua graça, a fim de que, mediante seu Filho Jesus Cristo, nos entreguemos ao seu serviço.'
  text.category = 'welcome'
end

# Frase Bíblica (rubrica)
LiturgicalText.find_or_create_by!(slug: 'evening_3_scripture_sentence_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Pode-se ler uma Frase Bíblica (p.131) e cantar um Hino'
  text.category = 'rubric'
end

# ==============================================================================
# CONVITE À CONFISSÃO
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_3_confession_invitation_minister', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Convite à Confissão'
  text.content = 'Se dissermos que não temos pecado enganamo-nos a nós próprios e faltamos à verdade; mas, se confessarmos os nossos pecados, Deus, que é fiel e justo, perdoará os nossos pecados e purificar-nos-á de toda a iniquidade.'
  text.category = 'confession'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_confession_alternative_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Em vez da admoestação anterior, o Ministro poderá dizer uma Frase Bíblica (p.248) que desperte o espírito de penitência'
  text.category = 'rubric'
end

# ==============================================================================
# CONFISSÃO
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_3_confession_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Confessemos os nossos pecados a Deus Onipotente.'
  text.category = 'confession'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_confession_prayer_all', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Confissão'
  text.content = 'Deus Todo-poderoso, nosso Pai celestial, confessamos, arrependidos, ter pecado contra Ti em pensamentos, palavras e atos, tanto no mal que fizemos como no bem que deixamos de fazer por negligência, fraqueza e intenção. Por amor de teu Filho Jesus Cristo, que morreu por nós, perdoa-nos todo o passado e concede que Te sirvamos com vidas renovadas, para glória do teu nome. Amém.'
  text.category = 'confession'
end

# ==============================================================================
# DECLARAÇÃO DE PERDÃO
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_3_absolution_minister', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Declaração de Perdão'
  text.content = 'Deus onipotente, que perdoa a todos os que verdadeiramente se arrependem, tenha misericórdia de vós, vos perdoe e liberte de todos os vossos pecados, vos confirme e fortaleça em todo o bem e vos guarde na vida eterna. Mediante Jesus Cristo, nosso Senhor.'
  text.category = 'absolution'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_absolution_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Amém.'
  text.category = 'absolution'
end

# A Introdução Penitencial pode ser omitida (rubrica)
LiturgicalText.find_or_create_by!(slug: 'evening_3_penitential_omit_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'A Introdução Penitencial antecedente pode ser omitida, salvo se for domingo'
  text.category = 'rubric'
end

# ==============================================================================
# RESPONSO
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_3_response_1_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Senhor, abre os nossos lábios.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_response_1_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'E a nossa boca proclamará o teu louvor.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_response_2_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Adoremos o Senhor.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_response_2_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Bendigamos a Deus.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_response_3_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Glória ao Pai e ao Filho e ao Espírito Santo.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_response_3_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'response'
end

# ==============================================================================
# CÂNTICO INVITATÓRIO - ANTES DA LEITURA
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_3_canticle_invitatory_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Usa-se um dos seguintes Cânticos, que pode ser precedido e seguido de Antífona'
  text.category = 'rubric'
end

# Salmo 134
LiturgicalText.find_or_create_by!(slug: 'evening_3_psalm_134', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Salmo 134'
  text.content = 'Bendizei ao Senhor, vós todos, servos do Senhor, que assistis na Casa do Senhor, nas horas da noite;
**Erguei as mãos para o santuário e bendizei ao Senhor.**
De Sião te abençoe o Senhor, criador do céu e da terra!'
  text.category = 'canticle'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_psalm_134_gloria_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Glória ao Pai e ao Filho e ao Espírito Santo.'
  text.category = 'canticle'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_psalm_134_gloria_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'canticle'
end

# Phos hilaron (Luz Alegre)
LiturgicalText.find_or_create_by!(slug: 'evening_3_phos_hilaron', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Phos hilaron'
  text.content = 'Salve, alegre luz, puro esplendor da gloriosa face paternal.
Salve, Jesus, bendito Salvador, Cristo ressuscitado e imortal.
**No horizonte o sol já declinou, brilham da noite as luzes cintilantes: ao Pai, ao Filho, ao Espírito de amor cantemos nossos hinos exultantes.**
De santas vozes sobe a adoração prestada a Ti, Jesus, Filho de Deus. Inteira, canta glória a criação, o universo, a terra, os novos céus.'
  text.category = 'canticle'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_phos_hilaron_gloria_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Glória ao Pai e ao Filho e ao Espírito Santo.'
  text.category = 'canticle'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_phos_hilaron_gloria_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'canticle'
end

# ==============================================================================
# SALMODIA
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_3_psalms_rubric', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Salmodia'
  text.content = 'Cada Salmo ou grupo de Salmos deve terminar com a Doxologia que segue. Para os Ofícios diários, os Salmos são indicados no Lecionário, pp.347 a 358:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_psalms_gloria_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Glória ao Pai e ao Filho e ao Espírito Santo.'
  text.category = 'psalms'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_psalms_gloria_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'psalms'
end

# ==============================================================================
# LEITURA DO ANTIGO TESTAMENTO
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_3_ot_reading_response_reader', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Esta é a palavra do Senhor.'
  text.category = 'readings'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_ot_reading_response_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Graças a Deus.'
  text.category = 'readings'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_silence_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Guarda-se silêncio'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_canticle_after_reading_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Usa-se um dos seguintes Cânticos, que pode ser precedido e seguido de Antífona'
  text.category = 'rubric'
end

# ==============================================================================
# CÂNTICOS - PÓS PRIMEIRA LEITURA
# ==============================================================================

# Magnificat (Cântico da Virgem Maria - Lc 1:46-55)
LiturgicalText.find_or_create_by!(slug: 'evening_3_magnificat', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Magnificat'
  text.reference = 'Lc 1:46-55'
  text.content = 'A minha alma engrandece ao Senhor, e o meu espírito se alegrou em Deus, meu Salvador,
**porque contemplou na humildade da sua serva. Pois, desde agora, todas as gerações me considerarão bem-aventurada, porque o poderoso me fez grandes coisas. Santo é o seu nome.**
A sua misericórdia vai de geração em geração sobre os que o temem. Agiu com o seu braço valorosamente; dispersou os que, no coração, alimentavam pensamentos soberbos.
**Derribou do seu trono os poderosos e exaltou os humildes.**
Encheu de bens os famintos e despediu vazios os ricos.
**Amparou a Israel, seu servo, a fim de lembrar-se da sua misericórdia a favor de Abraão e de sua descendência, para sempre, como prometera aos nossos pais.**'
  text.category = 'canticle'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_magnificat_gloria_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Glória ao Pai e ao Filho e ao Espírito Santo.'
  text.category = 'canticle'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_magnificat_gloria_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'canticle'
end

# Benedic, anima mea (Salmo 103)
LiturgicalText.find_or_create_by!(slug: 'evening_3_benedic_anima_mea', prayer_book_id: prayer_book.id) do |text|
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

LiturgicalText.find_or_create_by!(slug: 'evening_3_benedic_anima_mea_gloria_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Glória ao Pai e ao Filho e ao Espírito Santo.'
  text.category = 'canticle'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_benedic_anima_mea_gloria_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'canticle'
end

# ==============================================================================
# LEITURA DO NOVO TESTAMENTO
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_3_nt_reading_response_reader', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Esta é a palavra do Senhor.'
  text.category = 'readings'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_nt_reading_response_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Graças a Deus.'
  text.category = 'readings'
end

# Sermão (rubrica)
LiturgicalText.find_or_create_by!(slug: 'evening_3_sermon_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Guardar-se-á silêncio. Havendo Sermão, pregar-se-á aqui, ou no fim do Ofício. Usa-se um dos seguintes Cânticos'
  text.category = 'rubric'
end

# ==============================================================================
# CÂNTICOS - PÓS SEGUNDA LEITURA
# ==============================================================================

# Nunc dimittis (Cântico de Simeão - Lc 2:29-32)
LiturgicalText.find_or_create_by!(slug: 'evening_3_nunc_dimittis', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Nunc dimittis'
  text.reference = 'Lc 2:29-32'
  text.content = 'Agora, Senhor, podes despedir em paz o teu servo, segundo a tua palavra;
**porque os meus olhos já viram a tua salvação, a qual preparaste diante de todos os povos:**
luz para revelação aos gentios, e para glória do teu povo de Israel.'
  text.category = 'canticle'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_nunc_dimittis_gloria_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Glória ao Pai e ao Filho e ao Espírito Santo.'
  text.category = 'canticle'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_nunc_dimittis_gloria_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'canticle'
end

# Cântico da glória de Cristo (Fl 2:6-11)
LiturgicalText.find_or_create_by!(slug: 'evening_3_canticle_christ_glory', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Cântico da glória de Cristo'
  text.reference = 'Fl 2:6-11'
  text.content = 'Pois Cristo, subsistindo em forma de Deus, não julgou como usurpação o ser igual a Deus;
**antes a si mesmo se esvaziou, assumindo a forma de servo, tornando-se em semelhança de homens; e, reconhecido em figura humana,**
a si mesmo se humilhou, tornando-se obediente até à morte e morte de cruz.
**Pelo que também Deus o exaltou sobremaneira e lhe deu o nome que está acima de todo nome,**
para que ao nome de Jesus se dobre todo joelho, nos céus, na terra e debaixo da terra,
**e toda língua confesse que Jesus Cristo é Senhor, para glória de Deus Pai.**'
  text.category = 'canticle'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_canticle_christ_glory_gloria_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Glória ao Pai e ao Filho e ao Espírito Santo.'
  text.category = 'canticle'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_canticle_christ_glory_gloria_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'canticle'
end

# Glória e honra (Ap 4:11; 5:9,10,12)
LiturgicalText.find_or_create_by!(slug: 'evening_3_gloria_et_honor', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Glória e honra'
  text.reference = 'Ap 4:11; 5:9,10,12'
  text.content = 'Tu és digno, Senhor e Deus nosso, de receber a glória, a honra e o poder,
**porque todas as coisas tu criaste, sim, por causa da tua vontade vieram a existir e foram criadas.**
Digno és de tomar o livro e de abrir-lhe os selos, porque foste morto e com o teu sangue compraste para Deus os que procedem de toda tribo, língua, povo e nação e para o nosso Deus os constituíste reino e Ministros; e reinarão sobre a terra.
**Digno é o Cordeiro que foi morto de receber o poder, e riqueza, e sabedoria, e força, e honra, e glória, e louvor.**'
  text.category = 'canticle'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_gloria_et_honor_gloria_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Glória ao Pai e ao Filho e ao Espírito Santo.'
  text.category = 'canticle'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_gloria_et_honor_gloria_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'canticle'
end

# ==============================================================================
# CREDO DOS APÓSTOLOS
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_3_creed_all', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Credo dos Apóstolos'
  text.content = 'Creio em Deus Pai Todo-poderoso, Criador do Céu e da Terra; e em Jesus Cristo seu único Filho, nosso Senhor: o qual foi concebido por obra do Espírito Santo, nasceu da Virgem Maria; padeceu sob o poder de Pôncio Pilatos, foi crucificado, morto e sepultado; desceu ao Hades; ressuscitou ao terceiro dia; subiu ao céu, e está sentado à mão direita de Deus Pai Todo-poderoso: donde há de vir a julgar os vivos e os mortos. Creio no Espírito Santo; na santa Igreja Católica; na comunhão dos santos; na remissão dos pecados; na ressurreição do corpo; e na Vida Eterna. Amém.'
  text.category = 'creed'
end

# ==============================================================================
# ORAÇÕES
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_3_prayers_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'E a seguir'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_kyrie_1_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Senhor, tem misericórdia de nós.'
  text.category = 'prayers'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_kyrie_1_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Cristo tem misericórdia de nós.'
  text.category = 'prayers'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_kyrie_2_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Senhor, tem misericórdia de nós.'
  text.category = 'prayers'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_prayers_invitation', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Oremos.'
  text.category = 'prayers'
end

# Pai Nosso
LiturgicalText.find_or_create_by!(slug: 'evening_3_lords_prayer_all', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Pai Nosso'
  text.content = 'Pai nosso, que estás nos céus, santificado seja o teu nome. Venha o teu Reino, seja feita a tua vontade, assim na terra como no céu. O pão nosso de cada dia nos dá hoje. E perdoa-nos as nossas dívidas, assim como nós perdoamos aos nossos devedores. E não nos deixes cair em tentação, mas livra-nos do mal; pois teu é o Reino, e o poder, e a glória para sempre. Amém.'
  text.category = 'lords_prayer'
end

# Responsório
LiturgicalText.find_or_create_by!(slug: 'evening_3_responsory_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Pode-se dizer o responsório seguinte'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_responsory_1_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Senhor, mostra-nos a tua misericórdia,'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_responsory_1_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'e concede-nos a tua salvação.'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_responsory_2_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Reveste os teus Ministros de virtude,'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_responsory_2_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'e enche o teu povo de alegria.'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_responsory_3_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Dá a tua paz ao mundo,'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_responsory_3_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'pois só em Ti achamos segurança.'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_responsory_4_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Toma o Brasil ao teu cuidado,'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_responsory_4_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'guia-nos pelas veredas da justiça e da verdade.'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_responsory_5_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Sejam conhecidos na terra os teus propósitos,'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_responsory_5_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'e entre as nações a tua salvação.'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_responsory_6_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Encontrem os necessitados socorro,'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_responsory_6_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'e não esmoreça a esperança dos pobres.'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_responsory_7_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Purifica, ó Deus, os nossos corações,'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_responsory_7_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'e fortalece-nos com o teu Santo Espírito.'
  text.category = 'responsory'
end

# ==============================================================================
# COLETA DO DIA E ORAÇÕES FINAIS
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_3_collect_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Dir-se-á a Oração do Dia e uma ou mais das seguintes Orações'
  text.category = 'rubric'
end

# Oração Final 1
LiturgicalText.find_or_create_by!(slug: 'evening_3_final_prayer_1', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Ó Deus origem dos desejos bons, dos pensamentos retos e das obras justas: dá aos teus servos aquela paz que o mundo não pode dar; para que, determinados a cumprir os teus mandamentos, repousemos tranquilos, livres do medo dos nossos inimigos. Mediante Jesus Cristo, nosso Senhor. Amém.'
  text.category = 'collect'
end

# Oração Final 2
LiturgicalText.find_or_create_by!(slug: 'evening_3_final_prayer_2', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Ilumina as nossas trevas, nós te pedimos, Senhor; e, pela tua misericórdia, defende-nos nas incertezas e perigos desta noite. Por amor de teu único Filho, nosso Salvador Jesus Cristo. Amém.'
  text.category = 'collect'
end

# Oração Final 3
LiturgicalText.find_or_create_by!(slug: 'evening_3_final_prayer_3', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Senhor Deus, pedimos a tua bênção:
para a tua Igreja, santidade;
para o mundo, paz;
para esta nação, justiça;
para todos os povos, o conhecimento da tua lei;
guarda de todo o perigo as nossas famílias;
protege os fracos;
cura os doentes;
conforta os moribundos;
e conduz os mortos a uma alegre ressurreição.
Mediante Jesus Cristo, nosso Senhor. Amém'
  text.category = 'collect'
end

# ==============================================================================
# OUTRAS ORAÇÕES (opcional)
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_3_other_prayers_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Podem-se cantar Hinos, dizer Orações, Litanias e Ações de Graças; pode ser pregado aqui um Sermão; e o Ofício termina com uma fórmula de Bênção ou de Conclusão'
  text.category = 'rubric'
end

# ==============================================================================
# CONCLUSÃO / DESPEDIDA
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'evening_3_conclusion_dismissal_minister', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Despedida'
  text.content = 'Ide na paz de Cristo! Sede corajosos e fortes no testemunho do Evangelho entre todas as pessoas. Servi ao Senhor com alegria.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_conclusion_dismissal_people', prayer_book_id: prayer_book.id) do |text|
    text.content = 'No poder do Espírito Santo.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'evening_3_conclusion_dismissal_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Aleluia!'
  text.category = 'conclusion'
end

Rails.logger.info 'LOCB 2008 Evening Prayer III liturgical texts created successfully!'
