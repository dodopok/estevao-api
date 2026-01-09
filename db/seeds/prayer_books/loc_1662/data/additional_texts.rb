# Credo Atanasiano (Pág 25-27)
create_text('athanasian_creed_rubric', 'rubric', "Após as festas: Dia de Natal, Epifania, São Matias, Dia de Páscoa, Dia da Ascensão, Domingo de Pentecostes, São João Batista, São Tiago, São Bartolomeu, São Mateus, São Simão e São Judas, Santo André e no Domingo da Trindade, serão cantados ou recitados na Oração Matutina, em vez do Credo dos Apóstolos, essa Confissão da nossa Fé Cristã, comumente chamada de Credo de Santo Atanásio (ou Credo Atanasiano), pelo Ministro e pelo povo em pé.")

athanasian_creed_text = <<~TEXT
  Todo aquele que quiser ser salvo, * é necessário acima de tudo, que sustente a fé católica.
  A qual, a menos que cada um preserve perfeita e inviolável, * certamente perecerá para sempre.
  Mas a fé universal é esta: * Que adoremos um único Deus em Trindade, e a Trindade em unidade.
  Não confundindo as pessoas, * nem dividindo a substância.
  Porque a pessoa do Pai é uma, a do Filho é outra, * e a do Espírito Santo outra.
  Mas no Pai, no Filho e no Espírito Santo há uma mesma divindade, * igual em glória e coeterna majestade.
  O que o Pai é, o mesmo é o Filho, * e o Espírito Santo. O Pai é não criado, o Filho é não criado, * o Espírito Santo é não criado.
  O Pai é ilimitado, o Filho é ilimitado, * o Espírito Santo é ilimitado.
  O Pai é eterno, o Filho é eterno, * o Espírito Santo é eterno.
  Contudo, não há três eternos, * mas um eterno. Portanto não há três não criados, nem três ilimitados, * mas um não criado e um ilimitado.
  Do mesmo modo, o Pai é onipotente, o Filho é onipotente, * o Espírito Santo é onipotente.
  Contudo, não há três onipotentes, * mas um só onipotente.
  Assim, o Pai é Deus, o Filho é Deus, * o Espírito Santo é Deus.
  Contudo, não há três Deuses, * mas um só Deus. Portanto o Pai é Senhor, o Filho é Senhor, * e o Espírito Santo é Senhor.
  Contudo, não há três Senhores, * mas um só Senhor. Porque, assim como compelidos pela verdade cristã * a confessar cada pessoa separadamente como Deus e Senhor,
  Assim também somos proibidos pela religião católica * de dizer que há três Deuses ou Senhores.
  O Pai não foi feito de ninguém, * nem criado, nem gerado.
  O Filho procede do Pai somente, * nem feito, nem criado, mas gerado.
  O Espírito Santo procede do Pai e do Filho, * não feito, nem criado, nem gerado, mas procedente. Portanto, há um só Pai, não três Pais, um Filho, não três Filhos, * um Espírito Santo, não três Espíritos Santos. E nessa Trindade nenhum é primeiro ou último, * nenhum é maior ou menor.
  Mas todas as três pessoas coeternas * são coiguais entre si;
  De modo que em tudo o que foi dito acima, * tanto a unidade em trindade, como a trindade em unidade deve ser cultuada.
  Logo, todo aquele que quiser ser salvo * deve pensar desse modo com relação à Trindade.
  Mas também é necessário para a salvação eterna, * que se creia fielmente na encarnação do nosso Senhor Jesus Cristo.
  É, portanto, uma fé verdadeira, que creiamos e confessemos * que nosso Senhor e Salvador Jesus Cristo, o Filho de Deus, é tanto Deus como homem.
  Ele é Deus eternamente gerado da substância do Pai; * e homem nascido no tempo da substância da sua mãe.
  Perfeito Deus, perfeito homem, * subsistindo de uma alma racional e carne humana.
  Igual ao Pai com relação à sua divindade, * menor do que o Pai com relação à sua humanidade.
  O qual, embora seja Deus e homem, * não é dois, mas um só Cristo.
  E um, não pela conversão da sua divindade em carne, * mas por sua divindade haver assumido sua humanidade. Um, não, de modo algum, pela confusão de substância, * mas pela unidade da pessoa.
  Pois assim como uma alma racional e carne constituem um só homem, * assim Deus e homem constituem um só Cristo.
  O qual sofreu por nossa salvação, * desceu ao Hades, ressuscitou dos mortos ao terceiro dia.
  Ascendeu ao céu, assentou-se à direita de Deus Pai onipotente, * de onde virá para julgar os vivos e os mortos.
  Em cuja vinda, todo homem ressuscitará com seus corpos, * e prestarão conta de suas obras.
  E aqueles que houverem feito o bem irão para a vida eterna; * aqueles que houverem feito o mal, para o fogo eterno.
  Esta é a fé católica, * a qual a não ser que um homem creia firmemente nela, não pode ser salvo.
  Glória seja ao Pai e ao Filho: * e ao Espírito Santo; Como era no princípio, é hoje e para sempre: * Eternamente. Amém.
