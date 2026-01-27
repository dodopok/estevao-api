# frozen_string_literal: true

prayer_book = PrayerBook.find_by!(code: 'loc_2015')

Rails.logger.info "Criando textos do Ofício Familiar para LOC 2015 (Páginas 150-171)..."

# ============================================================================
# DE MANHÃ (Páginas 150-153)
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'family_morning_opening', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'invocation'
  lt.content = <<~TEXT
    A Deus Pai, Mãe, que criou o mundo;
    A Deus Filho, que redimiu o mundo;
    A Deus Espírito Santo, que sustém o mundo;
    Seja todo o louvor e a glória, agora e para sempre. Amém.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'family_morning_psalm_8', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'psalm'
  lt.title = 'DOMINE, DOMINUS NOSTER (Salmo 8)'
  lt.content = <<~TEXT
    Ó SENHOR, Senhor nosso, que puseste a tua glória nos céus, *
    quão admirável é o teu Nome em toda a terra!
    Da boca dos bebês fazes brotar a força, *
    para calarem as pessoas odientas e as vingativas.
    Quando contemplo os teus céus, obra das tuas mãos, *
    a lua e as estrelas, que formaste,
    Que é o ser mortal, para que te lembres dele? *
    e o ser humano, para que o visites?
    Fizeste-o um pouco abaixo dos anjos, *
    e de glória e de honra o coroaste.
    Deste-lhe domínio sobre as tuas obras; *
    e tudo a ele submeteste:
    Ovelhas e bois *
    e todos os animais do campo;
    As aves do céu, os peixes do mar *
    e tudo quanto passa pelo caminho das grandes águas.
    Ó SENHOR, Senhor nosso, *
    quão admirável é o teu Nome em toda a terra!
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    Como era no princípio, é agora e será sempre, *
    por todos os séculos. Amém.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'family_morning_reading_1', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'reading'
  lt.reference = '1 Cr 29.11-13'
  lt.content = <<~TEXT
    Tua é, SENHOR, a grandeza, e o poder, e a honra, e a vitória, e a majestade; porque teu é tudo quanto há nos céus e na terra; teu é, SENHOR, o reino, e a ti cabe elevar-te como soberano acima de tudo. Riquezas e glória vêm de ti, e tu governas todas as coisas. Na tua mão há força e vigor; e na tua mão está o poder de engrandecer e de dar força a tudo. Agora, pois, ó Deus nosso, graças te damos, e louvamos o teu nome glorioso.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'family_morning_reading_2', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'reading'
  lt.reference = 'Is 43.18-21'
  lt.content = <<~TEXT
    Esqueçam o que se foi; não vivam no passado. Vejam, estou fazendo uma coisa nova! Ela já está surgindo! Vocês não a reconhecem? Até no deserto vou abrir um caminho e riachos no ermo. Os animais do campo me honrarão, os chacais e as corujas, porque fornecerei água no deserto e riachos no ermo, para dar de beber a meu povo, meu escolhido, ao povo que formei para mim mesmo a fim de que proclamasse o meu louvor.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'family_morning_reading_3', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'reading'
  lt.reference = 'Rm 8.19-21'
  lt.content = <<~TEXT
    A própria criação espera com impaciência a manifestação dos filhos e filhas de Deus. Entregue ao poder do nada – não por sua própria vontade, mas por vontade daquele que a submeteu –, a criação abriga a esperança, pois ela também será liberta da escravidão da corrupção, para participar da liberdade e da glória dos filhos e filhas de Deus.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'family_morning_collect', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Ó Deus, criador de todas as coisas, que fizeste tudo o que há no universo, e sem o qual nada podemos: graças te rendemos por este novo dia que amanhece, e suplicamos por tua presença e companhia, dá que encontremos a unidade em ti, que nos alegremos no vínculo da paz, que partilhemos, com justiça, os recursos desta terra, que ninguém passe pela experiència da fome, da violência ou da opressão, e que nada em tua criação experimente a espoliação ou a humilhação. Nós te pedimos isso, em nome daquele que deu a si mesmo pelo mundo, Jesus Cristo nosso Senhor, na unidade do Espírito Santo. Amém.
  TEXT
