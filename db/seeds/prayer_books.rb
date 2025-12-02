# frozen_string_literal: true

Rails.logger.info "Seeding Prayer Books..."

prayer_books_data = [
  {
    code: "loc_1987",
    name: "IECB - 1987",
    year: 1987,
    jurisdiction: "Igreja Episcopal Anglicana do Brasil",
    description: "Versão do LOC da Igreja Episcopal Anglicana do Brasil de 1984 - Revisão de Julho de 1987 - Usado pela IECB",
    thumbnail_url: "https://caminhoanglicano.com.br/locs/thumbs/loc-1987.png",
    pdf_url: "https://caminhoanglicano.com.br/locs/pdfs/loc-1987.pdf",
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
    code: "locb_2008",
    name: "LOCb - 2008",
    year: 2008,
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
    code: "loc_1662",
    name: "IARB - 1662",
    year: 1662,
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
    code: "loc_2021",
    name: "IAB - 2021",
    year: 2021,
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
    code: "loc_2015",
    name: "IEAB - 2015",
    year: 2015,
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
    code: "loc_2019",
    name: "ACNA - 2019",
    year: 2019,
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

prayer_books_data.each do |data|
  pb = PrayerBook.find_or_initialize_by(code: data[:code])
  pb.name = data[:name]
  pb.year = data[:year]
  pb.jurisdiction = data[:jurisdiction]
  pb.description = data[:description]
  pb.thumbnail_url = data[:thumbnail_url]
  pb.pdf_url = data[:pdf_url]
  pb.is_recommended = data[:is_recommended]
  pb.features = data[:features] if data[:features].present?
  pb.save!
  Rails.logger.info "✓ LOC Criado/Atualizado: #{data[:code]}"
end

Rails.logger.info "Prayer Books seeded successfully!"