TEXT

create_text('athanasian_creed', 'prayer', athanasian_creed_text, title: "Quicunque Vult")

# A Litania (Pág 29-34)
create_text('litany_rubric', 'rubric', "Aqui continua a Litania, ou Suplica Geral, a ser dita depois da Oração Matutina ou Vespertina nos Domingos, e outros convenientes tempos a discrição do Ministro.")

# I'll create a single text for the Litany or break it down?
# Given the size, I'll break it into logical sections if needed, but for now a single large text is easier for the builder if it's always used together.
# But 1662 Litany is quite interactive.

create_text('litany_part_1', 'litany',
  <<~TEXT
    Ó DEUS o Pai, Criador do céu e da terra;
    **Tem misericórdia de nós, pobres pecadores.**
    Ó Deus o Filho, Redentor do mundo;
    **Tem misericórdia de nós, pobres pecadores.**
    Ó Deus o Espírito Santo, procedente do Pai e do Filho;
    **Tem misericórdia de nós, pobres pecadores.**
    Ó Santa, bendita e gloriosa Trindade, três pessoas e um só Deus;
    **Tem misericórdia de nós, pobres pecadores.**
  TEXT
)

create_text('litany_part_2', 'litany',
  <<~TEXT
    Não te lembres, ó Senhor, dos nossos pecados nem dos pecados dos nossos pais; nem te vingues dos nossos pecados:
    **Perdoa-nos, bom Senhor.**
    Perdoa ao teu povo, a quem remiste com teu precioso sangue, e não permaneças irado conosco para sempre.
    **Perdoa-nos, bom Senhor.**
  TEXT
)

create_text('litany_part_3', 'litany',
  <<~TEXT
    De todos os males e danos; do pecado; das ciladas do diabo e da ira vindoura,
    **Livra-nos, bom Senhor.**
    De toda cegueira do coração; de orgulho, vanglória e hipocrisia; de inveja, ódio, e malícia, e de toda falta de caridade.
    **Livra-nos, bom Senhor.**
    De pecados sexuais; de todos os outros pecados mortais; e de todos os enganos do mundo, da carne, e do demônio.
    **Livra-nos, bom Senhor.**
    De raios e tempestades; de praga, doença e fome; da guerra, assassinato, e morte repentina.
    **Livra-nos, bom Senhor.**
    De toda traição e conspiração; de toda falsa doutrina, heresia e cisma; da dureza do coração, e desprezo por tua Palavra e os mandamentos.
    **Livra-nos, bom Senhor.**
    Pelo mistério da tua santa encarnação; por teu santo nascimento e circuncisão; por teu batismo, jejum e tentação.
    **Livra-nos, bom Senhor.**
    Por tua agonia, cruz e paixão; por tua preciosa morte e sepultura; por tua gloriosa ressurreição e admirável ascensão; e pela vinda do Espírito Santo,
    **Livra-nos, bom Senhor.**
    No tempo de tribulação e no tempo de prosperidade; na hora da morte, e no dia do juízo.
    **Livra-nos, bom Senhor.**
  TEXT
)