end

# ============================================================================
# AO MEIO-DIA (Páginas 154-157)
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'family_midday_opening', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'invocation'
  lt.content = <<~TEXT
    Habita conosco,
    Deus santo,
    santo e forte,
    santo e imortal
    santo e doador da vida.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'family_midday_psalm_121', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'psalm'
  lt.title = 'LEVAVI OCULOS (Salmo 121)'
  lt.content = <<~TEXT
    PARA os montes elevo os meus olhos; *
    donde há de vir o meu auxílio?
    Meu auxílio vem do SENHOR, *
    que fez o céu e a terra.
    Não deixará vacilar o teu pé; *
    aquele que te guarda jamais adormece.
    Eis que não adormece e nem dormirá *
    o que guarda o seu povo.
    O SENHOR é quem te guarda; *
    o SENHOR é a tua sombra à tua direita.
    O sol não te molestará de dia, *
    nem a lua, de noite.
    O SENHOR te guarda de todo o mal; *
    ele guarda a tua alma.
    O SENHOR guarda a tua chegada e a tua partida, *
    desde agora e para sempre.
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    Como era no princípio, é agora e será sempre, *
    por todos os séculos. Amém.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'family_midday_reading_1', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'reading'
  lt.reference = 'Jo 1.10-14'
  lt.content = <<~TEXT
    No princípio era o Verbo, e o Verbo estava junto de Deus, e o Verbo era Deus. Ele estava no mundo, e o mundo foi feito por meio dele, mas o mundo não o conheceu. Veio para o que era seu, e o seu povo não o recebeu. Mas a todas as pessoas que o receberam, deu-lhes o poder de serem chamadas filhas de Deus, as quais creem no seu Nome; estas pessoas não nasceram do sangue, nem da vontade da carne, nem da vontade humana, mas de Deus. E o Verbo se fez carne, e habitou entre nós, e vimos a sua glória, como a glória do unigênito do Pai, cheio de graça e de verdade.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'family_midday_reading_2', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'reading'
  lt.reference = '1 Jo 4.7-11'
  lt.content = <<~TEXT
    Amemo-nos mutuamente; porque o amor vem de Deus; e quem ama nasceu de Deus e conhece a Deus. Quem não ama não conhece a Deus; porque Deus é amor. Nisto se manifesta o amor de Deus para conosco: que Deus enviou seu Filho unigênito ao mundo, para dar-nos vida por meio dele. Nisto consiste o amor, não em que nós tenhamos amado a Deus, mas em que ele nos amou primeiro, e enviou seu Filho para propiciação pelos nossos pecados.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'family_midday_reading_3', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'reading'
  lt.reference = '1 Jo 4.13-15'
  lt.content = <<~TEXT
    Isto sabemos, que estamos nele, e ele em nós, pois que nos deu do seu Espírito. E vimos, e testificamos que o Pai enviou seu Filho para salvar o mundo. Qualquer pessoa que confessar que Jesus é o Filho de Deus, Deus está nela, e ela em Deus.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'family_midday_collect', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Ó Deus, que revelaste teu amor por nós através da vinda de nosso Senhor Jesus Cristo ao mundo. Ajuda-nos a acolhê-lo com alegria, e a criar um espaço para ele em nossas vidas e lares, para que habitemos nele e ele em nós. Pelo mesmo Senhor Jesus Cristo, que vive e reina contigo, e o Santo Espírito, para todo o sempre. Amém.
  TEXT
end

