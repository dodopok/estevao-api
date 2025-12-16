# Service to fetch and format Bible passages
class BibleTextService
  attr_reader :translation

  # Livros de capítulo único que podem vir sem número de capítulo
  SINGLE_CHAPTER_BOOKS = %w[Obadias Filemom 2João 3João Judas].freeze

  def initialize(translation: "nvi")
    @translation = translation
  end

  # Fetch a passage and return as HTML
  def fetch_passage_html(reference)
    reference = normalize_reference(reference)
    BibleText.format_passage_html(reference, translation: @translation)
  end

  # Fetch a passage and return as plain text
  def fetch_passage_text(reference)
    reference = normalize_reference(reference)
    verses = BibleText.fetch_passage(reference, translation: @translation)
    return "Texto não disponível: #{reference}" unless verses&.any?

    verses.map { |v| "#{v.verse} #{v.text}" }.join("\n")
  end

  # Fetch a passage and return structured data
  def fetch_passage_structured(reference)
    original_reference = reference
    reference = normalize_reference(reference)
    
    Rails.logger.debug "[BibleTextService] Fetching: '#{original_reference}' -> '#{reference}' (#{@translation})"
    
    verses = BibleText.fetch_passage(reference, translation: @translation)
    
    if verses.nil? || !verses.any?
      Rails.logger.warn "[BibleTextService] No verses found for: #{reference} (#{@translation})"
      return nil
    end

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

  private

  # Normalize Bible references for single-chapter books
  # E.g., "Judas 17-25" -> "Judas 1.17-25"
  def normalize_reference(reference)
    return reference if reference.blank?

    original = reference
    
    # Check if reference matches a single-chapter book pattern without chapter number
    # Pattern: "BookName verses" (e.g., "Judas 17-25")
    SINGLE_CHAPTER_BOOKS.each do |book|
      # Match "BookName number" or "BookName number-number"
      if reference.match?(/^#{book}\s+\d/)
        # Insert "1." after book name if not already there
        unless reference.match?(/^#{book}\s+\d+\./)
          reference = reference.sub(/^(#{book})\s+(\d)/, '\1 1.\2')
          Rails.logger.debug "[BibleTextService] normalize_reference: '#{original}' -> '#{reference}'"
        end
        break
      end
    end

    reference
  end
end
