# ================================================================================
# CELEBRAÇÕES - LOC 2021 IAB
# ================================================================================

Rails.logger.info "📅 Carregando celebrações do calendário (LOC 2021 IAB)..."

prayer_book = PrayerBook.find_by!(code: 'loc_2021')

celebrations = [
  # FESTAS PRINCIPAIS
  { name: "Páscoa", celebration_type: "principal_feast", liturgical_color: "branco", movable: true, calculation_rule: "easter", rank: 0, can_be_transferred: false, post_slug: "celebration-easter", person_type: "event", gender: "neutral" },
  { name: "Vigília Pascal", celebration_type: "principal_feast", liturgical_color: "branco", movable: true, calculation_rule: "easter_minus_1_day", rank: 1, can_be_transferred: false, post_slug: "celebration-easter-vigil", person_type: "event", gender: "neutral" },
  { name: "Natal", celebration_type: "principal_feast", liturgical_color: "branco", fixed_month: 12, fixed_day: 25, rank: 1, can_be_transferred: false, post_slug: "celebration-christmas", person_type: "event", gender: "neutral" },
  { name: "Vigília de Natal", celebration_type: "principal_feast", liturgical_color: "branco", fixed_month: 12, fixed_day: 24, rank: 1, can_be_transferred: false, post_slug: "celebration-christmas-eve", person_type: "event", gender: "neutral" },
  { name: "Epifania", celebration_type: "principal_feast", liturgical_color: "branco", fixed_month: 1, fixed_day: 6, rank: 3, can_be_transferred: false, post_slug: "celebration-epiphany", person_type: "event", gender: "neutral" },
  { name: "Batismo de Cristo", celebration_type: "principal_feast", liturgical_color: "branco", movable: true, calculation_rule: "first_sunday_after_epiphany", rank: 4, can_be_transferred: false, post_slug: "celebration-baptism-of-christ", person_type: "event", gender: "neutral" },
  { name: "Ascensão", celebration_type: "principal_feast", liturgical_color: "branco", movable: true, calculation_rule: "easter_plus_39_days", rank: 7, can_be_transferred: true, post_slug: "celebration-ascension", person_type: "event", gender: "neutral" },
  { name: "Pentecostes", celebration_type: "principal_feast", liturgical_color: "vermelho", movable: true, calculation_rule: "easter_plus_49_days", rank: 8, can_be_transferred: false, post_slug: "celebration-pentecost", person_type: "event", gender: "neutral" },
  { name: "Santíssima Trindade", celebration_type: "principal_feast", liturgical_color: "branco", movable: true, calculation_rule: "first_sunday_after_pentecost", rank: 9, can_be_transferred: false, post_slug: "celebration-trinity", person_type: "event", gender: "neutral" },
  { name: "Transfiguração", celebration_type: "principal_feast", liturgical_color: "branco", fixed_month: 8, fixed_day: 6, rank: 10, can_be_transferred: false, post_slug: "celebration-transfiguration", person_type: "event", gender: "neutral" },
  { name: "Cristo Rei", celebration_type: "principal_feast", liturgical_color: "branco", movable: true, calculation_rule: "sunday_before_advent", rank: 12, can_be_transferred: false, post_slug: "celebration-christ-the-king", person_type: "event", gender: "neutral" },

  # DIAS SANTOS PRINCIPAIS / SEMANA SANTA
  { name: "Quarta-Feira de Cinzas", celebration_type: "major_holy_day", liturgical_color: "roxo", movable: true, calculation_rule: "ash_wednesday", rank: 50, can_be_transferred: false, post_slug: "celebration-ash-wednesday", person_type: "event", gender: "neutral" },
  { name: "Domingo de Ramos", celebration_type: "major_holy_day", liturgical_color: "vermelho", movable: true, calculation_rule: "palm_sunday", rank: 50, can_be_transferred: false, post_slug: "celebration-palm-sunday", person_type: "event", gender: "neutral" },
  { name: "Segunda-Feira Santa", celebration_type: "major_holy_day", liturgical_color: "roxo", movable: true, calculation_rule: "monday_holy_week", rank: 50, can_be_transferred: false, post_slug: "celebration-holy-monday", person_type: "event", gender: "neutral" },
  { name: "Terça-Feira Santa", celebration_type: "major_holy_day", liturgical_color: "roxo", movable: true, calculation_rule: "tuesday_holy_week", rank: 50, can_be_transferred: false, post_slug: "celebration-holy-tuesday", person_type: "event", gender: "neutral" },
  { name: "Quarta-Feira Santa", celebration_type: "major_holy_day", liturgical_color: "roxo", movable: true, calculation_rule: "wednesday_holy_week", rank: 50, can_be_transferred: false, post_slug: "celebration-holy-wednesday", person_type: "event", gender: "neutral" },
  { name: "Quinta-Feira Santa", celebration_type: "major_holy_day", liturgical_color: "branco", movable: true, calculation_rule: "maundy_thursday", rank: 50, can_be_transferred: false, post_slug: "celebration-maundy-thursday", person_type: "event", gender: "neutral" },
  { name: "Sexta-Feira da Paixão", celebration_type: "major_holy_day", liturgical_color: "vermelho", movable: true, calculation_rule: "good_friday", rank: 50, can_be_transferred: false, post_slug: "celebration-good-friday", person_type: "event", gender: "neutral" },
  { name: "Sábado Santo", celebration_type: "major_holy_day", liturgical_color: "roxo", movable: true, calculation_rule: "holy_saturday", rank: 50, can_be_transferred: false, post_slug: "celebration-holy-saturday", person_type: "event", gender: "neutral" },

  # DIAS SANTOS E FESTIVAIS FIXOS
  { name: "Santo Nome de Jesus", celebration_type: "festival", liturgical_color: "branco", fixed_month: 1, fixed_day: 1, rank: 100, post_slug: "celebration-holy-name-circumcision", person_type: "event", gender: "neutral" },
  { name: "Conversão de S. Paulo", celebration_type: "festival", liturgical_color: "branco", fixed_month: 1, fixed_day: 25, rank: 100, post_slug: "celebration-conversion-of-paul", person_type: "event", gender: "neutral" },
  { name: "Apresentação de Cristo no Templo", celebration_type: "festival", liturgical_color: "branco", fixed_month: 2, fixed_day: 2, rank: 100, post_slug: "celebration-presentation", person_type: "event", gender: "neutral" },
  { name: "S. José", celebration_type: "festival", liturgical_color: "branco", fixed_month: 3, fixed_day: 19, rank: 100, post_slug: "celebration-joseph-of-nazareth", person_type: "singular", gender: "masculine" },
  { name: "Anunciação de Nosso Senhor", celebration_type: "festival", liturgical_color: "branco", fixed_month: 3, fixed_day: 25, rank: 100, post_slug: "celebration-annunciation", person_type: "event", gender: "neutral" },
  { name: "S. Marcos, Evangelista", celebration_type: "festival", liturgical_color: "vermelho", fixed_month: 4, fixed_day: 25, rank: 100, post_slug: "celebration-mark-the-evangelist", person_type: "singular", gender: "masculine" },
  { name: "S. Filipe e S. Tiago, Apóstolos", celebration_type: "festival", liturgical_color: "vermelho", fixed_month: 5, fixed_day: 1, rank: 100, post_slug: "celebration-philip-and-james-apostles", person_type: "plural", gender: "masculine" },
  { name: "S. Matias, Apóstolo", celebration_type: "festival", liturgical_color: "vermelho", fixed_month: 5, fixed_day: 14, rank: 100, post_slug: "celebration-matthias-the-apostle", person_type: "singular", gender: "masculine" },
  { name: "Visitação da Virgem Maria", celebration_type: "festival", liturgical_color: "branco", fixed_month: 5, fixed_day: 31, rank: 100, post_slug: "celebration-visitation", person_type: "event", gender: "neutral" },
  { name: "S. Barnabé, Apóstolo", celebration_type: "festival", liturgical_color: "vermelho", fixed_month: 6, fixed_day: 11, rank: 100, post_slug: "celebration-barnabas-the-apostle", person_type: "singular", gender: "masculine" },
  { name: "Natividade de S. João Batista", celebration_type: "festival", liturgical_color: "branco", fixed_month: 6, fixed_day: 24, rank: 100, post_slug: "celebration-nativity-of-john-the-baptist", person_type: "event", gender: "neutral" },
  { name: "S. Pedro e S. Paulo, Apóstolos", celebration_type: "festival", liturgical_color: "vermelho", fixed_month: 6, fixed_day: 29, rank: 100, post_slug: "celebration-peter-and-paul-apostles", person_type: "plural", gender: "masculine" },
  { name: "S. Tomé, Apóstolo", celebration_type: "festival", liturgical_color: "vermelho", fixed_month: 7, fixed_day: 3, rank: 100, post_slug: "celebration-thomas-the-apostle", person_type: "singular", gender: "masculine" },
  { name: "Sta. Maria Madalena", celebration_type: "festival", liturgical_color: "branco", fixed_month: 7, fixed_day: 22, rank: 100, post_slug: "celebration-mary-magdalene", person_type: "singular", gender: "feminine" },
  { name: "S. Tiago, Apóstolo", celebration_type: "festival", liturgical_color: "vermelho", fixed_month: 7, fixed_day: 25, rank: 100, post_slug: "celebration-james-the-apostle", person_type: "singular", gender: "masculine" },
  { name: "S. Bartolomeu, Apóstolo", celebration_type: "festival", liturgical_color: "vermelho", fixed_month: 8, fixed_day: 24, rank: 100, post_slug: "celebration-bartholomew-the-apostle", person_type: "singular", gender: "masculine" },
  { name: "Bem-aventurada Virgem Maria", celebration_type: "festival", liturgical_color: "branco", fixed_month: 9, fixed_day: 8, rank: 100, post_slug: "celebration-assumption-of-mary", person_type: "singular", gender: "feminine" },
  { name: "S. Mateus, Apóstolo", celebration_type: "festival", liturgical_color: "vermelho", fixed_month: 9, fixed_day: 21, rank: 100, post_slug: "celebration-matthew-the-apostle", person_type: "singular", gender: "masculine" },
  { name: "S. Miguel e Todos os Anjos", celebration_type: "festival", liturgical_color: "branco", fixed_month: 9, fixed_day: 29, rank: 100, post_slug: "celebration-archangel-michael-and-all-angels", person_type: "plural", gender: "masculine" },
  { name: "S. Lucas, Evangelista", celebration_type: "festival", liturgical_color: "vermelho", fixed_month: 10, fixed_day: 18, rank: 100, post_slug: "celebration-luke-the-evangelist", person_type: "singular", gender: "masculine" },
  { name: "S. Simão e S. Judas, Apóstolos", celebration_type: "festival", liturgical_color: "vermelho", fixed_month: 10, fixed_day: 28, rank: 100, post_slug: "celebration-simon-and-jude-apostles", person_type: "plural", gender: "masculine" },
  { name: "Todos os Santos", celebration_type: "festival", liturgical_color: "branco", fixed_month: 11, fixed_day: 1, rank: 100, post_slug: "celebration-all-saints", person_type: "event", gender: "neutral" },
  { name: "S. André, Apóstolo", celebration_type: "festival", liturgical_color: "vermelho", fixed_month: 11, fixed_day: 30, rank: 100, post_slug: "celebration-andrew-the-apostle", person_type: "singular", gender: "masculine" },
  { name: "S. Estevão", celebration_type: "festival", liturgical_color: "vermelho", fixed_month: 12, fixed_day: 26, rank: 100, post_slug: "celebration-stephen", person_type: "singular", gender: "masculine" },
  { name: "S. João Evangelista", celebration_type: "festival", liturgical_color: "branco", fixed_month: 12, fixed_day: 27, rank: 100, post_slug: "celebration-john-the-apostle", person_type: "singular", gender: "masculine" },
  { name: "Santos Inocentes", celebration_type: "festival", liturgical_color: "vermelho", fixed_month: 12, fixed_day: 28, rank: 100, post_slug: "celebration-holy-innocents", person_type: "plural", gender: "masculine" }
]

count = 0
celebrations.each do |data|
  data[:prayer_book_id] = prayer_book.id
  Celebration.find_or_create_by!(name: data[:name], prayer_book_id: prayer_book.id) do |c|
    c.assign_attributes(data)
  end
  count += 1
end

Rails.logger.info "✅ #{count} celebrações criadas/atualizadas!"
