class Psalm < ApplicationRecord
  # Relacionamentos
  belongs_to :prayer_book

  # Validações
  validates :number, presence: true, uniqueness: { scope: :prayer_book_id }
  validates :verses, presence: true

  # Scopes
  scope :by_number, ->(number) { where(number: number) }
  scope :for_prayer_book, ->(code) {
    prayer_book = PrayerBook.find_by(code: code)
    where(prayer_book_id: prayer_book&.id)
  }

  # Find psalm by number and optional prayer book code
  def self.find_psalm(number, prayer_book_code: "loc_2015")
    prayer_book = PrayerBook.find_by(code: prayer_book_code)
    find_by(number: number, prayer_book_id: prayer_book&.id)
  end

  # Get verses as formatted text
  def formatted_verses
    return [] unless verses.is_a?(Array)

    verses.map do |verse|
      {
        number: verse["number"],
        text: verse["text"],
        pointer: verse["hebrew_pointer"]
      }
    end
  end

  # Get full text
  def full_text
    return "" unless verses.is_a?(Array)

    verses.map { |v| v["text"] }.join("\n")
  end

  # Format for responsive reading (alternating leader/congregation)
  def responsive_format
    return [] unless verses.is_a?(Array)

    verses.each_with_index.map do |verse, index|
      {
        number: verse["number"],
        text: verse["text"],
        speaker: index.even? ? "leader" : "congregation"
      }
    end
  end

  # Check if this is a compline psalm (4, 31, 91, 134)
  def compline_psalm?
    [ 4, 31, 91, 134 ].include?(number)
  end

  # Get psalm title with number
  def full_title
    if title.present?
      "Salmo #{number}: #{title}"
    else
      "Salmo #{number}"
    end
  end
end