create_text('litany_part_4', 'litany',
  <<~TEXT
    Nós, pecadores, te imploramos: ouve-nos, ó Senhor, e agrada-te em governar tua Igreja no caminho da verdade.
    **Suplicamos-Te que nos ouças, bom Senhor.**
    Queira agradar-te reinar no coração do teu servo, — e todos os demais em autoridade, para que, sob eles, possamos levar uma vida tranquila e pacífica em toda piedade e honestidade.
    **Suplicamos-Te que nos ouças, bom Senhor.**
    Queira agradar-te ser o defensor e guardião deles.
    **Suplicamos-Te que nos ouças, bom Senhor.**
    Queira agradar-te conceder aos legisladores e aos ministros do Estado graça, sabedoria e entendimento.
    **Suplicamos-Te que nos ouças, bom Senhor.**
    Queira agradar-te abençoar e proteger os juízes e magistrados, concedendo-lhes graça para exercer a justiça e manter a verdade.
    **Suplicamos-Te que nos ouças, bom Senhor.**
    Queira agradar-te iluminar todos os bispos, presbíteros e diáconos com o verdadeiro conhecimento e entendimento da tua palavra; e que, tanto por sua pregação quanto por sua vida, possam proclamá-la e demonstrá-la verdadeiramente.
    **Suplicamos-Te que nos ouças, bom Senhor.**
    Queira agradar-te abençoar e proteger todo o teu povo.
    **Suplicamos-Te que nos ouças, bom Senhor.**
    Queira agradar-te conceder a todas as nações unidade, paz e concórdia.
    **Suplicamos-Te que nos ouças, bom Senhor.**
    Queira agradar-te dar-nos um coração para amar e temer, e viver diligentemente segundo os teus mandamentos.
    **Suplicamos-Te que nos ouças, bom Senhor.**
    Queira agradar-te conceder a todo o teu povo o aumento da graça, para ouvir humildemente a tua palavra e recebê-la com puro afeto, e para produzir os frutos do Espírito.
    **Suplicamos-Te que nos ouças, bom Senhor.**
    Queira agradar-te guiar no caminho da verdade todos aqueles que erraram e estão enganados.
    **Suplicamos-Te que nos ouças, bom Senhor.**
    Queira agradar-te fortalecer os que permanecem firmes, consolar e ajudar os de coração fraco, levantar aqueles que caem e finalmente derrotar Satanás sob nossos pés.
    **Suplicamos-Te que nos ouças, bom Senhor.**
    Queira agradar-te socorrer, ajudar e consolar todos aqueles que estão em perigo, necessidade e tribulação.
    **Suplicamos-Te que nos ouças, bom Senhor.**
    Queira agradar-te preservar todos aqueles que viajam por terra, por água ou pelo ar; todas as mulheres grávidas, todas as pessoas doentes e crianças pequenas, e mostrar tua piedade a todos os prisioneiros e cativos.
    **Suplicamos-Te que nos ouças, bom Senhor.**
    Queira agradar-te defender e prover os órfãos, viúvas e todos os que estão desamparados e oprimidos.
    **Suplicamos-Te que nos ouças, bom Senhor.**
    Queira agradar-te ter misericórdia de todos os homens.
    **Suplicamos-Te que nos ouças, bom Senhor.**
    Queira agradar-te perdoar nossos inimigos, perseguidores e caluniadores, e transformar seus corações
    **Suplicamos-Te que nos ouças, bom Senhor.**
    Queira agradar-te dar e preservar para nosso uso os frutos benéficos da terra, para que, no devido tempo, possamos desfrutá-los
    **Suplicamos-Te que nos ouças, bom Senhor.**
    Queira agradar-te conceder-nos o verdadeiro arrependimento; perdoar-nos todos os nossos pecados, negligências e ignorâncias; e dotar-nos da graça do teu Espírito Santo, para melhorarmos nossas vidas de acordo com a tua Santa Palavra.
    **Suplicamos-Te que nos ouças, bom Senhor.**
  TEXT
)

create_text('litany_part_5', 'litany',
  <<~TEXT
    Filho de Deus, imploramos para que nos ouças.
    **Filho de Deus, imploramos, ouve-nos.**
    Ó Cordeiro de Deus, que tiras os pecados do mundo,
    **Dá-nos a tua paz.**
    Ó Cordeiro de Deus, que tiras os pecados do mundo,
    **Tem misericórdia de nós.**
    Ó Cristo, ouve-nos.
    **Ó Cristo, ouve-nos.**
    Senhor, tem misericórdia de nós.
    **Senhor, tem misericórdia de nós.**
    Cristo, tem misericórdia de nós.
    **Cristo, tem misericórdia de nós.**
    Senhor, tem misericórdia de nós.
    **Senhor, tem misericórdia de nós.**
  TEXT
)

