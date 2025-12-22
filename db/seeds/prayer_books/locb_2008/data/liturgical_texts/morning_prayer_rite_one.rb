Rails.logger.info "📿 Carregando textos Ofício Matutino 1 (LOCB 2008)..."

prayer_book = PrayerBook.find_by!(code: 'locb_2008')

# ==============================================================================
# ORAÇÃO MATUTINA I
# ==============================================================================

# Preparação - Saudação
LiturgicalText.find_or_create_by!(slug: 'morning_1_preparation_1_greeting_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Graça, misericórdia e Paz de Deus, nosso Pai e de Jesus Cristo, nosso Salvador, esteja convosco.'
  text.category = 'preparation'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_preparation_1_greeting_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E contigo também'
  text.category = 'preparation'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_preparation_1_opening_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Este é o dia que o Senhor nos fez.'
  text.category = 'preparation'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_preparation_1_opening_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Alegremo-nos e regozijemo-nos nele.'
  text.category = 'preparation'
end

# Preparação - Alternativa "Ou"
LiturgicalText.find_or_create_by!(slug: 'morning_1_preparation_2_greeting_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Senhor, abre meus lábios'
  text.category = 'preparation'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_preparation_2_greeting_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E proclamarei os teus louvores.'
  text.category = 'preparation'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_preparation_2_opening_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Dá-me a alegria da tua salvação.'
  text.category = 'preparation'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_preparation_2_opening_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E sustenta em mim um espírito inabalável.'
  text.category = 'preparation'
end

# Acolhida
LiturgicalText.find_or_create_by!(slug: 'morning_1_welcome_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Acolhida'
  text.content = 'Viemos juntos, em nome de Cristo, para oferecer nosso louvor e ação de graças, para ouvir e aceitar a Palavra de Deus, para orar pelos necessitados do mundo, e para receber o perdão dos nossos pecados. Que pelo poder do Espírito Santo possamos nos entregar ao serviço do Senhor.'
  text.category = 'welcome'
end

# Oração de Confissão
LiturgicalText.find_or_create_by!(slug: 'morning_1_confession_invitation_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Convite à Confissão'
  text.content = 'Jesus disse: "Arrependei-vos pois é chegado o Reino de Deus". Convertamo-nos de nossos pecados a Cristo, confessando-os com fé e certeza de perdão:'
  text.category = 'confession'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_confession_silence', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Silêncio por alguns instantes'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_confession_prayer_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Confissão'
  text.content = 'Senhor Deus, nós temos pecado contra Ti; temos feito muito mal na tua presença. Nós nos arrependemos. Tem misericórdia de nós por teu amor. Lava-nos de nossa culpa e purifica-nos de nossos pecados. Renova em nós um espírito reto e restaura a alegria de tua salvação. Pedimos por Jesus Cristo, nosso Senhor. Amém.'
  text.category = 'confession'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_confession_absolution_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Declaração de Perdão'
  text.content = 'Que o Pai das misericórdias nos purifique de nossos pecados, e restaure em nós a sua imagem para o louvor e glória de seu nome, por Cristo nosso Senhor.'
  text.category = 'confession'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_confession_absolution_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Amém.'
  text.category = 'confession'
end

# Ação de Graças
LiturgicalText.find_or_create_by!(slug: 'morning_1_thanksgiving_blessed_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Bendito seja o Senhor!'
  text.category = 'thanksgiving'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_thanksgiving_blessed_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Louvaremos, sempre o louvaremos.'
  text.category = 'thanksgiving'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_thanksgiving_hearts_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Nossos corações estão cheios de alegria,'
  text.category = 'thanksgiving'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_thanksgiving_hearts_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E nossa alma louva ao nosso Deus.'
  text.category = 'thanksgiving'
end

# Oração de Ação de Graças (opcional)
LiturgicalText.find_or_create_by!(slug: 'morning_1_thanksgiving_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Oração de Ação de Graças'
  text.content = 'Pode ser omitida à descrição do Ministro'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_thanksgiving_prayer_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Bendito sejas, Senhor nosso Deus, Criador e Redentor de todos e de tudo; a Ti seja o louvor e a glória para sempre. Do nada criastes o Universo e por teu amor nos criaste à Tua imagem e semelhança. Agora, através do vale da sombra da morte, tens conduzido teu povo ao Novo Nascimento para através de teu Filho viver em triunfo. Possa Cristo sempre iluminar o nosso coração a fim de sempre oferecermos sacrifícios de louvor e ações de graça. Bendito seja Deus, Pai, Filho e Espírito Santo:'
  text.category = 'thanksgiving_prayer'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_thanksgiving_prayer_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Bendito seja Deus para sempre.'
  text.category = 'thanksgiving_prayer'
end

# Breve Reflexão
LiturgicalText.find_or_create_by!(slug: 'morning_1_reflection_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Breve Reflexão'
  text.content = 'A noite já passou, e o dia já raiou; oremos numa só mente e coração.'
  text.category = 'reflection'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_reflection_silence', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Silêncio por alguns instantes'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_reflection_prayer_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Enquanto nos alegramos pelo dom deste novo dia, que a Luz da tua presença, ó Deus, aumente em nós o fogo do amor divino, agora e para todo o sempre.'
  text.category = 'reflection'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_reflection_prayer_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Amém.'
  text.category = 'reflection'
end

# A Palavra de Deus - Salmodia
LiturgicalText.find_or_create_by!(slug: 'morning_1_psalms_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Salmodia'
  text.content = 'Cada Salmo ou grupo de Salmos deve terminar com a Doxologia que segue. Para os Ofícios diários, os Salmos são indicados no Lecionário, pp.347 a 358:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_psalms_gloria_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Gloria Patri'
  text.content = 'Glória ao Pai, ao Filho e ao Espírito Santo.'
  text.category = 'psalms'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_psalms_gloria_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'psalms'
end

# Rubricas de tempos litúrgicos
# Advento
LiturgicalText.find_or_create_by!(slug: 'morning_1_ot_canticle_advent', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Advento'
  text.content = 'Isaías 35:1-10

    O deserto e a terra se alegrarão; o ermo exultará e florescerá como o narciso.
    **Florescerá abundantemente, jubilará de alegria e exultará; deu-se-lhes a glória do Líbano, o esplendor do Carmelo e de Sarom; eles verão a glória do Senhor, o esplendor do nosso Deus.**
    Fortalecei as mãos frouxas e firmai os joelhos vacilantes.
    **Dizei aos desalentados de coração: Sede fortes, não temais. Eis o vosso Deus. A vingança vem, a retribuição de Deus; ele vem e vos salvará.**
    Então, se abrirão os olhos dos cegos, e se desimpedirão os ouvidos dos surdos;
    **os coxos saltarão como cervos, e a língua dos mudos cantará; pois águas arrebentarão no deserto, e ribeiros, no ermo.**
    A areia esbraseada se transformará em lagos, e a terra sedenta, em mananciais de águas; onde outrora viviam os chacais, crescerá a erva com canas e juncos.
    **E ali haverá bom caminho, caminho que se chamará o Caminho Santo; o imundo não passará por ele, pois será somente para o seu povo; quem quer que por ele caminhe não errará, nem mesmo o louco.**
    Ali não haverá leão, animal feroz não passará por ele, nem se achará nele; mas os remidos andarão por ele.
    **Os resgatados do Senhor voltarão e virão a Sião com cânticos de júbilo; alegria eterna coroará a sua cabeça; gozo e alegria alcançarão, e deles fugirá a tristeza e o gemido.**'
  text.category = 'canticle'
end

# Natal
LiturgicalText.find_or_create_by!(slug: 'morning_1_ot_canticle_christmas', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Natal'
  text.content = 'Isaías 9:2-7

    O povo que andava em trevas viu grande luz, e aos que viviam na região da sombra da morte, resplandeceu-lhes a luz.
    **Tens multiplicado este povo, a alegria lhe aumentaste; alegram-se eles diante de ti, como se alegram na ceifa e como exultam quando repartem os despojos.**
    Porque tu quebraste o jugo que pesava sobre eles, a vara que lhes feria os ombros e o cetro do seu opressor, como no dia dos midianitas;
    **porque toda bota com que anda o guerreiro no tumulto da batalha e toda veste revolvida em sangue serão queimadas, servirão de pasto ao fogo.**
    Porque um menino nos nasceu, um filho se nos deu; o governo está sobre os seus ombros; e o seu nome será: Maravilhoso Conselheiro, Deus Forte, Pai da Eternidade, Príncipe da Paz;
    **para que se aumente o seu governo, e venha paz sem fim sobre o trono de Davi e sobre o seu reino, para o estabelecer e o firmar mediante o juízo e a justiça, desde agora e para sempre. O zelo do Senhor dos Exércitos fará isto.**'
  text.category = 'canticle'
end

# Epifania
LiturgicalText.find_or_create_by!(slug: 'morning_1_ot_canticle_epiphany', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Epifania'
  text.content = 'Isaías 60:1-22

    Dispõe-te, resplandece, porque vem a tua luz, e a glória do Senhor nasce sobre ti.
    **Porque eis que as trevas cobrem a terra, e a escuridão, os povos; mas sobre ti aparece resplendente o Senhor, e a sua glória se vê sobre ti.**
    As nações se encaminham para a tua luz, e os reis, para o resplendor que te nasceu.
    **Levanta em redor os olhos e vê; todos estes se ajuntam e vêm ter contigo; teus filhos chegam de longe, e tuas filhas são trazidas nos braços.**
    Então, o verás e serás radiante de alegria; o teu coração estremecerá e se dilatará de júbilo, porque a abundância do mar se tornará a ti, e as riquezas das nações virão a ter contigo.
    **A multidão de camelos te cobrirá, os dromedários de Midiã e de Efa; todos virão de Sabá; trarão ouro e incenso e publicarão os louvores do Senhor.**
    Todas as ovelhas de Quedar se reunirão junto de ti; servir-te-ão os carneiros de Nebaiote; para o meu agrado subirão ao meu altar, e eu tornarei mais gloriosa a casa da minha glória.
    **Quem são estes que vêm voando como nuvens e como pombas, ao seu pombal?**
    Certamente, as terras do mar me aguardarão; virão primeiro os navios de Társis para trazerem teus filhos de longe e, com eles, a sua prata e o seu ouro, para a santificação do nome do Senhor, teu Deus, e do Santo de Israel, porque ele te glorificou.
    **Estrangeiros edificarão os teus muros, e os seus reis te servirão; porque no meu furor te castiguei, mas na minha graça tive misericórdia de ti.**
    As tuas portas estarão abertas de contínuo; nem de dia nem de noite se fecharão, para que te sejam trazidas riquezas das nações, e, conduzidos com elas, os seus reis.
    **Porque a nação e o reino que não te servirem perecerão; sim, essas nações serão de todo assoladas.**
    A glória do Líbano virá a ti; o cipreste, o olmeiro e o buxo, conjuntamente, para adornarem o lugar do meu santuário; e farei glorioso o lugar dos meus pés.
    **Também virão a ti, inclinando-se, os filhos dos que te oprimiram; prostrar-se-ão até às plantas dos teus pés todos os que te desdenharam e chamar-te-ão Cidade do Senhor, a Sião do Santo de Israel.**
    De abandonada e odiada que eras, de modo que ninguém passava por ti, eu te constituirei glória eterna, regozijo, de geração em geração.
    **Mamarás o leite das nações e te alimentarás ao peito dos reis; saberás que eu sou o Senhor, o teu Salvador, o teu Redentor, o poderoso de Jacó.**
    Por bronze trarei ouro, por ferro trarei prata, por madeira, bronze e por pedras, ferro; farei da paz os teus inspetores e da justiça, os teus exatores.
    **Nunca mais se ouvirá de violência na tua terra, de desolação ou ruínas, nos teus limites; mas aos teus muros chamarás Salvação, e às tuas portas, louvor.**
    Nunca mais te servirá o sol para luz do dia, nem com o seu resplendor a lua te alumiará; mas o Senhor será a tua luz perpétua, e o teu Deus, a tua glória.
    **Nunca mais se porá o teu sol, nem a tua lua minguará, porque o Senhor será a tua luz perpétua, e os dias do teu luto findarão.**
    Todos os do teu povo serão justos, para sempre herdarão a terra; serão renovos por mim plantados, obra das minhas mãos, para que eu seja glorificado.
    **O menor virá a ser mil, e o mínimo, uma nação forte; eu, o Senhor, a seu tempo farei isso prontamente.**'
  text.category = 'canticle'
end

# Quaresma
LiturgicalText.find_or_create_by!(slug: 'morning_1_ot_canticle_lent', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Quaresma'
  text.content = 'Oséias 6:1-6

    Vinde, e tornemos para o Senhor, porque ele nos despedaçou e nos sarará; fez a ferida e a ligará.
    **Depois de dois dias, nos revigorará; ao terceiro dia, nos levantará, e viveremos diante dele.**
    Conheçamos e prossigamos em conhecer ao Senhor; como a alva, a sua vinda é certa; e ele descerá sobre nós como a chuva, como chuva serôdia que rega a terra.
    **Que te farei, ó Efraim? Que te farei, ó Judá? Porque o vosso amor é como a nuvem da manhã e como o orvalho da madrugada, que cedo passa.**
    Por isso, os abati por meio dos profetas; pela palavra da minha boca, os matei; e os meus juízos sairão como a luz.
    **Pois misericórdia quero, e não sacrifício, e o conhecimento de Deus, mais do que holocaustos.**'
  text.category = 'canticle'
end

# Páscoa
LiturgicalText.find_or_create_by!(slug: 'morning_1_ot_canticle_easter', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Páscoa'
  text.content = 'Êxodo 15:1b-3,6,10,13,17,18

    Cantarei ao Senhor, porque triunfou gloriosamente; lançou no mar o cavalo e o seu cavaleiro.
    **O Senhor é a minha força e o meu cântico; ele me foi por salvação; este é o meu Deus; portanto, eu o louvarei; ele é o Deus de meu pai; por isso, o exaltarei.**
    O Senhor é homem de guerra; Senhor é o seu nome.
    **A tua destra, ó Senhor, é gloriosa em poder; a tua destra, ó Senhor, despedaça o inimigo.**
    Sopraste com o teu vento, e o mar os cobriu; afundaram-se como chumbo em águas impetuosas.
    **Com a tua beneficência guiaste o povo que salvaste; com a tua força o levaste à habitação da tua santidade.**
    Tu o introduzirás e o plantarás no monte da tua herança, no lugar que aparelhaste, ó Senhor, para a tua habitação, no santuário, ó Senhor, que as tuas mãos estabeleceram.
    **O Senhor reinará por todo o sempre.**'
  text.category = 'canticle'
end

# Pentecostes
LiturgicalText.find_or_create_by!(slug: 'morning_1_ot_canticle_pentecost', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Pentecostes'
  text.content = 'Ezequiel 36:24-29

    Tomar-vos-ei de entre as nações, e vos congregarei de todos os países, e vos trarei para a vossa terra.
    **Então, aspergirei água pura sobre vós, e ficareis purificados; de todas as vossas imundícias e de todos os vossos ídolos vos purificarei**.
    Dar-vos-ei coração novo e porei dentro de vós espírito novo; tirarei de vós o coração de pedra e vos darei coração de carne.
    **Porei dentro de vós o meu Espírito e farei que andeis nos meus estatutos, guardeis os meus juízos e os observeis.**
    Habitareis na terra que eu dei a vossos pais; vós sereis o meu povo, e eu serei o vosso Deus.
    **Livrar-vos-ei de todas as vossas imundícias; farei vir o trigo, e o multiplicarei, e não trarei fome sobre vós.**'
  text.category = 'canticle'
end

# Tempo Comum
LiturgicalText.find_or_create_by!(slug: 'morning_1_ot_canticle_ordinary', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Tempo Comum'
  text.content = '1 Crônicas 29:10b-13,14b, 20b

    Bendito és tu, Senhor, Deus de Israel, nosso pai, de eternidade em eternidade.
    **Teu, Senhor, é o poder, a grandeza, a honra, a vitória e a majestade; porque teu é tudo quanto há nos céus e na terra; teu, Senhor, é o reino, e tu te exaltaste por chefe sobre todos.**
    Riquezas e glória vêm de ti, tu dominas sobre tudo, na tua mão há força e poder; contigo está o engrandecer e a tudo dar força.
    **Agora, pois, ó nosso Deus, graças te damos e louvamos o teu glorioso nome.**
    Porque tudo vem de ti, e das tuas mãos to damos.
    **Agora, louvai o Senhor, vosso Deus.**'
  text.category = 'canticle'
end

# Leituras das Escrituras
LiturgicalText.find_or_create_by!(slug: 'morning_1_readings_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Uma ou mais leituras do dia (ver Lecionário, pp.347 a 358)
O leitor pode dizer:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_readings_response_reader', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Esta é a Palavra do Senhor.'
  text.category = 'readings'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_readings_response_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Graças a Deus.'
  text.category = 'readings'
end

# Responso
LiturgicalText.find_or_create_by!(slug: 'morning_1_response_awake_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Responso'
  text.content = 'Desperta, tu que dormes, levanta-te dentre os mortos.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_response_awake_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E Cristo te esclarecerá.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_response_dead_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Tu estás morto e tua vida está oculta com Cristo em Deus.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_response_dead_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Desperta, tu que dormes, e levanta-te dentre os mortos.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_response_above_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Pense nas coisas lá de cima, e não nas que são da terra.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_response_above_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E Cristo te esclarecerá.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_response_manifest_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Quando Cristo, a nossa vida se manifestar, então seremos semelhantes a Ele.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_response_manifest_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Desperta, tu que dormes, levanta-te dentre os mortos e Cristo te esclarecerá.'
  text.category = 'response'
end

# Cântico Evangélico - Benedictus
LiturgicalText.find_or_create_by!(slug: 'morning_1_benedictus_title', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'O Benedictus (Cântico de Zacarias) - Lucas 1:68-79'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_benedictus', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Benedictus'
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
  **para alumiar os que jazem nas trevas e na sombra da morte, e dirigir os nossos pés pelo caminho da paz.**'
  text.category = 'benedictus'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_benedictus_gloria', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Gloria seja...'
  text.category = 'rubric'
end

# O Credo
LiturgicalText.find_or_create_by!(slug: 'morning_1_creed_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'O Credo'
  text.content = '(ou outra Afirmação de Fé na p.612)'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_creed_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Credo dos Apóstolos'
  text.content = 'Creio em Deus Pai Todo-poderoso, Criador do céu e da terra; e em Jesus Cristo seu único Filho, nosso Senhor: o qual foi concebido por obra do Espírito Santo, nasceu da Virgem Maria; padeceu sob o poder de Pôncio Pilatos, foi crucificado, morto e sepultado; desceu ao Hades; ressuscitou ao terceiro dia; subiu ao céu, e está sentado à mão direita de Deus Pai Todo-poderoso: donde há de vir a julgar os vivos e os mortos. Creio no Espírito Santo; na santa Igreja Católica; na comunhão dos santos; na remissão dos pecados; na ressurreição do corpo; e na Vida Eterna. Amém.'
  text.category = 'creed'
end

# A Coleta do Dia
LiturgicalText.find_or_create_by!(slug: 'morning_1_collect_rubric', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'A Coleta do Dia'
  text.content = '(no Próprio do tempo, ver Lecionário pp.347 a 358)'
  text.category = 'rubric'
end

# Conclusão - A Bênção
LiturgicalText.find_or_create_by!(slug: 'morning_1_conclusion_blessing_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Conclusão - A Bênção'
  text.content = 'O Senhor nos abençoe, guarde de todo mal e nos conduza à vida eterna.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_conclusion_blessing_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Amém.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_conclusion_blessing_praise_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Louvemos ao Senhor.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_conclusion_blessing_praise_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Agradeçamos sempre a Deus.'
  text.category = 'conclusion'
end

# Conclusão - A Graça (opção 2)
LiturgicalText.find_or_create_by!(slug: 'morning_1_conclusion_grace_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Conclusão - A Graça'
  text.content = 'A graça de nosso Senhor Jesus Cristo, o amor de Deus e as consolações do Espírito Santo seja com todos nós.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_conclusion_grace_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Amém.'
  text.category = 'conclusion'
end

# Conclusão - A Paz (opção 3)
LiturgicalText.find_or_create_by!(slug: 'morning_1_conclusion_peace_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Conclusão - A Paz'
  text.content = 'Que a paz de Deus que excede toda a compreensão humana guarde os nossos corações e mentes no conhecimento e na graça de nosso Senhor Jesus Cristo.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_conclusion_peace_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Amém.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_conclusion_peace_exchange_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'A paz de Cristo seja com todos vós.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_conclusion_peace_exchange_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'E contigo também.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_conclusion_peace_exchange_minister_2', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Vamos nos oferecer uns aos outros, Deus confirmará as nossas preces.'
  text.category = 'conclusion'
end

# Conclusão - Dismissal (opção 4)
LiturgicalText.find_or_create_by!(slug: 'morning_1_conclusion_dismissal_minister', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.title = 'Conclusão - Dismissal'
  text.content = 'Ide na paz de Cristo! Sede corajosos e fortes no testemunho do Evangelho entre todas as pessoas. Servi ao Senhor com a alegria.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_conclusion_dismissal_people', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'No poder do Espírito Santo.'
  text.category = 'conclusion'
end

LiturgicalText.find_or_create_by!(slug: 'morning_1_conclusion_dismissal_all', prayer_book_id: prayer_book.id) do |text|
  text.language = 'pt-BR'
  text.content = 'Aleluia!'
  text.category = 'conclusion'
end

puts 'LOCB 2008 Morning Prayer I liturgical texts created successfully!'
