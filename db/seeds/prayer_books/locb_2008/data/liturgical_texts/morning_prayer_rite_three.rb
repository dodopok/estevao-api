Rails.logger.info "📿 Carregando textos Ofício Matutino 3 (LOCB 2008)..."

prayer_book = PrayerBook.find_by!(code: 'locb_2008')

# ==============================================================================
# ORAÇÃO MATUTINA III
# ==============================================================================

# Acolhida
LiturgicalText.find_or_create_by!(slug: 'morning_3_welcome_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Acolhida'
  text.content = 'Estamos reunidos, como família de Deus, na presença de nosso Pai, para lhe oferecer louvor e ações de graças, escutar e acolher a sua santa Palavra, apresentar-lhe as carências do mundo, implorar-lhe o perdão dos nossos pecados e pedir a sua graça, a fim de que, mediante seu Filho, Jesus Cristo, nos entreguemos ao seu serviço.'
  text.category = 'welcome'
end

# Frase Bíblica (rubrica)
LiturgicalText.find_or_create_by!(slug: 'morning_3_scripture_sentence_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Sugestões encontram-se à p.128'
  text.category = 'rubric'
end

# Convite à Confissão
LiturgicalText.find_or_create_by!(slug: 'morning_3_confession_invitation_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Convite à Confissão'
  text.content = 'Se dissermos que não temos pecado enganamo-nos a nós próprios e faltamos à verdade; mas, se confessarmos os nossos pecados, Deus, que é fiel e justo, perdoará os nossos pecados e nos purificará de toda a iniquidade.'
  text.category = 'confession'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_confession_alternative_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Em vez da admoestação anterior, o Ministro poderá dizer uma Frase Bíblica (p.248) que desperte espírito de penitência'
  text.category = 'rubric'
end

# Confissão
LiturgicalText.find_or_create_by!(slug: 'morning_3_confession_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Confessemos os nossos pecados a Deus onipotente.'
  text.category = 'confession'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_confession_prayer_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Confissão'
  text.content = 'Deus Todo-poderoso, nosso Pai celestial, confessamos, arrependidos, ter pecado contra Ti em pensamentos, palavras e atos, tanto no mal que fizemos como no bem que deixamos de fazer por negligência, fraqueza e intenção. Por amor de teu Filho, Jesus Cristo, que morreu por nós, perdoa-nos todo o passado e concede que te sirvamos com vidas renovadas, para glória do teu nome. Amém.'
  text.category = 'confession'
end

# Declaração de Perdão
LiturgicalText.find_or_create_by!(slug: 'morning_3_absolution_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Declaração de Perdão'
  text.content = 'Deus onipotente, que perdoa a todos os que verdadeiramente se arrependem, tenha misericórdia de vós, vos perdoe e liberte de todos os vossos pecados, vos confirme e fortaleça em todo o bem e vos guarde na vida eterna. Mediante Jesus Cristo, nosso Senhor.'
  text.category = 'absolution'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_absolution_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Amém.'
  text.category = 'absolution'
end

# A Introdução Penitencial pode ser omitida (rubrica)
LiturgicalText.find_or_create_by!(slug: 'morning_3_penitential_omit_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'A Introdução Penitencial antecedente pode ser omitida, salvo se for Domingo'
  text.category = 'rubric'
end

# Responso
LiturgicalText.find_or_create_by!(slug: 'morning_3_response_1_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Senhor, abre os nossos lábios.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_response_1_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E a nossa boca proclamará o teu louvor.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_response_2_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Adoremos o Senhor.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_response_2_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Bendigamos a Deus.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_response_3_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Glória ao Pai e ao Filho e ao Espírito Santo.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_response_3_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'response'
end

# Cânticos antes da leitura (rubrica)
LiturgicalText.find_or_create_by!(slug: 'morning_3_canticle_before_reading_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Usa-se um dos seguintes Cânticos, que pode ser precedido e seguido de Antífona'
  text.category = 'rubric'
end

# ==============================================================================
# CÂNTICOS - ANTES DA LEITURA
# ==============================================================================

# Venite (Sl 95:1-7; Sl 96:13)
LiturgicalText.find_or_create_by!(slug: 'morning_3_venite', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Venite'
  text.reference = 'Sl 95:1-7; Sl 96:13'
  text.content = 'Vinde, cantemos ao Senhor, com júbilo, celebremos o Rochedo da nossa salvação.
**Saiamos ao seu encontro, com ações de graças, vitoriemo-lo com salmos.**
Porque o Senhor é o Deus supremo e o grande Rei acima de todos os deuses.
**Nas suas mãos estão as profundezas da terra, e as alturas dos montes lhe pertencem.**
Dele é o mar, pois ele o fez; obra de suas mãos, os continentes.
**Vinde, adoremos e prostremo-nos; ajoelhemos diante do Senhor, que nos criou.**
Ele é o nosso Deus, e nós, povo do seu pasto e ovelhas de sua mão.
**Na presença do Senhor, porque vem, vem julgar a terra; julgará o mundo com justiça e os povos, consoante a sua fidelidade.**
Glória ao Pai...'
  text.category = 'canticle'
end

# Jubilate (Sl 100)
LiturgicalText.find_or_create_by!(slug: 'morning_3_jubilate', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Jubilate'
  text.reference = 'Sl 100'
  text.content = 'Celebrai com júbilo ao Senhor, todas as terras.
**Servi ao Senhor com alegria, apresentai-vos diante dele com cântico.**
Sabei que o Senhor é Deus; foi ele quem nos fez, e dele somos; somos o seu povo e rebanho do seu pastoreio.
**Entrai por suas portas com ações de graças e nos seus átrios, com hinos de louvor; rendei-lhe graças e bendizei-lhe o nome.**
Porque o Senhor é bom, a sua misericórdia dura para sempre, e, de geração em geração, a sua fidelidade.
Glória ao Pai...'
  text.category = 'canticle'
end

# Antífonas Pascais
LiturgicalText.find_or_create_by!(slug: 'morning_3_easter_antiphons_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Antífonas Pascais'
  text.content = '(1 Cor 5:7-8; Rm 6:9-11; 1 Cor 15:20-22), de obrigação no Domingo de Páscoa'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_easter_antiphon_1', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Lançai fora o velho fermento, para que sejais nova massa, como sois, de fato, sem fermento. Pois também Cristo, nosso Cordeiro pascal, foi imolado.
**Por isso, celebremos a festa não com o fermento da maldade e da malícia, e sim com os asmos da sinceridade e da verdade.**'
  text.category = 'canticle'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_easter_antiphon_2', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Sabedores de que, havendo Cristo ressuscitado dentre os mortos, já não morre; a morte já não tem domínio sobre ele.
**Pois, quanto a ter morrido, de uma vez para sempre morreu para o pecado; mas, quanto a viver, vive para Deus.**
Assim também vós considerai-vos mortos para o pecado, mas vivos para Deus, em Cristo Jesus.'
  text.category = 'canticle'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_easter_antiphon_3', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = '**Mas, de fato, Cristo ressuscitou dentre os mortos, sendo ele as primícias dos que dormem.**
Visto que a morte veio por um homem, também por um homem veio a ressurreição dos mortos.
**Porque, assim como, em Adão, todos morrem, assim também todos serão vivificados em Cristo.**
Glória ao Pai...'
  text.category = 'canticle'
end

# ==============================================================================
# SALMODIA
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_3_psalms_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Salmodia'
  text.content = 'Cada Salmo ou grupo de Salmos deve terminar com a Doxologia que segue. Para os Ofícios diários, os Salmos são indicados no Lecionário, pp.347 a 358:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_psalms_gloria_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Glória ao Pai e ao Filho e ao Espírito Santo.'
  text.category = 'psalms'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_psalms_gloria_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'psalms'
end

# ==============================================================================
# LEITURA DO ANTIGO TESTAMENTO
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_3_ot_reading_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Leitura do Antigo Testamento'
  text.content = 'No fim'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_ot_reading_response_reader', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Palavra do Senhor.'
  text.category = 'readings'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_ot_reading_response_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Demos graças a Deus.'
  text.category = 'readings'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_silence_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Guardar-se-á silêncio'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_canticle_after_reading_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Usa-se um dos seguintes Cânticos, que pode ser antecedido e seguido de antífona'
  text.category = 'rubric'
end

# ==============================================================================
# CÂNTICOS - PÓS PRIMEIRA LEITURA
# ==============================================================================

# Benedictus (O cântico de Zacarias - Lc 1:68-79)
LiturgicalText.find_or_create_by!(slug: 'morning_3_benedictus', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Benedictus'
  text.reference = 'O cântico de Zacarias - Lc 1:68-79'
  text.content = 'Bendito seja o Senhor, Deus de Israel, porque visitou e redimiu o seu povo,
**e nos suscitou plena e poderosa salvação na casa de Davi, seu servo,**
como prometera, desde a antiguidade, por boca dos seus santos profetas,
**para nos libertar dos nossos inimigos e das mãos de todos os que nos odeiam;**
para usar de misericórdia com os nossos pais e lembrar-se da sua santa aliança e do juramento que fez a Abraão, o nosso pai,
de conceder-nos que, livres das mãos de inimigos, o adorássemos sem temor,
**em santidade e justiça perante ele, todos os nossos dias.**
Tu, menino, serás chamado profeta do Altíssimo, porque precederás o Senhor, preparando-lhe os caminhos,
**para dar ao seu povo conhecimento da salvação, no redimi-lo dos seus pecados,**
graças à entranhável misericórdia de nosso Deus, pela qual nos visitará o sol nascente das alturas,
**para alumiar os que jazem nas trevas e na sombra da morte, e dirigir os nossos pés pelo caminho da paz.**
Glória ao Pai...'
  text.category = 'canticle'
end

# Benedic, anima mea (Salmo 103)
LiturgicalText.find_or_create_by!(slug: 'morning_3_benedic_anima_mea', prayer_book_id: prayer_book.id) do |text|
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
**Bendizei ao Senhor, vós, todas as suas obras, em todos os lugares do seu domínio. Bendize, ó minha alma, ao Senhor.**
Glória ao Pai...'
  text.category = 'canticle'
end

# Magna et mirabilia (Ap 15:3-4; 5:13)
LiturgicalText.find_or_create_by!(slug: 'morning_3_magna_et_mirabilia', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Magna et mirabilia'
  text.reference = 'Ap 15:3-4; 5:13'
  text.content = 'Grandes e admiráveis são as tuas obras, Senhor Deus, Todo-poderoso! Justos e verdadeiros são os teus caminhos, ó Rei das nações!
**Quem não temerá e não glorificará o teu nome, ó Senhor? Pois só tu és santo;**
por isso, todas as nações virão e adorarão diante de ti, porque os teus atos de justiça se fizeram manifestos.
**Então, ouvi que toda criatura que há no céu e sobre a terra, debaixo da terra e sobre o mar, e tudo o que neles há, estava dizendo:**
Àquele que está sentado no trono e ao Cordeiro, seja o louvor, e a honra, e a glória, e o domínio pelos séculos dos séculos. **Amém.**'
  text.category = 'canticle'
end

# ==============================================================================
# LEITURA DO NOVO TESTAMENTO
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_3_nt_reading_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Leitura do Novo Testamento'
  text.content = 'No fim'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_nt_reading_response_reader', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Palavra do Senhor.'
  text.category = 'readings'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_nt_reading_response_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Demos graças a Deus.'
  text.category = 'readings'
end

# Sermão (rubrica)
LiturgicalText.find_or_create_by!(slug: 'morning_3_sermon_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Sermão'
  text.content = '(ou no fim do Ofício)'
  text.category = 'rubric'
end

# Cânticos - Pós Segunda Leitura (rubrica)
LiturgicalText.find_or_create_by!(slug: 'morning_3_canticle_after_second_reading_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Usa-se um dos seguintes Cânticos; mas, na Quaresma, o Salvador do Mundo'
  text.category = 'rubric'
end

# ==============================================================================
# CÂNTICOS - PÓS SEGUNDA LEITURA
# ==============================================================================

# Te Deum laudamus
LiturgicalText.find_or_create_by!(slug: 'morning_3_te_deum', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Te Deum laudamus'
  text.content = 'A Ti, ó Deus, louvamos e, por Senhor nosso, confessamos.
A Ti, ó Eterno Pai, adora toda a terra.
A Ti clamam os anjos todos, os céus, e todas as potestades.
A Ti clamam, continuamente, os querubins e os serafins, dizendo:
Santo, Santo, Santo é o Senhor, Deus dos Exércitos;
os céus e a terra estão plenos da Tua glória.
A Ti louva a gloriosa companhia dos apóstolos.
A Ti louva a santa comunhão dos profetas.
A Ti louva o nobre exército dos mártires.
A Ti confessa a santa Igreja espalhada pela terra.
A Ti, Pai de infinita majestade.
A Teu adorável, verdadeiro e único Filho.
Também ao Espírito Santo, o Consolador.
Tu és o Rei da glória, ó Cristo. Tu és o Filho Eterno do Pai.
Quando Tu empreendeste a redenção do gênero humano, Te humilhaste a nascer de uma virgem.
Quando Tu venceste o agulhão da morte, abriste o Reino dos Céus a todos os crentes.
Tu te assentas à destra de Deus, na glória do Pai.
Nós cremos que Tu virás para seres nosso juiz.
Por isso, te oramos, que socorras a Teus servos, aos quais redimiste com Teu precioso sangue.
Conta-os com os Teus santos na glória eterna.
Ó Senhor, salva o Teu povo, e abençoa a Tua herança.
Governa-o e exalta-o eternamente.
De dia em dia Te magnificamos; e louvamos Teu nome para sempre.
Digna-Te, Senhor, guardar-nos hoje sem pecado.
Tem misericórdia de nós.
Ó Senhor, seja sobre nós, a Tua misericórdia, assim como em Ti confiamos.
Em Ti, Senhor, eu confio; não me deixes nunca ser confundido.'
  text.category = 'canticle'
end

# Salvador do Mundo (para Quaresma)
LiturgicalText.find_or_create_by!(slug: 'morning_3_savior_of_the_world_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Ou (na Quaresma)'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_savior_of_the_world', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Salvador do Mundo'
  text.content = 'Jesus, Salvador do mundo, vem a nós, na tua misericórdia; esperamos de Ti a salvação e o socorro.
**Libertaste o teu povo pela tua cruz e oferta da tua vida; esperamos de Ti a salvação e o socorro.**
Quando os teus discípulos quase pereciam, Tu os salvaste; esperamos de Ti o socorro.
**Na tua grande misericórdia, livra-nos das nossas cadeias;
perdoa os pecados de todo o teu povo.**
Revela-Te como nosso salvador e poderoso libertador; salva-nos e ajuda-nos para Te adorarmos.
**Vem e fica conosco, Senhor Jesus Cristo; atende à nossa prece, e fica conosco para sempre.**
E quando voltares na tua glória, junta-nos a Ti, para participarmos da vida do teu reino.'
  text.category = 'canticle'
end

# Gloria in excelsis
LiturgicalText.find_or_create_by!(slug: 'morning_3_gloria_in_excelsis', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Gloria in excelsis'
  text.content = 'Glória a Deus nas alturas, e na terra paz, boa vontade entre os homens.
**Nós te louvamos, bendizemos, adoramos, glorificamos e te damos graças por tua grande glória. Ó Senhor Deus, Rei do Céu, Deus Pai Onipotente. Ó**
Senhor, unigênito Filho, Jesus Cristo; ó Senhor Deus, Cordeiro de Deus, Filho do Eterno Pai, que tiras os pecados do mundo, tem misericórdia de nós. Tu que tiras os pecados do mundo, recebe a nossa deprecação. Tu que estás sentado à destra de Deus Pai, tem misericórdia de nós. Porque só tu és Santo; só tu és o Senhor; só tu, ó Cristo, com o Espírito Santo, és altíssimo na glória de Deus Pai. Amém.'
  text.category = 'canticle'
end

# ==============================================================================
# CREDO DOS APÓSTOLOS
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_3_creed_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Credo dos Apóstolos'
  text.content = 'Creio em Deus Pai Todo-poderoso, Criador do céu e da terra; e em Jesus Cristo seu único Filho, nosso Senhor: o qual foi concebido por obra do Espírito Santo, nasceu da Virgem Maria; padeceu sob o poder de Pôncio Pilatos, foi crucificado, morto e sepultado; desceu ao Hades; ressuscitou ao terceiro dia; subiu ao céu, e está sentado à mão direita de Deus Pai Todo-poderoso: donde há de vir a julgar os vivos e os mortos. Creio no Espírito Santo; na santa Igreja Católica; na comunhão dos santos; na remissão dos pecados; na ressurreição do corpo; e na Vida Eterna. Amém.'
  text.category = 'creed'
end

# ==============================================================================
# ORAÇÕES
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_3_prayers_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E a seguir'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_prayers_invitation', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Oremos.'
  text.category = 'prayers'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_kyrie_1_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Senhor, tem misericórdia de nós.'
  text.category = 'prayers'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_kyrie_1_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Cristo, tem misericórdia de nós.'
  text.category = 'prayers'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_kyrie_2_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Senhor, tem misericórdia de nós.'
  text.category = 'prayers'
end

# Pai Nosso
LiturgicalText.find_or_create_by!(slug: 'morning_3_lords_prayer_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Pai Nosso'
  text.content = 'Pai nosso, que estás nos céus, santificado seja o teu nome. Venha o teu Reino, seja feita a tua vontade, assim na terra como no céu. O pão nosso de cada dia nos dá hoje. E perdoa-nos as nossas dívidas, assim como nós perdoamos aos nossos devedores. E não nos deixes cair em tentação, mas livra-nos do mal; pois teu é o Reino, e o poder, e a glória para sempre. Amém.'
  text.category = 'lords_prayer'
end

# Responsório (Opção 1 - mais longa)
LiturgicalText.find_or_create_by!(slug: 'morning_3_responsory_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Pode-se dizer o responsório seguinte'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_responsory_1_1_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Senhor, mostra-nos a tua misericórdia'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_responsory_1_1_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'e concede-nos a tua salvação.'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_responsory_1_2_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Reveste os teus ministros de virtude'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_responsory_1_2_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'e enche o teu povo de alegria.'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_responsory_1_3_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Dá a paz ao mundo'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_responsory_1_3_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'pois só em Ti achamos segurança.'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_responsory_1_4_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Toma o Brasil ao teu cuidado;'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_responsory_1_4_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'guia-nos pelas veredas da justiça e da verdade.'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_responsory_1_5_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Sejam conhecidos na terra os teus propósitos'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_responsory_1_5_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'e entre as nações a tua salvação.'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_responsory_1_6_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Encontrem os necessitados socorro'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_responsory_1_6_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'e não esmoreça a esperança dos pobres.'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_responsory_1_7_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Purifica, ó Deus, os nossos corações'
  text.category = 'responsory'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_responsory_1_7_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'e fortalece-nos com o teu Santo Espírito.'
  text.category = 'responsory'
end

# Responsório (Opção 2 - mais curta)
LiturgicalText.find_or_create_by!(slug: 'morning_3_responsory_2_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Ou a Oração seguinte'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_responsory_2_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Senhor Deus, pedimos a tua bênção: para a tua Igreja, santidade; para o mundo, paz; para esta nação, justiça; para todos os povos, o conhecimento da tua lei; guarda de todo o perigo as nossas famílias; protege os fracos; cura os doentes; conforta os moribundos; e conduz os mortos a uma alegre ressurreição. Mediante Jesus Cristo, nosso Senhor. Amém.'
  text.category = 'responsory'
end

# ==============================================================================
# COLETA DO DIA
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_3_collect_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Dir-se-á a Oração do Dia e uma das seguintes Orações:'
  text.category = 'rubric'
end

# Orações de Conclusão
LiturgicalText.find_or_create_by!(slug: 'morning_3_final_prayer_1', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Pai eterno e onipotente: agradecemos-Te porque nos trouxeste em segurança até ao princípio deste dia. Durante ele defende-nos com teu imenso poder, guarda-nos de cair em pecado e salva-nos em todos os perigos, de modo que, guiados pela tua mão, façamos só o que for bom a teus olhos. Mediante Jesus Cristo, nosso Senhor. Amém.'
  text.category = 'collect'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_final_prayer_2', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Ó Deus, Tu és o Autor da paz e amas a concórdia; conhecer-Te é a vida eterna, servir-Te é a liberdade completa. Defende-nos a nós, teus servos, dos assaltos dos nossos inimigos para que, confiados no teu amparo, não receemos o poder do adversário. Mediante Jesus Cristo, nosso Senhor. Amém.'
  text.category = 'collect'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_final_prayer_3', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Deus, Pai eterno, fomos criados pelo teu poder e redimidos pelo teu amor; fortalece-nos e guia-nos pelo teu Espírito para que nos entreguemos a Ti e uns aos outros em amor e serviço. Mediante Jesus Cristo, nosso Senhor. Amém.'
  text.category = 'collect'
end

# ==============================================================================
# OUTRAS ORAÇÕES (opcional)
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_3_other_prayers_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Podem-se cantar hinos, dizer Orações, litanias e ações de graças; o Sermão pode ser pregado aqui; e o Ofício termina com uma fórmula de Bênção ou de Conclusão'
  text.category = 'rubric'
end

# ==============================================================================
# CONCLUSÃO / DESPEDIDA
# ==============================================================================

LiturgicalText.find_or_create_by!(slug: 'morning_3_conclusion_dismissal_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Despedida'
  text.content = 'Ide na paz de Cristo! Sede corajosos e fortes no testemunho do Evangelho entre todas as pessoas. Servi ao Senhor com a alegria.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_conclusion_dismissal_people', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'No poder do Espírito Santo.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'morning_3_conclusion_dismissal_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Aleluia!'
  text.category = 'conclusion'
end

Rails.logger.info 'LOCB 2008 Morning Prayer III liturgical texts created successfully!'
