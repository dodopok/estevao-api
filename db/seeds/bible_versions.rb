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

# English Bible Versions
english_bible_versions = [
  {
    code: "esv",
    name: "ESV",
    full_name: "English Standard Version",
    language: "en",
    description: "The ESV is an 'essentially literal' translation that seeks as far as possible to capture the precise wording of the original text.",
    publisher: "Crossway",
    year: 2001,
    is_recommended: true,
    license: "proprietary"
  },
  {
    code: "niv",
    name: "NIV",
    full_name: "New International Version",
    language: "en",
    description: "The New International Version is a modern translation that balanced accuracy with readability.",
    publisher: "Biblica",
    year: 2011,
    is_recommended: false,
    license: "proprietary"
  },
  {
    code: "kjv",
    name: "KJV",
    full_name: "King James Version",
    language: "en",
    description: "The Authorized King James Version is an English translation of the Christian Bible for the Church of England, begun in 1604 and completed in 1611.",
    publisher: "Public Domain",
    year: 1611,
    is_recommended: false,
    license: "open"
  },
  {
    code: "nlt",
    name: "NLT",
    full_name: "New Living Translation",
    language: "en",
    description: "The New Living Translation is a clear and contemporary English translation of the Bible.",
    publisher: "Tyndale House",
    year: 1996,
    is_recommended: false,
    license: "proprietary"
  },
  {
    code: "nasb",
    name: "NASB",
    full_name: "New American Standard Bible",
    language: "en",
    description: "The NASB is a highly literal translation from the original languages.",
    publisher: "Lockman Foundation",
    year: 1995,
    is_recommended: false,
    license: "proprietary"
  },
  {
    code: "nkjv",
    name: "NKJV",
    full_name: "New King James Version",
    language: "en",
    description: "The NKJV is a modern translation of the Bible that maintains the style of the original King James Version.",
    publisher: "Thomas Nelson",
    year: 1982,
    is_recommended: false,
    license: "proprietary"
  }
]

# Combine all bible versions
all_bible_versions = bible_versions_data + english_bible_versions

all_bible_versions.each do |version_data|
  version = BibleVersion.find_or_initialize_by(code: version_data[:code])
  version.assign_attributes(version_data)
  version.save!
end

puts "✅ Seeded #{BibleVersion.count} Bible versions"