create_text('litany_lords_prayer_rubric', 'rubric', "Então, o Ministro, juntamente com o povo dirá a Oração do Senhor.")

create_text('litany_after_lords_prayer', 'litany',
  <<~TEXT
    Ministro: Ó Senhor, não nos trates conforme os nossos pecados.
    Resposta: Nem nos recompenses segundo as nossas iniquidades.
  TEXT
)

create_text('litany_prayer_1', 'litany',
  <<~TEXT
    Ó Deus, nosso Pai misericordioso, que não és insensível aos gemidos da contrição nem ao suspiro dos tristes: na tua misericórdia ensina-nos e ajuda-nos a orar sempre que somos oprimidos pela adversidade ou dificuldade; e ouve-nos de modo que pela tua providência os males trazidos contra nós pela malícia e maldade do diabo, ou do homem, possam vir a nada; e possamos, teus humildes servos, com todo o povo, dar graças e louvor a ti para sempre, por Cristo Jesus nosso Senhor. Amém.
    Ó Senhor, levanta-te, ajuda-nos e livra-nos por amor do teu nome.
  TEXT
)

create_text('litany_prayer_2', 'litany',
  <<~TEXT
    Ó Deus, temos escutado com os nossos ouvidos, e nossos pais nos contaram as obras nobres que realizaste em seus dias e nos tempos antigos antes deles.
    Ó Senhor, levanta-te, ajuda-nos e livra-nos pela honra do teu nome.
  TEXT
)

create_text('litany_gloria_patri', 'litany',
  <<~TEXT
    Glória seja ao Pai e ao Filho: e ao Espírito Santo;
    Como era no princípio, é hoje e para sempre: Eternamente. Amém.
    Defende-nos dos nossos inimigos, ó Cristo.
    Olha com graça para as nossas aflições.
    Contempla com compaixão as tristezas dos nossos corações.
    Perdoa misericordiosamente os pecados do teu povo.
    Ouve favoravelmente as nossas orações com misericórdia.
    Ó Filho de Davi, tem misericórdia de nós.
    Agora e sempre, digna-te a nos ouvir, ó Cristo.
    Ouve-nos com graça, ó Cristo; ouve-nos com graça, ó Senhor Cristo.
    Ministro: Ó Senhor, mostra tua misericórdia sobre nós.
    Resposta: Pois nós confiamos em Ti.
  TEXT
)

create_text('litany_final_prayer', 'litany',
  <<~TEXT
    Humildemente te suplicamos, ó Pai, que olhes misericordiosamente para as nossas fraquezas e, para a glória do teu nome, afaste de nós todos os males que justamente merecemos, e concede que, em todas as nossas dificuldades, depositemos plena confiança em tua misericórdia e sirvamos a ti sempre em santidade e pureza de vida, para tua honra e glória, por nosso único mediador e advogado, Jesus Cristo nosso Senhor. Amém.
  TEXT
)

create_text('litany_kings_supplications_rubric', 'rubric', "Em vez das duas súplicas que começam com “Queira agrada-de te reinar no coração e etc.” (pag: 30), podem ser ditas as súplicas seguintes:")

create_text('litany_kings_supplications', 'litany',
  <<~TEXT
    Queira agradar-te manter e fortalecer na verdadeira adoração a ti, na retidão e na santidade de vida, o teu servo CHARLES III, cheio de graça, nosso Rei e Governante,
    **Suplicamos-Te que nos ouças, bom Senhor.**
    Queira agradar-te reinar no coração dele na tua fé, temor e amor, e que ele possa sempre confiar o seu caminho a ti, e sempre buscar a tua honra e glória,
    **Suplicamos-Te que nos ouças, bom Senhor.**
    Queira agradar-te ser o seu defensor e protetor, dando- lhe a vitória sobre todos os seus inimigos,
    **Suplicamos-Te que nos ouças, bom Senhor.**
    Queira agradar-te abençoar e preservar a Rainha Camilla, William Príncipe de Gales, a Princesa de Gales, e toda a família real,
    **Suplicamos-Te que nos ouças, bom Senhor.**
  TEXT
)

