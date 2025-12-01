# Service to fetch and format Bible passages
class BibleTextService
  attr_reader :translation

  def initialize(translation: "nvi")
    @translation = translation
  end

  # Fetch a passage and return as HTML
  def fetch_passage_html(reference)
    BibleText.format_passage_html(reference, translation: @translation)
  end

  # Fetch a passage and return as plain text
  def fetch_passage_text(reference)
    verses = BibleText.fetch_passage(reference, translation: @translation)
    return "Texto não disponível: #{reference}" unless verses&.any?

    verses.map { |v| "#{v.verse} #{v.text}" }.join("\n")
  end

  # Fetch a passage and return structured data
  def fetch_passage_structured(reference)
    verses = BibleText.fetch_passage(reference, translation: @translation)
    return nil unless verses&.any?

    {
      reference: reference,
      translation: @translation,
      verses: verses.map do |v|
        {
          number: v.verse,
          text: v.text
        }
      end
    }
  end

  # Check if a passage exists in the database
  def passage_exists?(reference)
    parsed = BibleText.parse_reference(reference)
    return false unless parsed

    BibleText.exists?(
      book: parsed[:book],
      chapter: parsed[:chapter],
      translation: @translation
    )
  end

  # Get book name from number
  def self.book_name_from_number(number)
    BibleText::BOOKS.key(number)
  end

  # Get book number from name
  def self.book_number_from_name(name)
    BibleText::BOOKS[name]
  end
end