# ============================================================================
# AO ENTARDECER (Páginas 158-161)
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'family_evening_opening', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'invocation'
  lt.content = <<~TEXT
    O Espírito do Senhor preenche o mundo todo.
    O Espírito do Senhor se move sobre as profundezas.
    O Espírito do Senhor aquece os nossos corações.
    O Espírito do Senhor preenche todas as coisas.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'family_evening_psalm_29', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'psalm'
  lt.title = 'AFFERTE DOMINO (Salmo 29)'
  lt.content = <<~TEXT
    TRIBUTEM ao SENHOR, filhos e filhas de Deus, *
    tributem ao SENHOR glória e força.
    Tributem ao SENHOR a glória de seu Nome; *
    adorem ao SENHOR na beleza da santidade.
    A voz do SENHOR se ouve sobre as águas; o Deus da glória se faz ouvir qual trovão. *
    A voz do SENHOR está sobre a vastidão das águas.
    A voz do SENHOR é poderosa; *
    a voz do SENHOR é cheia de majestade.
    A voz do SENHOR quebra os cedros, *
    os cedros do Líbano despedaça.
    Ele os faz saltar como um bezerro; *
    ao Líbano e Siriom quais bois selvagens.
    A voz do SENHOR *
    separa as labaredas do fogo.
    A voz do SENHOR faz tremer o deserto; *
    o SENHOR faz tremer o deserto de Cades.
    A voz do SENHOR multiplica a vida; *
    e no seu templo é proclamada a sua glória.
    O SENHOR preside aos dilúvios; *
    e, como Rei, o SENHOR preside para sempre.
    A seu povo o SENHOR dá forças; *
    com paz Deus abençoa seu povo.
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    Como era no princípio, é agora e será sempre, *
    por todos os séculos. Amém.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'family_evening_reading_1', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'reading'
  lt.reference = 'Jl 2.28-29'
  lt.content = <<~TEXT
    E há de ser que, depois derramarei o meu Espírito sobre toda a carne, e seus filhos e suas filhas profetizarão, e as pessoas idosas terão sonhos, e as jovens terão visões. E também sobre os servos e sobre as servas, naqueles dias, derramarei o meu Espírito.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'family_evening_reading_2', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'reading'
  lt.reference = 'Rm 15.13'
  lt.content = <<~TEXT
    O Deus da esperança encha vocês de toda alegria e paz em sua fé, para que transbordem em esperança pela força do Espírito Santo.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'family_evening_reading_3', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'reading'
  lt.reference = 'Is 61.1-3'
  lt.content = <<~TEXT
    O Espírito do Senhor Deus está sobre mim, porque ele me ungiu para pregar boas-novas às pessoas pobres, enviou-me para animar as aflitas, anunciar a libertação às escravas e pôr em liberdade as cativas; e anunciar que chegou o tempo em que o Senhor salvará o seu povo, o dia da vingança do nosso Deus; para consolar as pessoas que choram e dar-thes uma coroa de alegria em lugar de tristeza, perfume de felicidade, em lugar de lágrimas, e roupas de festa, em lugar de luto; a fim de que se chamem carvalhos de justiça, plantados pelo Senhor para a sua glória.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'family_evening_collect', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Bendito Deus, tu tens nos ensinado que as nossas ações sem compaixão de nada valem. Envia-nos o teu Espírito Santo para dirigir e instruir nossos corações, e faze jorrar em nós o maravilhoso dom do amor, da verdadeira paz e de todas as virtudes, sem as quais nossas obras são mortas. Recebe nossas orações por teu Filho, nosso Senhor Jesus Cristo, na unidade do Espírito Santo. Amém.
  TEXT
end