# Orações e Ações de Graças (Pág 37-41)
create_text('prayers_thanksgivings_rubric', 'rubric', "Em várias ocasiões, para ser usado antes das duas orações finais da Litania, ou da Oração Matutina e Vespertina")

create_text('prayer_for_rain', 'prayer', "Ó DEUS, Pai celestial, que por meio de teu Filho Jesus Cristo prometeste a todos aqueles que buscam o teu reino e a sua justiça todas as coisas necessárias para o sustento do corpo: Envie-nos, te suplicamos, nesta nossa necessidade, chuvas moderadas e benéficas, para que possamos receber os frutos da terra para nosso conforto e para a tua honra, por Jesus Cristo, nosso Senhor. Amém.", title: "Para Chuva")

create_text('prayer_for_fair_weather', 'prayer', "Ó Deus Todo-Poderoso, que pelo pecado do homem uma vez afogaste todo o mundo, exceto oito pessoas, e depois, de tua grande misericórdia, prometeste nunca mais destruí-lo dessa forma: Te suplicamos humildemente que, embora por nossas iniquidades tenhamos merecido uma praga de chuvas e águas, ainda assim, mediante nosso verdadeiro arrependimento, enviarás sobre nós um tempo apropriado, para que possamos receber os frutos da terra na devida estação e aprender tanto com o teu castigo a corrigir nossas vidas, quanto com a tua clemência a te dar louvor e glória, por Jesus Cristo, nosso Senhor. Amém.", title: "Para o Bom Clima")

create_text('prayer_in_time_of_dearth_1', 'prayer', "Ó Deus, Pai celestial, cujo dom é fazer chover, tornar a terra fértil, aumentar as criaturas e multiplicar os peixes: Atenta-te, nós te imploramos, as aflições do teu povo, e concede que a escassez e a falta que agora justamente suportamos por nossa iniquidade possam, pela tua bondade, ser misericordiosamente transformadas em abundância e fartura, pelo amor de Jesus Cristo nosso Senhor, a quem, contigo e com o Espírito Santo, seja toda honra e glória, agora e para sempre. Amém.", title: "Em tempos de escassez e fome")

create_text('prayer_in_time_of_dearth_2', 'prayer', "Ó Deus, Pai misericordioso, que no tempo do profeta Eliseu transformaste subitamente a grande escassez e fome em Samaria em fartura e abundância: Tem misericórdia de nós, que agora estamos sendo punidos por nossos pecados com adversidades semelhantes, e concede-nos também um alívio oportuno. Aumenta os frutos da terra com tua bênção celestial e concede que, recebendo tua generosidade abundante, possamos usá-la para tua glória, para o auxílio dos necessitados e para nosso próprio conforto, por meio de Jesus Cristo nosso Senhor. Amém.", title: "Ou essa")

create_text('prayer_in_time_of_war', 'prayer', "Ó Deus Todo-Poderoso, Rei de todos os reis e governante de todas as coisas, cujo poder nenhuma criatura é capaz de resistir, a quem pertence justamente punir os pecadores e ser misericordioso com aqueles que se arrependem verdadeiramente: Salva e liberta-nos, das mãos de nossos inimigos, humildemente te rogamos. Abate o orgulho deles, aplaca a malícia deles e confunde seus planos, para que, estando nós armados com a tua defesa, sejamos preservados de todos os perigos, para glorificar a ti, que és o único doador de toda vitória, através dos méritos do teu único Filho, Jesus Cristo nosso Senhor. Amém.", title: "Em tempo de guerra e tumultos.")

create_text('prayer_in_time_of_plague', 'prayer', "Ó Deus Todo-Poderoso, que em tua ira enviaste uma praga sobre teu próprio povo no deserto, por sua rebelião obstinada contra Moisés e Arão; e também, no tempo do rei Davi, fizeste perecer setenta mil pessoas com a praga da pestilência, mas, lembrando de tua misericórdia, salvaste o restante: Tem piedade de nós, miseráveis pecadores, que agora somos afligidos com grande enfermidade e mortalidade, para que assim como aceitaste uma expiação naquela ocasião e ordenaste ao anjo destruidor que cessasse a punição, possa agora agradar-te afastar de nós esta praga e terrível enfermidade, por Jesus Cristo nosso Senhor. Amém.", title: "Em tempo de qualquer praga ou enfermidade generalizada.")

