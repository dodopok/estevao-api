# ================================================================================
# COLETAS DO ANO LITÚRGICO
# Baseado no Livro de Oração Comum da IEAB - LOC 2015
# ================================================================================

puts "📿 Carregando coletas do ano litúrgico (LOC 2015 IEAB)..."

# Buscar o prayer book
prayer_book = PrayerBook.find_by!(code: 'loc_2015')

# Helper para criar coletas
def create_collect(attrs, prayer_book_id)
  # Remove o campo alternative se existir e cria uma coleta separada
  alternative_text = attrs.delete(:alternative)

  # Pula se não tem nenhuma referência válida
  if attrs[:celebration_id].nil? && attrs[:season_id].nil? && attrs[:sunday_reference].nil?
    puts "⚠️  Coleta sem referência válida - pulando"
    puts attrs
    return false
  end

  # Adiciona prayer_book_id
  attrs[:prayer_book_id] = prayer_book_id

  # Cria a coleta principal
  Collect.create!(attrs)

  # Se houver alternativa, cria outra coleta com o texto alternativo
  if alternative_text.present?
    alternative_attrs = attrs.dup
    alternative_attrs[:text] = alternative_text
    Collect.create!(alternative_attrs)
  end

  true
end

count = 0
skipped = 0

# Buscar celebrações que serão usadas
epifania = Celebration.find_by("name LIKE ?", "%Epifania%") || Celebration.find_by(fixed_month: 1, fixed_day: 6)
cinzas = Celebration.find_by("name LIKE ?", "%Cinzas%")
segunda_santa = Celebration.find_by("name LIKE ?", "%Segunda-feira Santa%")
terca_santa = Celebration.find_by("name LIKE ?", "%Terça-feira Santa%")
quarta_santa = Celebration.find_by("name LIKE ?", "%Quarta-feira Santa%")
quinta_santa = Celebration.find_by("name LIKE ?", "%Quinta-Feira Santa%")
sexta_paixao = Celebration.find_by("name LIKE ?", "%Sexta-Feira%Paixão%")
sabado_santo = Celebration.find_by("name LIKE ?", "%Sábado Santo%")
vigilia_pascal = Celebration.find_by("name LIKE ?", "%Vigília Pascal%")
pascoa = Celebration.find_by("name LIKE ?", "Páscoa") || Celebration.find_by(calculation_rule: "easter")
ascensao = Celebration.find_by("name LIKE ?", "%Ascensão%")
pentecostes = Celebration.find_by("name LIKE ?", "%Pentecostes%")
trindade = Celebration.find_by("name LIKE ?", "%Trindade%")
transfiguracao = Celebration.find_by("name LIKE ?", "%Transfiguração%")

# ================================================================================
# COLETAS POR ESTAÇÃO LITÚRGICA (season_id)
# ================================================================================

# --------------------------------------------------------------------------------
# ADVENTO (4 coletas)
# --------------------------------------------------------------------------------