# ============================================================================
# AO ANOITECER (Páginas 162-165)
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'family_late_evening_opening', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'invocation'
  lt.content = <<~TEXT
    Que o amor de Deus transborde em nossos corações,
    para que possamos amar o mundo como ele o ama;
    Para que o amemos com todo o nosso coração, mente, alma e entendimento;
    E para que amemo-nos mutuamente.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'family_late_evening_psalm_138', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'psalm'
  lt.title = 'CONFITEBOR TIBI (Salmo 138)'
  lt.content = <<~TEXT
    EU TE louvarei, SENHOR, de todo o meu coração; *
    na tua presença, ó Deus, cantarei louvores.
    Adorarei voltado para o teu santo templo e louvarei o teu Nome pela tua bondade e pela tua verdade; *
    pois magnificaste a tua palavra sobre toda manifestação de teu Nome.
    No dia em que clamei, tu me respondeste; *
    com coragem fortaleceste a minha alma.
    Todos os reis da terra te louvarão, ó SENHOR, *
    porque eles ouviram as palavras de tua boca.
    E celebrarão, cantando, os caminhos do SENHOR, *
    pois grande é a glória do SENHOR.
    Porque ainda que o SENHOR seja excelso, lança, contudo, os olhos para as pessoas humildes; *
    e de longe conhece as pessoas orgulhosas.
    Embora eu ande no meio da tribulação, tu me reanimas; *
    estendes tua mão contra a ira de quem me quer mal, e teu poder me salva.
    O SENHOR aperfeiçoará o que me tem designado; tua misericórdia, ó SENHOR, subsiste para sempre; *
    não desampares as obras de tuas mãos.
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    Como era no princípio, é agora e será sempre, *
    por todos os séculos. Amém.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'family_late_evening_reading_1', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'reading'
  lt.reference = '1 Jo 4.7-12'
  lt.content = <<~TEXT
    Amados e amadas, amemo-nos mutuamente, pois o amor procede de Deus. Quem ama nasce de Deus e conhece a Deus. Quem não ama não conhece a Deus, porque Deus é amor. Foi assim que Deus manifestou o seu amor entre nós: enviou o seu Filho Unigênito ao mundo, para que pudéssemos viver por meio dele. Nisto consiste o amor: não em que nós tenhamos amado a Deus, mas em que ele nos amou e enviou seu Filho como propiciação pelos nossos pecados. Amados e amadas, visto que Deus assim nos amou, nós também devemos amar-nos mutuamente. Ninguém jamais viu a Deus; se nos amarmos, Deus permanece em nós, e o seu amor está aperfeiçoado em nós.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'family_late_evening_reading_2', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'reading'
  lt.reference = 'Ef 4.1-6'
  lt.content = <<~TEXT
    Rogo a vocês, pois, eu, o prisioneiro do Senhor, que andem como é digno da vocação com que Deus chamou vocês, com toda a humildade e mansidão, com paciência, suportando-se mutuamente em amor, procurando guardar a unidade do Espírito pelo vínculo da paz. Há um só corpo e um só Espírito, assim como a vocação de vocês lhes chamou a uma só esperança; Um só SENHOR, uma só fé, um só batismo; Um só Deus e Pai de todas as pessoas, que está acima de todas, que age por meio de todas e está presente em todas.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'family_late_evening_reading_3', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'reading'
  lt.reference = '2 Co 4.5-7'
  lt.content = <<~TEXT
    Não pregamos a nós, mas a Jesus Cristo, o Senhor, e quanto a nós é como servos de vocês que nos apresentamos, por causa de Jesus. Pois o Deus, que disse: “Das trevas resplandeça a luz”, ele mesmo brilhou em nossos corações, para iluminação do conhecimento da glória de Deus na face de Cristo. Mas temos esse tesouro em vasos de barro, para mostrar que este poder que a tudo excede provém de Deus, e não de nós.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'family_late_evening_collect', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Fica conosco, Senhor Jesus, agora que a noite se aproxima e o dia já findou. Sê nosso companheiro no caminho, anima nossos corações e desperta nossa esperança, para que te conheçamos tal como te revelas nas Escrituras e no partir do pão. Concede-nos isto por amor do teu nome. Amém.
  TEXT
end