create_text('prayer_ember_weeks_1', 'prayer', "Deus Todo-Poderoso, nosso Pai celestial, que adquiriste para ti a igreja universal pelo precioso sangue do teu amado Filho: Olha misericordiosamente para ela, e neste momento guia e governa as mentes dos teus servos, os bispos e pastores do teu rebanho, para que não imponham as mãos precipitadamente sobre ninguém, mas escolham com fidelidade e sabedoria as pessoas adequadas para servir no sagrado ministério da tua igreja. E aos que serão ordenados para qualquer função sagrada, concede a tua graça e bênção celestial, para que tanto pela sua vida quanto pela sua doutrina, possam manifestar a tua glória e promover a salvação de todos os homens, através de Jesus Cristo nosso Senhor. Amém.", title: "Nas Semanas das Quatro Têmporas")

create_text('prayer_ember_weeks_2', 'prayer', "Deus Todo-Poderoso, o doador de todos os bons dons, que em tua divina providência designaste diversas ordens na tua igreja: Humildemente te rogamos, concede, a tua graça a todos aqueles que são [ou que hoje estão sendo] chamados a algum ofício e administração nela, e assim os preenche com a verdade da tua doutrina e os reveste de inocência de vida, para que possam servir fielmente diante de ti, para a glória do teu grande nome e o benefício da tua santa igreja, por Jesus Cristo nosso Senhor. Amém.", title: "Ou essa")

create_text('prayer_after_any_former', 'prayer', "Ó Deus, cuja natureza e propriedade é sempre ter misericórdia e perdoar: Recebe nossas humildes petições e, embora estejamos amarrados e aprisionados pelos grilhões de nossos pecados, permite que a piedade de tua grande misericórdia nos liberte, para a honra de Jesus Cristo, nosso mediador e advogado. Amém.", title: "Uma Oração que Pode Ser Dita Após Alguma das Anteriores.")

create_text('prayer_for_legislature', 'prayer', "Deus Altíssimo, humildemente te suplicamos, tanto para esta nação em geral como especialmente para o legislativo atualmente reunido (ou especialmente para o Alto Tribunal do Parlamento, sob nosso rei religioso e gracioso atualmente reunido), que tu te agrade dirigir e abençoar todas as suas deliberações, para o avanço de tua glória, o bem de tua igreja, e a segurança, honra e bem- estar deste povo, de modo que todas as coisas sejam ordenadas e estabelecidas por seus esforços, sobre as melhores e mais seguras bases, de forma que a paz e a felicidade, a verdade e a justiça, a religião e a piedade possam ser estabelecidas entre nós por todas as gerações. Estas e todas as outras necessidades, para eles, para nós e para toda a tua igreja, humildemente suplicamos em nome e mediação de Jesus Cristo, nosso Bendito Senhor e Salvador. Amém.", title: "Uma Oração Pela Legislatura (ou pelo Alto Tribunal do Parlamento)")

create_text('prayer_all_conditions', 'prayer', "Ó Deus, Criador e Preservador de toda a humanidade, humildemente te suplicamos por todos os tipos e condições de pessoas; que tu te dignes a fazer conhecidos os teus caminhos para elas, e a tua salvação a todas as nações. Especialmente, oramos pela prosperidade da Igreja Católica; que ela seja guiada e governada pelo teu bom Espírito, para que todos os que professam e se chamam cristãos sejam conduzidos ao caminho da verdade, mantenham a fé em unidade de espírito, na paz e na retidão de vida. Por fim, recomendamos à tua bondade paternal a todos aqueles que estão aflitos ou angustiados de alguma forma em mente, corpo ou outra situação; [*especialmente aqueles por quem nossas orações são desejadas;] que tu possas confortá-los e aliviá-los, de acordo com suas várias necessidades, concedendo-lhes paciência em suas aflições e um final feliz para todas as suas tribulações. E isto te pedimos por amor de Jesus Cristo. Amém.", title: "Uma Coleta ou Oração por Todas as Condições dos Homens")

