# Seeds for Liturgical Texts
prayer_book = PrayerBook.find_by!(code: 'loc_2015')

puts "Criando textos do Ofício Diário para LOC 2015..."

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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
end

# Rubrica da Sentença de Abertura
LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_rubric', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Guarda-se um momento de silêncio.
    Pode-se cantar um hino ou salmo antes
    ou após as sentenças iniciais.
  TEXT
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
end

# Sentença de Abertura 7
LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_7', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Sejam bem aceitas as palavras de minha boca, e o meditar
    de meu coração, perante a tua face, ó SENHOR, rocha
    minha e redentor meu! __(Sl 19.15)__
  TEXT
  lt.language = 'pt-BR'
end

# Sentença de Abertura Advento
LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_advent', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Estejam sempre alegres em suas vidas no Senhor.
    Repito: Alegrem-se. O Senhor virá logo. __(Fl 4.4-5)__
    **Amém. Vem, Senhor Jesus.** __(Ap. 22.20)__
  TEXT
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
end

# Rubrica da Confissão
LiturgicalText.find_or_create_by!(slug: 'morning_rubric_confession', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Quem oficia diz:
  TEXT
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
end

# Abertura Confissão 2
LiturgicalText.find_or_create_by!(slug: 'morning_opening_confession_2', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'confession'
  lt.content = <<~TEXT
    Confessemos humildemente os nossos pecados
    a Deus Todo-poderoso.
  TEXT
  lt.language = 'pt-BR'
end

# Rubrica da Confissão
LiturgicalText.find_or_create_by!(slug: 'morning_rubric_post_opening_confession', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    As admoestações anteriores podem ser substituídas por um
    versículo bíblico que desperte espírito de penitência.
    Há um instante de silêncio, estando
    ajoelhadas as pessoas que puderem.
    É dito por todas as pessoas:
  TEXT
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
end

# Rubrica após Confissão
LiturgicalText.find_or_create_by!(slug: 'morning_rubric_post_confession', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    A pessoa oficiante, ainda ajoelhada,
    lê uma das orações seguintes.
    Estando, porém, presente um(a) bispo(a) ou presbítero(a),
    deve ser usada a Absolvição em lugar das orações a seguir:
  TEXT
  lt.language = 'pt-BR'
end

# Oração após Confissão 1
LiturgicalText.find_or_create_by!(slug: 'morning_prayer_after_confession_1', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'confession'
  lt.content = <<~TEXT
    Ó Senhor, suplicamos-te que escutes compassivo nossas
    orações, e perdoes as pessoas que a ti confessam os seus
    pecados; para que aquelas que são acusadas por suas
    consciências, sejam absolvidas por teu perdão;
    mediante Jesus Cristo nosso Senhor. Amém.
  TEXT
  lt.language = 'pt-BR'
end

# Oração após Confissão 2
LiturgicalText.find_or_create_by!(slug: 'morning_prayer_after_confession_2', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'confession'
  lt.content = <<~TEXT
    Deus Todo-poderoso tenha misericórdia de vocês,
    perdoe os seus pecados
    e mantenha vocês no caminho da vida eterna.
    **Deus Todo-poderoso tenha misericórdia de ti,
    perdoe os teus pecados
    e te mantenha no caminho da vida eterna. Amém.**
  TEXT
  lt.language = 'pt-BR'
end

# Absolvição
LiturgicalText.find_or_create_by!(slug: 'morning_absolution', prayer_book_id: prayer_book.id) do |lt|
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
  lt.language = 'pt-BR'
end

# Rubrica após Absolvição
LiturgicalText.find_or_create_by!(slug: 'morning_rubric_post_absolution', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Então levanta-se quem puder.
  TEXT
  lt.language = 'pt-BR'
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
    [Aleluia!]
  TEXT
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
end

# Pré-Invitatório Advento
LiturgicalText.find_or_create_by!(slug: 'morning_before_invocation_advent', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Nosso Rei e Salvador aproxima-se; Vamos adorá-lo.
  TEXT
  lt.language = 'pt-BR'
end

# Pré-Invitatório Natal
LiturgicalText.find_or_create_by!(slug: 'morning_before_invocation_christmas', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Aleluia. Porque a nós nos é nascido um menino;
    Vamos adorá-lo. Aleluia!
  TEXT
  lt.language = 'pt-BR'
end

# Pré-Invitatório Epifania
LiturgicalText.find_or_create_by!(slug: 'morning_before_invocation_epiphany', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Aleluia. O Senhor manifestou a sua glória;
    Vamos adorá-lo. Aleluia!
  TEXT
  lt.language = 'pt-BR'
end

# Pré-Invitatório Quaresma
LiturgicalText.find_or_create_by!(slug: 'morning_before_invocation_lent', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    O Senhor é cheio de compaixão e misericórdia;
    Vamos adorá-lo.
  TEXT
  lt.language = 'pt-BR'
end

# Pré-Invitatório Páscoa
LiturgicalText.find_or_create_by!(slug: 'morning_before_invocation_easter', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Aleluia. Ressuscitou verdadeiramente o Senhor;
    Vamos adorá-lo. Aleluia!
  TEXT
  lt.language = 'pt-BR'
end

# Pré-Invitatório Ascensão
LiturgicalText.find_or_create_by!(slug: 'morning_before_invocation_ascension', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Aleluia. Cristo Senhor subiu ao céu;
    Vamos adorá-lo. Aleluia!
  TEXT
  lt.language = 'pt-BR'
end

# Pré-Invitatório Pentecostes
LiturgicalText.find_or_create_by!(slug: 'morning_before_invocation_pentecost', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Aleluia. O Espírito do Senhor enche o mundo;
    Vamos adorá-lo. Aleluia!
  TEXT
  lt.language = 'pt-BR'
end

# Pré-Invitatório Trindade
LiturgicalText.find_or_create_by!(slug: 'morning_before_invocation_trinity', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Aleluia. Pai, Filho e Espírito Santo, um só Deus;
    Vamos adorá-lo. Aleluia!
  TEXT
  lt.language = 'pt-BR'
end

# Pré-Invitatório Anunciação
LiturgicalText.find_or_create_by!(slug: 'morning_before_invocation_anunciation', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Aleluia. O Verbo se fez carne e habitou entre nós;
    Vamos adorá-lo. Aleluia!
  TEXT
  lt.language = 'pt-BR'
end

# Pré-Invitatório Ação de Graças e outros dias festivos
LiturgicalText.find_or_create_by!(slug: 'morning_before_invocation_common_feast', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Aleluia!
    O Senhor é glorioso nos seus santos e santas;
    Vamos adorá-lo. Aleluia!
  TEXT
  lt.language = 'pt-BR'
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
  lt.reference = '(Salmo 95.1-7; 96.9,13)'
  lt.language = 'pt-BR'
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
  lt.reference = '(Salmo 100)'
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
end

# Rubrica do Gloria Patri
LiturgicalText.find_or_create_by!(slug: 'rubric_gloria_patri', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Há a recitação de um ou mais Salmos, sendo ao final de cada Salmo,
    ou após cada grupo de Salmos, cantado ou dito o Gloria Patri.
  TEXT
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
end

# Rubrica da Primeira Leitura
LiturgicalText.find_or_create_by!(slug: 'rubric_first_reading', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Sentando-se todas as pessoas, é feita
    a leitura do Primeiro Testamento.
    A leitura é anunciada da seguinte maneira:
  TEXT
  lt.language = 'pt-BR'
end

# Primeira Leitura
LiturgicalText.find_or_create_by!(slug: 'first_reading', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'invocation'
  lt.content = <<~TEXT
    A Palavra de Deus, escrita no Livro de {{book_name}},
    capítulo {{chapter}}, começando com o versículo {{verse}}.
  TEXT
  lt.language = 'pt-BR'
end

# Rubrica após a Primeira Leitura
LiturgicalText.find_or_create_by!(slug: 'rubric_post_first_reading', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Quem estiver lendo termina com:
  TEXT
  lt.language = 'pt-BR'
end

# Após a Primeira Leitura
LiturgicalText.find_or_create_by!(slug: 'canticle_post_first_reading', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Palavra do Senhor.
    **Demos graças a Deus.**
  TEXT
  lt.language = 'pt-BR'
end

# Rubrica ao fim da Primeira Leitura
LiturgicalText.find_or_create_by!(slug: 'morning_rubric_end_first_reading', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Após a leitura pode-se guardar um momento de silêncio.
    Estando de pé quem puder, é cantado ou
    recitado um dos Cânticos a seguir.
    Quando as circunstâncias exigirem,
    pode-se cantar um hino, em lugar do Cântico.
  TEXT
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
  lt.reference = '(Salmo 98)'
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
  lt.language = 'pt-BR'
  lt.reference = '(Dn 3.57-87)'
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
  lt.language = 'pt-BR'
end

# Segunda Leitura
LiturgicalText.find_or_create_by!(slug: 'second_reading', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'invocation'
  lt.content = <<~TEXT
    A Palavra de Deus, escrita na Epístola (ou Evangelho)
    de {{book_name}}, capítulo {{chapter}},
    começando com o versículo {{verse}}.
  TEXT
  lt.language = 'pt-BR'
end

# Rubrica após a Segunda Leitura
LiturgicalText.find_or_create_by!(slug: 'rubric_post_second_reading', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Quem estiver lendo termina com:
  TEXT
  lt.language = 'pt-BR'
end

# Após a Segunda Leitura
LiturgicalText.find_or_create_by!(slug: 'canticle_post_second_reading', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Palavra do Senhor.
    **Demos graças a Deus.**
  TEXT
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
  lt.reference = '(Ap 15.3-4)'
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
  lt.language = 'pt-BR'
  lt.reference = '(Salmo 103)'
end

# Rubrica ao fim da Segunda Leitura
LiturgicalText.find_or_create_by!(slug: 'rubric_end_second_canticle', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Segue-se o Sermão, que pode ser omitido
    exceto aos Domingos e Festas Principais.
    Estando de pé quem puder, é dito o Credo.
  TEXT
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
end

# Rubrica do Ofertório
LiturgicalText.find_or_create_by!(slug: 'morning_rubric_offertory', prayer_book_id: prayer_book.id) do |lt|
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
  lt.language = 'pt-BR'
end

# Rubrica das Orações
LiturgicalText.find_or_create_by!(slug: 'morning_rubric_prayers', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Estando em pé ou ajoelhadas as pessoas
    que puderem, é dita a Oração do Pai nosso:
  TEXT
  lt.language = 'pt-BR'
end

# Invocação da Oração do Pai Nosso 1
LiturgicalText.find_or_create_by!(slug: 'invocation_our_father_1', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'invocation'
  lt.content = <<~TEXT
    O Senhor seja com vocês.
    **Seja também contigo.**
  TEXT
  lt.language = 'pt-BR'
end

# Invocação da Oração do Pai Nosso 2
LiturgicalText.find_or_create_by!(slug: 'invocation_our_father_2', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'invocation'
  lt.content = <<~TEXT
    O Senhor está aqui.
    **Seu Espírito está conosco.**
  TEXT
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
end

# Rubrica da Coleta do Dia
LiturgicalText.find_or_create_by!(slug: 'rubric_collect_of_the_day', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Estando ajoelhadas as pessoas que puderem, é dita a
    Coleta do Dia e da Quadra do Ano Cristão, quando houver.
  TEXT
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
end

# Rubrica após as Orações
LiturgicalText.find_or_create_by!(slug: 'morning_rubric_after_prayers', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    (Aqui pode-se guardar um momento de silêncio
    ou dar oportunidade para intercessões pessoais)
  TEXT
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
end

# Rubrica após as Orações
LiturgicalText.find_or_create_by!(slug: 'morning_rubric_after_final_prayer', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    As Orações são concluídas com uma das seguintes
    Orações Gerais de Ação de Graças, podendo
    ser precedidas por uma música ou hino:
  TEXT
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
end

# Rubrica após a abertura da Ação de Graças
LiturgicalText.find_or_create_by!(slug: 'rubric_after_opening_general_thanksgiving', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    (Aqui pode-se guardar breve silêncio, para que
    as pessoas ofereçam suas ações de graças)
  TEXT
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
end

# Rubrica das Orações Conclusivas
LiturgicalText.find_or_create_by!(slug: 'morning_rubric_concluding_prayers', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Pode-se acrescentar a seguinte sentença:
  TEXT
  lt.language = 'pt-BR'
end

# Orações Conclusivas
LiturgicalText.find_or_create_by!(slug: 'morning_opening_concluding_prayers', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = <<~TEXT
    Bendigamos ao SENHOR.
    **Graças rendamos a Deus.**
  TEXT
  lt.language = 'pt-BR'
end

# Rubrica da Despedida
LiturgicalText.find_or_create_by!(slug: 'morning_rubric_dismissal', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    A Oração da Manhã termina com uma das seguintes
    Orações Conclusivas, podendo ainda serem substituídas
    por um outro versículo adequado das Sagradas Escrituras:
  TEXT
  lt.language = 'pt-BR'
end

# Despedida 1
LiturgicalText.find_or_create_by!(slug: 'morning_dismissal_1', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'dismissal'
  lt.content = <<~TEXT
    A Graça de nosso Senhor Jesus Cristo,
    e o amor de Deus,
    e a comunhão do Espírito Santo
    sejam conosco para sempre. __(2 Co 13.14)__
    **Amém.**
  TEXT
  lt.language = 'pt-BR'
end

# Despedida 2
LiturgicalText.find_or_create_by!(slug: 'morning_dismissal_2', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'dismissal'
  lt.content = <<~TEXT
    O Senhor nos abençoe e nos guarde.
    O Senhor faça resplandecer o seu semblante sobre nós,
    e tenha misericórdia de nós.
    O Senhor sobre nós levante sua face,
    e nos dê a paz, agora e sempre. __(Nm 6.24-26)__
    **Amém.**
  TEXT
  lt.language = 'pt-BR'
end

# Despedida 3
LiturgicalText.find_or_create_by!(slug: 'morning_dismissal_3', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'dismissal'
  lt.content = <<~TEXT
    Que o Deus da esperança
    nos encha de completa alegria e paz na fé,
    para que transbordemos de esperança,
    pela força do Espírito Santo. __(Rm 15.13)__
    **Amém.**
  TEXT
  lt.language = 'pt-BR'
end

# Despedida 4
LiturgicalText.find_or_create_by!(slug: 'morning_dismissal_4', prayer_book_id: prayer_book.id) do |lt|
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
  lt.language = 'pt-BR'
end

# Rubrica após a Despedida
LiturgicalText.find_or_create_by!(slug: 'morning_rubric_post_dismissal', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Estando porém presente um(a) bispo(a) ou presbítero(a),
    a congregação pode ser despedida com uma Bênção.
  TEXT
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
end

# Rubrica após a Preparação
LiturgicalText.find_or_create_by!(slug: 'compline_rubric_post_preparation', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Silêncio
    Pode ser dita a seguinte lição breve:
  TEXT
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
end

# Rubrica de Silêncio
LiturgicalText.find_or_create_by!(slug: 'compline_rubric_silence', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Silêncio
  TEXT
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
end

# Resposta após a Confissão
LiturgicalText.find_or_create_by!(slug: 'compline_post_confession', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'confession'
  lt.content = <<~TEXT
    **Deus Todo-Poderoso tenha misericórdia de nós,
    perdoe os nossos pecados e nos conduza à vida eterna.
    Amém.**
  TEXT
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
end

# Rubrica após a Súplica de Perdão
LiturgicalText.find_or_create_by!(slug: 'compline_rubric_post_absolution', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Pode cantar-se um hino.
  TEXT
  lt.language = 'pt-BR'
end

# Rubrica antes dos Salmos
LiturgicalText.find_or_create_by!(slug: 'compline_rubric_before_psalms', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Podem ser recitados ou cantados um ou mais dos seguintes
    salmos, bem como outras seleções adequadas do Saltério.
  TEXT
  lt.language = 'pt-BR'
end

# Cum invocarem
LiturgicalText.find_or_create_by!(slug: 'compline_cum_invocarem', prayer_book_id: prayer_book.id) do |lt|
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
  lt.reference = '(Salmo 4)'
  lt.language = 'pt-BR'
end

# Qui habitat
LiturgicalText.find_or_create_by!(slug: 'compline_qui_habitat', prayer_book_id: prayer_book.id) do |lt|
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
  lt.reference = '(Salmo 91)'
  lt.language = 'pt-BR'
end

# Ecce Nunc
LiturgicalText.find_or_create_by!(slug: 'compline_ecce_nunc', prayer_book_id: prayer_book.id) do |lt|
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
  lt.reference = '(Salmo 134)'
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
end

# Rubrica após as Lições
LiturgicalText.find_or_create_by!(slug: 'compline_rubric_post_lessons', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Estando de pé quem puder, é
    é cantado o hino Te Lucis ou
    outro hino vespertino adequado.
  TEXT
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
end

# Kyrie Eleison - Original
LiturgicalText.find_or_create_by!(slug: 'kyrie_original', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    **Kyrie Eleison.
    Christe Eleison.
    Kyrie Eleison.**
  TEXT
  lt.language = 'pt-BR'
end

# Rubrica antes das Orações
LiturgicalText.find_or_create_by!(slug: 'compline_rubric_before_prayers', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Estando as pessoas que puderem em pé ou ajoelhadas,
    é dita a Oração do Pai nosso da seguinte forma:
  TEXT
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
end

# Rubrica antes das Orações Finais
LiturgicalText.find_or_create_by!(slug: 'compline_rubric_before_final_prayer', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Pode ser dita uma ou mais das seguintes orações e coletas
  TEXT
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
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
  lt.language = 'pt-BR'
end

# Completas - Rubrica Final
LiturgicalText.find_or_create_by!(slug: 'compline_final_rubric', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'rubric'
  lt.content = <<~TEXT
    Não há bênção nem tampouco hino final.
    Todas as pessoas se retiram em silêncio.
  TEXT
  lt.language = 'pt-BR'
end

puts "Created #{LiturgicalText.count} liturgical texts"
