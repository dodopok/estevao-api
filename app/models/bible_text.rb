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
    # Old Testament (Portuguese)
    "G\u00EAnesis" => 1, "\u00CAxodo" => 2, "Lev\u00EDtico" => 3, "N\u00FAmeros" => 4, "Deuteron\u00F4mio" => 5,
    "Josu\u00E9" => 6, "Ju\u00EDzes" => 7, "Rute" => 8, "1 Samuel" => 9, "2 Samuel" => 10,
    "1 Reis" => 11, "2 Reis" => 12, "1 Cr\u00F4nicas" => 13, "2 Cr\u00F4nicas" => 14,
    "Esdras" => 15, "Neemias" => 16, "Ester" => 17, "J\u00F3" => 18,
    "Salmos" => 19, "Prov\u00E9rbios" => 20, "Eclesiastes" => 21, "C\u00E2nticos" => 22,
    "Isa\u00EDas" => 23, "Jeremias" => 24, "Lamenta\u00E7\u00F5es" => 25, "Ezequiel" => 26, "Daniel" => 27,
    "Os\u00E9ias" => 28, "Joel" => 29, "Am\u00F3s" => 30, "Obadias" => 31, "Jonas" => 32,
    "Miqu\u00E9ias" => 33, "Naum" => 34, "Habacuque" => 35, "Sofonias" => 36,
    "Ageu" => 37, "Zacarias" => 38, "Malaquias" => 39,
    # New Testament (Portuguese)
    "Mateus" => 40, "Marcos" => 41, "Lucas" => 42, "Jo\u00E3o" => 43,
    "Atos" => 44, "Romanos" => 45, "1 Cor\u00EDntios" => 46, "2 Cor\u00EDntios" => 47,
    "G\u00E1latas" => 48, "Ef\u00E9sios" => 49, "Filipenses" => 50, "Colossenses" => 51,
    "1 Tessalonicenses" => 52, "2 Tessalonicenses" => 53, "1 Tim\u00F3teo" => 54, "2 Tim\u00F3teo" => 55,
    "Tito" => 56, "Filemom" => 57, "Hebreus" => 58, "Tiago" => 59,
    "1 Pedro" => 60, "2 Pedro" => 61, "1 Jo\u00E3o" => 62, "2 Jo\u00E3o" => 63,
    "3 Jo\u00E3o" => 64, "Judas" => 65, "Apocalipse" => 66,

    # English book names (additional/alternative names)
    "Genesis" => 1, "Exodus" => 2, "Leviticus" => 3, "Numbers" => 4, "Deuteronomy" => 5,
    "Joshua" => 6, "Judges" => 7, "Ruth" => 8,
    "1 Kings" => 11, "2 Kings" => 12, "1 Chronicles" => 13, "2 Chronicles" => 14,
    "Ezra" => 15, "Nehemiah" => 16, "Esther" => 17, "Job" => 18, "Psalms" => 19, "Psalm" => 19,
    "Proverbs" => 20, "Ecclesiastes" => 21, "Song of Solomon" => 22, "Song of Songs" => 22,
    "Isaiah" => 23, "Jeremiah" => 24, "Lamentations" => 25,
    "Ezekiel" => 26,
    "Hosea" => 28, "Amos" => 30, "Obadiah" => 31, "Jonah" => 32,
    "Micah" => 33,
    "Nahum" => 34, "Habakkuk" => 35, "Zephaniah" => 36, "Haggai" => 37,
    "Zechariah" => 38, "Malachi" => 39, "Matthew" => 40, "Mark" => 41, "Luke" => 42,
    "John" => 43, "Acts" => 44, "Romans" => 45, "1 Corinthians" => 46, "2 Corinthians" => 47,
    "Galatians" => 48, "Efhesians" => 49, "Philippians" => 50, "Colossians" => 51,
    "1 Thessalonians" => 52, "2 Thessalonians" => 53, "1 Timothy" => 54, "2 Timothy" => 55,
    "Titus" => 56, "Philemon" => 57,
    "Hebrews" => 58, "James" => 59, "1 Peter" => 60,
    "2 Peter" => 61, "1 John" => 62, "2 John" => 63, "3 John" => 64,
    "Revelation" => 66
  }.freeze

  # Reverse mapping: book_id (1-66) => book name in Portuguese
  BOOKS_BY_ID = BOOKS.slice(*BOOKS.keys.first(66)).invert.freeze

  # Mapping of all names to canonical (Portuguese) name
  def self.canonical_book_name(name)
    id = BOOKS[name] || BOOKS[name.strip]
    return name unless id
    BOOKS_BY_ID[id]
  end

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
    "tb" => { name: "Tradução Brasileira", publisher: "SBB", year: 2010 },

    # English translations
    "esv" => { name: "English Standard Version", publisher: "Crossway", year: 2001 },
    "kjv" => { name: "King James Version", publisher: "Public Domain", year: 1611 },
    "nasb" => { name: "New American Standard Bible", publisher: "Lockman Foundation", year: 1995 },
    "niv" => { name: "New International Version", publisher: "Biblica", year: 2011 },
    "nlt" => { name: "New Living Translation", publisher: "Tyndale House", year: 1996 },
    "nkjv" => { name: "New King James Version", publisher: "Thomas Nelson", year: 1982 }
  }.freeze

  # Find verses for a passage reference like "João 3:16-17" or "Salmos 23"
  # Supports multiple segments like "1 Pedro 4:12-14; 5:6-11" and returns all verses
  # Also supports cross-chapter references like "Apocalipse 20:11-21:8"
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

      if parsed[:fetch_all]
        # Fetch all verses from the chapter (no verse filter)
        # Used for intermediate chapters in cross-chapter references
      elsif parsed[:fetch_all_from_verse]
        # Fetch all verses from verse_start to end of chapter
        verses = verses.where("verse >= ?", parsed[:verse_start]) if parsed[:verse_start]
      elsif parsed[:verse_start] && parsed[:verse_end]
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
  # Also handles cross-chapter references like "Apocalipse 20:11-21:8"
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

    # Split by comma or semicolon to get all segments
    segments = clean_ref.split(/[,;]/).map(&:strip)

    parsed_refs = []

    segments.each_with_index do |segment, index|
      # Remove letter suffixes from verses (e.g., "15a" -> "15")
      segment = segment.gsub(/(\d+)[a-z]/, '\1')

      if index == 0
        # First segment has the full book name
        # Check for cross-chapter reference like "Apocalipse 20:11-21:8"
        cross_chapter_match = segment.match(/^(\d*\s*[^\d:.]+?)\s*(\d+)[:.](\d+)-(\d+)[:.](\d+)$/)
        if cross_chapter_match
          book_name = cross_chapter_match[1].strip
          start_chapter = cross_chapter_match[2].to_i
          start_verse = cross_chapter_match[3].to_i
          end_chapter = cross_chapter_match[4].to_i
          end_verse = cross_chapter_match[5].to_i

          # Add all verses from start chapter (from start_verse to end of chapter)
          parsed_refs << build_parsed_reference(book_name, start_chapter, start_verse.to_s, nil, fetch_all_from_verse: true)

          # Add all verses from intermediate chapters (if any)
          ((start_chapter + 1)...end_chapter).each do |ch|
            parsed_refs << build_parsed_reference(book_name, ch, nil, nil, fetch_all: true)
          end

          # Add all verses from end chapter (from beginning to end_verse)
          parsed_refs << build_parsed_reference(book_name, end_chapter, "1", end_verse.to_s)
        else
          # Regular reference like "João 3:16-17"
          match = segment.match(/^(\d*\s*[^\d:.]+?)\s*(\d+)(?:[:.](\d+)(?:-(\d+))?)?$/)
          next unless match

          book_name = match[1].strip

          parsed_refs << build_parsed_reference(book_name, match[2].to_i, match[3], match[4])
        end
      else
        # Subsequent segments: could be "5:6-11" (new chapter) or "17-19" (same chapter, different verses)
        # Check for cross-chapter reference like "5:6-6:10"
        cross_chapter_match = segment.match(/^(\d+)[:.](\d+)-(\d+)[:.](\d+)$/)
        if cross_chapter_match
          start_chapter = cross_chapter_match[1].to_i
          start_verse = cross_chapter_match[2].to_i
          end_chapter = cross_chapter_match[3].to_i
          end_verse = cross_chapter_match[4].to_i

          parsed_refs << build_parsed_reference(base_book_name, start_chapter, start_verse.to_s, nil, fetch_all_from_verse: true)

          ((start_chapter + 1)...end_chapter).each do |ch|
            parsed_refs << build_parsed_reference(base_book_name, ch, nil, nil, fetch_all: true)
          end

          parsed_refs << build_parsed_reference(base_book_name, end_chapter, "1", end_verse.to_s)
        elsif segment.match?(/^\d+[:.]/)
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
  # Options:
  #   fetch_all: true - fetch all verses from the chapter (no verse filter)
  #   fetch_all_from_verse: true - fetch all verses from verse_start to end of chapter
  def self.build_parsed_reference(book_name, chapter, verse_start_str, verse_end_str, fetch_all: false, fetch_all_from_verse: false)
    verse_start = verse_start_str&.to_i
    verse_end = verse_end_str&.to_i

    # Normalize verse range if end is less than start
    if verse_start && verse_end && verse_end < verse_start
      verse_start, verse_end = verse_end, verse_start
    end

    result = {
      book: canonical_book_name(book_name),
      chapter: chapter,
      verse_start: verse_start.to_i == 0 ? nil : verse_start,
      verse_end: verse_end.to_i == 0 ? nil : verse_end
    }

    # Only add these keys when true to maintain backward compatibility
    result[:fetch_all] = true if fetch_all
    result[:fetch_all_from_verse] = true if fetch_all_from_verse

    result
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