# Ações de Graças (Pág 42-46)
create_text('general_thanksgiving', 'thanksgiving', "Deus Todo-Poderoso, Pai de todas as misericórdias, nós, teus indignos servos, te oferecemos as mais humildes e sinceras graças por toda a tua bondade e benignidade para conosco e para com todos os homens; [*especialmente àqueles que desejam agora apresentar seus louvores e ações de graças por tuas recentes misericórdias concedidas a eles]. Nós te bendizemos pela nossa criação, preservação e por todas as bênçãos desta vida; mas acima de tudo, pelo teu amor inestimável na redenção do mundo através de nosso Senhor Jesus Cristo, pelos meios de graça e pela esperança da glória. Imploramos a ti que nos concedas uma verdadeira percepção de todas as tuas misericórdias, para que nossos corações estejam verdadeiramente agradecidos e que possamos manifestar o teu louvor não apenas com nossos lábios, mas em nossas vidas, entregando-nos ao teu serviço e caminhando diante de ti em santidade e retidão todos os nossos dias; através de Jesus Cristo, nosso Senhor, a quem, contigo e com o Espírito Santo, seja toda honra e glória, agora e para sempre. Amém.", title: "Uma Ação de Graças Geral")

create_text('thanksgiving_for_rain', 'thanksgiving', "Ó Deus, nosso Pai celestial, que por tua graciosa providência fazes descer a chuva da primavera e do outono sobre a terra, para que ela possa dar frutos para o uso do homem: Te damos humildes agradecimentos por teres tido a bondade de enviar-nos finalmente uma alegre chuva em nossa grande necessidade, e de refrescar a terra quando ela estava seca, para grande conforto de nós, teus servos indignos, e para a glória do teu santo Nome; através de tuas misericórdias em Jesus Cristo nosso Senhor. Amém.", title: "Para Chuva.")

create_text('thanksgiving_for_fair_weather', 'thanksgiving', "Ó Senhor Deus, que justamente nos humilhaste pela tua recente praga de chuvas e águas imoderadas, e em tua misericórdia aliviaste e confortaste nossas almas com essa mudança de tempo oportuna e abençoada: Nós te louvamos e glorificamos teu santo Nome por essa tua misericórdia, e sempre declararemos o teu amor de geração em geração; através de Cristo Jesus nosso Senhor. Amém.", title: "Para Tempo Bom.")

create_text('thanksgiving_for_plenty', 'thanksgiving', "Ó Pai misericordioso, que em tua graciosa bondade ouviste as orações fervorosas de tua Igreja, e transformaste nossa escassez em abundância: Te damos humildes agradecimentos por essa tua especial generosidade; rogando-te que continues a tua bondade para conosco, para que nossa terra possa produzir frutos em abundância, para tua glória e nosso conforto; através de Jesus Cristo nosso Senhor. Amém.", title: "Para Abundância.")

create_text('thanksgiving_for_peace', 'thanksgiving', "Ó Deus Todo-Poderoso, que és uma forte torre de defesa para teus servos diante de seus inimigos: Te oferecemos louvor e agradecimento por nossa libertação desses grandes e evidentes perigos que nos cercaram: Reconhecemos que através da tua bondade que não fomos entregues a eles como presa; pedindo-te ainda que continues a conceder tais misericórdias a nós, para que todo o mundo saiba que tu és nosso Salvador e poderoso Libertador; através de Jesus Cristo nosso Senhor. Amém.", title: "Para Paz e Libertação de Nossos Inimigos.")

create_text('thanksgiving_for_public_peace', 'thanksgiving', "Ó Deus Eterno, nosso Pai celestial, o único que faz com que os homens tenham a mesma mente em uma casa e acalma a violência de um povo rebelde e indisciplinado: Bendizemos teu santo Nome por ter agradado a ti acalmar as turbulências sediciosas que surgiram entre nós: Humildemente te suplicamos que concedas a todos nós graça, para que de agora em diante caminhemos obedientemente em teus santos mandamentos; e levando uma vida quieta e pacífica, em toda piedade e honestidade, para que possamos continuamente oferecer a ti nosso sacrifício de louvor e agradecimento por essas tuas misericórdias para conosco; através de Jesus Cristo nosso Senhor. Amém.", title: "Para Restauração da Paz Pública em Nosso País.")

