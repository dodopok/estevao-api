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
  # Supports multiple segments like "1 Pedro 4:12-14; 5:6-11" and returns all verses
  def self.fetch_passage(reference, translation: "nvi")
    parsed_refs = parse_all_references(reference)
    return nil if parsed_refs.empty?

    all_verses = []

    parsed_refs.each do |parsed|
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

      all_verses.concat(verses.order(:verse).to_a)
    end

    # Return as a relation-like array that responds to common methods
    all_verses
  end

  # Parse all segments of a reference like "1 Pedro 4:12-14; 5:6-11"
  # Returns an array of parsed references
  def self.parse_all_references(reference)
    return [] if reference.blank?

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

    # Extract the book name from the first segment (everything before the first number that's followed by : or .)
    # For "1 Pedro 4:12-14", we want "1 Pedro"
    # For "João 3:16", we want "João"
    first_match = clean_ref.match(/^(\d*\s*[^\d:.]+)\s+\d/)
    return [] unless first_match
    base_book_name = first_match[1].strip
    base_book_name = "Salmos" if base_book_name == "Salmo"

    # Split by comma or semicolon to get all segments
    segments = clean_ref.split(/[,;]/).map(&:strip)

    parsed_refs = []

    segments.each_with_index do |segment, index|
      # Remove letter suffixes from verses (e.g., "15a" -> "15")
      segment = segment.gsub(/(\d+)[a-z]/, '\1')

      if index == 0
        # First segment has the full book name
        match = segment.match(/^(\d*\s*[^\d:.]+?)\s*(\d+)(?:[:.](\d+)(?:-(\d+))?)?$/)
        next unless match

        book_name = match[1].strip
        book_name = "Salmos" if book_name == "Salmo"

        parsed_refs << build_parsed_reference(book_name, match[2].to_i, match[3], match[4])
      else
        # Subsequent segments: could be "5:6-11" (new chapter) or "17-19" (same chapter, different verses)
        if segment.match?(/^\d+[:.]/)
          # New chapter reference like "5:6-11" or "5.6-11"
          match = segment.match(/^(\d+)[:.](\d+)(?:-(\d+))?$/)
          next unless match

          parsed_refs << build_parsed_reference(base_book_name, match[1].to_i, match[2], match[3])
        elsif segment.match?(/^\d+-\d+$/)
          # Verse range in same chapter like "17-19"
          match = segment.match(/^(\d+)-(\d+)$/)
          next unless match

          # Use the chapter from the previous segment
          prev_chapter = parsed_refs.last&.dig(:chapter) || 1
          parsed_refs << build_parsed_reference(base_book_name, prev_chapter, match[1], match[2])
        elsif segment.match?(/^\d+$/)
          # Single verse in same chapter like "17"
          prev_chapter = parsed_refs.last&.dig(:chapter) || 1
          parsed_refs << build_parsed_reference(base_book_name, prev_chapter, segment, nil)
        end
      end
    end

    parsed_refs
  end

  # Helper method to build a parsed reference hash with verse normalization
  def self.build_parsed_reference(book_name, chapter, verse_start_str, verse_end_str)
    verse_start = verse_start_str&.to_i
    verse_end = verse_end_str&.to_i

    # Normalize verse range if end is less than start
    if verse_start && verse_end && verse_end < verse_start
      verse_start, verse_end = verse_end, verse_start
    end

    {
      book: book_name,
      chapter: chapter,
      verse_start: verse_start.to_i == 0 ? nil : verse_start,
      verse_end: verse_end.to_i == 0 ? nil : verse_end
    }
  end

  # Parse a reference like "João 3:16-17" into components
  # Supports complex formats:
  # - Books with numbers: "1 Coríntios 13:1-13", "2 Samuel 7:1-11"
  # - Multiple verse ranges: "Salmo 80:1-7, 17-19" or "Salmo 80.1-7; 17-19" (returns first range)
  # - Multiple chapters with semicolon: "1 Pedro 4:12-14; 5:6-11" (returns first chapter)
  # - Letter suffixes: "2 Pedro 3:8-15a"
  # - Alternatives with "or": "Baruque 5:1-9 or Malaquias 3:1-4" (returns first option)
  # - Optional verses: "Lucas 1:39-45 (46-55)" (ignores optional part)
  # - Dot separator: "Gênesis 9.1-17" (uses dot instead of colon)
  # NOTE: For fetching all segments, use parse_all_references instead
  def self.parse_reference(reference)
    refs = parse_all_references(reference)
    refs.first
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
