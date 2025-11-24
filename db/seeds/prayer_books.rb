# frozen_string_literal: true

puts "Seeding Prayer Books..."

prayer_books_data = [
  {
    code: "loc_1987",
    name: "Livro de Oração Comum - 1987",
    year: 1987,
    jurisdiction: "Igreja Episcopal Anglicana do Brasil",
    description: "Versão do LOC da Igreja Episcopal Anglicana do Brasil de 1984 - Revisão de Julho de 1987",
    thumbnail_url: "https://caminhoanglicano.com.br/locs/thumbs/loc-1987.png",
    pdf_url: "https://caminhoanglicano.com.br/locs/pdfs/loc-1987.pdf",
    is_default: false
  },
  {
    code: "locb_2008",
    name: "Livro de Oração Comum Brasileiro - 2008",
    year: 2008,
    jurisdiction: "Diocese do Recife - Comunhão Anglicana Sob Autoridade Primacial da Igreja Anglicana do Cone Sul da América",
    description: "Adotado pela Diocese do Recife - Comunhão Anglicana Sob Autoridade Primacial da Igreja Anglicana do Cone Sul da América",
    thumbnail_url: "https://caminhoanglicano.com.br/locs/thumbs/locb-2008.png",
    pdf_url: "https://caminhoanglicano.com.br/locs/pdfs/locb-2008.pdf",
    is_default: false
  },
  {
    code: "loc_1662",
    name: "Livro de Oração Comum - IARB - 1662",
    year: 1662,
    jurisdiction: "Igreja Anglicana Reformada do Brasil",
    description: "Adotado pela Igreja Anglicana Reformada do Brasil, tradução do LOC da Igreja da Inglaterra de 1662",
    thumbnail_url: "https://caminhoanglicano.com.br/locs/thumbs/loc-1662.png",
    pdf_url: "https://caminhoanglicano.com.br/locs/pdfs/loc-1662.pdf",
    is_default: false
  },
  {
    code: "loc_2012",
    name: "Livro de Oração Comum Contemporâneo - IAB - 2012",
    year: 2012,
    jurisdiction: "Igreja Anglicana no Brasil",
    description: "LOC atual da IEAB, parte de uma nova geração de Livros de Oração",
    thumbnail_url: "https://caminhoanglicano.com.br/locs/thumbs/loc-2012.png",
    pdf_url: "https://caminhoanglicano.com.br/locs/pdfs/loc-2012.pdf",
    is_default: false
  },
  {
    code: "loc_2015",
    name: "Livro de Oração Comum - IEAB - 2015",
    year: 2015,
    jurisdiction: "Igreja Episcopal Anglicana do Brasil",
    description: "LOC atual da IEAB, parte de uma nova geração de Livros de Oração",
    thumbnail_url: "https://caminhoanglicano.com.br/locs/thumbs/loc-2015.png",
    pdf_url: "https://caminhoanglicano.com.br/locs/pdfs/loc-2015.pdf",
    is_default: true
  },
  {
    code: "loc_2019",
    name: "Livro de Oração Comum - IEAB - 2019",
    year: 2019,
    jurisdiction: "Anglican Church in North America",
    description: "LOC da ACNA, com Ofícios e Lecionário traduzidos pelo Rev. Douglas Araujo",
    thumbnail_url: "https://caminhoanglicano.com.br/locs/thumbs/loc-2019.png",
    pdf_url: "https://caminhoanglicano.com.br/locs/pdfs/loc-2019.pdf",
    is_default: false
  }
]

prayer_books_data.each do |data|
  PrayerBook.find_or_create_by!(code: data[:code]) do |pb|
    pb.name = data[:name]
    pb.year = data[:year]
    pb.jurisdiction = data[:jurisdiction]
    pb.description = data[:description]
    pb.thumbnail_url = data[:thumbnail_url]
    pb.pdf_url = data[:pdf_url]
    pb.is_default = data[:is_default]
  end
  puts "✓ LOC Criado: #{data[:code]}"
end

puts "Prayer Books seeded successfully!"
