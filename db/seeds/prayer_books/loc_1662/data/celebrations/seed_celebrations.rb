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
  { name: "1º Domingo do Advento", celebration_type: :principal_feast, liturgical_color: "purple", movable: true, calculation_rule: "first_sunday_of_advent" },
  { name: "Dia de Natal", celebration_type: :principal_feast, liturgical_color: "white", fixed_month: 12, fixed_day: 25 },
  { name: "Epifania", celebration_type: :principal_feast, liturgical_color: "white", fixed_month: 1, fixed_day: 6 },
  { name: "Quarta-feira de Cinzas", celebration_type: :major_holy_day, liturgical_color: "purple", movable: true, calculation_rule: "ash_wednesday" },
  { name: "Domingo de Ramos", celebration_type: :major_holy_day, liturgical_color: "red", movable: true, calculation_rule: "palm_sunday" },
  { name: "Quinta-feira Santa", celebration_type: :major_holy_day, liturgical_color: "white", movable: true, calculation_rule: "maundy_thursday" },
  { name: "Sexta-feira da Paixão", celebration_type: :major_holy_day, liturgical_color: "red", movable: true, calculation_rule: "good_friday" },
  { name: "Sábado Santo", celebration_type: :major_holy_day, liturgical_color: "black", movable: true, calculation_rule: "holy_saturday" },
  { name: "Domingo da Páscoa", celebration_type: :principal_feast, liturgical_color: "white", movable: true, calculation_rule: "easter" },
  { name: "Dia da Ascensão", celebration_type: :principal_feast, liturgical_color: "white", movable: true, calculation_rule: "ascension" },
  { name: "Pentecostes", celebration_type: :principal_feast, liturgical_color: "red", movable: true, calculation_rule: "pentecost" },
  { name: "Segunda-feira de Pentecostes", celebration_type: :principal_feast, liturgical_color: "red", movable: true, calculation_rule: "whitsun_monday" },
  { name: "Terça-feira de Pentecostes", celebration_type: :principal_feast, liturgical_color: "red", movable: true, calculation_rule: "whitsun_tuesday" },
  { name: "Santíssima Trindade", celebration_type: :principal_feast, liturgical_color: "white", movable: true, calculation_rule: "trinity_sunday" },
  # ============================================================================
  # DIAS SANTOS (RED LETTER DAYS)
  # ============================================================================
  { name: "Circuncisão do Senhor", celebration_type: :principal_feast, liturgical_color: "white", fixed_month: 1, fixed_day: 1 },
  { name: "Conversão de São Paulo", celebration_type: :major_holy_day, liturgical_color: "white", fixed_month: 1, fixed_day: 25 },
  { name: "Purificação de Maria", celebration_type: :major_holy_day, liturgical_color: "white", fixed_month: 2, fixed_day: 2 },
  { name: "São Matias, o Apóstolo", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 2, fixed_day: 24 },
  { name: "Anunciação da Bem-Aventurada Virgem Maria", celebration_type: :major_holy_day, liturgical_color: "white", fixed_month: 3, fixed_day: 25 },
  { name: "São Marcos, o Evangelista", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 4, fixed_day: 25 },
  { name: "São Filipe e São Tiago, os Apóstolos", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 5, fixed_day: 1 },
  { name: "São Barnabé", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 6, fixed_day: 11 },
  { name: "Nascimento de São João Batista", celebration_type: :major_holy_day, liturgical_color: "white", fixed_month: 6, fixed_day: 24 },
  { name: "São Pedro, o Apóstolo", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 6, fixed_day: 29 },
  { name: "São Tiago, o Apóstolo", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 7, fixed_day: 25 },
  { name: "São Bartolomeu, o Apóstolo", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 8, fixed_day: 24 },
  { name: "São Mateus, o Apóstolo", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 9, fixed_day: 21 },
  { name: "São Miguel e Todos os Anjos", celebration_type: :major_holy_day, liturgical_color: "white", fixed_month: 9, fixed_day: 29 },
  { name: "São Lucas, o Evangelista", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 10, fixed_day: 18 },
  { name: "São Simão e São Judas, os Apóstolos", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 10, fixed_day: 28 },
  { name: "Todos os Santos", celebration_type: :major_holy_day, liturgical_color: "white", fixed_month: 11, fixed_day: 1 },
  { name: "Santo André, o Apóstolo", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 11, fixed_day: 30 },
  { name: "São Tomé, o Apóstolo", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 12, fixed_day: 21 },
  { name: "Santo Estevão, o Mártir", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 12, fixed_day: 26 },
  { name: "São João, o Evangelista", celebration_type: :major_holy_day, liturgical_color: "white", fixed_month: 12, fixed_day: 27 },
  { name: "Santos Inocentes", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 12, fixed_day: 28 },

  # ============================================================================
  # DIAS MENORES (BLACK LETTER DAYS)
  # ============================================================================
  # JANEIRO
  { name: "Luciano, P. & M.", celebration_type: :lesser_feast, fixed_month: 1, fixed_day: 8 },
  { name: "Hilario, B & C.", celebration_type: :lesser_feast, fixed_month: 1, fixed_day: 13 },
  { name: "Priscila, V. & M. Romana", celebration_type: :lesser_feast, fixed_month: 1, fixed_day: 18 },
  { name: "Fabiano, B. de Roma & M.", celebration_type: :lesser_feast, fixed_month: 1, fixed_day: 20 },
  { name: "Agnes, V. & M. Romana", celebration_type: :lesser_feast, fixed_month: 1, fixed_day: 21 },
  { name: "Vicente, D. & M. Espanhol", celebration_type: :lesser_feast, fixed_month: 1, fixed_day: 22 },

  # FEVEREIRO
  { name: "Brás, B. & M. Armênio", celebration_type: :lesser_feast, fixed_month: 2, fixed_day: 3 },
  { name: "Ágata, V. & M. da Sicília", celebration_type: :lesser_feast, fixed_month: 2, fixed_day: 5 },
  { name: "Valentim, B. & M.", celebration_type: :lesser_feast, fixed_month: 2, fixed_day: 14 },

  # MARÇO
  { name: "Davi, Arc. De Menevia", celebration_type: :lesser_feast, fixed_month: 3, fixed_day: 1 },
  { name: "Cedde, ou Chad, B. de Lichfield", celebration_type: :lesser_feast, fixed_month: 3, fixed_day: 2 },
  { name: "Perpétua de Mauritânia, M.", celebration_type: :lesser_feast, fixed_month: 3, fixed_day: 7 },
  { name: "Gregória Magno, B. de Roma & C.", celebration_type: :lesser_feast, fixed_month: 3, fixed_day: 12 },
  { name: "Eduardo, Rei dos Saxões do Oeste", celebration_type: :lesser_feast, fixed_month: 3, fixed_day: 18 },
  { name: "Bento, Ab.", celebration_type: :lesser_feast, fixed_month: 3, fixed_day: 21 },

  # ABRIL
  { name: "Ricardo, B. de Chichester", celebration_type: :lesser_feast, fixed_month: 4, fixed_day: 3 },
  { name: "Ambrósio. B. de Milão", celebration_type: :lesser_feast, fixed_month: 4, fixed_day: 4 },
  { name: "Alfege, Arc. de Canterbury", celebration_type: :lesser_feast, fixed_month: 4, fixed_day: 19 },
  { name: "São Jorge, M.", celebration_type: :lesser_feast, fixed_month: 4, fixed_day: 23 },

  # MAIO
  { name: "Invenção da Cruz", celebration_type: :lesser_feast, fixed_month: 5, fixed_day: 3 },
  { name: "São João, o Evangelista ante portam Latinam", celebration_type: :lesser_feast, fixed_month: 5, fixed_day: 6 },
  { name: "Dunstan, Arc. de Canterbury", celebration_type: :lesser_feast, fixed_month: 5, fixed_day: 19 },
  { name: "Agostinho, Arc. De Canterbury", celebration_type: :lesser_feast, fixed_month: 5, fixed_day: 26 },
  { name: "Venerável Beda, P.", celebration_type: :lesser_feast, fixed_month: 5, fixed_day: 27 },

  # JUNHO
  { name: "Nicodeme, P. & M. de Roma", celebration_type: :lesser_feast, fixed_month: 6, fixed_day: 1 },
  { name: "Bonifácio, B. de Mainz & Mártir", celebration_type: :lesser_feast, fixed_month: 6, fixed_day: 5 },
  { name: "Santo Albano, M.", celebration_type: :lesser_feast, fixed_month: 6, fixed_day: 17 },
  { name: "Tr. de Edward, R. dos Saxões Ocidentais", celebration_type: :lesser_feast, fixed_month: 6, fixed_day: 20 },

  # JULHO
  { name: "Visitação da Bem-Aventurada V. Maria", celebration_type: :lesser_feast, fixed_month: 7, fixed_day: 2 },
  { name: "Tr. De São Martinho, B. & C.", celebration_type: :lesser_feast, fixed_month: 7, fixed_day: 4 },
  { name: "Tr. de Swithun, B. de Winchester", celebration_type: :lesser_feast, fixed_month: 7, fixed_day: 15 },
  { name: "Margarida, V. & M. em Antioquia", celebration_type: :lesser_feast, fixed_month: 7, fixed_day: 20 },
  { name: "Santa Maria Madalena", celebration_type: :lesser_feast, fixed_month: 7, fixed_day: 22 },
  { name: "Santa Ana, Mãe da Bem-Aventurada V. Maria", celebration_type: :lesser_feast, fixed_month: 7, fixed_day: 26 },

  # AGOSTO
  { name: "Dia de Lammas", celebration_type: :lesser_feast, fixed_month: 8, fixed_day: 1 },
  { name: "Transfiguração do Nosso Senhor", celebration_type: :lesser_feast, fixed_month: 8, fixed_day: 6 },
  { name: "Nome de Jesus", celebration_type: :lesser_feast, fixed_month: 8, fixed_day: 7 },
  { name: "Lourenço, Arqdo. de Roma & M.", celebration_type: :lesser_feast, fixed_month: 8, fixed_day: 10 },
  { name: "São Agostinho, B. de Hipona, C., Dr.", celebration_type: :lesser_feast, fixed_month: 8, fixed_day: 28 },
  { name: "Degolação de São João Batista", celebration_type: :lesser_feast, fixed_month: 8, fixed_day: 29 },

  # SETEMBRO
  { name: "Giles, Ab. & C.", celebration_type: :lesser_feast, fixed_month: 9, fixed_day: 1 },
  { name: "Evúrtio, B. de Orleans", celebration_type: :lesser_feast, fixed_month: 9, fixed_day: 7 },
  { name: "Natividade da Bem-Aventurada V. Maria", celebration_type: :lesser_feast, fixed_month: 9, fixed_day: 8 },
  { name: "Dia da Santa Cruz", celebration_type: :lesser_feast, fixed_month: 9, fixed_day: 14 },
  { name: "Lambert, B. & M.", celebration_type: :lesser_feast, fixed_month: 9, fixed_day: 17 },
  { name: "São Cipriano, Arc. De Cartago & M.", celebration_type: :lesser_feast, fixed_month: 9, fixed_day: 26 },
  { name: "São Jerônimo, P., C., & Dr.", celebration_type: :lesser_feast, fixed_month: 9, fixed_day: 30 },

  # OUTUBRO
  { name: "Remígio, B. de Reims", celebration_type: :lesser_feast, fixed_month: 10, fixed_day: 1 },
  { name: "Santa Fé, V. & M.", celebration_type: :lesser_feast, fixed_month: 10, fixed_day: 6 },
  { name: "Dionísio, o Areopagita, B. & M.", celebration_type: :lesser_feast, fixed_month: 10, fixed_day: 9 },
  { name: "Tr. do R. Eduardo, o C.", celebration_type: :lesser_feast, fixed_month: 10, fixed_day: 13 },
  { name: "Etelreda, V.", celebration_type: :lesser_feast, fixed_month: 10, fixed_day: 17 },
  { name: "Crispim, M.", celebration_type: :lesser_feast, fixed_month: 10, fixed_day: 25 },

  # NOVEMBRO
  { name: "Leonardo, C.", celebration_type: :lesser_feast, fixed_month: 11, fixed_day: 6 },
  { name: "São Martinho, B. & C.", celebration_type: :lesser_feast, fixed_month: 11, fixed_day: 11 },
  { name: "Britius, B.", celebration_type: :lesser_feast, fixed_month: 11, fixed_day: 13 },
  { name: "Machutus, B.", celebration_type: :lesser_feast, fixed_month: 11, fixed_day: 15 },
  { name: "Hugo, B. de Lincoln", celebration_type: :lesser_feast, fixed_month: 11, fixed_day: 17 },
  { name: "Edmund, R. & M.", celebration_type: :lesser_feast, fixed_month: 11, fixed_day: 20 },
  { name: "Cecília, V. & M.", celebration_type: :lesser_feast, fixed_month: 11, fixed_day: 22 },
  { name: "São Clemente I, B. de Roma & M.", celebration_type: :lesser_feast, fixed_month: 11, fixed_day: 23 },
  { name: "Catarina, V. & M.", celebration_type: :lesser_feast, fixed_month: 11, fixed_day: 25 },

  # DEZEMBRO
  { name: "Nicolau, B. de Mira na Lícia", celebration_type: :lesser_feast, fixed_month: 12, fixed_day: 6 },
  { name: "Concepção da Bem-Aventurada V. Maria", celebration_type: :lesser_feast, fixed_month: 12, fixed_day: 8 },
  { name: "Lúcia, V. & M.", celebration_type: :lesser_feast, fixed_month: 12, fixed_day: 13 },
  { name: "O Sapientia", celebration_type: :lesser_feast, fixed_month: 12, fixed_day: 16 },
  { name: "Silvester, B. de Roma", celebration_type: :lesser_feast, fixed_month: 12, fixed_day: 31 }
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
