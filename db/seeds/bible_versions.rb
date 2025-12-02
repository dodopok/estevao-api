# frozen_string_literal: true

Rails.logger.info "Seeding Bible Versions..."

bible_versions_data = [
  {
    code: "nvi",
    name: "NVI",
    full_name: "Nova Versão Internacional",
    language: "pt-BR",
    description: "Tradução moderna e equilibrada, amplamente utilizada no Brasil",
    publisher: "Vida",
    year: 2011,
    is_recommended: true,
    license: "proprietary"
  },
  {
    code: "nvt",
    name: "NVT",
    full_name: "Nova Versão Transformadora",
    language: "pt-BR",
    description: "Linguagem contemporânea e acessível",
    publisher: "Mundo Cristão",
    year: 2016,
    is_recommended: false,
    license: "proprietary"
  },
  {
    code: "naa",
    name: "NAA",
    full_name: "Nova Almeida Atualizada",
    language: "pt-BR",
    description: "Revisão da clássica tradução Almeida",
    publisher: "SBB",
    year: 2017,
    is_recommended: false,
    license: "open"
  },
  {
    code: "ara",
    name: "ARA",
    full_name: "Almeida Revista e Atualizada",
    language: "pt-BR",
    description: "Tradução tradicional e respeitada",
    publisher: "SBB",
    year: 1993,
    is_recommended: false,
    license: "open"
  },
  {
    code: "acf",
    name: "ACF",
    full_name: "Almeida Corrigida Fiel",
    language: "pt-BR",
    description: "Versão tradicional preservada baseada no Textus Receptus",
    publisher: "SBTB",
    year: 1994,
    is_recommended: false,
    license: "open"
  },
  {
    code: "ntlh",
    name: "NTLH",
    full_name: "Nova Tradução na Linguagem de Hoje",
    language: "pt-BR",
    description: "Linguagem simples e clara para leitura fácil",
    publisher: "SBB",
    year: 2000,
    is_recommended: false,
    license: "open"
  },
  {
    code: "arc",
    name: "ARC",
    full_name: "Almeida Revista e Corrigida",
    language: "pt-BR",
    description: "Edição clássica da tradução Almeida",
    publisher: "SBB",
    year: 1995,
    is_recommended: false,
    license: "open"
  },
  {
    code: "kja",
    name: "KJA",
    full_name: "King James Atualizada",
    language: "pt-BR",
    description: "Baseada na tradição King James com linguagem atualizada",
    publisher: "Abba Press",
    year: 1999,
    is_recommended: false,
    license: "open"
  },
  {
    code: "as21",
    name: "AS21",
    full_name: "Almeida Século XXI",
    language: "pt-BR",
    description: "Atualização da Almeida para o século 21",
    publisher: "Vida Nova",
    year: 2008,
    is_recommended: false,
    license: "proprietary"
  },
  {
    code: "jfaa",
    name: "JFAA",
    full_name: "João Ferreira de Almeida Atualizada",
    language: "pt-BR",
    description: "Versão atualizada da tradução clássica",
    publisher: "SBB",
    year: 2011,
    is_recommended: false,
    license: "open"
  },
  {
    code: "kjf",
    name: "KJF",
    full_name: "King James Fiel",
    language: "pt-BR",
    description: "Tradução fiel à King James em português",
    publisher: "BV Books",
    year: 2020,
    is_recommended: false,
    license: "open"
  },
  {
    code: "nbv",
    name: "NBV",
    full_name: "Nova Bíblia Viva",
    language: "pt-BR",
    description: "Paráfrase em linguagem contemporânea",
    publisher: "Mundo Cristão",
    year: 2010,
    is_recommended: false,
    license: "proprietary"
  },
  {
    code: "tb",
    name: "TB",
    full_name: "Tradução Brasileira",
    language: "pt-BR",
    description: "Tradução histórica brasileira",
    publisher: "SBB",
    year: 2010,
    is_recommended: false,
    license: "open"
  }
]

bible_versions_data.each do |version_data|
  version = BibleVersion.find_or_initialize_by(code: version_data[:code])
  version.assign_attributes(version_data)
  version.save!
end

puts "✅ Seeded #{BibleVersion.count} Bible versions"
