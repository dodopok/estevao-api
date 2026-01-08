# frozen_string_literal: true

Rails.logger.info "📿 Carregando textos Oração do Meio-Dia (LOCB 2008)..."

prayer_book = PrayerBook.find_by!(code: 'locb_2008')

# ==============================================================================
# ORAÇÃO DO MEIO-DIA - LOCB 2008 (páginas 65-67)
# ==============================================================================

# ============================================================================
# ABERTURA
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'midday_opening_minister', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Abertura'
  text.content = 'Ó Deus, digna-te a livrar-nos.'
  text.category = 'opening_sentence'
end

LiturgicalText.find_or_create_by!(slug: 'midday_opening_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Senhor, apressa-te em socorrer-nos.'
  text.category = 'opening_sentence'
end

LiturgicalText.find_or_create_by!(slug: 'midday_gloria_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Glória ao Pai, ao Filho e ao Espírito Santo.'
  text.category = 'gloria'
end

LiturgicalText.find_or_create_by!(slug: 'midday_gloria_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'gloria'
end

LiturgicalText.find_or_create_by!(slug: 'midday_alleluia', prayer_book_id: prayer_book.id) do |text|
    text.content = '[Aleluia!]'
  text.category = 'alleluia'
end

LiturgicalText.find_or_create_by!(slug: 'midday_rubric_alleluia', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Omite-se o "Aleluia!" no Advento e na Quaresma. Pode-se cantar um Hino adequado. Canta-se ou diz-se um ou mais dos seguintes Salmos. Outras seleções adequadas incluem os Salmos 19, 67 ou uma ou mais seções do Salmo 119 ou ainda uma seleção dos Salmos 120 a 133.'
  text.category = 'rubric'
end

# ============================================================================
# SALMO 119 (Salmo 119:105-112)
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'midday_psalm_119', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Salmo 119'
  text.reference = 'Salmo 119:105-112'
  text.category = 'canticle'
  text.content = <<~TEXT.strip
    Lâmpada para os meus pés é a tua palavra e luz para os meus caminhos.
    **Jurei e confirmei o juramento de guardar os teus retos juízos.**
    Estou aflitíssimo; vivifica-me, Senhor, segundo a tua palavra.
    **Aceita, Senhor, a espontânea oferenda dos meus lábios e ensina-me os teus juízos.**
    Estou de contínuo em perigo de vida; todavia, não me esqueço da tua lei.
    **Armam ciladas contra mim os ímpios; contudo, não me desvio dos teus preceitos.**
    Os teus testemunhos, recebi-os por legado perpétuo, porque me constituem o prazer do coração.
    **Induzo o coração a guardar os teus decretos, para sempre, até ao fim.**
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'midday_psalm_119_gloria_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Glória ao Pai, ao Filho e ao Espírito Santo.'
  text.category = 'gloria'
end

LiturgicalText.find_or_create_by!(slug: 'midday_psalm_119_gloria_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'gloria'
end

# ============================================================================
# SALMO 121
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'midday_psalm_121', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Salmo 121'
  text.reference = 'Salmo 121'
  text.category = 'canticle'
  text.content = <<~TEXT.strip
    Elevo os olhos para os montes: de onde me virá o socorro?
    **O meu socorro vem do Senhor, que fez o céu e a terra.**
    Ele não permitirá que os teus pés vacilem; não dormitará aquele que te guarda.
    **É certo que não dormita, nem dorme o guarda de Israel.**
    O Senhor é quem te guarda; o Senhor é a tua sombra à tua direita.
    **De dia não te molestará o sol, nem de noite, a lua.**
    O Senhor te guardará de todo mal; guardará a tua alma.
    **O Senhor guardará a tua saída e a tua entrada, desde agora e para sempre.**
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'midday_psalm_121_gloria_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Glória ao Pai, ao Filho e ao Espírito Santo.'
  text.category = 'gloria'
end

LiturgicalText.find_or_create_by!(slug: 'midday_psalm_121_gloria_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'gloria'
end

# ============================================================================
# SALMO 126
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'midday_psalm_126', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Salmo 126'
  text.reference = 'Salmo 126'
  text.category = 'canticle'
  text.content = <<~TEXT.strip
    Quando o Senhor restaurou a sorte de Sião, ficamos como quem sonha.
    **Então a nossa boca se encheu de riso, e a nossa língua, de júbilo; então, entre as nações se dizia: Grandes coisas o Senhor tem feito por eles.**
    Com efeito, grandes coisas fez o Senhor por nós; por isso, estamos alegres.
    **Restaura, Senhor, a nossa sorte, como as torrentes no Neguebe.**
    Os que com lágrimas semeiam com júbilo ceifarão.
    **Quem sai andando e chorando, enquanto semeia, voltará com júbilo, trazendo os seus feixes.**
  TEXT
end

LiturgicalText.find_or_create_by!(slug: 'midday_psalm_126_gloria_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Glória ao Pai, ao Filho e ao Espírito Santo.'
  text.category = 'gloria'
end

LiturgicalText.find_or_create_by!(slug: 'midday_psalm_126_gloria_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Como era no princípio, é agora e será sempre, por todos os séculos. Amém.'
  text.category = 'gloria'
end

# ============================================================================
# LEITURA DAS ESCRITURAS
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'midday_readings_rubric', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Leitura das Escrituras'
  text.content = 'Uma das seguintes passagens ou outra mais adequada é lida, então:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'midday_reading_1', prayer_book_id: prayer_book.id) do |text|
    text.reference = 'Romanos 5:5'
  text.content = 'Ora, a esperança não confunde, porque o amor de Deus é derramado em nosso coração pelo Espírito Santo, que nos foi outorgado.'
  text.category = 'reading'
end

LiturgicalText.find_or_create_by!(slug: 'midday_reading_1_response_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Demos graças a Deus.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'midday_reading_2', prayer_book_id: prayer_book.id) do |text|
    text.reference = '2 Coríntios 5:17-18'
  text.content = 'E, assim, se alguém está em Cristo, é nova criatura; as coisas antigas já passaram; eis que se fizeram novas. Ora, tudo provém de Deus, que nos reconciliou consigo mesmo por meio de Cristo e nos deu o ministério da reconciliação.'
  text.category = 'reading'
end

LiturgicalText.find_or_create_by!(slug: 'midday_reading_2_response_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Demos graças a Deus.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'midday_reading_3', prayer_book_id: prayer_book.id) do |text|
    text.reference = 'Malaquias 1:11'
  text.content = 'Mas, desde o nascente do sol até ao poente, é grande entre as nações o meu nome; e em todo lugar lhe é queimado incenso e trazidas ofertas puras, porque o meu nome é grande entre as nações, diz o Senhor dos Exércitos.'
  text.category = 'reading'
end

LiturgicalText.find_or_create_by!(slug: 'midday_reading_3_response_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Demos graças a Deus.'
  text.category = 'response'
end

LiturgicalText.find_or_create_by!(slug: 'midday_meditation_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Pode-se seguir uma meditação em voz alta ou em silêncio'
  text.category = 'rubric'
end

# ============================================================================
# ORAÇÕES
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'midday_prayers_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Depois o Ministro e os demais presentes dizem:'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'midday_kyrie_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Senhor, tem piedade de nós.'
  text.category = 'prayer'
end

LiturgicalText.find_or_create_by!(slug: 'midday_kyrie_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Cristo, tem piedade de nós.'
  text.category = 'prayer'
end

LiturgicalText.find_or_create_by!(slug: 'midday_kyrie_minister_2', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Senhor, tem piedade de nós.'
  text.category = 'prayer'
end

# ============================================================================
# PAI NOSSO
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'midday_lords_prayer_all', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Pai Nosso'
  text.content = <<~TEXT.strip
    Pai nosso, que estás nos céus, santificado seja o teu nome. Venha o teu Reino, seja feita a tua vontade, assim na terra como no céu. O pão nosso de cada dia nos dá hoje. E perdoa-nos as nossas dívidas, assim como nós perdoamos aos nossos devedores. E não nos deixes cair em tentação, mas livra-nos do mal; pois teu é o Reino, e o poder, e a glória para sempre. Amém.
  TEXT
  text.category = 'prayer'
end

LiturgicalText.find_or_create_by!(slug: 'midday_versicle_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Senhor, escuta a nossa oração.'
  text.category = 'prayer'
end

LiturgicalText.find_or_create_by!(slug: 'midday_versicle_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'E chegue até ti o nosso clamor.'
  text.category = 'prayer'
end

LiturgicalText.find_or_create_by!(slug: 'midday_oremos', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Oremos.'
  text.category = 'prayer'
end

# ============================================================================
# COLETAS
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'midday_collects_rubric', prayer_book_id: prayer_book.id) do |text|
    text.content = 'O Ministro, então, diz uma das seguintes coletas, seguida da Coleta do Dia (pp.280 a 333):'
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'midday_collect_1', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Coleta 1'
  text.content = 'Pai celestial, envia teu Santo Espírito a nossos corações para que nos dirija e governe segundo a tua vontade, nos console em todas as nossas aflições, nos defenda de todo erro e nos conduza a toda a verdade. Por Jesus Cristo, nosso Senhor. Amém.'
  text.category = 'collect'
end

LiturgicalText.find_or_create_by!(slug: 'midday_collect_2', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Coleta 2'
  text.content = 'Bendito Salvador, nesta hora em que estavas sobre a cruz estendendo teus braços amorosos: Concede que todos os povos da terra olhem somente a ti e sejam salvos por tua grande misericórdia. Amém.'
  text.category = 'collect'
end

LiturgicalText.find_or_create_by!(slug: 'midday_collect_3', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Coleta 3'
  text.content = 'Salvador Todo-poderoso, que ao meio-dia chamaste o teu servo São Paulo para ser o apóstolo dos gentios: rogamos-te que ilumines o mundo com teu resplendor de glória para que todas as nações venham a ti e te adorem. Tu que vives com o Pai e o Espírito Santo, eternamente. Amém.'
  text.category = 'collect'
end

LiturgicalText.find_or_create_by!(slug: 'midday_collect_4', prayer_book_id: prayer_book.id) do |text|
    text.title = 'Coleta 4'
  text.content = 'Senhor Jesus Cristo, que disseste aos vossos apóstolos: Eu vos deixo a paz, eu vos dou a minha paz: não olhes para os nossos pecados, mas para a fé que anima a tua Igreja. Dá-lhe, segundo o vosso desejo, a Paz e a Unidade. Vós que sois Deus, com o Pai e o Espírito Santo. Amém.'
  text.category = 'collect'
end

# ============================================================================
# INTERCESSÕES E CONCLUSÃO
# ============================================================================

LiturgicalText.find_or_create_by!(slug: 'midday_intercessions_rubric_1', prayer_book_id: prayer_book.id) do |text|
    text.content = "Podem-se oferecer intercessões espontâneas"
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'midday_intercessions_rubric_2', prayer_book_id: prayer_book.id) do |text|
    text.content = "O Ofício termina como se segue:"
  text.category = 'rubric'
end

LiturgicalText.find_or_create_by!(slug: 'midday_dismissal_minister', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Bendigamos ao Senhor.'
  text.category = 'dismissal'
end

LiturgicalText.find_or_create_by!(slug: 'midday_dismissal_all', prayer_book_id: prayer_book.id) do |text|
    text.content = 'Demos graças a Deus.'
  text.category = 'dismissal'
end

Rails.logger.info "✅ Textos Oração do Meio-Dia (LOCB 2008) carregados com sucesso!"
