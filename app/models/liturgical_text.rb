class LiturgicalText < ApplicationRecord
  # Validações
  validates :slug, presence: true, uniqueness: { scope: :version }
  validates :category, presence: true
  validates :content, presence: true
  validates :version, presence: true
  validates :language, presence: true

  # Scopes
  scope :by_category, ->(category) { where(category: category) }
  scope :by_slug, ->(slug) { where(slug: slug) }
  scope :by_version, ->(version) { where(version: version) }
  scope :for_season, ->(season_slug) { where("slug LIKE ?", "%#{season_slug}%") }

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

  # Helper method to find text by slug and version
  def self.find_text(slug, version: "loc_2015")
    find_by(slug: slug, version: version)
  end

  # Helper to get content safely
  def text
    content
  end
end
