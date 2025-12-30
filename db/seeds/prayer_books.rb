# frozen_string_literal: true

Rails.logger.info "Seeding Prayer Books..."

# Portuguese Prayer Books (existing + premium flags)
portuguese_prayer_books = [
  {
    order: 1,
    code: "loc_2015",
    name: "IEAB - 2015",
    year: 2015,
    language: "pt-BR",
    premium_required: false,  # FREE - DEFAULT
    jurisdiction: "Igreja Episcopal Anglicana do Brasil",
    description: "LOC atual da IEAB, parte de uma nova geração de Livros de Oração",
    thumbnail_url: "https://caminhoanglicano.com.br/locs/thumbs/loc-2015.png",
    pdf_url: "https://caminhoanglicano.com.br/locs/pdfs/loc-2015.pdf",
    is_recommended: true,
    features: {
      lectionary: {
        reading_types: [ "semicontinuous", "complementary" ],
        default_reading_type: "semicontinuous",
        readings_per_week: 4,
        supports_vigil: false
      },
      daily_office: {
        supports_family_rite: true,
        available_confession_types: [ "long", "short" ],
        available_lords_prayer: [ "traditional", "contemporary" ]
      },
      psalter: {
        cycle_length: 30,
        supports_seasonal_variations: true
      }
    }
  },
  {
    order: 2,
    code: "locb_2008",
    name: "LOCb - 2008",
    year: 2008,
    language: "pt-BR",
    premium_required: false,
    jurisdiction: "Diocese do Recife - Comunhão Anglicana Sob Autoridade Primacial da Igreja Anglicana do Cone Sul da América",
    description: "Adotado pela Diocese do Recife - Comunhão Anglicana Sob Autoridade Primacial da Igreja Anglicana do Cone Sul da América",
    thumbnail_url: "https://caminhoanglicano.com.br/locs/thumbs/locb-2008.png",
    pdf_url: "https://caminhoanglicano.com.br/locs/pdfs/locb-2008.pdf",
    is_recommended: false,
    features: {
      lectionary: {
        reading_types: [ "semicontinuous" ],
        default_reading_type: "semicontinuous",
        readings_per_week: 4,
        supports_vigil: false
      },
      daily_office: {
        supports_family_rite: false,
        available_confession_types: [ "long" ],
        available_lords_prayer: [ "traditional" ]
      },
      psalter: {
        cycle_length: 28,
        supports_seasonal_variations: false
      }
    }
  },
  {
    order: 3,
    code: "loc_1987",
    name: "IECB - 1987",
    year: 1987,
    language: "pt-BR",
    premium_required: false,
    jurisdiction: "Igreja Episcopal Anglicana do Brasil",
    description: "Versão do LOC da Igreja Episcopal Anglicana do Brasil de 1984 - Revisão de Julho de 1987 - Usado pela IECB",
    thumbnail_url: "https://caminhoanglicano.com.br/locs/thumbs/loc-1987.png",
    pdf_url: "https://caminhoanglicano.com.br/locs/pdfs/loc-1987.pdf",
    is_recommended: false,
    features: {
      daily_office: {
        has_midday: false,
        has_compline: false
      }
    }
  },
  {
    order: 4,
    code: "loc_1662",
    name: "IARB - 1662",
    year: 1662,
    language: "pt-BR",
    premium_required: true,  # PREMIUM
    jurisdiction: "Igreja Anglicana Reformada do Brasil",
    description: "Adotado pela Igreja Anglicana Reformada do Brasil, tradução do LOC da Igreja da Inglaterra de 1662",
    thumbnail_url: "https://caminhoanglicano.com.br/locs/thumbs/loc-1662.png",
    pdf_url: "https://caminhoanglicano.com.br/locs/pdfs/loc-1662.pdf",
    is_recommended: false,
    features: {
      lectionary: {
        reading_types: [ "semicontinuous" ],
        default_reading_type: "semicontinuous",
        readings_per_week: 4,
        supports_vigil: false
      },
      daily_office: {
        supports_family_rite: false,
        available_confession_types: [ "long" ],
        available_lords_prayer: [ "traditional" ]
      },
      psalter: {
        cycle_length: 30,
        supports_seasonal_variations: false
      }
    }
  },
  {
    order: 5,
    code: "loc_2021",
    name: "IAB - 2021",
    year: 2021,
    language: "pt-BR",
    premium_required: false,
    jurisdiction: "Igreja Anglicana no Brasil",
    description: "LOC atual da IEAB, parte de uma nova geração de Livros de Oração",
    thumbnail_url: "https://caminhoanglicano.com.br/locs/thumbs/loc-2021.png",
    pdf_url: "https://caminhoanglicano.com.br/locs/pdfs/loc-2021.pdf",
    is_recommended: false,
    features: {
      lectionary: {
        reading_types: [ "semicontinuous" ],
        default_reading_type: "semicontinuous",
        readings_per_week: 4,
        supports_vigil: false
      },
      daily_office: {
        supports_family_rite: false,
        available_confession_types: [ "long", "short" ],
        available_lords_prayer: [ "traditional", "contemporary" ]
      },
      psalter: {
        cycle_length: 30,
        supports_seasonal_variations: false
      }
    }
  },
  {
    order: 6,
    code: "loc_2019",
    name: "ACNA - 2019",
    year: 2019,
    language: "pt-BR",
    premium_required: false,  # PREMIUM
    jurisdiction: "Anglican Church in North America",
    description: "LOC da ACNA, com Ofícios e Lecionário traduzidos pelo Rev. Douglas Araujo",
    thumbnail_url: "https://caminhoanglicano.com.br/locs/thumbs/loc-2019.png",
    pdf_url: "https://caminhoanglicano.com.br/locs/pdfs/loc-2019.pdf",
    is_recommended: false,
    features: {
      lectionary: {
        reading_types: [ "semicontinuous", "complementary" ],
        default_reading_type: "semicontinuous",
        readings_per_week: 7,
        supports_vigil: true
      },
      daily_office: {
        supports_family_rite: true,
        available_confession_types: [ "long", "short" ],
        available_lords_prayer: [ "traditional", "contemporary" ]
      },
      psalter: {
        cycle_length: 60,
        supports_seasonal_variations: true
      }
    }
  }
]

