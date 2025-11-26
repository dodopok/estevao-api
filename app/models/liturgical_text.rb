class LiturgicalText < ApplicationRecord
  # Relacionamentos
  belongs_to :prayer_book

  # Validações
  validates :slug, presence: true, uniqueness: { scope: :prayer_book_id }
  validates :category, presence: true
  validates :content, presence: true
  validates :language, presence: true

  # Scopes
  scope :by_category, ->(category) { where(category: category) }
  scope :by_slug, ->(slug) { where(slug: slug) }
  scope :for_season, ->(season_slug) { where("slug LIKE ?", "%#{season_slug}%") }
  scope :for_prayer_book, ->(code) {
    prayer_book = PrayerBook.find_by(code: code)
    where(prayer_book_id: prayer_book&.id)
  }

  # Categories constants
  CATEGORIES = {
    opening_sentence: "opening_sentence",
    confession: "confession",
    absolution: "absolution",
    invocation: "invocation",
    canticle: "canticle",
    prayer: "prayer",
    creed: "creed",
    suffrage: "suffrage",
    dismissal: "dismissal",
    rubric: "rubric"
  }.freeze

  # Helper method to find text by slug and prayer book code
  def self.find_text(slug, prayer_book_code: "loc_2015")
    prayer_book = PrayerBook.find_by(code: prayer_book_code)
    find_by(slug: slug, prayer_book_id: prayer_book&.id)
  end

  # Helper to get content safely
  def text
    content
  end
end
