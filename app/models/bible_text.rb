class BibleText < ApplicationRecord
  # Validações
  validates :book, presence: true
  validates :book_number, presence: true
  validates :chapter, presence: true
  validates :verse, presence: true
  validates :text, presence: true
  validates :translation, presence: true

  # Scopes
  scope :by_book, ->(book) { where(book: book) }
  scope :by_chapter, ->(book, chapter) { where(book: book, chapter: chapter) }
  scope :by_translation, ->(translation) { where(translation: translation) }

  # Bible books in order
  BOOKS = {
    # Old Testament
    "G\u00EAnesis" => 1, "\u00CAxodo" => 2, "Lev\u00EDtico" => 3, "N\u00FAmeros" => 4, "Deuteron\u00F4mio" => 5,
    "Josu\u00E9" => 6, "Ju\u00EDzes" => 7, "Rute" => 8, "1 Samuel" => 9, "2 Samuel" => 10,
    "1 Reis" => 11, "2 Reis" => 12, "1 Cr\u00F4nicas" => 13, "2 Cr\u00F4nicas" => 14,
    "Esdras" => 15, "Neemias" => 16, "Ester" => 17, "J\u00F3" => 18,
    "Salmos" => 19, "Prov\u00E9rbios" => 20, "Eclesiastes" => 21, "C\u00E2nticos" => 22,
    "Isa\u00EDas" => 23, "Jeremias" => 24, "Lamenta\u00E7\u00F5es" => 25, "Ezequiel" => 26, "Daniel" => 27,
    "Os\u00E9ias" => 28, "Joel" => 29, "Am\u00F3s" => 30, "Obadias" => 31, "Jonas" => 32,
    "Miqu\u00E9ias" => 33, "Naum" => 34, "Habacuque" => 35, "Sofonias" => 36,
    "Ageu" => 37, "Zacarias" => 38, "Malaquias" => 39,
    # New Testament
    "Mateus" => 40, "Marcos" => 41, "Lucas" => 42, "Jo\u00E3o" => 43,
    "Atos" => 44, "Romanos" => 45, "1 Cor\u00EDntios" => 46, "2 Cor\u00EDntios" => 47,
    "G\u00E1latas" => 48, "Ef\u00E9sios" => 49, "Filipenses" => 50, "Colossenses" => 51,
    "1 Tessalonicenses" => 52, "2 Tessalonicenses" => 53, "1 Tim\u00F3teo" => 54, "2 Tim\u00F3teo" => 55,
    "Tito" => 56, "Filemom" => 57, "Hebreus" => 58, "Tiago" => 59,
    "1 Pedro" => 60, "2 Pedro" => 61, "1 Jo\u00E3o" => 62, "2 Jo\u00E3o" => 63,
    "3 Jo\u00E3o" => 64, "Judas" => 65, "Apocalipse" => 66
  }.freeze

  # Reverse mapping: book_id (1-66) => book name in Portuguese
  BOOKS_BY_ID = BOOKS.invert.freeze

  # Available Bible translations with metadata
  TRANSLATIONS = {
    "acf" => { name: "Almeida Corrigida Fiel", publisher: "SBTB", year: 1994 },
    "ara" => { name: "Almeida Revista e Atualizada", publisher: "SBB", year: 1993 },
    "arc" => { name: "Almeida Revista e Corrigida", publisher: "SBB", year: 1995 },
    "as21" => { name: "Almeida Século XXI", publisher: "Vida Nova", year: 2008 },
    "jfaa" => { name: "João Ferreira de Almeida Atualizada", publisher: "SBB", year: 2011 },
    "kja" => { name: "King James Atualizada", publisher: "Abba Press", year: 1999 },
    "kjf" => { name: "King James Fiel", publisher: "BV Books", year: 2020 },
    "naa" => { name: "Nova Almeida Atualizada", publisher: "SBB", year: 2017 },
    "nbv" => { name: "Nova Bíblia Viva", publisher: "Mundo Cristão", year: 2010 },
    "ntlh" => { name: "Nova Tradução na Linguagem de Hoje", publisher: "SBB", year: 2000 },
    "nvi" => { name: "Nova Versão Internacional", publisher: "Vida", year: 2011 },
    "nvt" => { name: "Nova Versão Transformadora", publisher: "Mundo Cristão", year: 2016 },
    "tb" => { name: "Tradução Brasileira", publisher: "SBB", year: 2010 }
  }.freeze

  # Find verses for a passage reference like "João 3:16-17" or "Salmos 23"
  def self.fetch_passage(reference, translation: "nvi")
    parsed = parse_reference(reference)
    return nil unless parsed

    verses = where(
      book: parsed[:book],
      chapter: parsed[:chapter],
      translation: translation
    )

    if parsed[:verse_start] && parsed[:verse_end]
      verses = verses.where("verse >= ? AND verse <= ?", parsed[:verse_start], parsed[:verse_end])
    elsif parsed[:verse_start]
      verses = verses.where(verse: parsed[:verse_start])
    end

    verses.order(:verse)
  end

  # Parse a reference like "João 3:16-17" into components
  # Supports complex formats:
  # - Books with numbers: "1 Coríntios 13:1-13", "2 Samuel 7:1-11"
  # - Multiple verse ranges: "Salmo 80:1-7, 17-19" (returns first range)
  # - Letter suffixes: "2 Pedro 3:8-15a"
  # - Alternatives with "or": "Baruque 5:1-9 or Malaquias 3:1-4" (returns first option)
  # - Optional verses: "Lucas 1:39-45 (46-55)" (ignores optional part)
  # - Dot separator: "Gênesis 9.1-17" (uses dot instead of colon)
  def self.parse_reference(reference)
    return nil if reference.blank?

    # Clean up the reference
    clean_ref = reference.strip

    # Normalize Roman numerals to Arabic numbers (I, II, III -> 1, 2, 3)
    clean_ref = clean_ref.gsub(/^(I{1,3})\s+/) do |match|
      roman = match.strip
      case roman
      when "I" then "1 "
      when "II" then "2 "
      when "III" then "3 "
      end
    end

    # Handle "or" alternatives - take first option
    clean_ref = clean_ref.split(/\s+or\s+/i).first.strip

    # Remove optional verses in parentheses
    clean_ref = clean_ref.gsub(/\s*\([^)]+\)/, "")

    # Handle multiple verse ranges - take first segment
    clean_ref = clean_ref.split(",").first.strip

    # Remove letter suffixes from verses (e.g., "15a" -> "15")
    clean_ref = clean_ref.gsub(/(\d+)[a-z]/, '\1')

    # Enhanced regex to handle books with numbers
    # Captures: (optional number + book name) (chapter) (optional [:.]verse) (optional -verse_end)
    # Supports both : and . as separators between chapter and verse
    match = clean_ref.match(/^(\d*\s*[^\d:.]+?)\s*(\d+)(?:[:.](\d+)(?:-(\d+))?)?$/)
    return nil unless match

    book_name = match[1].strip
    # Normalize "Salmo" to "Salmos" for consistency with BOOKS hash
    book_name = "Salmos" if book_name == "Salmo"

    verse_start = match[3]&.to_i
    verse_end = match[4]&.to_i

    # Normalize verse range if end is less than start (e.g., "3:11-8" should be "3:8-11")
    if verse_start && verse_end && verse_end < verse_start
      verse_start, verse_end = verse_end, verse_start
    end

    {
      book: book_name,
      chapter: match[2].to_i,
      verse_start: verse_start,
      verse_end: verse_end
    }
  end

  # Format passage as HTML
  def self.format_passage_html(reference, translation: "nvi")
    verses = fetch_passage(reference, translation: translation)
    return "<p>Texto não disponível</p>" unless verses&.any?

    html = "<div class='bible-passage'>"
    html += "<p class='passage-reference'>#{reference}</p>"

    verse_texts = verses.map do |verse|
      "<sup>#{verse.verse}</sup>#{verse.text}"
    end

    html += "<p>#{verse_texts.join(' ')}</p>"
    html += "</div>"
    html
  end
end