# English Prayer Books (new)
english_prayer_books = [
  {
    order: 1,
    code: "loc_2019_en",
    name: "ACNA - 2019",
    year: 2019,
    language: "en",
    premium_required: false,  # PREMIUM
    jurisdiction: "Anglican Church in North America",
    description: "The Book of Common Prayer (2019) from the Anglican Church in North America",
    thumbnail_url: "https://caminhoanglicano.com.br/locs/thumbs/loc-2019.png",
    pdf_url: "https://bcp2019.anglicanchurch.net/",
    is_recommended: false,
    features: {
      lectionary: {
        reading_types: [ "semicontinuous", "complementary" ],
        default_reading_type: "semicontinuous",
        readings_per_week: 7,
        supports_vigil: true
      },
      daily_office: {
        supports_family_rite: true,
        available_confession_types: [ "long", "short" ],
        available_lords_prayer: [ "traditional", "contemporary" ]
      },
      psalter: {
        cycle_length: 60,
        supports_seasonal_variations: true
      }
    }
  }
  # Future: Add more English Prayer Books (BCP 1662, BCP 1979, etc.)
]

# Spanish Prayer Books (prepared for future)
spanish_prayer_books = [
  # Future: Add Spanish translations
]

# Combine all prayer books
all_prayer_books = portuguese_prayer_books + english_prayer_books + spanish_prayer_books


all_prayer_books.each_with_index do |data, idx|
  pb = PrayerBook.find_or_initialize_by(code: data[:code])
  # Garante que o campo order seja preenchido, mesmo se não estiver no hash
  pb.assign_attributes(data.except(:code).merge(order: data[:order] || idx + 1))
  pb.save!

  premium_badge = pb.premium_required ? "[PREMIUM]" : "[FREE]"
  Rails.logger.info "✓ #{premium_badge} #{data[:language]} - #{data[:code]}"
end

Rails.logger.info "Prayer Books seeded successfully!"
