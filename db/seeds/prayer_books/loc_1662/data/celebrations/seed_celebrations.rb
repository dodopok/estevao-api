# ================================================================================
# CELEBRAÇÕES - LOC 1662
# ================================================================================

Rails.logger.info "🎉 Carregando celebrações do LOC 1662..."

prayer_book = PrayerBook.find_by!(code: 'loc_1662')

DEFAULT_RANKS = {
  'principal_feast' => 0,
  'major_holy_day' => 50,
  'festival' => 100,
  'lesser_feast' => 200,
  'commemoration' => 300
}.freeze

celebrations = [
  # ============================================================================
  # FESTAS MÓVEIS (PRINCIPAIS)
  # ============================================================================
  { name: "1º Domingo do Advento", celebration_type: :principal_feast, liturgical_color: "purple", movable: true, calculation_rule: "first_sunday_of_advent", post_slug: "celebration-first-sunday-of-advent", person_type: nil, gender: nil },
  { name: "Dia de Natal", celebration_type: :principal_feast, liturgical_color: "white", fixed_month: 12, fixed_day: 25, post_slug: "celebration-christmas", person_type: "christ", gender: "male" },
  { name: "Epifania", celebration_type: :principal_feast, liturgical_color: "white", fixed_month: 1, fixed_day: 6, post_slug: "celebration-epiphany", person_type: "christ", gender: "male" },
  { name: "Quarta-feira de Cinzas", celebration_type: :major_holy_day, liturgical_color: "purple", movable: true, calculation_rule: "ash_wednesday", post_slug: "celebration-ash-wednesday", person_type: nil, gender: nil },
  { name: "Domingo de Ramos", celebration_type: :major_holy_day, liturgical_color: "red", movable: true, calculation_rule: "palm_sunday", post_slug: "celebration-palm-sunday", person_type: "christ", gender: "male" },
  { name: "Quinta-feira Santa", celebration_type: :major_holy_day, liturgical_color: "white", movable: true, calculation_rule: "maundy_thursday", post_slug: "celebration-maundy-thursday", person_type: "christ", gender: "male" },
  { name: "Sexta-feira da Paixão", celebration_type: :major_holy_day, liturgical_color: "red", movable: true, calculation_rule: "good_friday", post_slug: "celebration-good-friday", person_type: "christ", gender: "male" },
  { name: "Sábado Santo", celebration_type: :major_holy_day, liturgical_color: "black", movable: true, calculation_rule: "holy_saturday", post_slug: "celebration-holy-saturday", person_type: "christ", gender: "male" },
  { name: "Domingo da Páscoa", celebration_type: :principal_feast, liturgical_color: "white", movable: true, calculation_rule: "easter", post_slug: "celebration-easter", person_type: "christ", gender: "male" },
  { name: "Dia da Ascensão", celebration_type: :principal_feast, liturgical_color: "white", movable: true, calculation_rule: "ascension", post_slug: "celebration-ascension", person_type: "christ", gender: "male" },
  { name: "Pentecostes", celebration_type: :principal_feast, liturgical_color: "red", movable: true, calculation_rule: "pentecost", post_slug: "celebration-pentecost", person_type: nil, gender: nil },
  { name: "Segunda-feira de Pentecostes", celebration_type: :principal_feast, liturgical_color: "red", movable: true, calculation_rule: "whitsun_monday", post_slug: "celebration-whitsun-monday", person_type: nil, gender: nil },
  { name: "Terça-feira de Pentecostes", celebration_type: :principal_feast, liturgical_color: "red", movable: true, calculation_rule: "whitsun_tuesday", post_slug: "celebration-whitsun-tuesday", person_type: nil, gender: nil },
  { name: "Santíssima Trindade", celebration_type: :principal_feast, liturgical_color: "white", movable: true, calculation_rule: "trinity_sunday", post_slug: "celebration-trinity", person_type: nil, gender: nil },
  # ============================================================================
  # DIAS SANTOS (RED LETTER DAYS)
  # ============================================================================
  { name: "Circuncisão do Senhor", celebration_type: :principal_feast, liturgical_color: "white", fixed_month: 1, fixed_day: 1, post_slug: "celebration-holy-name-circumcision", person_type: "christ", gender: "male" },
  { name: "Conversão de São Paulo", celebration_type: :major_holy_day, liturgical_color: "white", fixed_month: 1, fixed_day: 25, post_slug: "celebration-conversion-of-paul", person_type: "apostle", gender: "male" },
  { name: "Purificação de Maria", celebration_type: :major_holy_day, liturgical_color: "white", fixed_month: 2, fixed_day: 2, post_slug: "celebration-presentation", person_type: "mary", gender: "female" },
  { name: "São Matias, o Apóstolo", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 2, fixed_day: 24, post_slug: "celebration-matthias-the-apostle", person_type: "apostle", gender: "male" },
  { name: "Anunciação da Bem-Aventurada Virgem Maria", celebration_type: :major_holy_day, liturgical_color: "white", fixed_month: 3, fixed_day: 25, post_slug: "celebration-annunciation", person_type: "mary", gender: "female" },
  { name: "São Marcos, o Evangelista", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 4, fixed_day: 25, post_slug: "celebration-mark-the-evangelist", person_type: "evangelist", gender: "male" },
  { name: "São Filipe e São Tiago, os Apóstolos", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 5, fixed_day: 1, post_slug: "celebration-philip-and-james-apostles", person_type: "apostle", gender: "male" },
  { name: "São Barnabé", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 6, fixed_day: 11, post_slug: "celebration-barnabas-the-apostle", person_type: "apostle", gender: "male" },
  { name: "Nascimento de São João Batista", celebration_type: :major_holy_day, liturgical_color: "white", fixed_month: 6, fixed_day: 24, post_slug: "celebration-nativity-of-john-the-baptist", person_type: "baptist", gender: "male" },
  { name: "São Pedro, o Apóstolo", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 6, fixed_day: 29, post_slug: "celebration-peter-and-paul-apostles", person_type: "apostle", gender: "male" },
  { name: "São Tiago, o Apóstolo", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 7, fixed_day: 25, post_slug: "celebration-james-the-apostle", person_type: "apostle", gender: "male" },
  { name: "São Bartolomeu, o Apóstolo", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 8, fixed_day: 24, post_slug: "celebration-bartholomew-the-apostle", person_type: "apostle", gender: "male" },
  { name: "São Mateus, o Apóstolo", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 9, fixed_day: 21, post_slug: "celebration-matthew-the-apostle", person_type: "apostle", gender: "male" },
  { name: "São Miguel e Todos os Anjos", celebration_type: :major_holy_day, liturgical_color: "white", fixed_month: 9, fixed_day: 29, post_slug: "celebration-archangel-michael-and-all-angels", person_type: "archangel", gender: "male" },
  { name: "São Lucas, o Evangelista", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 10, fixed_day: 18, post_slug: "celebration-luke-the-evangelist", person_type: "evangelist", gender: "male" },
  { name: "São Simão e São Judas, os Apóstolos", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 10, fixed_day: 28, post_slug: "celebration-simon-and-jude", person_type: "apostle", gender: "male" },
  { name: "Todos os Santos", celebration_type: :major_holy_day, liturgical_color: "white", fixed_month: 11, fixed_day: 1, post_slug: "celebration-all-saints", person_type: nil, gender: nil },
  { name: "Santo André, o Apóstolo", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 11, fixed_day: 30, post_slug: "celebration-andrew-the-apostle", person_type: "apostle", gender: "male" },
  { name: "São Tomé, o Apóstolo", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 12, fixed_day: 21, post_slug: "celebration-thomas-the-apostle", person_type: "apostle", gender: "male" },
  { name: "Santo Estevão, o Mártir", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 12, fixed_day: 26, post_slug: "celebration-stephen", person_type: "martyr", gender: "male" },
  { name: "São João, o Evangelista", celebration_type: :major_holy_day, liturgical_color: "white", fixed_month: 12, fixed_day: 27, post_slug: "celebration-john-the-apostle", person_type: "evangelist", gender: "male" },
  { name: "Santos Inocentes", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 12, fixed_day: 28, post_slug: "celebration-holy-innocents", person_type: "martyr", gender: nil },

  # ============================================================================
  # DIAS MENORES (BLACK LETTER DAYS)
  # ============================================================================
  # JANEIRO
  { name: "Luciano, P. & M.", celebration_type: :lesser_feast, fixed_month: 1, fixed_day: 8, post_slug: "celebration-lucyn", person_type: "martyr", gender: "male" },
  { name: "Hilario, B & C.", celebration_type: :lesser_feast, fixed_month: 1, fixed_day: 13, post_slug: "celebration-hilary-of-poitiers", person_type: "bishop", gender: "male" },
  { name: "Priscila, V. & M. Romana", celebration_type: :lesser_feast, fixed_month: 1, fixed_day: 18, post_slug: "celebration-prisca", person_type: "martyr", gender: "female" },
  { name: "Fabiano, B. de Roma & M.", celebration_type: :lesser_feast, fixed_month: 1, fixed_day: 20, post_slug: "celebration-fabian", person_type: "bishop", gender: "male" },
  { name: "Agnes, V. & M. Romana", celebration_type: :lesser_feast, fixed_month: 1, fixed_day: 21, post_slug: "celebration-agnes", person_type: "martyr", gender: "female" },
  { name: "Vicente, D. & M. Espanhol", celebration_type: :lesser_feast, fixed_month: 1, fixed_day: 22, post_slug: "celebration-vincent-of-saragossa", person_type: "martyr", gender: "male" },

  # FEVEREIRO
  { name: "Brás, B. & M. Armênio", celebration_type: :lesser_feast, fixed_month: 2, fixed_day: 3, post_slug: "celebration-blaise", person_type: "bishop", gender: "male" },
  { name: "Ágata, V. & M. da Sicília", celebration_type: :lesser_feast, fixed_month: 2, fixed_day: 5, post_slug: "celebration-agatha", person_type: "martyr", gender: "female" },
  { name: "Valentim, B. & M.", celebration_type: :lesser_feast, fixed_month: 2, fixed_day: 14, post_slug: "celebration-valentine", person_type: "bishop", gender: "male" },

  # MARÇO
  { name: "Davi, Arc. De Menevia", celebration_type: :lesser_feast, fixed_month: 3, fixed_day: 1, post_slug: "celebration-david-of-wales", person_type: "bishop", gender: "male" },
  { name: "Cedde, ou Chad, B. de Lichfield", celebration_type: :lesser_feast, fixed_month: 3, fixed_day: 2, post_slug: "celebration-chad-of-lichfield", person_type: "bishop", gender: "male" },
  { name: "Perpétua de Mauritânia, M.", celebration_type: :lesser_feast, fixed_month: 3, fixed_day: 7, post_slug: "celebration-perpetua-and-her-companions", person_type: "martyr", gender: "female" },
  { name: "Gregória Magno, B. de Roma & C.", celebration_type: :lesser_feast, fixed_month: 3, fixed_day: 12, post_slug: "celebration-gregory-the-great", person_type: "bishop", gender: "male" },
  { name: "Eduardo, Rei dos Saxões do Oeste", celebration_type: :lesser_feast, fixed_month: 3, fixed_day: 18, post_slug: "celebration-edward-confessor", person_type: "king", gender: "male" },
  { name: "Bento, Ab.", celebration_type: :lesser_feast, fixed_month: 3, fixed_day: 21, post_slug: "celebration-benedict-of-nursia", person_type: "abbot", gender: "male" },

  # ABRIL
  { name: "Ricardo, B. de Chichester", celebration_type: :lesser_feast, fixed_month: 4, fixed_day: 3, post_slug: "celebration-richard-of-chichester", person_type: "bishop", gender: "male" },
  { name: "Ambrósio. B. de Milão", celebration_type: :lesser_feast, fixed_month: 4, fixed_day: 4, post_slug: "celebration-ambrose", person_type: "bishop", gender: "male" },
  { name: "Alfege, Arc. de Canterbury", celebration_type: :lesser_feast, fixed_month: 4, fixed_day: 19, post_slug: "celebration-alphege", person_type: "bishop", gender: "male" },
  { name: "São Jorge, M.", celebration_type: :lesser_feast, fixed_month: 4, fixed_day: 23, post_slug: "celebration-george", person_type: "martyr", gender: "male" },

  # MAIO
  { name: "Invenção da Cruz", celebration_type: :lesser_feast, fixed_month: 5, fixed_day: 3, post_slug: "celebration-finding-of-cross", person_type: nil, gender: nil },
  { name: "São João, o Evangelista ante portam Latinam", celebration_type: :lesser_feast, fixed_month: 5, fixed_day: 6, post_slug: "celebration-john-latin-gate", person_type: "evangelist", gender: "male" },
  { name: "Dunstan, Arc. de Canterbury", celebration_type: :lesser_feast, fixed_month: 5, fixed_day: 19, post_slug: "celebration-dunstan", person_type: "bishop", gender: "male" },
  { name: "Agostinho, Arc. De Canterbury", celebration_type: :lesser_feast, fixed_month: 5, fixed_day: 26, post_slug: "celebration-augustine-of-canterbury", person_type: "bishop", gender: "male" },
  { name: "Venerável Beda, P.", celebration_type: :lesser_feast, fixed_month: 5, fixed_day: 27, post_slug: "celebration-bede", person_type: "priest", gender: "male" },

  # JUNHO
  { name: "Nicodeme, P. & M. de Roma", celebration_type: :lesser_feast, fixed_month: 6, fixed_day: 1, post_slug: "celebration-nicomedes", person_type: "martyr", gender: "male" },
  { name: "Bonifácio, B. de Mainz & Mártir", celebration_type: :lesser_feast, fixed_month: 6, fixed_day: 5, post_slug: "celebration-boniface", person_type: "bishop", gender: "male" },
  { name: "Santo Albano, M.", celebration_type: :lesser_feast, fixed_month: 6, fixed_day: 17, post_slug: "celebration-alban", person_type: "martyr", gender: "male" },
  { name: "Tr. de Edward, R. dos Saxões Ocidentais", celebration_type: :lesser_feast, fixed_month: 6, fixed_day: 20, post_slug: "celebration-edward", person_type: "king", gender: "male" },

  # JULHO
  { name: "Visitação da Bem-Aventurada V. Maria", celebration_type: :lesser_feast, fixed_month: 7, fixed_day: 2, post_slug: "celebration-visitation", person_type: "mary", gender: "female" },
  { name: "Tr. De São Martinho, B. & C.", celebration_type: :lesser_feast, fixed_month: 7, fixed_day: 4, post_slug: "celebration-translation-martin", person_type: "bishop", gender: "male" },
  { name: "Tr. de Swithun, B. de Winchester", celebration_type: :lesser_feast, fixed_month: 7, fixed_day: 15, post_slug: "celebration-swithun", person_type: "bishop", gender: "male" },
  { name: "Margarida, V. & M. em Antioquia", celebration_type: :lesser_feast, fixed_month: 7, fixed_day: 20, post_slug: "celebration-margaret-of-antioch", person_type: "martyr", gender: "female" },
  { name: "Santa Maria Madalena", celebration_type: :lesser_feast, fixed_month: 7, fixed_day: 22, post_slug: "celebration-mary-magdalene", person_type: "saint", gender: "female" },
  { name: "Santa Ana, Mãe da Bem-Aventurada V. Maria", celebration_type: :lesser_feast, fixed_month: 7, fixed_day: 26, post_slug: "celebration-saint-anne", person_type: "saint", gender: "female" },

  # AGOSTO
  { name: "Dia de Lammas", celebration_type: :lesser_feast, fixed_month: 8, fixed_day: 1, post_slug: "celebration-lammas", person_type: nil, gender: nil },
  { name: "Transfiguração do Nosso Senhor", celebration_type: :lesser_feast, fixed_month: 8, fixed_day: 6, post_slug: "celebration-transfiguration", person_type: "christ", gender: "male" },
  { name: "Nome de Jesus", celebration_type: :lesser_feast, fixed_month: 8, fixed_day: 7, post_slug: "celebration-name-of-jesus", person_type: "christ", gender: "male" },
  { name: "Lourenço, Arqdo. de Roma & M.", celebration_type: :lesser_feast, fixed_month: 8, fixed_day: 10, post_slug: "celebration-lawrence", person_type: "martyr", gender: "male" },
  { name: "São Agostinho, B. de Hipona, C., Dr.", celebration_type: :lesser_feast, fixed_month: 8, fixed_day: 28, post_slug: "celebration-augustine-of-hippo", person_type: "bishop", gender: "male" },
  { name: "Degolação de São João Batista", celebration_type: :lesser_feast, fixed_month: 8, fixed_day: 29, post_slug: "celebration-beheading-john-baptist", person_type: "baptist", gender: "male" },

  # SETEMBRO
  { name: "Giles, Ab. & C.", celebration_type: :lesser_feast, fixed_month: 9, fixed_day: 1, post_slug: "celebration-giles", person_type: "abbot", gender: "male" },
  { name: "Evúrtio, B. de Orleans", celebration_type: :lesser_feast, fixed_month: 9, fixed_day: 7, post_slug: "celebration-evurtius", person_type: "bishop", gender: "male" },
  { name: "Natividade da Bem-Aventurada V. Maria", celebration_type: :lesser_feast, fixed_month: 9, fixed_day: 8, post_slug: "celebration-nativity-of-mary", person_type: "mary", gender: "female" },
  { name: "Dia da Santa Cruz", celebration_type: :lesser_feast, fixed_month: 9, fixed_day: 14, post_slug: "celebration-holy-cross", person_type: nil, gender: nil },
  { name: "Lambert, B. & M.", celebration_type: :lesser_feast, fixed_month: 9, fixed_day: 17, post_slug: "celebration-lambert", person_type: "bishop", gender: "male" },
  { name: "São Cipriano, Arc. De Cartago & M.", celebration_type: :lesser_feast, fixed_month: 9, fixed_day: 26, post_slug: "celebration-cyprian", person_type: "bishop", gender: "male" },
  { name: "São Jerônimo, P., C., & Dr.", celebration_type: :lesser_feast, fixed_month: 9, fixed_day: 30, post_slug: "celebration-jerome-of-betlehem", person_type: "priest", gender: "male" },

  # OUTUBRO
  { name: "Remígio, B. de Reims", celebration_type: :lesser_feast, fixed_month: 10, fixed_day: 1, post_slug: "celebration-remigius", person_type: "bishop", gender: "male" },
  { name: "Santa Fé, V. & M.", celebration_type: :lesser_feast, fixed_month: 10, fixed_day: 6, post_slug: "celebration-faith", person_type: "martyr", gender: "female" },
  { name: "Dionísio, o Areopagita, B. & M.", celebration_type: :lesser_feast, fixed_month: 10, fixed_day: 9, post_slug: "celebration-dionysus-areopagite", person_type: "bishop", gender: "male" },
  { name: "Tr. do R. Eduardo, o C.", celebration_type: :lesser_feast, fixed_month: 10, fixed_day: 13, post_slug: "celebration-edward-confessor", person_type: "king", gender: "male" },
  { name: "Etelreda, V.", celebration_type: :lesser_feast, fixed_month: 10, fixed_day: 17, post_slug: "celebration-etheldreda", person_type: "saint", gender: "female" },
  { name: "Crispim, M.", celebration_type: :lesser_feast, fixed_month: 10, fixed_day: 25, post_slug: "celebration-crispin", person_type: "martyr", gender: "male" },

  # NOVEMBRO
  { name: "Leonardo, C.", celebration_type: :lesser_feast, fixed_month: 11, fixed_day: 6, post_slug: "celebration-leonard", person_type: "saint", gender: "male" },
  { name: "São Martinho, B. & C.", celebration_type: :lesser_feast, fixed_month: 11, fixed_day: 11, post_slug: "celebration-martin-of-tours", person_type: "bishop", gender: "male" },
  { name: "Britius, B.", celebration_type: :lesser_feast, fixed_month: 11, fixed_day: 13, post_slug: "celebration-britius", person_type: "bishop", gender: "male" },
  { name: "Machutus, B.", celebration_type: :lesser_feast, fixed_month: 11, fixed_day: 15, post_slug: "celebration-machutus", person_type: "bishop", gender: "male" },
  { name: "Hugo, B. de Lincoln", celebration_type: :lesser_feast, fixed_month: 11, fixed_day: 17, post_slug: "celebration-hugh-of-lincoln", person_type: "bishop", gender: "male" },
  { name: "Edmund, R. & M.", celebration_type: :lesser_feast, fixed_month: 11, fixed_day: 20, post_slug: "celebration-edmund-king", person_type: "king", gender: "male" },
  { name: "Cecília, V. & M.", celebration_type: :lesser_feast, fixed_month: 11, fixed_day: 22, post_slug: "celebration-cecilia", person_type: "martyr", gender: "female" },
  { name: "São Clemente I, B. de Roma & M.", celebration_type: :lesser_feast, fixed_month: 11, fixed_day: 23, post_slug: "celebration-clement-of-rome", person_type: "bishop", gender: "male" },
  { name: "Catarina, V. & M.", celebration_type: :lesser_feast, fixed_month: 11, fixed_day: 25, post_slug: "celebration-catherine-of-alexandria", person_type: "martyr", gender: "female" },

  # DEZEMBRO
  { name: "Nicolau, B. de Mira na Lícia", celebration_type: :lesser_feast, fixed_month: 12, fixed_day: 6, post_slug: "celebration-nicholas", person_type: "bishop", gender: "male" },
  { name: "Concepção da Bem-Aventurada V. Maria", celebration_type: :lesser_feast, fixed_month: 12, fixed_day: 8, post_slug: "celebration-conception-mary", person_type: "mary", gender: "female" },
  { name: "Lúcia, V. & M.", celebration_type: :lesser_feast, fixed_month: 12, fixed_day: 13, post_slug: "celebration-lucy", person_type: "martyr", gender: "female" },
  { name: "O Sapientia", celebration_type: :lesser_feast, fixed_month: 12, fixed_day: 16, post_slug: "celebration-o-sapientia", person_type: nil, gender: nil },
  { name: "Silvester, B. de Roma", celebration_type: :lesser_feast, fixed_month: 12, fixed_day: 31, post_slug: "celebration-sylvester", person_type: "bishop", gender: "male" }
]

count = 0
celebrations.each do |cel_data|
  # Atribuir PB
  cel_data[:prayer_book_id] = prayer_book.id

  # Nome (título) - se não fornecido, usa o name humanizado
  cel_data[:name] ||= cel_data[:title].parameterize(separator: '_') unless cel_data[:name] # Fallback apenas se não tiver name
  cel_data[:rank] = DEFAULT_RANKS[cel_data[:celebration_type]] || 500

  # Encontrar ou criar
  c = Celebration.find_or_initialize_by(
    prayer_book_id: prayer_book.id,
    name: cel_data[:name]
  )
  c.assign_attributes(cel_data.except(:title)) # Title não é coluna, é convenção minha no array
  c.name = cel_data[:name]
  c.save!
  count += 1
end

Rails.logger.info "\n✅ #{count} celebrações criadas!"
