# Seeds for Liturgical Texts
prayer_book = PrayerBook.find_by!(code: 'loc_2015')

Rails.logger.info "Criando textos do Ofício Diário para LOC 2015..."

## Oração da Manhã

# Acolhida Tradicional
LiturgicalText.find_or_create_by!(slug: 'morning_welcome_traditional', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Reunimo-nos como família de Deus,
    para lhe oferecer louvor e ações de graças,
    escutar e acolher a sua Palavra,
    apresentar-lhe as necessidades do mundo,
    implorar-lhe o perdão dos nossos pecados
    e pedir a sua graça,
    a fim de que, mediante seu Filho, Jesus Cristo,
    nos entreguemos ao seu serviço.
  TEXT
  end

# Acolhida Contemporânea
LiturgicalText.find_or_create_by!(slug: 'morning_welcome_contemporary', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Bendito sejas ó Deus Pai e Mãe,
    por teu Filho, nosso irmão Jesus Cristo,
    e pela presença da Ruáh Divina, teu Espírito de amor.
    **Glória a ti, ó santa e bendita Trindade,
    agora e para sempre. Amém.**

    Tu nos concedeste a Igreja, a qual fizeste Una, Santa,
    Católica e Apostólica.
    Em tua Igreja anunciamos o teu Reinado Vindouro;
    em tua Igreja conhecemos a transformação;
    em tua Igreja vivenciamos a cura e a reconciliação.

    **Pelo teu Santo Espírito, Ventania Divina,
    mantém-nos fiéis à unidade, santidade, catolicidade
    e fé apostólica da tua Igreja. Amém.**
  TEXT
  end

# Rubrica da Sentença de Abertura
LiturgicalText.find_or_create_by!(slug: 'opening_sentence_rubric', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Guarda-se um momento de silêncio.
    Pode-se cantar um hino ou salmo antes
    ou após as sentenças iniciais.
  TEXT
  end

# Sentença de Abertura 1
LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_1', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Este é o dia que o Senhor fez.
    **Vamos nos regozijar e nos alegrar nele.**
    Desde o oriente até o ocidente,
    seja louvado o nome do Senhor.
    **Excelso é o SENHOR acima de todas as nações;
    sua glória está acima dos céus.** __(Sl 113.4)__
  TEXT
  end

# Sentença de Abertura 2
LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_2', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Graça e Paz a vocês, da parte de Deus nosso Pai
    e do Senhor Jesus Cristo. __(Fl 1.2)__
    **Graças a Deus que nos dá a vitória por meio
    de nosso Senhor Jesus Cristo.** __(I Co 15.57)__
  TEXT
  end

# Sentença de Abertura 3
LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_3', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Envia a tua luz e a tua verdade, para que elas me guiem;
    e me levem ao teu santo monte e à tua morada.
    **Possa eu então chegar ao altar de DEUS, a DEUS,
    que é a minha grande alegria; e louvar-te ao som da
    harpa, ó DEUS, DEUS meu!** __(Sl 43.3-4)__
  TEXT
  end

# Sentença de Abertura 4
LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_4', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Eu me alegrei quando me disseram:
    Vamos à casa do SENHOR. __(Sl 122.1)__
    **O SENHOR está no seu santo templo;
    cale-se diante dele toda a terra.** __(Hb 2.20)__
  TEXT
  end

# Sentença de Abertura 5
LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_5', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Mas a hora vem, e é agora, em que adorarão
    verdadeiramente a Deus em espírito e verdade;
    porque Deus procura a quem assim o adore.
    **Deus é Espírito, e quem o adora deve adorá-lo
    em espírito e verdade.** __(Jo 4.23-24)__
  TEXT
  end

# Sentença de Abertura 6
LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_6', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Porque assim diz aquele que habita na eternidade,
    e cujo nome é Santo: Eu habito num alto e santo lugar;
    mas estou com as pessoas oprimidas e humilhadas.
    **Para reanimar o espírito das pessoas humilhadas,
    e para vivificar o coração das oprimidas.** __(Is 57.15)__
  TEXT
  end

# Sentença de Abertura 7
LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_7', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Sejam bem aceitas as palavras de minha boca, e o meditar
    de meu coração, perante a tua face, ó SENHOR, rocha
    minha e redentor meu! __(Sl 19.15)__
  TEXT
  end

# Sentença de Abertura Advento
LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_advent', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Estejam sempre alegres em suas vidas no Senhor.
    Repito: Alegrem-se. O Senhor virá logo. __(Fl 4.4-5)__
    **Amém. Vem, Senhor Jesus.** __(Ap. 22.20)__
  TEXT
  end

# Sentença de Abertura Natal
LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_christmas', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Foi assim que Ele mostrou o seu amor por nós:
    Ele mandou seu único Filho ao mundo para
    termos vida por meio dele. (I Jo 4.9)
    **A Palavra se fez carne e habitou entre nós,
    cheia de graça e de verdade.** __(Jo 1.14)__
  TEXT
  end

# Sentença de Abertura Epifania
LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_epiphany', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Dei-te como luz para as nações, para seres a minha
    salvação até a extremidade da terra. __(Is 49.6b)__
    **O povo que andava nas trevas viu uma grande luz, e
    uma luz brilhou sobre quem habitava na região da
    sombra da morte.** __(Is 9.2)__
  TEXT
  end

# Sentença de Abertura Quaresma
LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_lent', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Lava-me completamente de minha maldade e purifica-me
    do meu pecado.
    **Torna a dar-me a alegria da tua salvação, e sustenta-me
    com espontâneo Espírito.** __(Sl 51.2,12)__
  TEXT
  end

# Sentença de Abertura Semana Santa
LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_holy_week', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Disse Jesus: Se alguma pessoa quiser vir após mim, negue-se a si mesma, tome a sua cruz, e siga-me. __(Mc 8.34)__
    **Porque quem quiser salvar a sua vida,
    perdê-la-á, mas, quem perder a sua vida
    por amor a mim e ao Evangelho a salvará.** __(Mc 8.35)__
  TEXT
  end

# Sentença de Abertura Sexta-feira da Paixão
LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_good_friday', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Deus nos mostrou o quanto nos ama: quando ainda
    estávamos no pecado, Cristo morreu por nós. __(Rm 5.8)__
    **E agora, que Deus já nos aceitou por meio da morte
    de Cristo na cruz, com muito mais razão ficaremos
    livres do castigo, por meio dele.** __(Rm 5.9)__
  TEXT
  end

# Sentença de Abertura Páscoa
LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_easter', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Bendito seja o Deus e Pai de nosso Senhor Jesus Cristo
    por sua grande misericórdia!
    Ressuscitando a Jesus Cristo da morte,
    Ele nos fez renascer para uma esperança viva. __(I Pe 1.3)__
    **Graças a Deus que nos dá a vitória por meio
    de nosso Senhor Jesus Cristo.** __(I Co 15.57)__
  TEXT
  end

# Sentença de Abertura Ascensão
LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_ascension', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Vocês já ressuscitaram com Cristo,
    portanto busquem as coisas do alto,
    onde Cristo está assentado à direita de Deus.
    **Quando Cristo, que é a nossa vida, se manifestar, então
    também nos manifestaremos com ele na glória.** __(Cl 3.1,4)__
  TEXT
  end

# Sentença de Abertura Santo Nome
LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_holy_name', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Deus lhe deu a mais alta honra,
    e um nome que é superior a qualquer outro nome.
    **E, assim em honra ao nome de Jesus, todas as criaturas, no
    céu, na terra e sob a terra, dobram os joelhos, e para glória
    de Deus Pai proclamam: Jesus é o Senhor!** __(Fl 2.9,11)__
  TEXT
  end

# Sentença de Abertura Pentecostes
LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_pentecost', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Mas o Espírito Santo descerá sobre vocês,
    e dele receberão força para serem minhas
    testemunhas até aos confins da terra. __(At 1.8)__
    **Ora, há diversidade de dons,
    mas o Espírito é o mesmo.
    E há diversidade de ministérios,
    mas o Senhor é o mesmo.
    Cada qual recebe o dom de manifestar
    o Espírito para o bem comum.** __(1 Co 12.4-5,7)__
  TEXT
  end

# Sentença de Abertura Trindade
LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_trinity', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Santo, Santo, Santo, é o SENHOR Deus,
    o Todo-Poderoso, que era, e que é, e que há de vir.
    **Digno és, SENHOR, de receber glória, e honra,
    e poder; porque tu criaste todas as coisas, e por
    tua vontade existem e foram criadas.** __(Ap 4.8,11)__
  TEXT
  end

# Sentença de Abertura Todos os Santos
LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_all_saints', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Com alegria deem graças a Deus que permitiu a vocês
    participarem da herança dos santos e santas na luz. __(Cl 1.12)__
    **Assim, já somos parte da comunhão dos santos
    e santas, e membros da família de Deus.** __(Ef 2.19)__
  TEXT
  end

# Sentença de Abertura Ação de Graças e dias Festivos
LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_common_feast', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Louvem-te as nações, ó Deus;
    rendam-te graças todos os povos.
    **Alegrem-se e cantem as nações, pois julgas com retidão
    e guias os povos sobre a terra.** __(Sl 67.3-4)__
  TEXT
  end

# Rubrica da Confissão
LiturgicalText.find_or_create_by!(slug: 'morning_rubric_confession', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Quem oficia diz:
  TEXT
  end

# Abertura Confissão 1
LiturgicalText.find_or_create_by!(slug: 'morning_opening_confession_1', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'confession'
  lt.content = <<~TEXT
    Irmãs e irmãos em Cristo: Aqui, na presença de Deus, em
    silêncio, e com humildes e sinceros corações, confessemos
    os nossos pecados, de maneira que obtenhamos perdão e
    alívio por sua infinita bondade e misericórdia.
  TEXT
  end

# Abertura Confissão 2
LiturgicalText.find_or_create_by!(slug: 'morning_opening_confession_2', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'confession'
  lt.content = <<~TEXT
    Confessemos humildemente os nossos pecados
    a Deus Todo-poderoso.
  TEXT
  end

# Rubrica da Confissão
LiturgicalText.find_or_create_by!(slug: 'rubric_post_opening_confession', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    As admoestações anteriores podem ser substituídas por um
    versículo bíblico que desperte espírito de penitência.
    Há um instante de silêncio, estando
    ajoelhadas as pessoas que puderem.
    É dito por todas as pessoas:
  TEXT
  end

# Confissão 1
LiturgicalText.find_or_create_by!(slug: 'morning_confession_1', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'confession'
  lt.content = <<~TEXT
    Misericordioso Deus,
    confessamos que temos pecado contra ti,
    em pensamentos, palavras e ações;
    não te amamos de todo o nosso coração,
    nem a nossas irmãs e irmãos como amamos a nós.
    Imploramos a tua compaixão;
    esquece o que fomos, emenda o que somos,
    dirige o que seremos;
    de modo que nos alegremos em tua vontade
    e andemos em teus caminhos,
    por Jesus Cristo nosso Senhor. Amém.
  TEXT
  end

# Confissão 2
LiturgicalText.find_or_create_by!(slug: 'morning_confession_2', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'confession'
  lt.content = <<~TEXT
    Ó Deus,
    sentimos sobre nossos ombros o peso
    das injustiças deste nosso tempo.
    Temos visto o aparecimento de violências
    para subjugar diferenças,
    gerando desigualdades em todas as esferas sociais,
    tanto privadas quanto públicas.

    Perdoa nossa omissão e silêncio, ó Deus de justiça,
    e tem misericórdia de nós de acordo
    com tua amorosa bondade.
    Converte-nos e nos concede a graça de agirmos
    com coragem, generosidade e amor.
    Na certeza de que quando confessamos com
    sinceridade os nossos pecados, tu nos concedes perdão.
    Por Jesus Cristo, nosso irmão. Amém.
  TEXT
  end

# Confissão 3
LiturgicalText.find_or_create_by!(slug: 'morning_confession_3', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'confession'
  lt.content = <<~TEXT
    Tem misericórdia de nós, ó Deus,
    segundo a tua benignidade;
    apaga as nossas transgressões
    segundo a multidão de tuas misericórdias.
    Lava-nos completamente de nossa maldade
    e purifica-nos do nosso pecado.
    Cria em nós, ó Deus, um coração puro,
    e renova em nós um espírito reto.
    Não nos lances fora de tua presença
    e não retires de nós o teu Santo Espírito.
    Torna a dar-nos a alegria da tua salvação
    e sustenta-nos com a graça de teu Filho Jesus Cristo.
    Amém.
  TEXT
  end

# Rubrica após Confissão
LiturgicalText.find_or_create_by!(slug: 'rubric_post_confession', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    A pessoa que oficia, ainda ajoelhada,
    lê uma das orações seguintes.
    Estando, porém, presente um(a) bispo(a) ou presbítero(a),
    deve ser usada a Absolvição em lugar das orações a seguir:
  TEXT
  end

# Oração após Confissão 1
LiturgicalText.find_or_create_by!(slug: 'prayer_after_confession_1', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'confession'
  lt.content = <<~TEXT
    Ó Senhor, suplicamos-te que escutes compassivo nossas
    orações, e perdoes as pessoas que a ti confessam os seus
    pecados; para que aquelas que são acusadas por suas
    consciências, sejam absolvidas por teu perdão;
    mediante Jesus Cristo nosso Senhor. Amém.
  TEXT
  end

# Oração após Confissão 2
LiturgicalText.find_or_create_by!(slug: 'prayer_after_confession_2', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'confession'
  lt.content = <<~TEXT
    Deus Todo-poderoso tenha misericórdia de vocês,
    perdoe os seus pecados
    e mantenha vocês no caminho da vida eterna.
    **Deus Todo-poderoso tenha misericórdia de ti,
    perdoe os teus pecados
    e te mantenha no caminho da vida eterna. Amém.**
  TEXT
  end

# Absolvição
LiturgicalText.find_or_create_by!(slug: 'absolution', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'absolution'
  lt.content = <<~TEXT
    O Deus de amor,
    que, por sua grande misericórdia,
    promete o perdão a todas as pessoas que,
    com sincero arrependimento
    e viva fé, a Ele se convertem,
    perdoe e liberte vocês de todos os seus pecados,
    confirme e fortaleça suas vidas em todo o bem,
    e preserve vocês no caminho da vida eterna;
    mediante Jesus Cristo, nosso Senhor.
    **Amém.**
  TEXT
  end

# Rubrica após Absolvição
LiturgicalText.find_or_create_by!(slug: 'rubric_post_absolution', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Então levanta-se quem puder.
  TEXT
  end

# Invitatório
LiturgicalText.find_or_create_by!(slug: 'morning_invocation', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'invocation'
  lt.content = <<~TEXT
    Abre, ó SENHOR, os nossos lábios.
    **E a nossa boca proclamará o teu louvor.**
    Glória a Deus nas alturas!
    **E na terra paz,
    boa-vontade entre todas as suas criaturas.**
    Louvemos ao SENHOR.
    Aleluia!
  TEXT
  end

# Invitatório Quaresma
LiturgicalText.find_or_create_by!(slug: 'morning_invocation_lent', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'invocation'
  lt.content = <<~TEXT
    Abre, ó SENHOR, os nossos lábios.
    **E a nossa boca proclamará o teu louvor.**
    Glória a Deus nas alturas!
    **E na terra paz,
    boa-vontade entre todas as suas criaturas.**
    Louvemos ao SENHOR.
  TEXT
  end

# Pré-Invitatório Advento
LiturgicalText.find_or_create_by!(slug: 'morning_before_invocation_advent', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Nosso Rei e Salvador aproxima-se; Vamos adorá-lo.
  TEXT
  end

# Pré-Invitatório Natal
LiturgicalText.find_or_create_by!(slug: 'morning_before_invocation_christmas', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Aleluia. Porque a nós nos é nascido um menino;
    Vamos adorá-lo. Aleluia!
  TEXT
  end

# Pré-Invitatório Epifania
LiturgicalText.find_or_create_by!(slug: 'morning_before_invocation_epiphany', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Aleluia. O Senhor manifestou a sua glória;
    Vamos adorá-lo. Aleluia!
  TEXT
  end

# Pré-Invitatório Quaresma
LiturgicalText.find_or_create_by!(slug: 'morning_before_invocation_lent', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    O Senhor é cheio de compaixão e misericórdia;
    Vamos adorá-lo.
  TEXT
  end

# Pré-Invitatório Páscoa
LiturgicalText.find_or_create_by!(slug: 'morning_before_invocation_easter', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Aleluia. Ressuscitou verdadeiramente o Senhor;
    Vamos adorá-lo. Aleluia!
  TEXT
  end

# Pré-Invitatório Ascensão
LiturgicalText.find_or_create_by!(slug: 'morning_before_invocation_ascension', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Aleluia. Cristo Senhor subiu ao céu;
    Vamos adorá-lo. Aleluia!
  TEXT
  end

# Pré-Invitatório Pentecostes
LiturgicalText.find_or_create_by!(slug: 'morning_before_invocation_pentecost', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Aleluia. O Espírito do Senhor enche o mundo;
    Vamos adorá-lo. Aleluia!
  TEXT
  end

# Pré-Invitatório Trindade
LiturgicalText.find_or_create_by!(slug: 'morning_before_invocation_trinity', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Aleluia. Pai, Filho e Espírito Santo, um só Deus;
    Vamos adorá-lo. Aleluia!
  TEXT
  end

# Pré-Invitatório Anunciação
LiturgicalText.find_or_create_by!(slug: 'morning_before_invocation_anunciation', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Aleluia. O Verbo se fez carne e habitou entre nós;
    Vamos adorá-lo. Aleluia!
  TEXT
  end

# Pré-Invitatório Ação de Graças e outros dias festivos
LiturgicalText.find_or_create_by!(slug: 'morning_before_invocation_common_feast', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Aleluia!
    O Senhor é glorioso nos seus santos e santas;
    Vamos adorá-lo. Aleluia!
  TEXT
  end

# Venite
LiturgicalText.find_or_create_by!(slug: 'venite', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.title = 'Venite, exultemus Domino'
  lt.content = <<~TEXT
    Venham, cantemos ao SENHOR; *
    jubilemos à rocha da nossa salvação.
    Cheguemos ante a sua face com ação de graças; *
    e celebremos em salmos o seu louvor.
    Porque o SENHOR é Deus supremo, *
    e Rei de excelsa majestade.
    Guarda em sua mão os abismos da terra, *
    e as alturas dos montes são suas.
    Seu é o mar, pois ele o fez, *
    e a terra firme suas mãos formaram.
    Venham, adoremos e prostremo-nos; *
    ajoelhemos ante o SENHOR, que nos criou.
    Porque ele é o nosso Deus, *
    e nós, o povo que ele pastoreia,
    o rebanho que sua mão conduz.
    Adoremos ao SENHOR na beleza da santidade; *
    trema à sua presença toda a terra.
    Porque ele vem, sim, vem julgar a terra; *
    julgará o mundo com justiça,
    e os povos com a sua verdade.
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    Como era no princípio, é agora e será sempre, *
    por todos os séculos. Amém.
  TEXT
  lt.reference = 'Salmo 95.1-7; 96.9,13'
  end

# Venite
LiturgicalText.find_or_create_by!(slug: 'jubilate', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.title = 'Jubilate Deo'
  lt.content = <<~TEXT
    CELEBREM com júbilo ao SENHOR, *
    ó habitantes da terra;
    Sirvam ao SENHOR com alegria *
    e, cantando, venham à sua presença.
    Saibam que o SENHOR é DEUS; foi ele quem nos
    formou e nós lhe pertencemos; *
    somos seu povo e rebanho que ele pastoreia.
    Venham às suas portas bendizendo e
    com hino aos átrios sagrados; *
    deem graças, e bendigam seu Nome.
    Porque o SENHOR é benigno e eterna a sua misericórdia; *
    e sua fidelidade subsiste de geração em geração.
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    Como era no princípio, é agora e será sempre, *
    por todos os séculos. Amém.
  TEXT
  lt.reference = 'Salmo 100'
  end

# Venite
LiturgicalText.find_or_create_by!(slug: 'pascha_nostrum', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.title = 'Pascha Nostrum'
  lt.content = <<~TEXT
    Aleluia!
    Cristo, que é nossa Páscoa, foi imolado, *
    pelo que celebremos a festa!
    Não com o fermento velho, nem com o fermento
    da maldade e da malícia, *
    mas com os ázimos da sinceridade e da verdade.
    Aleluia! __(1 Co 5. 7)__
    Cristo, havendo ressuscitado da morte,
    já não morre mais; *
    a morte não mais domina sobre ele.
    Pois quanto ao morrer, ele morreu uma só vez ao pecado; *
    mas quanto ao viver, vive para Deus.
    Assim também vocês morrendo para o pecado, *
    vivam para Deus em Cristo Jesus nosso Senhor. __(Rm 6.9)__
    Cristo é agora ressuscitado da morte, *
    sendo ele as primícias de quem dorme.
    Pois desde que a morte veio por um homem, *
    também por um homem veio a ressurreição da morte.
    Pois assim como em Adão todas as pessoas morrem, *
    assim também em Cristo todas serão vivificadas.
    __(1 Co 15.20)__
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    Como era no princípio, é agora e será sempre, *
    por todos os séculos. Amém.
  TEXT
  end

# Rubrica do Gloria Patri
LiturgicalText.find_or_create_by!(slug: 'rubric_gloria_patri', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Há a recitação de um ou mais Salmos, sendo ao final de cada Salmo,
    ou após cada grupo de Salmos, cantado ou dito o Gloria Patri.
  TEXT
  end

# Gloria Patri
LiturgicalText.find_or_create_by!(slug: 'gloria_patri', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    **Como era no princípio, é agora e será sempre, *
    por todos os séculos. Amém.**
  TEXT
  end

# Rubrica da Primeira Leitura
LiturgicalText.find_or_create_by!(slug: 'rubric_first_reading', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Sentando-se todas as pessoas, é feita
    a leitura do Primeiro Testamento.
    A leitura é anunciada da seguinte maneira:
  TEXT
  end

# Primeira Leitura
LiturgicalText.find_or_create_by!(slug: 'first_reading', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'invocation'
  lt.content = <<~TEXT
    A Palavra de Deus, escrita no Livro de {{book_name}},
    capítulo {{chapter}}, começando com o versículo {{verse}}.
  TEXT
  end

# Rubrica após a Primeira Leitura
LiturgicalText.find_or_create_by!(slug: 'rubric_post_first_reading', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Quem estiver lendo termina com:
  TEXT
  end

# Após a Primeira Leitura
LiturgicalText.find_or_create_by!(slug: 'canticle_post_first_reading', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Palavra do Senhor.
    **Demos graças a Deus.**
  TEXT
  end

# Rubrica ao fim da Primeira Leitura
LiturgicalText.find_or_create_by!(slug: 'rubric_end_first_reading', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Após a leitura pode-se guardar um momento de silêncio.
    Estando de pé quem puder, é cantado ou
    recitado um dos Cânticos a seguir.
    Quando as circunstâncias exigirem,
    pode-se cantar um hino, em lugar do Cântico.
  TEXT
  end

# Benedictus es, Domine
LiturgicalText.find_or_create_by!(slug: 'benedictus_es_domine', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.title = 'Benedictus es, Domine'
  lt.content = <<~TEXT
    Bendito és tu, Senhor Deus de nossas mães e nossos pais; *
    digno de louvor e de glória para sempre.
    Bendito o santo Nome de tua Majestade; *
    digno de louvor e de glória para sempre.
    Bendito és tu no templo de tua santidade; *
    digno de louvor e de glória para sempre.
    Bendito és tu que sondas os abismos e presides
    acima dos Querubins; *
    digno de louvor e de glória para sempre.
    Bendito és tu sobre o glorioso trono do teu reino; *
    digno de louvor e de glória para sempre.
    Bendito és tu no firmamento dos céus; *
    digno de louvor e de glória para sempre.
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    Como era no princípio, é agora e será sempre, *
    por todos os séculos. Amém.
  TEXT
  end

# Cantate Domino
LiturgicalText.find_or_create_by!(slug: 'cantate_domino', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.title = 'Cantate Domino'
  lt.content = <<~TEXT
    CANTEM ao SENHOR um cântico novo,
    pois ele fez maravilhas; *
    sua mão e seu braço santo alcançaram a vitória.
    O SENHOR manifestou sua salvação, *
    revelou justiça entre as nações.
    Lembrou-se de sua bondade e fidelidade
    para com a casa de Israel; *
    viram os confins da terra a divina salvação.
    Exaltem ao SENHOR, habitantes da terra, *
    exclamem, alegrem-se e cantem louvores.
    Cantem louvores ao SENHOR com a harpa, *
    com a harpa e com voz de canto.
    Com flauta e som de trombetas, *
    exultem na presença do SENHOR, o Rei.
    Ruja o mar e sua plenitude, *
    o mundo e quem nele habita.
    Batam palmas os rios; *
    unânimes aplaudam os montes ao SENHOR.
    Ante a face do SENHOR, porque ele vem julgar a terra; *
    com justiça julgará o mundo,
    e os povos com imparcialidade.
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    Como era no princípio, é agora e será sempre, *
    por todos os séculos. Amém.
  TEXT
    lt.reference = 'Salmo 98'
end

# Benedicite Omnia Opera
LiturgicalText.find_or_create_by!(slug: 'benedicite_omnia_opera', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.title = 'Benedicite, omnia opera'
  lt.content = <<~TEXT
    __(Invocação)__
    Bendigam ao SENHOR todas as suas obras, *
    louvem-no e exaltem-no para sempre.
    Nos céus bendigam ao SENHOR, *
    louvem-no e exaltem-no para sempre.

    __(A Ordem Cósmica)__
    Bendigam ao SENHOR os seus anjos e potências; *
    céus e águas todas acima dos céus,
    Sol e lua, e estrelas do céu, bendigam ao Senhor, *
    louvem-no e exaltem-no para sempre.

    Bendigam ao SENHOR chuva e orvalho, *
    ventos todos, fogo e calor.
    Inverno e verão, bendigam ao SENHOR, *
    louvem-no e exaltem-no para sempre.
    Bendigam ao SENHOR orvalhos e aguaceiros, *
    gelo e frio.

    Geada, neve e granizo, bendigam ao SENHOR, *
    louvem-no e exaltem-no para sempre.
    Bendigam ao SENHOR noite e dia, *
    luz e trevas.
    Relâmpagos e nuvens, bendigam ao SENHOR, *
    louvem-no e exaltem-no para sempre.

    __(A Terra e suas Criaturas)__
    Terra bendiga ao SENHOR, *
    louve-o e exalte-o para sempre.
    Montanhas e colinas, e tudo que brota do chão,
    bendigam ao SENHOR, *
    louvem-no e exaltem-no para sempre.
    Bendigam ao SENHOR mananciais e fontes, mares e rios, *
    baleias e tudo que se move nas águas.
    Aves do céu, bendigam ao SENHOR, *
    louvem-no e exaltem-no para sempre
    Bendigam ao SENHOR animais selvagens e domésticos, *
    e todos os rebanhos e manadas.
    Homens e mulheres em todos os lugares,
    bendigam ao SENHOR, *
    louvem-no e exaltem-no para sempre.

    __(O Povo de Deus)__
    O povo do SENHOR bendiga ao SENHOR, *
    louve-o e exalte-o para sempre.
    Bendigam ao SENHOR todas as pessoas
    que servem ao SENHOR, *
    louvem-no e exaltem-no para sempre.

    Bendigam ao SENHOR espíritos e almas das pessoas justas, *
    louvem-no e exaltem-no para sempre.
    Pessoas santas de coração bendigam ao SENHOR, *
    louvem-no e exaltem-no para sempre.

    __(Doxologia)__
    Bendigamos ao SENHOR: Pai, Filho e Espírito Santo, *
    O louvemos e exaltemos para sempre.
    Nos céus, bendito seja o Senhor, *
    louvado e exaltado acima de tudo e para sempre.
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    Como era no princípio, é agora e será sempre, *
    por todos os séculos. Amém.
  TEXT
    lt.reference = 'Dn 3.57-87'
end

# Rubrica da Segunda Leitura
LiturgicalText.find_or_create_by!(slug: 'rubric_second_reading', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Sentando-se, há a leitura do Segundo Testamento.
    Nos casos em que a Oração da Manhã for utilizada em
    substituição à Liturgia da Palavra na Celebração Eucarística o
    Evangelho não pode ser omitido.
    Sempre que as três leituras bíblicas forem usadas o
    Evangelho é lido após o segundo cântico.
    A leitura é anunciada da seguinte maneira:
  TEXT
  end

# Segunda Leitura
LiturgicalText.find_or_create_by!(slug: 'second_reading', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'invocation'
  lt.content = <<~TEXT
    A Palavra de Deus, escrita na Epístola (ou Evangelho)
    de {{book_name}}, capítulo {{chapter}},
    começando com o versículo {{verse}}.
  TEXT
  end

# Rubrica após a Segunda Leitura
LiturgicalText.find_or_create_by!(slug: 'rubric_post_second_reading', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Quem estiver lendo termina com:
  TEXT
  end

# Após a Segunda Leitura
LiturgicalText.find_or_create_by!(slug: 'canticle_post_second_reading', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Palavra do Senhor.
    **Demos graças a Deus.**
  TEXT
  end

# Rubrica ao fim da Primeira Leitura
LiturgicalText.find_or_create_by!(slug: 'rubric_end_second_reading', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Após a leitura pode-se guardar um momento de silêncio.
    Estando de pé quem puder, é cantado ou
    recitado um dos Cânticos a seguir:
    Quando as circunstâncias exigirem pode-se
    cantar um hino em lugar do Cântico.
  TEXT
  end

# Te Deum Laudamus
LiturgicalText.find_or_create_by!(slug: 'te_deum_laudamus', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.title = 'Te Deum Laudamus'
  lt.content = <<~TEXT
    A ti, ó Deus, louvamos, e por Senhor nosso confessamos.
    A ti, ó eterno, adora toda a terra.
    A ti os anjos todos,
    a ti clamam os Céus e todas as Potestades.
    A ti os Querubins e os Serafins proclamam
    com incessante voz:
    Santo, Santo, Santo, Senhor Deus das Celestes hostes;
    Os céus e a terra estão plenos da Majestade da tua glória.
    A ti louvam em coro Apóstolos e Apóstolas,
    A ti louva a santa congregação dos Profetas e Profetizas,
    A ti louva o triunfante exército de Mártires.
    A ti confessa pela amplidão do universo a Santa Igreja;
    A ti Pai Materno de infinita majestade;
    A teu Filho unigênito, verdadeiro e adorável;
    E ao Espírito Santo, o Consolador.
    Tu és o Rei da Glória, Ó Cristo.
    Tu és do Pai o sempiterno Filho.
    Tu, ao empreenderes a redenção da humanidade,
    te humilhaste a nascer de uma Virgem.
    Tu, vencido o aguilhão da morte,
    abriste a quem crê o Reino dos céus.
    Tu, à destra de Deus, te assentas na glória eterna.
    Cremos seres tu o Juiz vindouro.
    Eis porque te rogamos socorras a quem te serve,
    pois com sangue precioso redimiste.
    Para que estejam com teus santos e santas
    na glória sempiterna.
    Salva o teu povo, ó Senhor, e abençoa a tua herança.
    Governa-o e exalta-o eternamente.
    De dia em dia te bendizemos;
    E louvamos teu Nome pelos séculos sem fim.
    Digna-te, ó Senhor, guardar-nos hoje sem pecado.
    Tem misericórdia de nós, Senhor,
    tem misericórdia de nós.
    Seja sobre nós, Senhor, a tua misericórdia,
    assim como em ti confiamos.
    Em ti, Senhor, temos esperado;
    livra-nos de todo sofrimento e confusão.
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    Como era no princípio, é agora e será sempre, *
    por todos os séculos. Amém.
  TEXT
  end

# Magna et mirabilia
LiturgicalText.find_or_create_by!(slug: 'magna_et_mirabilia', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.title = 'Magna et mirabilia'
  lt.content = <<~TEXT
    Grandes e admiráveis são as tuas obras, *
    Senhor Deus, Todo-poderoso!
    Justos e verdadeiros são os teus caminhos, *
    ó Soberano das nações!
    Quem não temerá e não glorificará o teu nome, ó Senhor? *
    Pois só tu és santo.
    Todas as nações virão à tua presença e te adorarão, *
    pois teus juízos ficaram claros diante
    de toda humanidade.
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    Como era no princípio, é agora e será sempre, *
    por todos os séculos. Amém.
  TEXT
    lt.reference = 'Ap 15.3-4'
end

# Benedic, anima mea (Salmo 103)
LiturgicalText.find_or_create_by!(slug: 'benedic_anima_mea', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.title = 'Benedic, anima mea'
  lt.content = <<~TEXT
    BENDIZE, ó minha alma, ao SENHOR, *
    bendiga todo o meu ser o Nome santo.
    Bendize ao SENHOR, ó minha alma, *
    e não esqueças seus benefícios.
    É ele quem perdoa o teu pecado, *
    quem sara tuas enfermidades.
    Quem da destruição tua vida redime; *
    quem de misericórdia e de bondade te coroa.
    Bendigam ao SENHOR vocês, seres angelicais,
    de muito poder; que executam o divino mando, *
    obedecendo à voz da sua palavra.
    Bendigam ao SENHOR, todos os seus exércitos, *
    vocês, que estão ao seu serviço,
    que cumprem a sua vontade.
    Bendigam ao SENHOR vocês, todas as suas obras,
    em todos os lugares de seu domínio; *
    ó minha alma, bendize ao SENHOR!
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    Como era no princípio, é agora e será sempre, *
    por todos os séculos. Amém.
  TEXT
    lt.reference = 'Salmo 103'
end

# Rubrica ao fim da Segunda Leitura
LiturgicalText.find_or_create_by!(slug: 'rubric_end_second_canticle', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Segue-se o Sermão, que pode ser omitido
    exceto aos Domingos e Festas Principais.
    Estando de pé quem puder, é dito o Credo.
  TEXT
  end

# Credo Apostólico
LiturgicalText.find_or_create_by!(slug: 'apostles_creed', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'creed'
  lt.content = <<~TEXT
    **Creio em Deus Pai Todo-Poderoso,
    Criador do céu e da terra;
    e em Jesus Cristo, seu único Filho, nosso Senhor,
    o qual foi concebido por obra do Espírito Santo,
    nasceu da Virgem Maria,
    padeceu sob o poder de Pôncio Pilatos,
    foi crucificado, morto e sepultado,
    desceu ao Hades,
    ressuscitou ao terceiro dia,
    subiu ao Céu,
    e está sentado à mão direita de
    Deus Pai Todo-Poderoso
    donde há de vir a julgar os vivos e os mortos.
    Creio no Espírito Santo,
    na Santa Igreja Católica,
    na Comunhão dos Santos,
    na remissão dos pecados,
    na ressurreição do corpo
    e na Vida eterna. Amém.**
  TEXT
  end

# Paráfrase do Credo Apostólico
LiturgicalText.find_or_create_by!(slug: 'apostles_creed_paraphrase', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'creed'
  lt.content = <<~TEXT
    Bendigamos a Deus, Pai, Filho e Espírito Santo.
    **Nós o louvamos e exaltamos para todo o sempre.**
    Damos graças ao SENHOR,
    porque ele nos ama desde a eternidade.
    **Porque sua misericórdia dura para sempre.**
    Na plenitude dos tempos,
    ele desceu do céu para nos trazer salvação.
    **Porque sua misericórdia dura para sempre.**
    E encarnou por obra do Espírito Santo
    da Virgem Maria e foi feito homem,
    **Porque sua misericórdia dura para sempre.**
    E nos remiu dos nossos pecados, sofrendo morte de cruz.
    **Porque sua misericórdia dura para sempre.**
    Ao terceiro dia ressurgiu da morte.
    **Porque sua misericórdia dura para sempre.**
    E, também, nos deu a vitória sobre a morte.
    **Porque sua misericórdia dura para sempre.**
    Subiu às alturas, e nos abriu os portais da eternidade.
    **Porque sua misericórdia dura para sempre.**
    Está em posição de honra, junto ao Pai.
    **Porque sua misericórdia dura para sempre.**
    E vive eternamente para interceder por nós.
    **Porque sua misericórdia dura para sempre.**
    Nele temos comunhão com todos os santos e santas,
    inclusive com quem já partiu.
    **Porque sua misericórdia dura para sempre.**
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    **Como era no princípio, é agora e será sempre, *
    por todos os séculos. Amém.**
  TEXT
  end

# Rubrica do Ofertório
LiturgicalText.find_or_create_by!(slug: 'rubric_offertory', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Neste momento podem ser recolhidas e apresentadas Ofertas.
    Quem oficia pode iniciar e encerrar o Ofertório
    com quaisquer sentenças das Escrituras Sagradas.
    Durante o Ofertório pode-se cantar um Salmo ou um hino.
    Nos casos em que a Oração da Manhã for utilizada
    como Liturgia da Palavra na Celebração Eucarística,
    a Coleta do Dia e a Saudação da Paz devem anteceder o
    Ofertório, passando-se logo após para a Oração Eucarística.
  TEXT
  end

# Rubrica das Orações
LiturgicalText.find_or_create_by!(slug: 'morning_rubric_prayers', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Estando em pé ou ajoelhadas as pessoas
    que puderem, é dita a Oração do Pai nosso:
  TEXT
  end

# Invocação da Oração do Pai Nosso 1
LiturgicalText.find_or_create_by!(slug: 'invocation_our_father_1', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'invocation'
  lt.content = <<~TEXT
    O Senhor seja com vocês.
    **Seja também contigo.**
  TEXT
  end

# Invocação da Oração do Pai Nosso 2
LiturgicalText.find_or_create_by!(slug: 'invocation_our_father_2', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'invocation'
  lt.content = <<~TEXT
    O Senhor está aqui.
    **Seu Espírito está conosco.**
  TEXT
  end

# Oração do Pai Nosso
LiturgicalText.find_or_create_by!(slug: 'our_father', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Oremos.
    **Pai nosso, que estás nos céus.
    Santificado seja o teu Nome.
    Venha o teu Reino.
    Seja feita a tua vontade, assim na terra como no céu.
    O pão nosso de cada dia nos dá hoje.
    Perdoa-nos as nossas ofensas,
    assim como nós perdoamos a quem nos tem ofendido.
    E não nos deixes cair em tentação,
    mas livra-nos do mal;
    pois teu é o Reino, o poder e a glória para sempre.
    Amém.**
  TEXT
  end

# Oração da Misericórdia 1
LiturgicalText.find_or_create_by!(slug: 'mercy_prayer_1', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Ó Senhor, mostra-nos a tua misericórdia.
    **E concede-nos a tua salvação.**
    Reveste de santidade teus ministros e ministras.
    **E cante teu povo de alegria.**
    Derrama paz sobre o mundo inteiro.
    **Pois só em ti podemos viver em segurança**
    Guarda a Nação sob os teus cuidados.
    **E guia-nos pelos caminhos da justiça e da verdade.**
    Sejam teus mandamentos conhecidos em toda a terra.
    **E vivam as nações em harmonia.**
    Não sejam esquecidas as pessoas necessitadas.
    **Nem se apague a esperança das pessoas pobres.**
    Cria em nós um coração novo.
    **E sustenta-nos com teu Espírito Santo.**
  TEXT
  end

# Oração da Misericórdia 2
LiturgicalText.find_or_create_by!(slug: 'mercy_prayer_2', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Salva, ó Deus, o teu povo.
    **Governa-o e protege-o, agora e sempre.**
    De dia em dia te bendizemos.
    **E louvamos teu nome para sempre.**
    Guarda-nos, hoje, do pecado.
    **Tem piedade de nós, ó Deus, tem piedade.**
    Mostra-nos teu amor e bondade.
    **Pois em ti pomos nossa confiança.**
    Em ti está nossa esperança.
    **Jamais haja dúvidas em nossa fé.**
  TEXT
  end

# Rubrica da Coleta do Dia
LiturgicalText.find_or_create_by!(slug: 'rubric_collect_of_the_day', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Estando ajoelhadas as pessoas que puderem, é dita a
    Coleta do Dia e da Quadra do Ano Cristão, quando houver.
  TEXT
  end

# Rubrica da Coleta do Dia
LiturgicalText.find_or_create_by!(slug: 'rubric_general_collects', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    São feitas uma ou mais das orações que seguem,
    e que podem ser substituídas por orações espontâneas,
    a cargo das pessoas da congregação.
    Também podem ser dados, por quem oficia,
    tópicos para orações, seguidos de orações silenciosas
  TEXT
  end

# Pela paz
LiturgicalText.find_or_create_by!(slug: 'for_peace', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Ó Deus, que és o autor da paz,
    a quem conhecer é possuir a vida eterna
    e a quem servir é a plena liberdade,
    conserva sob tua proteção as pessoas que
    humildes invocam teu nome,
    a fim de que, na certeza de teu amparo,
    jamais temamos as forças do mal;
    mediante o poder de Jesus Cristo, nosso Senhor.
    **Amém.**
  TEXT
  end

# Pela graça
LiturgicalText.find_or_create_by!(slug: 'for_grace', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Ó Deus Eterno, nosso Pai e Mãe de misericórdia,
    que nos trouxeste em segurança até o início deste dia,
    defende-nos com teu imenso poder,
    não permitindo que a adversidade nos vença,
    ou que de ti nos afastemos,
    e concede que nossos pensamentos e ações,
    inspirados por ti,
    sejam sempre agradáveis a teus olhos;
    mediante Jesus Cristo nosso Senhor.
    **Amém.**
  TEXT
  end

# Por todas as autoridades
LiturgicalText.find_or_create_by!(slug: 'for_all_authorities', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Ó Deus, que és justo e compassivo,
    oramos por nosso país e pelo mundo todo.
    Concede à(ao) Presidente da República,
    e a todas às demais autoridades, sabedoria e força,
    coragem e inspiração.
    Fazendo-as sempre conscientes da missão de conduzir a
    construção de uma sociedade alicerçada na tua vontade.
    De modo que as pessoas fracas sejam protegidas;
    os recursos e bens materiais sejam compartilhados,
    e todas as pessoas possam desfrutá-los;
    as diversas etnias e culturas vivam com respeito mútuo;
    a paz seja alicerçada na justiça,
    e a justiça conduzida pelo amor.
    Mediante Jesus Cristo, nosso Senhor.
    **Amém.**
  TEXT
  end

# Pela liderança clerical
LiturgicalText.find_or_create_by!(slug: 'for_clergy', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Ó Deus, nosso Pai Materno,
    oramos pela liderança clerical de tua Igreja,
    para que faças descer sobre ela
    a abundância dos teus dons;
    de forma que fielmente manifeste os teus mistérios
    e incansavelmente proclame o teu Evangelho.
    Abençoa e guarda, ó Senhor, nossa liderança,
    fazendo com que sejam um sinal genuíno da presença
    e do amor de Cristo no meio do teu povo.
    Mediante Jesus Cristo, nosso Bom Pastor.
    **Amém.**
  TEXT
  end

# Pela família paroquial
LiturgicalText.find_or_create_by!(slug: 'for_parish_family', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Ó Deus, Espírito Santo,
    Santificador das pessoas fiéis,
    visita, te rogamos, nossa congregação
    com teu amor e favor;
    ilumina nossos entendimentos mais e mais
    com a luz de teu eterno Evangelho;
    implanta em nossos corações o amor à verdade;
    nutre-nos com toda a bondade;
    aumenta em nós a verdadeira fé;
    e nela nos guarda por tua misericórdia,
    ó bendito Espírito, que, com o Pai e o Filho,
    juntos adoramos e glorificamos como um só Deus,
    por séculos sem fim.
    **Amém.**
  TEXT
  end

# Por toda a humanidade
LiturgicalText.find_or_create_by!(slug: 'for_all_humanity', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Ó Deus, Criador e Protetor de todo o gênero humano,
    intercedemos humildemente pelas pessoas
    de todas as classes e condições:
    digna-te fazer-lhes conhecidos os teus caminhos,
    e manifesta a todas as nações a tua eterna salvação.
    Pedimos especialmente a favor de tua santa Igreja;
    a fim de que ela seja de tal maneira guiada e governada
    por teu Santo Espírito,
    que todas as pessoas que professam a fé cristã
    sejam conduzidas no caminho da verdade,
    em unidade, paz e retidão.
    Confiamos, finalmente, à tua bondosa mão
    todas as pessoas que de qualquer modo
    se achem aflitas ou perturbadas
    na consciência, no corpo ou na situação da vida;
    particularmente aquelas por quem
    as nossas orações são desejadas.
  TEXT
  end

# Rubrica após as Orações
LiturgicalText.find_or_create_by!(slug: 'morning_rubric_after_prayers', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    (Aqui pode-se guardar um momento de silêncio
    ou dar oportunidade para intercessões pessoais)
  TEXT
  end

# Oração Final
LiturgicalText.find_or_create_by!(slug: 'morning_final_prayer', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Suplicamos que as confortes e alivies,
    em todos os seus problemas,
    dando-lhes paciência no sofrimento
    e força para vencer as aflições.
    E isto nós te rogamos por amor de Jesus.
    **Amém.**
  TEXT
  end

# Rubrica após as Orações
LiturgicalText.find_or_create_by!(slug: 'morning_rubric_after_final_prayer', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Aqui podem ser usadas uma das intercessões
    deste livro ou litanias autorizadas.
    As Orações são concluídas com uma das seguintes
    Orações Gerais de Ação de Graças, podendo
    ser precedidas por uma música ou hino:
  TEXT
  end

# Geral Ação de Graças
LiturgicalText.find_or_create_by!(slug: 'opening_general_thanksgiving', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    **Onipotente e misericordioso Deus,
    nós te rendemos os mais humildes
    e sinceros agradecimentos
    por toda a tua ternura e bondade para conosco
    e para com todas as pessoas.**
  TEXT
  end

# Rubrica após a abertura da Ação de Graças
LiturgicalText.find_or_create_by!(slug: 'rubric_after_opening_general_thanksgiving', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    (Aqui pode-se guardar breve silêncio, para que
    as pessoas ofereçam suas ações de graças)
  TEXT
  end

# Geral Ação de Graças
LiturgicalText.find_or_create_by!(slug: 'general_thanksgiving_1', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    **Nós te bendizemos por nossa criação,
    preservação e por todas as bênçãos desta vida;
    principalmente por teu inestimável amor
    na redenção do mundo
    por nosso Senhor Jesus Cristo,
    pelos meios de graça e esperança da glória.
    A ti rogamos nos concedas tal apreciação
    de tuas misericórdias,
    que nossos corações exultem de sincera gratidão,
    e que proclamemos teus louvores
    não somente com os nossos lábios,
    mas com as nossas vidas,
    entregando-nos inteiramente a teu serviço,
    e andando na tua presença em santidade e retidão
    todos os nossos dias.
    Por Jesus Cristo nosso Senhor,
    a quem contigo e o Espírito Santo,
    seja toda a honra e glória, por séculos sem fim.
    Amém.**
  TEXT
  end

# Geral Ação de Graças
LiturgicalText.find_or_create_by!(slug: 'general_thanksgiving_2', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Pelo dom de teu Espírito.
    **Bendito sejas, ó Cristo.**
    Pela tua Santa Igreja.
    **Bendito sejas, ó Cristo.**
    Pelos Sacramentos e outros meios de graça.
    **Bendito sejas, ó Cristo.**
    Pela esperança da glória de Deus.
    **Bendito sejas, ó Cristo.**
    Pelas vitórias do Evangelho.
    **Bendito sejas, ó Cristo.**
    Pelo testemunho de todos os teus santos e santas.
    **Bendito sejas, ó Cristo.**
    Na alegria e na tristeza.
    **Bendito sejas, ó Cristo.**
    Na vida e na morte.
    **Bendito sejas, ó Cristo.**
    Hoje e todo o sempre.
    **Bendito sejas, ó Cristo.
    Honra, louvor e ações de graças te sejam dadas,
    ó santa e gloriosa Trindade,
    Pai, Filho e Espírito Santo,
    por todos os seres humanos,
    para todo o sempre.
    Amém.**
  TEXT
  end

# Oração de São João Crisóstomo
LiturgicalText.find_or_create_by!(slug: 'chrysostom_prayer', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Deus Todo-poderoso,
    que nos deste hoje a graça de te dirigirmos
    as nossas orações,
    prometendo que onde se reunissem
    duas ou três pessoas em teu Nome,
    atenderias as suas petições;
    cumpre agora, ó Senhor,
    os desejos e orações de teus servos e servas,
    segundo a estas pessoas mais convier,
    e concede-nos neste mundo
    o conhecimento da tua verdade
    e no vindouro a vida eterna.
    **Amém.**
  TEXT
  end

# Rubrica das Orações Conclusivas
LiturgicalText.find_or_create_by!(slug: 'rubric_concluding_prayers', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Pode-se acrescentar a seguinte sentença:
  TEXT
  end

# Orações Conclusivas
LiturgicalText.find_or_create_by!(slug: 'opening_concluding_prayers', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Bendigamos ao SENHOR.
    **Graças rendamos a Deus.**
  TEXT
  end

# Rubrica da Despedida
LiturgicalText.find_or_create_by!(slug: 'morning_rubric_dismissal', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    A Oração da Manhã termina com uma das seguintes
    Orações Conclusivas, podendo ainda serem substituídas
    por um outro versículo adequado das Sagradas Escrituras:
  TEXT
  end

# Despedida 1
LiturgicalText.find_or_create_by!(slug: 'dismissal_1', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'dismissal'
  lt.content = <<~TEXT
    A Graça de nosso Senhor Jesus Cristo,
    e o amor de Deus,
    e a comunhão do Espírito Santo
    sejam conosco para sempre. __(2 Co 13.14)__
    **Amém.**
  TEXT
  end

# Despedida 2
LiturgicalText.find_or_create_by!(slug: 'dismissal_2', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'dismissal'
  lt.content = <<~TEXT
    O Senhor nos abençoe e nos guarde.
    O Senhor faça resplandecer o seu semblante sobre nós,
    e tenha misericórdia de nós.
    O Senhor sobre nós levante sua face,
    e nos dê a paz, agora e sempre. __(Nm 6.24-26)__
    **Amém.**
  TEXT
  end

# Despedida 3
LiturgicalText.find_or_create_by!(slug: 'dismissal_3', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'dismissal'
  lt.content = <<~TEXT
    Que o Deus da esperança
    nos encha de completa alegria e paz na fé,
    para que transbordemos de esperança,
    pela força do Espírito Santo. __(Rm 15.13)__
    **Amém.**
  TEXT
  end

# Despedida 4
LiturgicalText.find_or_create_by!(slug: 'dismissal_4', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'dismissal'
  lt.content = <<~TEXT
    Glória a Deus,
    cujo poder agindo em nós,
    pode fazer infinitamente mais
    do que podemos pedir ou imaginar.
    Glória a Deus,
    na igreja e em Cristo Jesus,
    de geração em geração,
    para todo o sempre. __(Ef 3.20-21)__
    **Amém.**
  TEXT
  end

# Rubrica após a Despedida
LiturgicalText.find_or_create_by!(slug: 'rubric_post_dismissal', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Estando porém presente um(a) bispo(a) ou presbítero(a),
    a congregação pode ser despedida com uma Bênção.
  TEXT
  end

## Oração da Noite (Complines/Completas)

# Rubrica de abertura
LiturgicalText.find_or_create_by!(slug: 'compline_rubric_opening', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Guarda-se um momento de silêncio.
    Estando de pé as pessoas que puderem,
    quem oficia inicia com as seguintes sentenças:
  TEXT
  end

# Preparação
LiturgicalText.find_or_create_by!(slug: 'compline_preparation', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    O Senhor Onipotente nos conceda uma
    noite tranquila e a paz na derradeira hora.
    **Amém.**
    Nosso auxílio está no nome do Senhor.
    **Que fez o céu e a terra.**
  TEXT
  end

# Rubrica após a Preparação
LiturgicalText.find_or_create_by!(slug: 'compline_rubric_post_preparation', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Silêncio
    Pode ser dita a seguinte lição breve:
  TEXT
  end

# Preparação
LiturgicalText.find_or_create_by!(slug: 'compline_brief_lesson', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Irmãs e irmãos,
    estejam alertas e vigiem, porque o inimigo de vocês,
    o diabo, anda ao redor como um leão,
    rugindo e procurando a quem possa devorar.
    Resistam-lhe firmes na fé. __(I Pe 5.8-9a)__

    Tu, porém, Senhor, tem misericórdia de nós.
    **Graças rendamos a Deus.**
    O nosso auxílio está no nome do Senhor.
    **Que fez os Céus e a Terra.**
  TEXT
  end

# Rubrica de Silêncio
LiturgicalText.find_or_create_by!(slug: 'compline_rubric_silence', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Silêncio
  TEXT
  end

# Confissão
LiturgicalText.find_or_create_by!(slug: 'compline_confession', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'confession'
  lt.content = <<~TEXT
    Confessamos a Deus Todo-Poderoso,
    **Pai, Filho e Espírito Santo,
    que temos pecado excessivamente,
    por pensamentos, palavras e ações,
    por nossa culpa, por nossa própria culpa,
    por nossa máxima culpa.
    Por isso rogamos a Deus
    que tenha misericórdia de nós.**
  TEXT
  end

# Resposta após a Confissão
LiturgicalText.find_or_create_by!(slug: 'compline_post_confession', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'confession'
  lt.content = <<~TEXT
    **Deus Todo-Poderoso tenha misericórdia de nós,
    perdoe os nossos pecados e nos conduza à vida eterna.
    Amém.**
  TEXT
  end

# Súplica de Perdão
LiturgicalText.find_or_create_by!(slug: 'compline_absolution', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'absolution'
  lt.content = <<~TEXT
    O Senhor nos enriqueça com sua graça,
    **nos honre com sua bênção celestial;
    nos defenda de toda a adversidade,
    e nos afaste de todo o mal.
    O Senhor receba as nossas orações
    e graciosamente nos absolva
    de nossas faltas e pecados. Amém.**
    Converte-nos, ó Deus nosso Salvador.
    **E afasta de nós a tua ira.**
    Ó Deus, vem em nosso auxílio.
    **Senhor, apressa-te em socorrer-nos.**
    Glória ao Pai e ao Filho;
    e ao Espírito Santo;
    **Como era no princípio, é agora e será sempre,
    por todos os séculos. Amém.**
  TEXT
  end

# Rubrica após a Súplica de Perdão
LiturgicalText.find_or_create_by!(slug: 'compline_rubric_post_absolution', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Pode cantar-se um hino.
  TEXT
  end

# Rubrica antes dos Salmos
LiturgicalText.find_or_create_by!(slug: 'compline_rubric_before_psalms', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Podem ser recitados ou cantados um ou mais dos seguintes
    salmos, bem como outras seleções adequadas do Saltério.
  TEXT
  end

# Cum invocarem
LiturgicalText.find_or_create_by!(slug: 'cum_invocarem', prayer_book_id: prayer_book.id) do |lt|
  lt.title = 'Cum invocarem'
  lt.category = 'canticle'
  lt.content = <<~TEXT
    RESPONDE ao meu clamor, DEUS de minha justiça,
    tu que na angústia me dás alívio. *
    Compadece-te de mim e escuta minha súplica.
    Grandes da terra, até quando difamarão minha glória? *
    Até quando amarão a vaidade e buscarão a mentira?
    Saibam que o SENHOR distingue quem lhe é benquisto; *
    o SENHOR ouve, quando a ele clamo.
    Tremam e não pequem mais. *
    Consultem, em seus corações,
    e no silêncio de seus leitos.
    Ofereçam sacrifícios de justiça *
    e descansem no SENHOR.
    Muitas pessoas dizem: ah! quem nos mostrará prosperidade? *
    Levanta sobre nós, SENHOR, a luz da tua face.
    Puseste em meu coração mais alegria que a delas *
    quando tem abundante o trigo e o vinho.
    Em paz me deitarei e logo dormirei; *
    porque, SENHOR, só tu me fazes habitar
    em segurança.
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    Como era no princípio, é agora e será sempre, *
    por todos os séculos. Amém.
  TEXT
  lt.reference = 'Salmo 4'
  end

# Qui habitat
LiturgicalText.find_or_create_by!(slug: 'qui_habitat', prayer_book_id: prayer_book.id) do |lt|
  lt.title = 'Qui habitat'
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Quem habita sob a proteção do Altíssimo, *
    à sombra do Onipotente repousará.
    Direi do SENHOR: Ele é meu refúgio e fortaleza, *
    DEUS meu, em quem eu confio.
    Ele te livrará das ciladas, *
    e da peste perniciosa.
    Cobrir-te-á com as suas penas; sob suas asas encontrarás
    refúgio; *
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
    vou lhe dar salvação, porque conheceu o
    meu Nome.
    Clamará por mim e eu lhe responderei; *
    junto estarei na sua angústia;
    encontrará libertação e lhe glorificarei.
    Eu lhe darei a satisfação de uma longa vida, *
    e lhe mostrarei minha salvação.
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    Como era no princípio, é agora e será sempre, *
    por todos os séculos. Amém.
  TEXT
  lt.reference = 'Salmo 91'
  end

# Ecce Nunc
LiturgicalText.find_or_create_by!(slug: 'ecce_nunc', prayer_book_id: prayer_book.id) do |lt|
  lt.title = 'Ecce Nunc'
  lt.category = 'canticle'
  lt.content = <<~TEXT
    BENDIGAM ao SENHOR, todas as pessoas
    que servem ao SENHOR, *
    vocês que ministram à noite na casa do SENHOR.
    Ergam as mãos para o santuário *
    e bendigam ao SENHOR.
    De Sião te abençoe o SENHOR, *
    que fez os céus e a terra.
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    Como era no princípio, é agora e será sempre, *
    por todos os séculos. Amém.
  TEXT
  lt.reference = 'Salmo 134'
  end

# Rubrica antes das Lições
LiturgicalText.find_or_create_by!(slug: 'compline_rubric_before_lessons', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Quem oficia lê uma ou mais das seguintes
    passagens bíblicas.
    Outras passagens bíblicas podem
    ser anunciadas por quem oficia.
    Entre as passagens bíblicas, diferentes pessoas
    podem partilhar suas meditações.
  TEXT
  end

# Lição Breve 1
LiturgicalText.find_or_create_by!(slug: 'compline_brief_lesson_1', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Tu estás em nosso meio, ó Senhor,
    e nós pertencemos a ti; não nos abandones!
    Por amor do teu nome não nos desprezes;
    não desonres o teu trono glorioso.
    Lembra-te da tua aliança conosco e não a quebres.
    Podem os céus, por si mesmos, produzir chuvas copiosas?
    Somente tu o podes, Senhor, nosso Deus!
    Portanto, a nossa esperança está em ti,
    pois tu fazes todas essas coisas. __(Jr 14.9-22)__
  TEXT
  end

# Lição Breve 2
LiturgicalText.find_or_create_by!(slug: 'compline_brief_lesson_2', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Venham a mim, todas as pessoas que estão cansadas
    e sobrecarregadas, e eu lhes darei descanso.
    Tomem sobre vocês o meu jugo e aprendam de mim,
    pois sou manso e humilde de coração,
    e vocês encontrarão descanso.
    Pois o meu jugo é suave e o meu fardo é leve. __(Mt 11.28-30)__
  TEXT
  end

# Lição Breve 3
LiturgicalText.find_or_create_by!(slug: 'compline_brief_lesson_3', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    O Deus da paz,
    que pelo sangue da eterna aliança tirou da morte
    o nosso Senhor Jesus, o grande Pastor das ovelhas,
    aperfeiçoe vocês em todo o bem para
    fazerem a sua vontade,
    e opere em vocês o que lhe é agradável,
    mediante Jesus Cristo, a quem seja a glória para
    todo o sempre. Amém. __(Hb 13.20-21)__
  TEXT
  end

# Rubrica após as Lições
LiturgicalText.find_or_create_by!(slug: 'compline_rubric_post_lessons', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Estando de pé quem puder, é
    é cantado o hino Te Lucis ou
    outro hino vespertino adequado.
  TEXT
  end

# Responsório Breve
LiturgicalText.find_or_create_by!(slug: 'compline_brief_response', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Nas tuas mãos, Senhor, entrego o meu espírito.
    **Nas tuas mãos, Senhor, entrego o meu espírito.**
    Pois tu me redimiste, Senhor, verdadeiro Deus.
    **Entrego o meu espírito.**
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    **Nas tuas mãos, Senhor, entrego o meu espírito.**
    Guarda-nos, Senhor, como a pupila dos olhos.
    **Protege-nos à sombra de tuas asas.**
  TEXT
  end

# Kyrie Eleison - Traduzido
LiturgicalText.find_or_create_by!(slug: 'kyrie_translated', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Senhor, tem piedade de nós.
    **Cristo, tem piedade de nós.
    Senhor, tem piedade de nós.
    Sim, tem piedade de nós.**
  TEXT
  end

# Kyrie Eleison - Original
LiturgicalText.find_or_create_by!(slug: 'kyrie_original', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    **Kyrie Eleison.
    Christe Eleison.
    Kyrie Eleison.**
  TEXT
  end

# Rubrica antes das Orações
LiturgicalText.find_or_create_by!(slug: 'compline_rubric_before_prayers', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Estando as pessoas que puderem em pé ou ajoelhadas,
    é dita a Oração do Pai nosso da seguinte forma:
  TEXT
  end

# Oração do Pai Nosso - Completas
LiturgicalText.find_or_create_by!(slug: 'compline_our_father', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Pai nosso... --(é rezado em silêncio até...)--
    **mas livra-nos do mal;
    pois teu é o Reino, o poder e a glória para sempre.
    Amém.**
  TEXT
  end

# Oração - Completas
LiturgicalText.find_or_create_by!(slug: 'compline_starting_prayer', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Digna-te, ó Senhor, durante esta noite.
    **Guardar-nos sem pecado.**
    Ouve, ó Senhor, a nossa oração.
    **E a ti chegue o nosso clamor.**
    O Senhor está aqui.
    **O seu Espírito está conosco.**
    Oremos.
  TEXT
  end

# Rubrica antes das Orações Finais
LiturgicalText.find_or_create_by!(slug: 'compline_rubric_before_final_prayer', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Pode ser dita uma ou mais das seguintes orações e coletas
  TEXT
  end

# Oração Final - Completas 1
LiturgicalText.find_or_create_by!(slug: 'compline_final_prayer_1', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Ilumina, suplicamos-te,
    Senhor Deus, as nossas trevas e,
    misericordioso, defende-nos de todos
    os perigos e ciladas desta noite;
    por amor de teu único Filho,
    nosso Salvador Jesus Cristo.
    **Amém.**
  TEXT
  end

# Oração Final - Completas 2
LiturgicalText.find_or_create_by!(slug: 'compline_final_prayer_2', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Sê presente conosco, ó Deus de misericórdia,
    e protege-nos no silêncio desta noite,
    de sorte que nós, diante das aflições e mudanças
    deste mundo inconstante, repousemos na confiança
    do teu amor imutável e eterno;
    por Jesus Cristo, nosso Senhor.
    **Amém.**
  TEXT
  end

# Oração Final - Completas 3
LiturgicalText.find_or_create_by!(slug: 'compline_final_prayer_3', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Ó radiante sol da justiça, olha para nós,
    E ilumina esta noite com a tua resplendorosa presença,
    para que assim de noite como de dia,
    teu povo glorifique teu santo nome;
    por Jesus Cristo, nosso Senhor.
    **Amém.**
  TEXT
  end

# Oração Final - Completas 4
LiturgicalText.find_or_create_by!(slug: 'compline_final_prayer_4', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Damos-te graças, ó Deus,
    por nos teres revelado teu filho Jesus Cristo,
    através da luz da sua ressurreição:
    Concede que assim como cantamos
    tua glória ao declinar este dia,
    também transbordemos de alegria
    ao alvorecer de cada novo dia,
    quando renovamos nossa esperança
    no mistério pascal;
    por Jesus Cristo, nosso Senhor.
    **Amém.**
  TEXT
  end

# Oração Final - Completas 5
LiturgicalText.find_or_create_by!(slug: 'compline_final_prayer_5', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Olha, ó Senhor amado, as pessoas que
    trabalham, ou vigiam, ou choram esta noite.
    Manda que teus anjos guardem as que dormem.
    Cuida das enfermas, Cristo Senhor,
    dá repouso às cansadas,
    abençoa as que estão à beira da morte,
    consola as que sofrem,
    compadece-te das aflitas, defende as alegres.
    Tudo isto te suplicamos somente por teu grande amor.
    **Amém.**
  TEXT
  end

# Oração Final - Completas 6
LiturgicalText.find_or_create_by!(slug: 'compline_final_prayer_6', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Ó Deus,
    tua providência inesgotável sustenta
    o mundo em que vivemos
    e também as nossas próprias vidas.
    Protege e ampara, dia e noite,
    as pessoas que trabalham enquanto outras dormem,
    e concede que jamais esqueçamos
    que nossa vida comunitária
    depende do desempenho de nossas tarefas mútuas.
    Por Jesus Cristo, nosso Senhor.
    **Amém.**
  TEXT
  end

# Rubrica antes da Antífona
LiturgicalText.find_or_create_by!(slug: 'compline_rubric_before_antiphon', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Podem ser feitas orações espontâneas, ou serem usadas a
    coleta do dia ou quaisquer das coletas e orações contidas
    nos Ofícios Diários da Palavra, bem como as Orações
    para Ocasiões Variadas contidas neste livro.
  TEXT
  end

# Completas - Antífona
LiturgicalText.find_or_create_by!(slug: 'compline_antiphon', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    **Guia-nos, Senhor, durante o dia,
    e guarda-nos enquanto dormimos.
    Que em nosso despertar vigiemos com Cristo e,
    no silêncio da noite, descansemos em paz.**
  TEXT
  end

# Nunc Dimittis
LiturgicalText.find_or_create_by!(slug: 'nunc_dimittis', prayer_book_id: prayer_book.id) do |lt|
  lt.title = 'Nunc Dimittis'
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Eis que agora, SENHOR, despedes em paz o teu servo, *
    segundo a tua palavra;
    Pois já os meus olhos viram *
    a tua salvação,
    A qual tu preparaste *
    perante a face de todos os povos:
    Luz para iluminar as nações *
    e glória de Israel teu povo.
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    Como era no princípio, é agora e será sempre, *
    por todos os séculos. Amém.
  TEXT
  lt.reference = 'S. Lucas 2.29'
  end

# Completas - Oração Final
LiturgicalText.find_or_create_by!(slug: 'compline_final_prayer', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Em paz nos deitaremos e descansaremos.
    **Pois só tu, Senhor, nos fazes habitar em segurança.**
    O Senhor está aqui.
    **O seu Espírito está conosco.**
    Bendigamos ao Senhor.
    **Demos graças a Deus.**
    O Senhor misericordioso, Pai, Filho e Espírito Santo,
    nos abençoe e nos guarde.
    **Amém.**

    A Divina proteção permaneça conosco para sempre.
    **E com nossos irmãos e irmãs ausentes. Amém.**
    Que as vidas das pessoas fiéis,
    pela misericórdia de Deus, descansem em paz.
    **Amém.**
  TEXT
  end

# Completas - Rubrica Final
LiturgicalText.find_or_create_by!(slug: 'compline_final_rubric', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Não há bênção nem tampouco hino final.
    Todas as pessoas se retiram em silêncio.
  TEXT
  end

## Oração do Meio-dia

# Rubrica de abertura
LiturgicalText.find_or_create_by!(slug: 'midday_rubric_opening', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    O Ofício inicia com uma das seguintes saudações,
    ou ainda com uma saudação espontânea:
  TEXT
  end

# Preparação
LiturgicalText.find_or_create_by!(slug: 'midday_preparation', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Na presença de nosso Deus
    temos paz e somos felizes.
    Reunimo-nos aqui, no auge do dia
    a fim de louvar aquele que é
    o sol da justiça,
    a luz que brilha entre as trevas
    e a razão do nosso viver.
  TEXT
  end

# Rubrica de abertura
LiturgicalText.find_or_create_by!(slug: 'midday_rubric_opening', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    O Ofício inicia com uma das seguintes saudações,
    ou ainda com uma saudação espontânea:
  TEXT
  end

# Rubrica do invitatório
LiturgicalText.find_or_create_by!(slug: 'midday_rubric_invitation', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Estando de pé quem puder,
    quem oficia proclama:
  TEXT
  end

# Invitatório
LiturgicalText.find_or_create_by!(slug: 'midday_invitation', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'invocation'
  lt.content = <<~TEXT
    Apressa-te, ó Deus, em nos livrar.
    **Senhor, apressa-te em socorrer-nos.**
    Glória ao Pai e ao Filho
    e ao Espírito Santo;
    **como era no princípio, é agora e será sempre,
    por todos os séculos. Amém. Aleluia!**
  TEXT
  end

# Invitatório para Quaresma
LiturgicalText.find_or_create_by!(slug: 'midday_invitation_lent', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'invocation'
  lt.content = <<~TEXT
    Apressa-te, ó Deus, em nos livrar.
    **Senhor, apressa-te em socorrer-nos.**
    Glória ao Pai e ao Filho
    e ao Espírito Santo;
    **como era no princípio, é agora e será sempre,
    por todos os séculos. Amém.**
  TEXT
  end

# Invitatório para Quaresma
LiturgicalText.find_or_create_by!(slug: 'midday_rubric_psalm', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Um dos seguintes salmos é recitado, ou cantado:
  TEXT
  end

# Lucerna pedibus meis
LiturgicalText.find_or_create_by!(slug: 'lucerna_pedibus_meis', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    A TUA palavra é lâmpada para os meus pés, *
    e luz para o meu caminho.
    Fiz juramento e vou cumpri-lo, *
    que guardarei teus justos juízos.
    Estou em grande aflição; *
    vivifica-me, ó SENHOR, segundo a tua palavra.
    Aceita, ó SENHOR, as oferendas voluntárias
    de minha boca, *
    e ensina-me os teus juízos.
    Estou sempre em perigo, *
    contudo, não me esqueço da tua lei.
    Pessoas injustas me armaram ciladas, *
    todavia, não me desvio dos teus preceitos.
    Tomei por herança eterna os teus testemunhos, *
    pois são o gozo do meu coração.
    Inclinei o meu coração a cumprir a tua lei, *
    para sempre, até o fim.
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    Como era no princípio, é agora e será sempre, *
    por todos os séculos. Amém.
  TEXT
  lt.title = 'Lucerna pedibus meis'
  lt.reference = 'Salmo 119, XIV'
  end

# Levavi oculos
LiturgicalText.find_or_create_by!(slug: 'levavi_oculos', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
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
  lt.title = 'Levavi oculos'
  lt.reference = 'Salmo 121'
  end

# In convertendo
LiturgicalText.find_or_create_by!(slug: 'in_convertendo', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    QUANDO o SENHOR nos fez voltar do cativeiro, *
    estávamos como sonhando.
    Era toda risonha a nossa boca,
    e jubiloso cântico a nossa língua; *
    dizia-se então entre as nações:
    grandes coisas fez em seu favor o Senhor.
    Na verdade, maravilhas fez por nós o SENHOR, *
    por isso estamos cheios de júbilo.
    Reconduze, ó SENHOR, as pessoas cativas, *
    como as torrentes do Sul.
    Quem semeia em lágrimas, *
    ceifará com alegria.
    Quem leva chorando a preciosa semente para semear, *
    tornará cantando de alegria, sobraçando grandes feixes.
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    Como era no princípio, é agora e será sempre, *
    por todos os séculos. Amém.
  TEXT
  lt.title = 'In convertendo'
  lt.reference = 'Salmo 126'
  end

# Rubrica antes das leituras
LiturgicalText.find_or_create_by!(slug: 'midday_rubric_before_readings', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Algumas passagens bíblicas, como as
    que estão a seguir, podem ser feitas.
    Outras passagens bíblicas podem ser
    anunciadas por quem oficia.
    Entre as passagens bíblicas, diferentes pessoas
    podem partilhar suas meditações.
  TEXT
  end

# Leitura 1
LiturgicalText.find_or_create_by!(slug: 'midday_reading_1', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Desde o Oriente até o Ocidente,
    é grande o meu nome entre as nações.
    E em todo lugar se oferece incenso ao meu nome
    e uma oferta pura,
    pois grande é o meu nome entre as nações.
    Assim diz o Senhor. __(Ml 1.11)__
  TEXT
  end

# Leitura 2
LiturgicalText.find_or_create_by!(slug: 'midday_reading_2', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    E a esperança não engana,
    pois o amor de Deus foi derramado
    em nossos corações pelo Espírito Santo que nos foi dado. __(Rm 5.5)__
  TEXT
  end

# Leitura 3
LiturgicalText.find_or_create_by!(slug: 'midday_reading_3', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Se alguém está em Cristo, é nova criatura.
    As coisas antigas passaram;
    eis que uma realidade nova apareceu.

    Tudo isso vem de Deus,
    que nos reconciliou consigo por meio de Cristo,
    e nos confiou o ministério da reconciliação.
    __(II Co 5.17-18)__
  TEXT
  end

# Rubrica antes das orações
LiturgicalText.find_or_create_by!(slug: 'rubric_before_prayers', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Estando as pessoas que puderem em pé ou
    ajoelhadas, é dita a Oração do Pai nosso:
  TEXT
  end

# Oração do Pai Nosso - Meio-dia
LiturgicalText.find_or_create_by!(slug: 'midday_our_father', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    O Senhor seja com vocês.
    **Seja também contigo.**
    Oremos.
    **Pai nosso, que estás nos céus.
    Santificado seja o teu Nome.
    Venha o teu Reino.
    Seja feita a tua vontade, assim na terra como no céu.
    O pão nosso de cada dia nos dá hoje.
    Perdoa-nos as nossas ofensas,
    assim como nós perdoamos a quem nos tem ofendido.
    E não nos deixes cair em tentação,
    mas livra-nos do mal;
    pois teu é o Reino, o poder e a glória para sempre.
    Amém.**
  TEXT
  end

# Rubrica após a oração do Pai Nosso
LiturgicalText.find_or_create_by!(slug: 'rubric_after_our_father', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    A seguir são realizadas as seguintes orações:
  TEXT
  end

# Oração - Meio-dia
LiturgicalText.find_or_create_by!(slug: 'midday_prayer', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Salvador bendito,
    nesta hora, estavas pendurado no madeiro,
    estendendo teus braços amorosos por nós.
    Concede que todos os povos da terra
    possam buscar-te e encontrar salvação,
    mediante a tua grande misericórdia.
    **Amém.**

    Deus da Missão,
    nesta mesma hora, chamaste a teu servo,
    o Apóstolo Paulo,
    para proclamar o teu amor a todas as pessoas.
    Ilumina grandiosamente este mundo
    com o brilho da tua glória,
    de modo que todas as nações
    possam adorar-te e servir-te,
    tu que vives e reinas com o Filho
    e com o Espírito Santo, um só Deus, agora e sempre.
    **Amém.**

    Querido Jesus,
    deste-nos a paz, deixaste-nos a paz.
    Perdoa nossos pecados, nós te pedimos,
    e infunde em nossos corações o desejo
    de te amar mais e mais,
    para que nossa vida possa refletir
    a tua magnífica luz, que alcança todas as nações.
    Na certeza da tua compaixão
    para conosco, oramos.
    **Amém.**
  TEXT
  end

# Rubrica após a oração do Meio-dia
LiturgicalText.find_or_create_by!(slug: 'midday_rubric_after_prayer', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Podem ser feitas orações constantes deste livro, ou espontâneas
  TEXT
  end

# Despedida
LiturgicalText.find_or_create_by!(slug: 'midday_dismissal', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'dismissal'
  lt.content = <<~TEXT
    O Espírito de Deus habita em nosso meio,
    transformando corações,
    quebrando barreiras
    e trazendo a paz.
    Bendigamos ao Senhor! Aleluia!
    **Graças rendamos a Deus! Aleluia!**
  TEXT
  end

# Despedida - Quaresma e ocasiões penitenciais
LiturgicalText.find_or_create_by!(slug: 'midday_dismissal_lent', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'dismissal'
  lt.content = <<~TEXT
    O Espírito de Deus habita em nosso meio,
    transformando corações,
    quebrando barreiras
    e trazendo a paz.
    Bendigamos ao Senhor!
    **Graças rendamos a Deus!**
  TEXT
  end

## Oração da Tarde

# Rubrica antes da Acolhida
LiturgicalText.find_or_create_by!(slug: 'morning_rubric_before_welcome', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    O Ofício inicia com uma das seguintes saudações,
    ou ainda com uma saudação espontânea:
  TEXT
  end

# Acolhida Tradicional
LiturgicalText.find_or_create_by!(slug: 'evening_welcome_traditional', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Estamos aqui na presença de Deus,
    para oferecer-lhe, através do nosso Senhor Jesus Cristo,
    nossa adoração, louvor e ação de graças;
    para confessar os nossos pecados;
    ouvir sua santa Palavra,
    orar pelas nossas próprias necessidades
    e pelas necessidades do mundo.
    A fim de que possamos conhecer mais
    verdadeiramente a grandeza do amor de Deus
    e proclamar através de nossas vidas os frutos de sua graça.
  TEXT
  end

# Acolhida Contemporânea
LiturgicalText.find_or_create_by!(slug: 'evening_welcome_contemporary', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Venham minhas irmãs e irmãos, ao Deus da Vida,
    Venham ao Pai Materno que permanece
    ao lado das pessoas pobres.
    Venham ao Filho Fraterno que luta
    com as que buscam a liberdade.
    Venham à Ruáh divina, Espírito Santo de amor
    que capacita a todas as que promovem a justiça.
    **Glória e louvor à Santa e Bendita Trindade,
    que restaura as nossas forças e renova a sua Igreja.**
  TEXT
  end

# opening_sentence_rubric

# Sentença de Abertura 1
LiturgicalText.find_or_create_by!(slug: 'evening_opening_sentence_1', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Eu amo, SENHOR, a habitação da tua casa
    e o lugar onde assiste a tua glória. (Sl 26.8)
    **Suba a minha oração perante a tua face qual incenso, e
    minhas mãos levantadas sejam o sacrifício da tarde.** __(Sl 141.2)__
  TEXT
  end

# Sentença de Abertura 2
LiturgicalText.find_or_create_by!(slug: 'evening_opening_sentence_2', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Sejam bem aceitas as palavras de minha boca, e o meditar
    de meu coração, perante a tua face, ó SENHOR, rocha
    minha e redentor meu! (Sl 19.15)
    **Envia a tua luz e a tua verdade, para que elas me
    guiem; e me levem ao teu santo monte e à tua morada.** __(Sl 43.3)__
  TEXT
  end

# Sentença de Abertura 3
LiturgicalText.find_or_create_by!(slug: 'evening_opening_sentence_3', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    O dia e a noite são teus;
    formaste a luz e o sol.
    **Estabeleceste os limites da terra;
    verão e inverno tu os formaste.** __(Sl 74.16,17)__
  TEXT
  end

# Sentença de Abertura 4
LiturgicalText.find_or_create_by!(slug: 'evening_opening_sentence_4', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Adorem ao SENHOR na beleza da santidade;
    trema à sua presença toda a terra.
    **Na presença do SENHOR, porque ele vem, sim, vem
    julgar a terra; julgará o mundo com justiça, e os povos
    com a sua verdade.**
    __(Sl 96.9,13)__
  TEXT
  end

# Sentença de Abertura 5
LiturgicalText.find_or_create_by!(slug: 'evening_opening_sentence_5', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Bendigo ao SENHOR que aconselha;
    até de noite meu coração me instrui.
    **Trago sempre o SENHOR diante de mim;
    enquanto estiver à minha direita, nada jamais me abalará.**
    __(Sl 16.7-8)__
  TEXT
  end

# Sentença de Abertura 6
LiturgicalText.find_or_create_by!(slug: 'evening_opening_sentence_6', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    A tua palavra é lâmpada para os meus pés,
    e luz para o meu caminho. __(Sl 119.105)__
    **Firma os meus passos em teu caminho,
    para que meus pés não vacilem.** __(Sl 17.5)__
  TEXT
  end

# Sentença de Abertura 7
LiturgicalText.find_or_create_by!(slug: 'evening_opening_sentence_7', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Mesmo que eu dissesse: Cubram-me só trevas,
    e a luz se torne noite ao meu redor,
    **As trevas não seriam demasiado escuras para ti;
    antes, a noite resplandece como o dia
    e as trevas como a luz.** __(Sl 139.11-12)__
  TEXT
  end

# Sentença de Abertura 8
LiturgicalText.find_or_create_by!(slug: 'evening_opening_sentence_8', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Jesus disse: Eu sou a luz do mundo;
    quem me segue de modo algum andará em trevas,
    mas terá a luz da vida. __(Jo 8.12)__
  TEXT
  end

# Rubrica após a Sentença de Abertura
LiturgicalText.find_or_create_by!(slug: 'evening_rubric_post_opening_sentence', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Além das sentenças gerais devem ser usadas as seguintes sentenças
    ocasionais de acordo com a quadra do Ano Cristão.
  TEXT
  end

# Sentença de Abertura Advento
LiturgicalText.find_or_create_by!(slug: 'evening_opening_sentence_advent', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Vigiem, porque vocês não sabem quando
    o dono da casa voltará; pode ser à tarde, à meia-noite,
    de madrugada ou pelo amanhecer. __(Mc 13.35)__
    **Para que quando vier não nos encontre dormindo.**
  TEXT
  end

# Sentença de Abertura Natal
LiturgicalText.find_or_create_by!(slug: 'evening_opening_sentence_christmas', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Não tenham medo! Eu anuncio para vocês
    a Boa Nova, que será uma grande alegria
    para todo o povo: Hoje na cidade de Davi,
    nasceu para vocês um Salvador. __(Jo 2.10,11)__
    **Grande será o seu domínio,
    e a Paz não terá fim!** __(Is 9.7a)__
  TEXT
  end

# Sentença de Abertura Epifania
LiturgicalText.find_or_create_by!(slug: 'evening_opening_sentence_epiphany', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Os povos se encaminharão para a tua luz,
    e as autoridades das nações para o resplendor
    da tua aurora. __(Is 60.3)__
    **Também te dei como luz da humanidade,
    para seres a minha salvação até as
    extremidades da terra.** __(Is 49.6)__
  TEXT
  end

# Sentença de Abertura Quaresma
LiturgicalText.find_or_create_by!(slug: 'evening_opening_sentence_lent', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Rasguem o coração, e não as roupas! Convertam-se
    ao Senhor seu Deus; porque ele é piedoso e compassivo,
    tardio em irar-se e cheio de amor. __(Jl 2.13)__
    **Ao SENHOR, nosso Deus,
    pertencem a misericórdia e o perdão.** __(Dn 9.9)__
  TEXT
  end

# Sentença de Abertura Semana Santa
LiturgicalText.find_or_create_by!(slug: 'evening_opening_sentence_holy_week', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Temos nos dispersado quais ovelhas desgarradas,
    e seguimos os nossos próprios caminhos.
    **Mas o SENHOR fez cair sobre Ele o nosso pecado.**
    __(Is 53.6)__
  TEXT
  end

# Sentença de Abertura Paixão
LiturgicalText.find_or_create_by!(slug: 'evening_opening_sentence_good_friday', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Mas Cristo esvaziou-se a si mesmo, assumindo a forma
    de servo, fazendo-se semelhante aos seres humanos.
    **Humilhou-se a si mesmo, tornando-se obediente
    até a morte, e morte de cruz.** __(Fl 2.7-8)__
  TEXT
  end

# Sentença de Abertura Páscoa
LiturgicalText.find_or_create_by!(slug: 'evening_opening_sentence_easter', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Aleluia! Cristo ressuscitou! __(Mc 16.6)__
    **Verdadeiramente o SENHOR ressuscitou. Aleluia!**
  TEXT
  end

# Sentença de Abertura Ascensão
LiturgicalText.find_or_create_by!(slug: 'evening_opening_sentence_ascension', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Temos um grande sumo sacerdote, que atravessou os céus:
    Jesus, Filho de Deus. Por isso mantenhamos
    firme a fé que professamos.
    **Portanto, aproximemo-nos do trono da graça com
    plena confiança, para que alcancemos misericórdia,
    encontremos graça, e recebamos ajuda em
    tempo oportuno.** __(Hb 4.14-16)__
  TEXT
  end

# Sentença de Abertura Festa do Santo Nome
LiturgicalText.find_or_create_by!(slug: 'evening_opening_sentence_holy_name', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Para que o nome de nosso Senhor Jesus Cristo
    seja glorificado em vocês, e vocês nele,
    segundo a graça do nosso Deus. __(2 Ts 1.12)__
    **Para que acreditemos que Jesus é o Cristo,
    o Filho de Deus, e para que, acreditando,
    tenhamos vida em seu nome.** __(Jo 20.31)__
  TEXT
  end

# Sentença de Abertura Pentecostes
LiturgicalText.find_or_create_by!(slug: 'evening_opening_sentence_pentecost', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Deus tem derramado o seu amor em nossos corações,
    por meio do Espírito Santo que ele nos deu. __(Rm 5.5)__
    **Pois todas as pessoas que são guiadas pelo
    Espírito de Deus são filhas de Deus.** __(Rm 8.14)__
  TEXT
  end

# Sentença de Abertura Trindade
LiturgicalText.find_or_create_by!(slug: 'evening_opening_sentence_trinity', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Como são grandes as riquezas de Deus! Como são
    profundos o seu conhecimento e a sua sabedoria!
    **Quem pode explicar as suas decisões?
    Quem pode entender os seus planos?** __(Rm 11.33)__
  TEXT
  end

# Sentença de Abertura Todos os Santos (e festa de um Santo ou Santa)
LiturgicalText.find_or_create_by!(slug: 'evening_opening_sentence_all_saints', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Quanto a nós, temos esta grande multidão de
    testemunhas ao nosso redor. Corramos com
    coragem a corrida que está à nossa frente.
    **Continuemos com os nossos olhos fixos em Jesus,
    pois dele depende a nossa fé, e está sentado à direita
    do trono de Deus.** __(Hb 12.1,2)__
  TEXT
  end

# Sentença de Abertura Ação de Graças e dias festivos
LiturgicalText.find_or_create_by!(slug: 'evening_opening_sentence_thanksgiving', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Rendam graças ao SENHOR, invoquem o seu Nome;
    façam conhecidos os seus feitos entre os povos.
    **Cantem-lhe, cantem-lhe louvores; meditem
    em todas as suas maravilhas.** __(Sl 105.1,2)__
  TEXT
  end

# Rubrica após a abertura da Ação de Graças
LiturgicalText.find_or_create_by!(slug: 'evening_rubric_after_opening', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    A Confissão de Pecados pode ser omitida, exceto nas quadras
    penitenciais ou quando a Oração da Tarde for a principal
    Celebração Dominical, passando-se das Sentenças Introdutórias
    diretamente para: “Abre, ó Senhor, os nossos lábios...”
  TEXT
  end

# Rubrica antes da Confissão
LiturgicalText.find_or_create_by!(slug: 'evening_rubric_before_confession', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Então quem oficia diz:
  TEXT
  end

# Confissão - longa
LiturgicalText.find_or_create_by!(slug: 'evening_confession_long', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'confession'
  lt.content = <<~TEXT
    Queridas irmãs e irmãos,
    as Santas Escrituras nos lembram
    que não é possível dissimular
    nem encobrir ante a face de Deus
    os nossos muitos pecados e maldades,
    e nos movem a reconhecê-los e confessá-los
    com corações humildes e penitentes,
    a fim de que possamos obter o perdão
    por sua infinita bondade e misericórdia.
    Reconheçamos e confessemos os nossos pecados
    com pureza e humildade de coração, dizendo:
  TEXT
  end

# Confissão - curta
LiturgicalText.find_or_create_by!(slug: 'evening_confession_short', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'confession'
  lt.content = <<~TEXT
    Confessemos humildemente os nossos pecados
    a Deus Todo-poderoso.
  TEXT
  end

# rubric_post_opening_confession

# Pós Confissão 1
LiturgicalText.find_or_create_by!(slug: 'evening_after_confession_1', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'confession'
  lt.content = <<~TEXT
    **Justo e compassivo Deus,
    nós chegamos à tua presença procurando misericórdia,
    perdão e restauração de vida.
    Reconhecemos o silêncio de nossa consciência
    e nossa falta de interesse em relação
    às injustiças que acontecem ao nosso redor.
    Confessamos toda a nossa infidelidade passada:
    o orgulho, a falsidade e a impaciência de nossas vidas;
    os nossos desejos e atitudes egoístas;
    a nossa raiva diante de nossas próprias frustrações
    e também o nosso descuido na oração e no culto.
    Perdoa a nossa relutância em agir segundo
    a tua vontade e por tua grande misericórdia
    restaura as nossas vidas de acordo com tua amorosa
    bondade, por Jesus Cristo nosso Senhor. Amém.**
  TEXT
  end

# Pós Confissão 2
LiturgicalText.find_or_create_by!(slug: 'evening_after_confession_2', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'confession'
  lt.content = <<~TEXT
    **Ó Deus de misericórdia;
    temos errado e temo-nos apartado dos
    teus caminhos quais ovelhas desgarradas.
    Temos por demais seguido os caprichos
    e desejos de nossos corações.
    Pecamos contra as tuas santas leis.
    Deixamos de fazer o que devíamos ter feito.
    E temos feito o que não devíamos fazer.
    Tu, porém, ó Senhor, tem misericórdia de nós.
    Perdoa, ó Deus, as pessoas que confessam
    as suas culpas.
    Restaura as que são penitentes,
    segundo as tuas promessas declaradas à humanidade,
    em Cristo Jesus nosso Senhor.
    E concede por amor dele, ó Deus,
    que de hoje em diante levemos vida sóbria,
    piedosa e justa.
    À glória do teu santo Nome. Amém.**
  TEXT
  end

# Pós Confissão 3
LiturgicalText.find_or_create_by!(slug: 'evening_after_confession_3', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'confession'
  lt.content = <<~TEXT
    **Deus Santíssimo e misericordioso,
    confessamos a ti e mutuamente
    todo o mal que temos cometido,
    por nossa insensibilidade à dor e
    às necessidades das outras pessoas;
    por nossa indiferença diante
    das injustiças e da violência;
    por todos os nossos falsos juízos,
    pela falta de caridade em nossos
    pensamentos sobre os nossos semelhantes;
    pelo preconceito e menosprezo daquelas
    pessoas que são diferentes de nós;
    pelo abuso, destruição e contaminação da tua criação
    e pela falta de preocupação com
    as crianças e as futuras gerações.
    Aceita o nosso arrependimento, Senhor,
    por tua misericórdia e sê bondoso para conosco.
    Ouve a nossa oração quando a ti
    confessamos os nossos muitos pecados,
    e pela tua fidelidade e justiça concede-nos teu perdão.
    Por Jesus Cristo, nosso Senhor. Amém.**
  TEXT
  end

# rubric_post_confession

# prayer_after_confession_1 ou prayer_after_confession_2

# absolution

# rubric_post_absolution

# Invitatório
LiturgicalText.find_or_create_by!(slug: 'evening_invocation', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'invocation'
  lt.content = <<~TEXT
    Abre, ó SENHOR, os nossos lábios.
    **E a nossa boca proclamará o teu louvor.**
    Ó Deus, digna-te salvar-nos.
    **Senhor, apressa-te em socorrer-nos.**
    Adoremos ao SENHOR.
    **Bendigamos a Deus.**
    Glória ao Pai, e ao Filho,
    e ao Espírito Santo;
    **Como era no princípio, é agora e será sempre,
    por todos os séculos. Amém.**
  TEXT
  end

# Rubrica após o Invitatório
LiturgicalText.find_or_create_by!(slug: 'evening_rubric_post_invocation', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    É recitado em uníssono ou entoado um dos
    Cânticos abaixo, que podem ser substituídos
    por um hino adequado, bem como por um dos
    Salmos Invitatórios (Venite ou Jubilate) às páginas 71 e 72.
  TEXT
  end

# ecce_nunc ou phos hilaron (pascha_nostrum na páscoa até pentecostes)

# Phos Hilaron
LiturgicalText.find_or_create_by!(slug: 'phos_hilaron', prayer_book_id: prayer_book.id) do |lt|
  lt.title = 'Phos Hilaron'
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Salve, alegre luz, puro esplendor *
    da gloriosa face paternal,
    Salve, Jesus, bendito Salvador, *
    Cristo ressuscitado e imortal.
    No horizonte o sol já declinou, *
    brilham da noite as luzes cintilantes:
    ao Pai, ao Filho, ao Espírito de amor *
    cantemos nossos hinos exultantes.
    De santas vozes sobe a adoração *
    prestada a ti, Jesus, Filho de Deus.
    A criação inteira canta glória,
    o universo, a terra, os novos céus.
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    Como era no princípio, é agora e será sempre, *
    por todos os séculos. Amém.
  TEXT
  lt.reference = 'Luz Radiante'
  end

# rubric_gloria_patri

# rubric_first_reading

# first_reading

# rubric_post_first_reading

# canticle_post_first_reading

# rubric_end_first_reading

# Magnificat
LiturgicalText.find_or_create_by!(slug: 'magnificat', prayer_book_id: prayer_book.id) do |lt|
  lt.title = 'Magnificat'
  lt.category = 'canticle'
  lt.content = <<~TEXT
    A minha alma engrandece ao Senhor, *
    e o meu espírito se alegra em Deus meu Salvador.
    Porquanto considerou *
    a humildade de sua serva
    Pois eis que desde agora, *
    as gerações todas me chamarão bem-aventurada.
    Grandes coisas me fez o Poderoso; *
    e santo é o seu Nome.
    E a sua misericórdia é de geração em geração *
    sobre as pessoas que o temem.
    Com seu braço agiu valorosamente, *
    e dispersou as soberbas pelo intento de seus corações.
    Depôs dos tronos as poderosas, *
    e exaltou as humildes.
    As famintas encheu de bens, *
    e as ricas despediu vazias.
    Recordando-se de misericórdia, auxiliou a Israel, seu servo, *
    como prometeu as primeiras gerações,
    a Abraão e sua posteridade para sempre.
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    Como era no princípio, é agora e será sempre, *
    por todos os séculos. Amém.
  TEXT
  lt.reference = 'S. Lucas 1.46'
  end

# Bonum est confiteri
LiturgicalText.find_or_create_by!(slug: 'bonum_est_confiteri', prayer_book_id: prayer_book.id) do |lt|
  lt.title = 'Bonum est confiteri'
  lt.category = 'canticle'
  lt.content = <<~TEXT
    BOM é louvar ao SENHOR, *
    e ao teu Nome, ó altíssimo, cantar louvores.
    Anunciar de manhã a tua misericórdia *
    e à noite a tua fidelidade.
    Tangendo a lira e a citara, *
    com a harpa em harmonioso acorde.
    Pois me alegraste, SENHOR, pelos teus feitos, *
    exultarei nas obras de tuas mãos.
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    Como era no princípio, é agora e será sempre, *
    por todos os séculos. Amém.
  TEXT
  lt.reference = 'Salmo 92'
  end

# Benedictus
LiturgicalText.find_or_create_by!(slug: 'benedictus', prayer_book_id: prayer_book.id) do |lt|
  lt.title = 'Benedictus'
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Bendito seja o SENHOR Deus de Israel, *
    porque visitou e redimiu o seu povo;
    E nos suscitou um poderoso Salvador *
    na casa de Davi seu servo;
    Como falou desde o princípio, *
    pela boca dos seus santos e santas,
    no tempo dos profetas e profetisas.
    Para nos livrar de quem nos quer mal, *
    e da mão de quem nos odeia.
    Usando de misericórdia para com nossos pais e mães, *
    e lembrar-se de sua santa aliança;
    E do juramento que fez a Abraão, *
    nosso pai,
    De conceder-nos que, livres da mão
    de quem nos quer mal, *
    o servíssemos sem temor;
    Em santidade e justiça na sua presença, *
    todos os dias de nossa vida.
    E tu, ó menino, serás chamado profeta do Altíssimo, *
    porque hás de ir adiante da face do Senhor,
    a preparar os seus caminhos;
    Para dar ao seu povo conhecimento da salvação, *
    na remissão dos seus pecados;
    Graças à entranhável misericórdia de nosso Deus, *
    com que a aurora do alto nos visitou;
    Para iluminar quem está nas trevas e
    nas sombras da morte; *
    guiar nossos pés ao caminho da paz.
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    Como era no princípio, é agora e será sempre, *
    por todos os séculos. Amém.
  TEXT
  lt.reference = 'O Cântico de Zacarias – S. Lucas 1.68-79'
  end

# rubric_second_reading

# second_reading

# rubric_post_second_reading

# nunc_dimittis

# Deus misereatur
LiturgicalText.find_or_create_by!(slug: 'deus_misereatur', prayer_book_id: prayer_book.id) do |lt|
  lt.title = 'Deus misereatur'
  lt.category = 'canticle'
  lt.content = <<~TEXT
    DEUS tenha misericórdia de nós e nos abençoe; *
    e sua face resplandeça sobre nós.
    Para que se conheça na terra o teu caminho, *
    e entre todos os povos a tua salvação.
    Louvem-te as nações, ó Deus; *
    rendam-te graças todos os povos.
    Alegrem-se e cantem as nações, *
    pois julgas com retidão e guias os povos sobre a terra.
    Louvem-te as nações, ó Deus, *
    rendam-te graças todos os povos.
    A terra produz as suas riquezas; *
    e Deus, o nosso Deus, nos abençoa.
    DEUS nos abençoa, *
    e todos os confins da terra o temerão.
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    Como era no princípio, é agora e será sempre, *
    por todos os séculos. Amém.
  TEXT
  lt.reference = 'Salmo 67'
  end

# Dignus es
LiturgicalText.find_or_create_by!(slug: 'dignus_es', prayer_book_id: prayer_book.id) do |lt|
  lt.title = 'Dignus es'
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Digno és tu, Senhor nosso Deus,
    de receber glória e honra e poder, *
    porque todas as coisas tu criaste,
    e por tua vontade existem e foram criadas.
    Digno és, ó Cristo, porque foste morto, *
    com teu sangue resgataste homens e mulheres
    para Deus.
    Procedentes de toda tribo, língua, povo e nação, *
    e os constituíste reino e sacerdotes e sacerdotisas
    para nosso Deus.
    Àquele que está sentado no trono e ao Cordeiro
    seja o louvor, e a honra, e a glória, *
    e o domínio pelos séculos dos séculos.
    Glória ao Pai e ao Filho; *
    e ao Espírito Santo;
    Como era no princípio, é agora e será sempre, *
    por todos os séculos. Amém.
  TEXT
  lt.reference = 'Ap 4.11; 5.9-10,13'
  end

# rubric_end_second_canticle

# apostles_creed

# Rubrica após o Credo dos Apóstolos
LiturgicalText.find_or_create_by!(slug: 'evening_rubric_post_apostles_creed', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Ou é dita a seguinte Afirmação de Fé, desde que o
    Credo seja dito, ao menos, uma vez por semana.
  TEXT
  end

# Afirmação de Fé
LiturgicalText.find_or_create_by!(slug: 'evening_affirmation_of_faith', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Como resposta à Palavra de Deus
    façamos a nossa afirmação de fé:

    **Cremos em Deus;
    Cremos na força das pessoas pobres,
    Na audácia das pessoas poetas,
    Na ousadia das profetas,
    Na inspiração das artistas.

    Cremos em Jesus,
    Cremos na humildade para servir,
    Na coragem de transformar,
    Na alegria de celebrar,
    No respeito às diferenças,
    No pão para toda mesa,
    No conforto para toda tristeza.

    Cremos no Espírito,
    Cremos na esperança de recomeçar,
    Na beleza do gesto solidário,
    Na justiça para toda opressão,
    Na compaixão diante da dor,
    No amor, dádiva divino-humana. Amém.**
  TEXT
  end

# rubric_offertory

# rubric_before_prayers

# invocation_our_father_1 ou invocation_our_father_2

# our_father

# rubric_after_our_father

# mercy_prayer_1 ou evening_closing_prayer

# Oração de Encerramento
LiturgicalText.find_or_create_by!(slug: 'evening_closing_prayer', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Para que esta noite seja santa, boa e pacífica,
    **Nós oramos, Senhor.**
    Para que teus santos anjos nos conduzam
    pelos caminhos da paz e da bondade,
    **Nós oramos, Senhor.**
    Para que nos perdoes e absolvas de nossos pecados e ofensas,
    **Nós oramos, Senhor.**
    Para que haja paz na tua Igreja e em todo o mundo,
    **Nós oramos, Senhor.**
    Para que vivamos com fé, esperança e constante amor,
    **Nós oramos, Senhor.**
    Que o teu Espírito Santo nos una em comunhão
    com (N._______) e com todos os teus santos e santas,
    de maneira que alcancemos nesta vida o conhecimento
    da tua vontade, e na vindoura a vida eterna.
    **Nós oramos, Senhor.**
  TEXT
  end

# rubric_collect_of_the_day

# rubric_general_collects

# for_peace, for_grace

# Por proteção
LiturgicalText.find_or_create_by!(slug: 'for_protection', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Ó Deus,
    que és a vida daquelas pessoas que estão vivas
    e a luz das que morreram na fé;
    que és a força das que trabalham,
    e o descanso eterno das que já partiram:
    Damos-te graças pelas bênçãos deste dia que termina,
    e humildemente oramos pela tua santa proteção
    durante a noite que começa.
    Guarda-nos em segurança,
    e livra-nos de todos os perigos;
    Isto te pedimos por amor daquele que
    por nós morreu e ressuscitou, teu Filho,
    nosso Salvador Jesus Cristo.
    **Amém.**
  TEXT
  end

# Pela presença de Cristo
LiturgicalText.find_or_create_by!(slug: 'for_christ_presence', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Fica conosco, Senhor Jesus,
    agora que a noite se aproxima e o dia já findou.
    Sê nosso companheiro no caminho,
    anima nossos corações e desperta nossa esperança,
    para que te conheçamos tal como te revelas
    nas Escrituras e no partir do pão.
    Concede-nos isto por amor do teu nome.
    **Amém.**
  TEXT
  end

# Por todas as autoridades
LiturgicalText.find_or_create_by!(slug: 'evening_for_all_authorities', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Ó Senhor, que nos governas,
    e de quem a glória enche toda a terra;
    ao teu misericordioso cuidado
    encomendamos nossa Pátria,
    a fim de que, sob o amparo de tua providência,
    habitemos em tua paz e em segurança.
    Concede à(ao) Presidente da República,
    e à todas as outras autoridades,
    sabedoria e força para conhecer e praticar a tua vontade.
    Enche-as de amor à verdade e à justiça.
    Faze-as sempre zelosas da sua missão para servirem
    este povo no temor do teu santo Nome;
    mediante Jesus Cristo nosso Senhor,
    que vive e reina contigo
    e o Espírito Santo, um só Deus, pelos séculos sem fim.
    **Amém.**
  TEXT
  end

# Pela liderança clerical
LiturgicalText.find_or_create_by!(slug: 'evening_for_clergy', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Onipotente e sempiterno Deus,
    do qual procede toda a boa dádiva e dom perfeito;
    envia lá do alto sobre os nossos bispos e bispas,
    clérigos e clérigas e as congregações
    confiadas a seus cuidados,
    o poder do Santo Espírito,
    e para que verdadeiramente te agradem,
    espalha continuamente sobre
    toda a liderança clerical o orvalho de tua bênção.
    Concede-nos isto, ó Senhor, à honra de teu Filho
    que se fez nosso irmão, Jesus Cristo.
    **Amém.**
  TEXT
  end

# Pela família paroquial
LiturgicalText.find_or_create_by!(slug: 'evening_for_parish_family', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Deus cheio de graça,
    humildemente suplicamos
    por nossa comunidade paroquial.
    Enche-a de tua verdade e paz,
    e dá-lhe flexibilidade para aceitar
    a ação de teu Santo Espírito.
    Em um mundo repleto de violência e ódio,
    dá-lhe coragem para semear o amor e a harmonia.
    Em um mundo marcado pela violência
    da discriminação e da desigualdade,
    cria nela a capacidade de abrir-se em amor,
    de tal forma que possa acolher todas as pessoas
    que te buscam; por Jesus Cristo nosso Senhor
    e Salvador. **Amém.**
  TEXT
  end

# Litania por toda a humanidade
LiturgicalText.find_or_create_by!(slug: 'litany_for_all_humanity', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Sobre a Igreja Una, Santa, Católica e Apostólica,
    **Envia, ó Deus, teu Santo Espírito.**
    Sobre aquelas pessoas que proclamam o Evangelho,
    **Envia, ó Deus, a tua sabedoria.**
    Sobre aquelas que declaram a tua presença e amor,
    **Envia, ó Deus, a tua inspiração.**
    Sobre aquelas que ministram os sacramentos,
    **Envia, ó Deus, o teu fortalecimento.**
    Sobre as tuas fiéis testemunhas,
    **Envia, ó Deus, o teu conhecimento.**
    Sobre as pessoas recém-convertidas,
    **Envia, ó Deus, a tua proteção.**
    Sobre as que perderam a esperança e a alegria,
    **Envia, ó Deus, a tua misericórdia.**
    Sobre as que se encontram amedrontadas e enfermas,
    **Envia, ó Deus, a cura e a restauração.**
    Sobre aquelas pessoas que têm poder,
    **Envia, ó Deus, a humildade e a responsabilidade.**
    Sobre nós e sobre nossas vidas,
    **Envia, ó Deus, a tua paz, que transcende
    todo entendimento.**
    Sobre aquelas que morreram na paz de Cristo,
    **Envia, ó Deus, a tua luz perpétua, na companhia de
    todos os santos e santas. Amém.**
  TEXT
  end

# Rubrica após as Orações
LiturgicalText.find_or_create_by!(slug: 'evening_rubric_post_prayers', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Aqui podem ser usadas uma das intercessões
    deste livro ou litanias autorizadas.
    As Orações são concluídas uma das seguintes Orações Gerais de
    Ação de Graças, podendo ser precedidas por uma música ou hino:
  TEXT
  end

# opening_general_thanksgiving

# rubric_after_opening_general_thanksgiving

# general_thanksgiving_1

# general_thanksgiving_2

# chrysostom_prayer

# rubric_concluding_prayers

# opening_concluding_prayers

# Rubrica após as Orações Conclusivas
LiturgicalText.find_or_create_by!(slug: 'evening_rubric_post_concluding_prayers', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    A Oração da Tarde termina com uma das seguintes Orações
    Conclusivas, podendo ainda serem substituídas por um outro
    versículo adequado das Sagradas Escrituras:
  TEXT
  end

# dismissal_1 ou dismissal_2 ou dismissal_3 ou dismissal_4

# rubric_post_dismissal

Rails.logger.info "Created #{LiturgicalText.count} liturgical texts"