advent = LiturgicalSeason.find_by(name: "Advento")
advent_collects = [
  {
    sunday_reference: "1st_sunday_of_advent",
    text: "Deus Onipotente, dá-nos a graça de rejeitar as obras das trevas e vestir-nos das armas da luz, durante esta vida mortal, em que teu Filho Jesus Cristo, com grande humildade, veio visitar-nos; a fim de que, no último dia, quando ele vier em sua gloriosa majestade, para julgar os vivos e os mortos, ressuscitemos para a vida imortal, mediante Jesus Cristo, que vive e reina contigo e com o Espírito Santo, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "2nd_sunday_of_advent",
    text: "Deus Misericordioso, que enviaste teus mensageiros, os profetas, para pregar o arrependimento e preparar o caminho da nossa salvação; concede-nos a graça, para ouvirmos suas advertências e para abandonarmos os nossos pecados, a fim de saudarmos com alegria a vinda de Jesus Cristo, nosso Redentor, o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "3rd_sunday_of_advent",
    text: "Senhor Jesus Cristo que, na tua primeira vinda, enviaste o precursor para preparar o teu caminho, concede à tua Igreja a graça e o poder para converter muitos ao caminho da justiça, a fim de que, na tua segunda vinda em glória, encontres um povo agradável aos teus olhos, ó Tu, que vives e reinas com o Pai e o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "4th_sunday_of_advent",
    text: "Ó Deus Onipotente, purifica a nossa consciência com tua visitação diária, para que o teu Filho Jesus Cristo, na sua vinda em glória, encontre em nós a morada preparada para Si; o qual vive e reina contigo, na unidade do Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  }
]

advent_collects.each do |collect|
  if create_collect(collect.merge(season_id: advent&.id), prayer_book.id)
    count += 1
  else
    skipped += 1
  end
end

# ================================================================================
# COLETAS POR DOMINGO/REFERÊNCIA TEMPORAL (sunday_reference)
# Organizadas em ordem do Ano Litúrgico
# ================================================================================

# --------------------------------------------------------------------------------
# NATAL E EPIFANIA
# --------------------------------------------------------------------------------

christmas_epiphany_collects = [
  {
    sunday_reference: "1st_sunday_after_christmas",
    text: "Onipotente Deus, que derramaste sobre nós a nova luz do teu Verbo feito carne; concede que essa mesma luz, acesa em nossos corações, brilhe em nossas vidas; por Jesus Cristo, nosso Senhor, que vive e reina contigo, na unidade do Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "2nd_sunday_after_christmas",
    text: "Ó Deus, que maravilhosamente criaste e ainda mais maravilhosamente restauraste a dignidade da natureza humana; concede que participemos da vida divinal de teu Filho Jesus Cristo, que se humilhou para participar de nossa humanidade, o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "1st_sunday_of_epiphany",
    text: "Ó Pai Celestial, que, no Batismo de Jesus, no Jordão, o proclamaste teu amado Filho e o ungiste com o Espírito Santo; concede que todos os batizados em seu nome guardem constantes a aliança que estabeleceste e, com ousadia, o confessem Senhor e Salvador, o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "2nd_sunday_of_epiphany",
    text: "Deus Onipotente, cujo Filho, nosso Salvador Jesus Cristo, é a luz do mundo; concede que o teu povo, iluminado e fortalecido pela tua Palavra e Sacramentos, brilhe com o resplendor da glória de Cristo, para que Ele seja conhecido, adorado e obedecido até os confins da terra; mediante Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "3rd_sunday_of_epiphany",
    text: "Concede-nos a graça, ó Senhor, para responder prontamente ao chamado de nosso Senhor Jesus Cristo e proclamar a todos os povos as Boas Novas da sua salvação, para que nós e o mundo todo contemplemos a glória das suas maravilhosas obras; o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "4th_sunday_of_epiphany",
    text: "Onipotente e sempiterno Deus que governas todas as coisas no céu e na terra; ouve, misericordioso, as súplicas de teu povo, e concede-nos tua paz todos os dias de nossa vida; mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "5th_sunday_of_epiphany",
    text: "Liberta-nos, ó Deus, da escravidão de nossos pecados e concede-nos a liberdade daquela vida abundante que nos fizeste conhecer em teu Filho Jesus Cristo, nosso Salvador, o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "6th_sunday_of_epiphany",
    text: "Ó Deus, fortaleza dos que em Ti confiam; misericordioso aceita nossas orações; e porquanto sem ti nada pode a fraqueza humana, concede-nos o auxílio de tua graça, para que, na prática de teus preceitos, te agrademos com a vontade e com as obras; mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "7th_sunday_of_epiphany",
    text: "Ó Senhor, que nos ensinaste que todas as nossas ações sem amor, de nada valem; envia-nos o teu Santo Espírito e derrama em nossos corações o excelente dom da caridade, que é o verdadeiro vínculo da paz e de todas as virtudes, pois os que sem ela vivem, são considerados mortos aos teus olhos; concede-nos essa graça, mediante o teu único Filho Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "8th_sunday_of_epiphany",
    text: "Ó Amorosíssimo Pai, que desejas nos mostremos agradecidos e lancemos os nossos cuidados sobre ti, que zelas por nós, nada temendo senão a perda de tua presença; preserva-nos de infundados receios e ansiedades mundanas, e não permitas que nuvem alguma da vida terrenal esconda de nós a luz de teu eterno amor, que a nós manifestaste na pessoa de teu Filho Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "last_sunday_of_epiphany",
    text: "Ó Deus, que, antes da Paixão de teu unigênito Filho, revelaste a sua glória sobre o monte, na Transfiguração; concede que nós, contemplando pela fé o resplendor de sua face, sejamos fortalecidos para carregar a nossa cruz e transformados na sua semelhança de glória em glória; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  }
]

christmas_epiphany_collects.each do |collect|
  if create_collect(collect, prayer_book.id)
    count += 1
  else
    skipped += 1
  end
end

# --------------------------------------------------------------------------------
# QUARESMA (7 coletas)
# --------------------------------------------------------------------------------

lent_collects = [
  {
    sunday_reference: "1st_sunday_in_lent",
    text: "Onipotente Deus, cujo bendito Filho foi conduzido pelo Espírito para ser tentado pelo demônio, apressa-te em socorrer a nós, que somos assaltados por muitas tentações, nós te rogamos. E, assim como conheces as fraquezas de cada um de nós, permite que cada qual encontre em ti o poder de salvação. Por Jesus Cristo teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "2nd_sunday_in_lent",
    text: "Ó Deus, cuja glória é sempre ser misericordioso, sê benigno para com todos os que se afastaram dos teus caminhos, conduze-os de novo a ti, com corações penitentes e viva fé, para que se firmem na verdade imutável da tua Palavra, Jesus Cristo, teu Filho, que, contigo e com o Espírito Santo, vive e reina, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "3rd_sunday_in_lent",
    text: "Ó Deus, que sabes quão frágeis somos, guarda-nos a nós, teus servos, defendendo exteriormente nossos corpos de toda a adversidade e purificando interiormente nossas almas de todo mau pensamento; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "4th_sunday_in_lent",
    text: "Bendito Pai, cujo Filho Jesus Cristo desceu do céu para ser o verdadeiro Pão que vivifica o mundo; concede-nos sempre esse Pão, para que Ele viva em nós e nós nele, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "5th_sunday_in_lent",
    text: "Onipotente Deus, Tu somente podes colocar em ordem a vontade e as afeições desordenadas dos pecadores. Concede ao teu povo a graça de amar o que ordenas e desejar o que prometes; para que, entre as inconstâncias do mundo, permaneçam nossos corações firmados lá onde se acha a verdadeira alegria, por nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "palm_sunday",
    text: "Onipotente e Eterno Deus, de tal modo amaste o mundo, que enviaste teu Filho, nosso Salvador Jesus Cristo, para tomar sobre si a nossa carne e sofrer morte na cruz, dando ao gênero humano exemplo de sua profunda humildade; concede, em tua misericórdia, que imitemos a sua paciência no sofrimento e possamos participar também de sua ressurreição; mediante o mesmo Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  }
]

lent_collects.each do |collect|
  if create_collect(collect, prayer_book.id)
    count += 1
  else
    skipped += 1
  end
end

# --------------------------------------------------------------------------------
# PÁSCOA (8 coletas)
# --------------------------------------------------------------------------------

easter_collects = [
  {
    sunday_reference: "2nd_sunday_of_easter",
    text: "Pai celestial, libertaste-nos do poder do pecado e trouxeste-nos para o reino de teu Filho; concede que Aquele cuja morte nos restaurou à vida, pela sua presença entre nós, nos erga até às alegrias eternas. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "3rd_sunday_of_easter",
    text: "Senhor de misericórdia, teu Filho é a ressurreição e a vida de todos os que n'Ele creem; ergue-nos da morte do pecado, para a vida da retidão. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "4th_sunday_of_easter",
    text: "Ó Deus, cujo Filho Jesus é o Bom Pastor do teu povo; concede que, quando ouvirmos sua voz, reconheçamos Aquele que nos chama cada um pelo nome e o sigamos para onde nos conduz; o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "5th_sunday_of_easter",
    text: "Ó Deus Onipotente, a quem verdadeiramente conhecer é a vida eterna; concede-nos que conheçamos perfeitamente que teu Filho Jesus Cristo é o caminho, a verdade e a vida; para que, seguindo seus passos, andemos com perseverança no caminho que conduz à vida eterna; mediante o mesmo teu Filho Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "6th_sunday_of_easter",
    text: "Pai eterno, o teu reino vai além do espaço e do tempo; concede que neste mundo de constantes mutações nos fixemos naquilo que permanece para sempre. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "7th_sunday_of_easter",
    text: "Ó Deus, Rei da glória, que exaltaste o teu único Filho Jesus Cristo com grande triunfo ao teu celeste reino; suplicamos-te que não nos deixes desconsolados, mas nos envies o teu Santo Espírito para nos confortar e conduzir ao alto e santo lugar, onde nosso Senhor Jesus Cristo já nos precedeu, o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  }
]

easter_collects.each do |collect|
  if create_collect(collect, prayer_book.id)
    count += 1
  else
    skipped += 1
  end
end

# --------------------------------------------------------------------------------
# TEMPO COMUM - TRINDADE E PRÓPRIOS (30 coletas: Proper 1-28 + Christ the King)
# --------------------------------------------------------------------------------

trinity_propers_collects = [
  {
    sunday_reference: "proper_1",
    text: "Lembra-te, Senhor, da graça que nos concedeste e não dos nossos merecimentos, e, assim como nos chamaste ao teu serviço, faze-nos dignos de nossa vocação; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "proper_2",
    text: "Onipotente e misericordioso Deus, fortalece-nos em tua misericórdia, em todas as adversidades, para que, tendo a disposição da mente e do corpo, realizemos com corações alegres tudo quanto pertence ao teu propósito. Por nosso Senhor Jesus Cristo que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "proper_3",
    text: "Concede, ó Senhor, que o curso deste mundo seja governado em paz pela tua providência; e que tua Igreja possa servir-te com alegria e confiança; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "proper_4",
    text: "O Deus, cuja infalível providência ordena todas as coisas no céu e na terra, com humildade te imploramos que de nós afastes tudo o que nos possa causar dano e nos outorgues quanto nos seja proveitoso; mediante nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "proper_5",
    text: "Ó Senhor, de quem procede todo o bem, concede que, por tua santa inspiração, cogitemos o que é bom, e por tua orientação misericordiosa o executemos. Mediante nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "proper_6",
    text: "Guarda, ó Senhor, tua Família, a Igreja, firme na fé, para que, pela tua graça, proclame tua verdade com ousadia e ministre a tua justiça com amor. Mediante nosso Salvador Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "proper_7",
    text: "Ó Senhor, faze com que tenhamos amor e reverência constantes, porque nunca deixas de ajudar e governar os que colocaste sobre o fundamento seguro de tua bondade; mediante nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "proper_8",
    text: "Deus Onipotente, que edificaste tua Igreja sobre o fundamento dos Apóstolos e Profetas, sendo Jesus Cristo mesmo a principal pedra angular; concede que sejamos unidos em espírito por meio de seu ensino e feitos um santo templo aceitável a teus olhos; mediante nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "proper_9",
    text: "Ó Deus, ensinaste-nos que amar a Ti e ao nosso próximo é guardar os teus mandamentos; concede-nos a graça do teu Espírito Santo para que sejamos consagrados a ti com todo o nosso coração e unidos uns aos outros com pura afeição; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "proper_10",
    text: "Ó Senhor, suplicamos-te que recebas, com piedade celestial, as orações do teu povo que te invoca; e concede que todos saibam e compreendam o que devem fazer e tenham a graça e poder para fielmente o realizar. Mediante nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "proper_11",
    text: "Deus Onipotente, fonte de toda a sabedoria, que tanto conheces de antemão as nossas necessidades, quanto nós ignoramos o que pedir; tem compaixão de nossas fraquezas, e concede-nos tudo o que, por indignidade ou cegueira nossa, não ousamos nem sabemos suplicar, senão pelos merecimentos de teu Filho Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "proper_12",
    text: "Ó Deus, protetor dos que em ti confiam, sem o qual nada é forte, nada é santo; acrescenta e multiplica a tua misericórdia para conosco, a fim de que, sob o teu governo e direção, vivamos esta vida de tal maneira que não percamos a vida eterna. Por nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "proper_13",
    text: "Permite, ó Senhor, que a tua contínua misericórdia purifique e defenda a tua Igreja; e, porquanto ela não pode continuar em segurança sem teu socorro, preserva-a sempre com teu auxílio e bondade; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "proper_14",
    text: "Concede-nos, Senhor, te rogamos, a graça de pensar e executar sempre o que é justo e bom, para que nós, que sem ti nada podemos, por ti nos tornemos capazes de viver conforme a tua vontade; mediante nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "proper_15",
    text: "Deus Onipotente, que deste teu único Filho não só em sacrifício pelo pecado, mas também para exemplo de santidade, dá-nos a graça de sempre receber com gratidão os frutos de sua obra redentora e de seguir diariamente os bem-aventurados passos de sua santíssima vida. Mediante nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "proper_16",
    text: "Ó Misericordioso Deus, concede que a tua Igreja, unida pelo Espírito Santo, manifeste o teu poder entre todos os povos, para a glória do teu nome. Mediante Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "proper_17",
    text: "Senhor de todo o poder e majestade, autor e dispensador de todo o bem; enxerta em nossos corações o amor do teu nome; aumenta em nós a verdadeira religião, nutre-nos com toda a bondade e frutifica em nós as boas obras; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "proper_18",
    text: "Concede-nos, Senhor, que confiemos em ti com todo o nosso coração, porque assim como tu resistes aos orgulhosos, que se vangloriam de sua própria força, também nunca abandonas os que exaltam a tua misericórdia; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "proper_19",
    text: "Ó Deus, visto que sem ti não te podemos agradar, misericordioso, permite que teu Santo Espírito dirija e governe os nossos corações; mediante nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "proper_20",
    text: "Pai celestial, concede, ó Senhor, que não andemos ansiosos quanto às coisas terrenas, que são passageiras, mas que amemos as celestiais que permanecem para sempre. Por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "proper_21",
    text: "Ó Deus, cuja onipotência se revela principalmente em misericórdia e compaixão; concede-nos a plenitude da tua graça, para que, esforçando-nos para alcançar as tuas promessas, sejamos feitos participantes do teu tesouro celestial; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "proper_22",
    text: "Onipotente e sempiterno Deus, que sempre estás mais pronto a ouvir do que nós a suplicar, e nos dás mais do que desejamos ou merecemos; derrama sobre nós a tua misericórdia, perdoando o que nos pesa na consciência e dando-nos as bênçãos que não somos dignos de pedir, senão pelos merecimentos de Jesus Cristo teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "proper_23",
    text: "Rogamos-te, Senhor, que a tua graça sempre nos preceda e acompanhe, inspirando-nos a perseverar na prática de boas obras; mediante Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "proper_24",
    text: "Onipotente e sempiterno Deus, que em Cristo tens revelado tua glória entre as nações. Mantém viva esta obra, por tua misericórdia, para que a tua Igreja pelo mundo inteiro persevere com fé inabalável na confissão do teu nome; mediante Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "proper_25",
    text: "Onipotente e eterno Deus, aumenta em nós a fé, a esperança e o amor; e para que alcancemos as tuas promessas, inclina-nos a amar o que nos ordenas; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "proper_26",
    text: "Onipotente e misericordioso Deus, de quem procede a graça de teus servos te servirem bem e agradavelmente; permite que te sirvamos com tanta fidelidade nesta vida, que alcancemos finalmente as tuas promessas celestiais; pelos merecimentos de Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "proper_27",
    text: "Ó Deus, cujo Filho, para sempre bendito, foi manifestado para destruir as obras do maligno e tornar-nos filhos de Deus e herdeiros da vida eterna; permite, nós te suplicamos, que nesta esperança nos purifiquemos, assim como Ele é puro; para que, quando vier outra vez com poder e grande glória, sejamos feitos semelhantes a Ele no seu eterno e glorioso reino, onde contigo, Pai, e com o Espírito Santo, vive e reina sempre, um só Deus, pelos séculos dos séculos. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "proper_28",
    text: "Ó Deus Onipotente, que enviaste a tua Igreja até os confins da terra para reunir um povo agradável aos teus olhos; concede que permaneçamos vigilantes e fiéis nesta Missão, de tal maneira que, mesmo que se abalem as estruturas deste mundo, proclamemos que Jesus Cristo teu Filho, vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "christ_the_king",
    text: "Senhor soberano, Onipotente e sempiterno Deus, cuja vontade é restaurar todas as coisas em teu amado Filho, o Rei dos Reis e Senhor dos senhores; concede misericordiosamente que os povos da terra, divididos e escravizados pelo pecado, sejam libertados e reunidos em Teu reino de amor, por meio de Cristo Jesus, Teu Filho, nosso Senhor, o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  }
]

trinity_propers_collects.each do |collect|
  if create_collect(collect, prayer_book.id)
    count += 1
  else
    skipped += 1
  end
end

# --------------------------------------------------------------------------------
# COLETAS COMUNS (6 coletas)
# --------------------------------------------------------------------------------

common_collects = [
  {
    sunday_reference: "common_saints",
    text: "Deus Todo-poderoso, que nos manténs em unidade com todos os teus santos no céu e na terra, permite que fortalecidos pelo bom exemplo de teu servo N., e imitando a sua fé, sejamos continuamente sustentados por esta comunhão de fé e oração, sabedores que pela intercessão de Jesus Cristo teu Filho, nosso Senhor, as nossas orações são aceitáveis a ti, ó Pai, por meio do Espírito Santo, um só Deus agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "common_martyrs",
    text: "Deus Todo-poderoso, que deste ao teu servo N., a ousadia de confessar diante dos poderosos deste mundo o nome glorioso de teu Filho e de morrer como mártir pela fé cristã, ajuda-nos a seguir o seu supremo exemplo de renúncia e a viver nossa vida, prontos a dar a razão da esperança que há em nós e, se necessário, a morrer por esta esperança; por Jesus Cristo teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "common_pastors",
    text: "Ó Senhor, tu que és Pastor e Bispo das nossas almas e que escolheste teu servo N. para ser [Bispo e] Pastor na tua Igreja, ajuda-o, com teu poder, a apascentar o teu rebanho; e concede, pelo teu Espírito, a todos os pastores, dons, talentos e habilidades, para que, como verdadeiros servos de Cristo e fiéis despenseiros dos teus divinos mistérios, ministrem ao teu povo; por Jesus Cristo, teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "common_missionaries",
    text: "Deus Todo-poderoso e eterno, damos-te graças por teu servo N., a quem chamaste para pregar o Evangelho ao povo de N.; desperta, neste e em todos os povos, evangelistas e mensageiros do teu reino, para que a tua Igreja proclame as insondáveis riquezas de nosso Salvador Jesus Cristo teu Filho, que vive e reina contigo e com o Espírito Santo, um só Deus agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "common_theologians",
    text: "Ó Deus, que pelo Espírito Santo concedes dons especiais para que possamos entender e ensinar a tua Palavra, louvamos o teu nome pela graça manifestada ao teu servo N., a quem capacitaste, e suplicamos que a tua Igreja seja sempre provida com esses dons; por Jesus Cristo teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "common_religious",
    text: "Ó Deus, cujo bendito Filho viveu vida consagrada a ti, liberta-nos do amor indevido por este mundo, para que, inspirados na vida consagrada do teu servo N., te sirvamos alegremente e com ele alcancemos a herança da vida eterna; por Jesus Cristo teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus agora e sempre. Amém.",
    language: "pt-BR"
  }
]

common_collects.each do |collect|
  if create_collect(collect, prayer_book.id)
    count += 1
  else
    skipped += 1
  end
end

# ================================================================================
# COLETAS POR CELEBRAÇÃO (celebration_id)
# Organizadas em ordem do Ano Litúrgico e por Rank
# ================================================================================

# --------------------------------------------------------------------------------
# NATAL E EPIFANIA - Celebrações
# --------------------------------------------------------------------------------

christmas_celebrations_collects = [
  {
    celebration_id: Celebration.find_by(fixed_month: 12, fixed_day: 24)&.id,
    text: "Deus Onipotente, que nos deste teu unigênito Filho para que tomasse sobre si a nossa natureza, e nascesse neste tempo de uma Virgem pura; concede que nós, renascidos e feitos teus filhos por adoção e graça, sejamos de dia em dia renovados por teu Santo Espírito; mediante nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    celebration_id: epifania&.id,
    text: "Ó Deus, que pela Estrela manifestaste teu unigênito Filho a todos os povos da terra; guia-nos à tua presença, os que hoje te conhecemos pela fé; a fim de que desfrutemos de tua glória face a face; mediante Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  }
]

christmas_celebrations_collects.each do |collect|
  if create_collect(collect, prayer_book.id)
    count += 1
  else
    skipped += 1
  end
end

# --------------------------------------------------------------------------------
# QUARESMA - Celebrações
# --------------------------------------------------------------------------------

lent_celebrations_collects = [
  {
    celebration_id: cinzas&.id,
    text: "Onipotente e Eterno Deus, que amas tudo quanto criaste, e que perdoas a todos os penitentes; cria em nós corações novos e contritos, para que, lamentando deveras os nossos pecados e confessando a nossa miséria, alcancemos de ti, Deus de suma piedade, perfeita remissão e perdão; por nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  }
]

lent_celebrations_collects.each do |collect|
  if create_collect(collect, prayer_book.id)
    count += 1
  else
    skipped += 1
  end
end

# --------------------------------------------------------------------------------
# SEMANA SANTA - Celebrações
# --------------------------------------------------------------------------------

holy_week_collects = [
  {
    celebration_id: segunda_santa&.id,
    text: "Onipotente Deus, cujo Filho muito amado não gozou perfeita alegria, senão após o sofrimento, e só subiu à glória depois de crucificado; concede-nos misericordioso que, seguindo o caminho da cruz, seja este para nós vereda de vida e paz; por Jesus Cristo, teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    celebration_id: terca_santa&.id,
    text: "Ó Deus, que pela paixão de teu bendito Filho, fizeste com que o instrumento da morte vergonhosa se tornasse para nós símbolo de vida; concede que nos glorifiquemos na cruz de Cristo, a fim de que alegremente suportemos infâmias e privações, por amor de teu Filho, nosso Salvador Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    celebration_id: quarta_santa&.id,
    text: "Ó Senhor Deus, cujo bendito Filho, nosso Salvador Jesus Cristo, teve o seu corpo torturado e seu rosto cuspido; concede-nos a graça de enfrentar com esperança os sofrimentos deste tempo e de confiar na glória que há de ser revelada; por Jesus Cristo teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    celebration_id: quinta_santa&.id,
    text: "Ó Pai Onipotente, cujo amado Filho, na noite anterior à sua paixão, instituiu o Sacramento do seu Corpo e Sangue; concede-nos, misericordioso, que dele participemos agradecidos, em memória daquele que nestes santos mistérios nos dá o penhor da vida eterna, teu Filho Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    celebration_id: sexta_paixao&.id,
    text: "Deus Onipotente, nós te suplicamos olhes com misericórdia para esta família que é tua, e pela qual nosso Senhor Jesus Cristo não hesitou em entregar-se, traído, às mãos de homens iníquos, e sofrer morte de cruz; o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    celebration_id: sabado_santo&.id,
    text: "Ó Deus, Criador do céu e da terra; concede que, assim como o corpo crucificado de teu amado Filho foi colocado no túmulo e descansou neste sábado santo, também sepultados com Ele aguardemos o terceiro dia e com Ele ressuscitemos para uma vida nova; o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  }
]

holy_week_collects.each do |collect|
  if create_collect(collect, prayer_book.id)
    count += 1
  else
    skipped += 1
  end
end

# --------------------------------------------------------------------------------
# PÁSCOA - Celebrações
# --------------------------------------------------------------------------------

easter_celebrations_collects = [
  {
    celebration_id: vigilia_pascal&.id,
    text: "Senhor Deus, Tu fizeste resplandecer esta noite com a glória da ressurreição de Cristo; faz com que a sua luz brilhe na tua Igreja para que sejamos renovados no corpo e na alma e nos entreguemos plenamente ao teu serviço. Amém.",
    language: "pt-BR"
  },
  {
    celebration_id: pascoa&.id,
    text: "Ó Deus, que para a nossa redenção entregaste o teu unigênito Filho à morte de cruz, e pela tua gloriosa ressurreição nos libertaste do poder de nosso inimigo; concede que morramos diariamente para o pecado, a fim de que vivamos sempre com Ele na alegria de sua ressurreição; mediante Jesus Cristo, teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    celebration_id: ascensao&.id,
    text: "Senhor soberano, teu Filho ascendeu em triunfo para governar todo o universo em amor e glória; faz que todos os povos reconheçam a autoridade do seu reino. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  {
    celebration_id: pentecostes&.id,
    text: "Ó Deus, que no dia de Pentecostes, ensinaste os fiéis, derramando em seus corações a luz do teu Santo Espírito; concede-nos, por meio do mesmo Espírito, um juízo acertado em todas as coisas, e perene regozijo em seu fortalecimento; pelos méritos de Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  }
]

easter_celebrations_collects.each do |collect|
  if create_collect(collect, prayer_book.id)
    count += 1
  else
    skipped += 1
  end
end

# --------------------------------------------------------------------------------
# TEMPO COMUM - Celebrações
# --------------------------------------------------------------------------------

trinity_celebration_collect = [
  {
    celebration_id: trindade&.id,
    text: "Deus nosso Pai, enviaste ao mundo a Palavra da verdade e o Espírito da santidade para revelar aos homens o mistério admirável do teu Ser: concede-nos que na profissão da verdadeira fé reconheçamos a glória da eterna Trindade e adoremos a Unidade na sua onipotência. Mediante nosso Senhor Jesus Cristo. Amém.",
    language: "pt-BR"
  }
]

trinity_celebration_collect.each do |collect|
  if create_collect(collect, prayer_book.id)
    count += 1
  else
    skipped += 1
  end
end

# --------------------------------------------------------------------------------
# DIAS SANTOS E FESTAS (42 coletas por celebration_id)
# Organizadas por ordem cronológica do ano litúrgico
# --------------------------------------------------------------------------------

holy_days_collects = [
  # Janeiro
  {
    celebration_id: Celebration.find_by(name: "Santo Nome de Jesus")&.id,
    text: "Pai misericordioso, ensinaste-nos não haver salvação noutro nome que não seja o de Jesus; ensina-nos a glorificar o seu nome e a tornar conhecida a sua salvação em todo o mundo. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  {
    celebration_id: Celebration.find_by(name: "Conversão de São Paulo")&.id,
    text: "Ó Deus, instruíste o mundo inteiro com a palavra do Apóstolo Paulo de quem celebramos hoje a conversão; concede-nos a graça de, imitando-o, caminharmos para ti e sermos no mundo testemunhas do teu Evangelho. Por nosso Senhor Jesus Cristo, teu Filho, na unidade do Espírito Santo. Amém.",
    language: "pt-BR"
  },

  # Fevereiro
  {
    celebration_id: Celebration.find_by(name: "Apresentação de Cristo no Templo")&.id,
    text: "Pai onipotente, teu Filho Jesus Cristo foi apresentado no templo, sendo proclamado a glória de Israel e a luz das nações; concede-nos que por Ele sejamos apresentados a ti e possamos refletir a tua glória no mundo. Mediante Jesus Cristo, nosso Senhor Amém.",
    language: "pt-BR"
  },

  # Março
  {
    celebration_id: Celebration.find_by(name: "São José")&.id,
    text: "Deus onipotente, chamaste José a ser o esposo da Virgem Maria, e o guardião do teu único Filho; abre os nossos olhos e os nossos ouvidos às mensagens da tua santa vontade, e dá-nos a coragem de agir de acordo com ela. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  {
    celebration_id: Celebration.find_by(name: "Thomas Cranmer")&.id,
    text: "Recebe, Senhor, nós te rogamos, as preces da tua Igreja, hoje quando nos lembramos de teu servo N. e de sua luta em favor do cristianismo reformado. Concede a nós a coragem deste irmão do passado para que lutemos com fé e coragem pela fé uma vez dada aos santos. Mediante Jesus Cristo, nosso Salvador. Amém.",
    language: "pt-BR"
  },
  {
    celebration_id: Celebration.find_by(name: "Anunciação de Nosso Senhor")&.id,
    text: "Suplicamos-te, Senhor, que, derrames a tua graça nos nossos corações, para que assim como conhecemos a encarnação de teu Filho Jesus Cristo, também pela sua cruz e paixão alcancemos a glória da sua ressurreição. Mediante o mesmo Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },

  # Abril
  {
    celebration_id: Celebration.find_by(name: "São Marcos Evangelista")&.id,
    text: "Deus onipotente, iluminaste a tua Igreja através do testemunho inspirado do teu evangelista Marcos; fundamenta-nos firmemente na verdade do Evangelho, e faz-nos fiéis ao seu ensino. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },

  # Maio
  {
    celebration_id: Celebration.find_by(name: "São Filipe e São Tiago")&.id,
    text: "Pai eterno, os apóstolos Filipe e Tiago conheceram no teu Filho o caminho vivo e verdadeiro; concede-nos a graça de os seguirmos ao longo desse caminho que conduz à vida eterna. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  {
    celebration_id: Celebration.find_by(name: "São Matias")&.id,
    text: "Senhor Deus, o teu servo Matias foi escolhido em substituição de Judas Iscariotes, para ser um dos apóstolos; preserva a tua Igreja de falsos apóstolos, e, pelo ministério de pastores e mestres fiéis, guarda-nos firmes na tua verdade. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  {
    celebration_id: Celebration.find_by(name: "Visitação da Bem-Aventurada Virgem Maria")&.id,
    text: "Pai misericordioso, inspiraste a bem-aventurada Virgem Maria a visitar Isabel, que com alegria a saudou como mãe do Senhor; enche-nos da tua graça para que aclamemos o seu Filho como nosso Senhor, o qual vive e reina, contigo e com o Espírito Santo, um só Deus para todo o sempre. Amém.",
    language: "pt-BR"
  },

  # Junho
  {
    celebration_id: Celebration.find_by(name: "São Barnabé")&.id,
    text: "Senhor Deus, teu Filho Jesus Cristo ensinou-nos ser coisa mais abençoada dar que receber; ajuda-nos, com o exemplo do teu apóstolo Barnabé, a ser magnânimos a julgar e generosos a servir. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  {
    celebration_id: Celebration.find_by(name: "Natividade de São João Batista")&.id,
    text: "Senhor Deus, o teu servo João Batista nasceu maravilhosamente e preparou o caminho para o advento de teu Filho; ajuda-nos a conhecer Jesus Cristo como nosso Salvador e a obter por meio d'Ele o perdão dos nossos pecados. Ele que vive e reina, contigo e com o Espírito Santo, um só Deus, para todo o sempre Amém.",
    language: "pt-BR"
  },
  {
    celebration_id: Celebration.find_by(name: "São Pedro e São Paulo")&.id,
    text: "Deus onipotente, os teus apóstolos Pedro e Paulo glorificaram-te tanto na vida como na morte; inspira a tua Igreja a seguir os seus exemplos e a permanecer firme no único fundamento que é Cristo, nosso Senhor, a quem, contigo e com o Espírito Santo, seja dada honra e glória, agora e para sempre. Amém.",
    language: "pt-BR"
  },

  # Julho
  {
    celebration_id: Celebration.find_by(name: "São Tomé")&.id,
    text: "Deus eterno, o teu apóstolo Tomé duvidou da ressurreição do teu Filho até que a palavra e a vista o convenceram; concede-nos, a nós que não vimos, a graça de não sermos infiéis, mas crentes. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  {
    celebration_id: Celebration.find_by(name: "Santa Maria Madalena")&.id,
    text: "Senhor misericordioso, teu Filho restituiu a Maria Madalena a saúde do corpo e da mente e chamou-a a ser testemunha da sua ressurreição; purifica-nos e renova-nos para te servirmos no poder da vida ressuscitada de Jesus, o qual, contigo e com o Espírito Santo, vive e reina, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    celebration_id: Celebration.find_by(name: "São Tiago")&.id,
    text: "Senhor Deus, o teu apóstolo Tiago consentiu em deixar seu pai e tudo o que possuía e ainda em sofrer pelo nome do teu Filho; ajuda-nos misericordioso para que nenhum dos laços terrenos nos afastem do teu serviço. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },

  # Agosto
  {
    celebration_id: Celebration.find_by(name: "Transfiguração do Senhor")&.id,
    text: "Deus onipotente, teu Filho revelou-se em glória antes de sofrer na Cruz; concede-nos que pela fé na sua morte e ressurreição triunfemos no poder da sua vitória. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  {
    celebration_id: Celebration.find_by(name: "São Bartolomeu")&.id,
    text: "Deus eterno, deste ao teu apóstolo Bartolomeu a graça de crer e de pregar a tua Palavra; permite que a tua Igreja ame a Palavra em que ele creu e fielmente lhe obedeça e a proclame. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },

  # Setembro
  {
    celebration_id: Celebration.find_by(name: "Visitação da Bem-Aventurada Virgem Maria")&.id,
    text: "Deus onipotente, escolheste a bem-aventurada Virgem Maria para ser a mãe do teu único Filho; concede-nos a nós, redimidos pelo Sangue de Jesus, a graça de estarmos com ela na glória do teu reino eterno. Mediante Jesus Cristo, nosso Senhor, que vive e reina, contigo e com o Espírito Santo. Amém.",
    language: "pt-BR"
  },
  {
    celebration_id: Celebration.find_by(name: "São Mateus")&.id,
    text: "Deus nosso Salvador, teu Filho chamou Mateus a ser apóstolo e evangelista; livra-nos de ser possessivos e amantes do dinheiro e inspira-nos a seguir Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e para sempre. Amém.",
    language: "pt-BR"
  },
  {
    celebration_id: Celebration.find_by(name: "São Miguel e Todos os Anjos")&.id,
    text: "Senhor Deus das hostes celestiais, criaste os anjos para te adorarem e servirem; concede que, inspirando o nosso culto, eles nos socorram e fortaleçam na nossa luta contra o mal. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },

  # Outubro
  {
    celebration_id: Celebration.find_by(name: "São Lucas")&.id,
    text: "Pai de toda a graça, tu inspiraste o médico Lucas a anunciar o amor e o poder de cura do teu Filho; dá à tua Igreja, pela graça do Espírito, o mesmo amor e o mesmo poder de curar. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  {
    celebration_id: Celebration.find_by(name: "São Simão e São Judas")&.id,
    text: "Senhor Deus, edificaste a tua Igreja mediante apóstolos e profetas, sendo Jesus Cristo a sua pedra angular; permite que, auxiliados pela sua doutrina, nos reunamos na unidade do Espírito e nos tomemos templo santo aceitável por ti. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },

  # Novembro
  {
    celebration_id: Celebration.find_by(name: "Todos os Santos")&.id,
    text: "Senhor de toda a graça, juntaste os teus santos na comunhão da tua Igreja e criaste para eles alegrias que ultrapassam o nosso entendimento; ajuda-nos a imitá-los na nossa vida diária e conduz-nos com eles à glória eterna. Mediante Jesus Cristo, nosso Senhor Amém.",
    language: "pt-BR"
  },
  {
    celebration_id: Celebration.find_by(name: "Santo André")&.id,
    text: "Senhor Deus, pela tua graça o apóstolo André obedeceu à chamada do teu Filho Jesus Cristo e seguiu-o sem demora; concede-nos o dom de nos entregarmos a ti em alegre obediência. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },

  # Dezembro
  {
    celebration_id: Celebration.find_by(name: "Santo Estêvão")&.id,
    text: "Pai celestial, deste ao teu mártir Estevão a graça de orar por aqueles que o apedrejaram; concede que, ao sofrermos pela verdade, imitemos o seu exemplo de perdão. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  {
    celebration_id: Celebration.find_by(name: "São João")&.id,
    text: "Senhor misericordioso, iluminaste a tua Igreja com o ensino de João; lança sobre nós os brilhantes raios da tua luz para podermos caminhar na tua verdade e chegar finalmente ao teu eterno esplendor. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  {
    celebration_id: Celebration.find_by(name: "Santos Inocentes")&.id,
    text: "Pai celestial, crianças sofreram às mãos de Herodes, embora nenhum mal tivessem feito; dá-nos a graça de não sermos indiferentes perante a crueldade ou a opressão, mas prontos a defender os fracos da tirania dos fortes. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  }
]

holy_days_collects.each do |collect|
  if create_collect(collect, prayer_book.id)
    count += 1
  else
    skipped += 1
  end
end

# ================================================================================
# RESUMO FINAL
# ================================================================================

puts "\n✅ #{count} coletas criadas com sucesso!"
puts "⏭️  #{skipped} coletas já existiam no banco de dados." if skipped > 0