create_text('thanksgiving_for_deliverance_plague_1', 'thanksgiving', "Ó Senhor Deus, que nos feriste por nossos pecados e nos consumiste por nossas transgressões, através de tua recente e pesada visita; e agora, no meio do julgamento, lembrando de tua misericórdia, resgataste nossas almas das garras da morte: Nós oferecemos à tua bondade paternal, nossas almas e corpos, que entregaste, para sermos um sacrifício vivo a ti, sempre louvando e magnificando tuas misericórdias no meio de tua Igreja; por Jesus Cristo nosso Senhor. Amém.", title: "Para Libertação da Peste ou Outras Enfermidades Comuns.")

create_text('thanksgiving_for_deliverance_plague_2', 'thanksgiving', "Nós humildemente reconhecemos perante ti, ó Pai misericordioso, que todas as punições que são ameaçadas em tua lei poderiam justamente ter recaído sobre nós, por causa de nossas muitas transgressões e dureza de coração: No entanto, vendo que foi do teu terno amor, através de nossa fraca e indigna humilhação, que acalmaste a doença contagiosa com a qual fomos gravemente afligidos recentemente, e restauraste a voz de alegria e saúde em nossas moradas: Oferecemos à tua Majestade Divina o sacrifício de louvor e agradecimento, louvando e magnificando o teu glorioso Nome por tal preservação e providência sobre nós; através de Jesus Cristo nosso Senhor. Amém.", title: "Ou essa")

create_text('collects_for_king_1', 'prayer', "Deus Todo-Poderoso, cujo reino é eterno e o poder é infinito: Tem misericórdia de toda a igreja, e dirige o coração do teu escolhido servo CHARLES III, nosso Rei e Governante, para que ele, sabendo de quem é ministro, busque acima de tudo a tua honra e glória; e para que nós e todos os seus súditos, considerando devidamente a autoridade que ele possui, possamos servi-lo, honrá-lo e obedecê-lo humildemente, de acordo com a tua bendita palavra e ordenança, através de Jesus Cristo nosso Senhor, que contigo e com o Espírito Santo vive e reina, um só Deus, por toda a eternidade. Amém.", title: "Coletas para o Rei.")

create_text('collects_for_king_2', 'prayer', "Deus Todo-Poderoso e eterno, somos ensinados pela tua santa palavra que os corações dos reis estão sob a tua regra e governo, e que tu os dispões e os diriges como melhor parecer à tua sábia vontade: Humildemente te rogamos que assim disponhas e governe o coração do CHARLES III, teu servo, nosso Rei e Governante, que em todos os seus pensamentos, palavras e obras, ele possa sempre buscar a tua honra e glória, e se esforçar para preservar o teu povo confiado à sua responsabilidade, em prosperidade, paz e piedade. Concede isto, ó Pai misericordioso, pelo amor do teu querido Filho, Jesus Cristo nosso Senhor. Amém.")

create_text('prayer_for_king', 'prayer', "Ó Senhor, nosso Pai celestial, o supremo e poderoso Rei dos reis, Senhor dos senhores, o único governante dos príncipes, que do teu trono contempla todos os habitantes da terra: Pedimos humildemente que, com o teu favor, contemples o nosso muito gracioso Soberano Senhor, o rei CHARLES III ; e que o enchas abundantemente com a graça do teu Espírito Santo, para que sempre se incline à tua vontade e siga o teu caminho. Concede-lhe abundantemente dons celestiais; dá-lhe longa vida com saúde e prosperidade; fortalece-o para que possa vencer e superar todos os seus inimigos; e, finalmente, após esta vida, possa alcançar alegria e felicidade eterna, por Cristo Jesus nosso Senhor. Amém.", title: "Uma Oração pelo Rei.")

create_text('prayer_for_royal_family', 'prayer', "Deus Todo-Poderoso, fonte de toda bondade, rogamos humildemente que abençoes a Rainha Camilla, William Príncipe de Gales, a Princesa de Gales e toda a família real: Enche-os com o teu Espírito Santo, enriquece-os com a tua graça celestial, prospera-os com toda a felicidade e conduze-os ao teu reino eterno, através de Cristo Jesus nosso Senhor. Amém.", title: "Uma Oração pela Família Real.")
