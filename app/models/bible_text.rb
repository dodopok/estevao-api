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
  def self.parse_reference(reference)
    # Simple regex to parse references (can be enhanced)
    # Format: "Book Chapter:Verse" or "Book Chapter:Verse-Verse"
    match = reference.match(/^([^0-9]+)\s*(\d+)(?::(\d+)(?:-(\d+))?)?$/)
    return nil unless match

    {
      book: match[1].strip,
      chapter: match[2].to_i,
      verse_start: match[3]&.to_i,
      verse_end: match[4]&.to_i
    }
  end

  # Format passage as HTML
  def self.format_passage_html(reference, translation: "nvi")
    verses = fetch_passage(reference, translation: translation)
    return "<p>Texto não disponível</p>" unless verses.any?

    html = "<div class='bible-passage'>"
    html += "<p class='passage-reference'>#{reference}</p>"

    current_paragraph = []

    verses.each do |verse|
      verse_html = "<sup>#{verse.verse}</sup>#{verse.text}"

      if verse.verse_type == "poetry"
        html += "<p class='poetry-line'>#{verse_html}</p>"
      else
        current_paragraph << verse_html
      end
    end

    html += "<p>#{current_paragraph.join(' ')}</p>" if current_paragraph.any?
    html += "</div>"
    html
  end
end
