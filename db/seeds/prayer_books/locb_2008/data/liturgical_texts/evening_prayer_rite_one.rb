Rails.logger.info "🌙 Carregando textos Ofício Vespertino 1 (LOCB 2008)..."

prayer_book = PrayerBook.find_by!(code: 'locb_2008')

# ==============================================================================
# ORAÇÃO VESPERTINA I
# ==============================================================================

# Preparação - Saudação (Opção 1)
LiturgicalText.find_or_create_by!(slug: 'evening_1_preparation_1_greeting_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'A luz e paz de Jesus Cristo estejam com vocês!'
  text.category = 'preparation'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_preparation_1_greeting_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'E também contigo.'
  text.category = 'preparation'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_preparation_1_opening_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'A glória de Deus, em Jesus, nos ergueu.'
  text.category = 'preparation'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_preparation_1_opening_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Alegremo-nos sempre e cantemos ao Senhor.'
  text.category = 'preparation'
end

# Preparação - Alternativa "Ou" (Opção 2)
LiturgicalText.find_or_create_by!(slug: 'evening_1_preparation_2_greeting_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Deus, apressa-te em nos salvar.'
  text.category = 'preparation'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_preparation_2_greeting_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Ó Senhor, apressa-te em socorrer-nos!'
  text.category = 'preparation'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_preparation_2_opening_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Conduze teus filhos à liberdade, ó Deus.'
  text.category = 'preparation'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_preparation_2_opening_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'E afasta toda a escuridão de nossos corações e mentes.'
  text.category = 'preparation'
end

# Oração de Confissão
LiturgicalText.find_or_create_by!(slug: 'evening_1_welcome_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'O Ministro pode dizer'
  text.category = 'rubric'
end

# Acolhida
LiturgicalText.find_or_create_by!(slug: 'evening_1_welcome_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Nós nos apresentamos em nome de Cristo para oferecermos juntos louvor e ação de graças, ouvir e receber a santa Palavra de Deus, orar pelas necessidades do mundo e buscar o perdão dos nossos pecados para que, pelo poder do Espírito Santo, possamos nos dar a nós mesmos ao serviço de Mestre.'
  text.category = 'welcome'
end

# Oração de Confissão
LiturgicalText.find_or_create_by!(slug: 'evening_1_confession_rubric', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Orações de Confissão e arrependimento'
  text.content = 'Orações de Confissão e arrependimento são usadas quando Oração Vespertina for o serviço principal e pode ser usada em outras ocasiões'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_confession_invitation_minister', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Convite à Confissão'
  text.content = 'Jesus disse: "Arrependei-vos, o Reino dos céus está próximo". Assim nos deixou para que vivamos longe de nosso pecado e nos convertamos a Cristo, enquanto confessamos nossos pecados em penitência e fé. Oremos:'
  text.category = 'confession'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_confession_silence', prayer_book_id: prayer_book.id) do |text|
    text.content = '(pausa)'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_confession_prayer_all', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Confissão'
  text.content = 'Deus muitíssimo misericordioso, Pai de nosso Senhor Jesus Cristo, nós confessamos que temos pecado em pensamento, palavra e ação. Nós não o amamos com nosso coração inteiro. Nós não amamos nosso próximo como nós mesmos. Em sua misericórdia perdoe o que nós fomos, nos ajude a emendar o que nós somos, e dirija o que nós seremos; que nós possamos fazer o que é justo, amar desinteressadamente, e caminhar humildemente contigo, nosso Deus. Amém.'
  text.category = 'confession'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_confession_absolution_minister', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Declaração de Perdão'
  text.content = 'Possa o Deus de amor e poder os perdoar e os livrar de seus pecados, curá-lhes e fortalecê-lhes pelo Espírito Santo, e os eleve à vida nova em Cristo, nosso Senhor.'
  text.category = 'confession'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_confession_absolution_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Amém.'
  text.category = 'confession'
end

# Ação de Graças (opcional)
LiturgicalText.find_or_create_by!(slug: 'evening_1_thanksgiving_rubric', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Oração de Ação de Graças'
  text.content = 'Um ou mais dos seguintes textos pode concluir a Preparação ou eles podem ser omitidos. Esta Oração de Ação de Graças pode ser dita:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_thanksgiving_prayer_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Bendito sejas tu, Deus Supremo, nossa luz e nossa salvação; para ti, seja a glória e o louvor para sempre. Tu conduziste teus filhos à liberdade, conduzindo-os de dia com a coluna de nuvem e a noite com a coluna de fogo. Que possamos entrar na Luz da tua presença, aclamando teu Cristo, pois ele ressurgiu gloriosamente, banindo de nossos corações e nossas mentes toda escuridão. Bendito seja o Deus, Trindade Santa, Pai, Filho e Espírito Santo.'
  text.category = 'thanksgiving_prayer'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_thanksgiving_prayer_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Bendito seja Deus para sempre!'
  text.category = 'thanksgiving_prayer'
end

# Salmo 104 (Cântico de Abertura - opção 1)
LiturgicalText.find_or_create_by!(slug: 'evening_1_canticle_psalm_104', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Salmo 104'
  text.content = 'Bendize, ó minha alma, ao Senhor! Senhor, Deus meu, como tu és magnificente: sobrevestido de glória e majestade,
**coberto de luz como de um manto. Tu estendes o céu como uma cortina,**
põe nas águas o vigamento da tua morada, tomas as nuvens por teu carro e voas nas asas do vento.
Fazes a teus anjos ventos e a teus ministros, labaredas de fogo.
Lançaste os fundamentos da terra, para que ela não vacile em tempo nenhum.
**Tomaste o abismo por vestuário e a cobriste; as águas ficaram acima das montanhas;**
à tua repreensão, fugiram, à voz do teu trovão, bateram em retirada.
**Elevaram-se os montes, desceram os vales, até ao lugar que lhes havias preparado.**
Puseste às águas divisa que não ultrapassarão, para que não tornem a cobrir a terra.
**Tu fazes rebentar fontes no vale, cujas águas correm entre os montes;**
dão de beber a todos os animais do campo; os jumentos selvagens matam a sua sede.
**Junto delas têm as aves do céu o seu pouso e, por entre a ramagem, desferem o seu canto.**
Do alto de tua morada, regas os montes; a terra farta-se do fruto de tuas obras.
**Fazes crescer a relva para os animais e as plantas, para o serviço do homem, de sorte que da terra tire o seu pão,**
o vinho, que alegra o coração do homem, o azeite, que lhe dá brilho ao rosto, e o alimento, que lhe sustém as forças.
**Avigoram-se as árvores do Senhor e os cedros do Líbano que ele plantou,**
em que as aves fazem seus ninhos; quanto à cegonha, a sua casa é nos ciprestes.
**Os altos montes são das cabras montesinas, e as rochas, o refúgio dos arganazes.**
Fez a lua para marcar o tempo; o sol conhece a hora do seu ocaso.
**Dispões as trevas, e vem a noite, na qual vagueiam os animais da selva.**
Os leõezinhos rugem pela presa e buscam de Deus o sustento; em vindo o sol, eles se recolhem e se acomodam nos seus covis.
**Sai o homem para o seu trabalho e para o seu encargo até à tarde.**
Que variedade, Senhor, nas tuas obras! Todas com sabedoria as fizeste; cheia está a terra das tuas riquezas.
**Eis o mar vasto, imenso, no qual se movem seres sem conta, animais pequenos e grandes.**
Por ele transitam os navios e o monstro marinho que formaste para nele folgar.
**Todos esperam de ti que lhes dês de comer a seu tempo. Se lhes dás, eles o recolhem; se abres a mão, eles se fartam de bens.**
Se ocultas o rosto, eles se perturbam; se lhes cortas a respiração, morrem e voltam ao seu pó.
**Envias o teu Espírito, eles são criados, e, assim, renovas a face da terra.**
A glória do Senhor seja para sempre! Exulte o Senhor por suas obras!
**Com só olhar para a terra, ele a faz tremer; toca as montanhas, e elas fumegam.**
Cantarei ao Senhor enquanto eu viver; cantarei louvores ao meu Deus durante a minha vida.
**Seja-lhe agradável a minha meditação; eu me alegrarei no Senhor.**
Desapareçam da terra os pecadores, e já não subsistam os perversos. Bendize, ó minha alma, ao Senhor! Aleluia!'
  text.category = 'canticle'
end

# Salmo 141 (Cântico de Abertura - opção 2)
LiturgicalText.find_or_create_by!(slug: 'evening_1_canticle_psalm_141', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Salmo 141'
  text.content = 'Senhor, a ti clamo, dá-te pressa em me acudir; inclina os ouvidos à minha voz, quando te invoco.
**Suba à tua presença a minha oração, como incenso, e seja o erguer de minhas mãos como oferenda vespertina.**
Põe guarda, Senhor, à minha boca; vigia a porta dos meus lábios.
**Não permitas que meu coração se incline para o mal, para a prática da perversidade na companhia de homens que são malfeitores; e não coma eu das suas iguarias.**
Fira-me o justo, será isso mercê; repreenda-me, será como óleo sobre a minha cabeça, a qual não há de rejeitá-lo. Continuarei a orar enquanto os perversos praticam maldade.
**Os seus juízes serão precipitados penha abaixo, mas ouvirão as minhas palavras, que são agradáveis,**
ainda que sejam espalhados os meus ossos à boca da sepultura, quando se lavra e sulca a terra.
**Pois em ti, Senhor, estão fitos os meus olhos: em ti confio; não desampares a minha alma.**
Guarda-me dos laços que me armaram e das armadilhas dos que praticam iniquidade.
**Caiam os ímpios nas suas próprias redes, enquanto eu, nesse meio tempo, me salvo incólume.**'
  text.category = 'canticle'
end

# Gloria Patri (após cânticos)
LiturgicalText.find_or_create_by!(slug: 'evening_1_canticle_gloria_minister', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Gloria Patri'
  text.content = 'Glória ao Pai, ao Filho e ao Espírito Santo.'
  text.category = 'canticle'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_canticle_gloria_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'canticle'
end

# Breve Reflexão
LiturgicalText.find_or_create_by!(slug: 'evening_1_reflection_minister', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Então o Ministro dirá'
  text.content = 'O dia quase terminou, e a noite veio; oremos com um só coração e mente.'
  text.category = 'reflection'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_reflection_silence', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Momento de silêncio'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_reflection_prayer_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Como nossa oração nesta tarde (ou noite) sobe a ti, Senhor, que assim teu Espírito desça a nós para nos levar sempre ao teu louvor, para sempre.'
  text.category = 'reflection'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_reflection_prayer_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Amém.'
  text.category = 'reflection'
end

# A Palavra de Deus - Salmodia
LiturgicalText.find_or_create_by!(slug: 'evening_1_psalms_rubric', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Salmodia'
  text.content = 'Cada Salmo ou grupo de Salmos deve terminar com a Doxologia que segue. Para os Ofícios diários, os Salmos são indicados no Lecionário pp.347 a 358:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_psalms_gloria_minister', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Gloria Patri'
  text.content = 'Glória ao Pai, ao Filho e ao Espírito Santo.'
  text.category = 'psalms'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_psalms_gloria_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'psalms'
end

# Leituras das Escrituras
LiturgicalText.find_or_create_by!(slug: 'evening_1_readings_rubric', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Leituras Bíblicas'
  text.content = 'Uma ou mais leituras designadas para o dia são lidas. A leitura pode ser seguida de um tempo de silêncio. O leitor pode dizer:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_readings_response_reader', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Esta é a palavra do Senhor.'
  text.category = 'readings'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_readings_response_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Graças a Deus.'
  text.category = 'readings'
end

# Responso
LiturgicalText.find_or_create_by!(slug: 'evening_1_response_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Um Hino apropriado ou o responso, pode seguir-se:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_response_light_minister', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Responso'
  text.content = 'O Senhor é minha luz e minha salvação; o Senhor é a fortaleza de minha vida.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_response_light_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'O Senhor é minha luz e minha salvação; o Senhor é a fortaleza de minha vida.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_response_darkness_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'A luz brilhou sobre as trevas e as trevas não prevaleceram.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_response_darkness_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'O Senhor é minha luz e minha salvação; o Senhor é a fortaleza de minha vida.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_response_gloria_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Glória ao Pai, ao Filho e ao Espírito Santo.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_response_gloria_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'O Senhor é minha luz e minha salvação; o Senhor é a fortaleza de minha vida.'
  text.category = 'response'
end

# Cântico Evangélico - Magnificat
LiturgicalText.find_or_create_by!(slug: 'evening_1_magnificat_title', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Cântico evangélico'
  text.content = 'O Magnificat (Lucas 1:46-55, abaixo) pode ser cantado ou recitado:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_magnificat', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Magnificat'
  text.content = 'A minha alma engrandece ao Senhor, e o meu espírito se alegrou em Deus, meu Salvador,
**porque contemplou na humildade da sua serva. Pois, desde agora, todas as gerações me considerarão bem-aventurada, porque o poderoso me fez grandes coisas. Santo é o seu nome.**
A sua misericórdia vai de geração em geração sobre os que o temem. **Agiu com o seu braço valorosamente; dispersou os que, no coração, alimentavam pensamentos soberbos. Derribou do seu trono os poderosos e exaltou os humildes.**
Encheu de bens os famintos e despediu vazios os ricos.
**Amparou a Israel, seu servo, a fim de lembrar-se da sua misericórdia a favor de Abraão e de sua descendência, para sempre, como prometera aos nossos pais.**'
  text.category = 'magnificat'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_magnificat_gloria_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Glória ao Pai, ao Filho e ao Espírito Santo.'
  text.category = 'magnificat'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_magnificat_gloria_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'magnificat'
end

# Sermão
LiturgicalText.find_or_create_by!(slug: 'evening_1_sermon_rubric', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Sermão'
  text.content = 'Na Oração Vespertina pode haver um momento especial de Ações de Graças'
  text.category = 'rubric'
end

# Afirmação de Fé
LiturgicalText.find_or_create_by!(slug: 'evening_1_creed_rubric', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Afirmação de Fé'
  text.content = 'Credo Apostólico ou outra Afirmação de Fé (p.612)'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_creed_all', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Credo dos Apóstolos'
  text.content = 'Creio em Deus Pai Todo-poderoso, Criador do Céu e da Terra; e em Jesus Cristo seu único Filho, nosso Senhor: o qual foi concebido por obra do Espírito Santo, nasceu da Virgem Maria; padeceu sob o poder de Pôncio Pilatos, foi crucificado, morto e sepultado; desceu ao Hades; ressuscitou ao terceiro dia; subiu ao céu, e está sentado à mão direita de Deus Pai Todo-poderoso: donde há de vir a julgar os vivos e os mortos. Creio no Espírito Santo; na santa Igreja Católica; na comunhão dos santos; na remissão dos pecados; na ressurreição do corpo; e na Vida Eterna. Amém.'
  text.category = 'creed'
end

# Orações
LiturgicalText.find_or_create_by!(slug: 'evening_1_prayers_rubric', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Orações'
  text.content = 'Pedidos de Oração podem ser apresentados pela comunidade'
  text.category = 'rubric'
end

# Coleta do Dia
LiturgicalText.find_or_create_by!(slug: 'evening_1_collect_rubric', prayer_book_id: prayer_book.id) do |text|
    text.title = 'A Coleta do Dia'
  text.content = '(no Próprio do tempo, ver Lecionário pp.280 a 333)'
  text.category = 'rubric'
end

# A Oração do Senhor - Opção 1
LiturgicalText.find_or_create_by!(slug: 'evening_1_lords_prayer_opening_1_minister', prayer_book_id: prayer_book.id) do |text|
    text.title = 'A Oração do Senhor'
  text.content = 'Juntando nossas vozes e louvores, numa só voz, oremos como Jesus Cristo nos ensinou:'
  text.category = 'lords_prayer'
end

# A Oração do Senhor - Opção 2
LiturgicalText.find_or_create_by!(slug: 'evening_1_lords_prayer_opening_2_minister', prayer_book_id: prayer_book.id) do |text|
    text.title = 'A Oração do Senhor'
  text.content = 'Juntando nossas orações e louvores numa só voz, oremos com confiança como Jesus nos ensinou:'
  text.category = 'lords_prayer'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_lords_prayer_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Pai Nosso...'
  text.category = 'lords_prayer'
end

# A Conclusão

# A Bênção
LiturgicalText.find_or_create_by!(slug: 'evening_1_conclusion_blessing_minister', prayer_book_id: prayer_book.id) do |text|
    text.title = 'A Bênção'
  text.content = 'Que Deus nos abençoe, e nos preserve de todo o mal, e nos conduza à vida eterna.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_conclusion_blessing_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Amém.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_conclusion_blessing_praise_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Que Deus nos abençoe.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_conclusion_blessing_praise_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Demos graças a Deus.'
  text.category = 'conclusion'
end

# A Graça
LiturgicalText.find_or_create_by!(slug: 'evening_1_conclusion_grace_minister', prayer_book_id: prayer_book.id) do |text|
    text.title = 'A Graça'
  text.content = 'A Graça de nosso Senhor Jesus Cristo, o amor do Pai e a comunhão do Espírito Santo seja com todos nós.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_conclusion_grace_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Amém.'
  text.category = 'conclusion'
end

# A Paz
LiturgicalText.find_or_create_by!(slug: 'evening_1_conclusion_peace_minister', prayer_book_id: prayer_book.id) do |text|
    text.title = 'A Paz'
  text.content = 'Que a Paz de Deus que excede toda a compreensão humana, guarde os nossos corações e mentes no conhecimento e na graça de nosso Senhor Jesus Cristo.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_conclusion_peace_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Amém.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_conclusion_peace_exchange_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'A Paz de Deus seja sempre com vocês.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_conclusion_peace_exchange_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'E contigo também.'
  text.category = 'conclusion'
end

# Palavras finais (opcionais)
LiturgicalText.find_or_create_by!(slug: 'evening_1_conclusion_final_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Estas palavras podem ser acrescidas'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'evening_1_conclusion_final_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Ofereçamos-nos uns aos outros com o ósculo da paz e que Deus confirme e responda as nossas orações.'
  text.category = 'conclusion'
end

Rails.logger.info 'LOCB 2008 Evening Prayer I liturgical texts created successfully!'