# ============================================================================
# NO FIM DO DIA (Páginas 166-171)
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'family_compline_opening', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'invocation'
  lt.content = <<~TEXT
    Ó Deus, pela Paixão de Cristo, protege-nos;
    por suas feridas, cura-nos;
    por sua morte ergue-nos;
    e por sua ressurreição conduz-nos à vida eterna.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'family_compline_psalm_91', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'psalm'
  lt.title = 'QUI HABITAT (Salmo 91)'
  lt.content = <<~TEXT
    QUEM habita sob a proteção do Altíssimo, *
    à sombra do Onipotente repousará.
    Direi do SENHOR: Ele é meu refúgio e fortaleza, *
    DEUS meu, em quem eu confio.
    Ele te livrará das ciladas, *
    e da peste perniciosa.
    Cobrir-te-á com as suas penas; sob suas asas encontrarás refúgio; *
    a sua verdade será o teu amparo e escudo.
    Não terás medo do terror da noite, *
    nem da seta, que voa de dia.
    Nem da peste que se propaga, *
    nem da mortandade que assola ao meio-dia.
    Podem cair mil ao teu lado e dez mil à tua direita, *
    mas não te atingirão.
    Contemplarás com os teus olhos, *
    e verás o castigo de quem pratica a injustiça.
    Porque tu, SENHOR, és o meu refúgio, *
    fizeste no Altíssimo a tua habitação.
    Nenhum mal te sucederá, *
    nem praga alguma se acercará da tua tenda.
    Porque de ti encarregará ele seus anjos, *
    para te guardarem em todos os teus caminhos.
    Eles te sustentarão em suas mãos, *
    para que não tropeces em alguma pedra.
    Pisarás o leão e a cobra, *
    calcarás aos pés o filho do leão e a serpente.
    Pois a quem me consagrou seu amor, eu libertarei; *
    vou lhe dar salvação, porque conheceu o meu Nome.
    Clamará por mim e eu lhe responderei; *
    junto estarei na sua angústia; encontrará libertação e lhe glorificarei.
    Eu lhe darei a satisfação de uma longa vida, *
    e lhe mostrarei minha salvação.
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    Como era no princípio, é agora e será sempre, *
    por todos os séculos. Amém.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'family_compline_reading_1', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'reading'
  lt.reference = 'Jo 3.16-17'
  lt.content = <<~TEXT
    Porque Deus amou o mundo de tal maneira que deu o seu Filho unigênito, para que toda pessoa que nele crê não pereça, mas tenha a vida eterna. Porque Deus enviou o seu Filho ao mundo, não para julgar o mundo, mas para que o mundo fosse salvo por ele.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'family_compline_reading_2', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'reading'
  lt.reference = 'Rm 5.6-8'
  lt.content = <<~TEXT
    Porque Cristo, estando nós ainda frágeis, morreu a seu tempo pelas pessoas ímpias. Dificilmente alguém dá a vida por uma pessoa justa; por uma pessoa de bem, talvez haja alguém que se disponha a morrer. Mas Deus prova o seu amor para conosco, em que Cristo morreu por nós, quando ainda estávamos em pecado.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'family_compline_reading_3', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'reading'
  lt.reference = '2 Co 5.14-15'
  lt.content = <<~TEXT
    Porque o amor de Cristo nos impulsiona, considerando que, se uma pessoa morreu por todas, logo todas morreram. E ele morreu por todas, para que quem vive não viva mais para si, mas para aquele que por nós morreu e ressuscitou.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'family_compline_collect_1', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Senhor Jesus Cristo, filho do Deus vivo, nosso irmão libertador: tu tomaste sobre ti os nossos pesares e carregaste a nossa frágil humanidade; pelo poder do Espírito Santo, renova em nós os dons que vêm de ti, a fim de que possamos dar testemunho do teu amor em nosso lar, em nossas vidas, e em toda parte. Que a tua bênção esteja sobre nós e sobre o nosso lar hoje e sempre. Por Jesus Cristo, nosso Senhor que contigo e o Espírito Santo vive e reina, um só Deus pelos séculos dos séculos. Amém.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'family_compline_collect_2', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Visita-nos nesta noite, ó Senhor, e livra-nos das ciladas e perigos; que teus santos anjos habitem conosco para nos preservar em paz e segurança; Que, nas incertezas da noite, tenhamos nossas vidas firmes na fé, e confiemo-nos inteiramente em tuas mãos para que faças florescer em nós a vida e a saúde, e transformes os desertos de nossas vidas pessoais e familiares em mananciais de vida, amor e alegria. Por Jesus Cristo, teu filho, nosso senhor, e na unidade do Espírito Santo. Amém.
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'family_compline_dismissal', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'dismissal'
  lt.reference = 'Nm 6.24-26'
  lt.content = <<~TEXT
    O Senhor nos abençoe e nos guarde.
    O Senhor faça resplandecer o seu semblante sobre nós, e tenha misericórdia de nós.
    O Senhor sobre nós levante sua face, e nos dê a paz, agora e sempre. Amém.
  TEXT
end
