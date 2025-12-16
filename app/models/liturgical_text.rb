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
  scope :for_audio_generation, -> { where.not(category: "rubric") }

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

  # Available audio voices
  AVAILABLE_VOICES = %w[male_1 female_1 male_2].freeze

  # Audio generation statuses
  AUDIO_STATUSES = %w[pending in_progress completed failed partial].freeze

  # Helper method to find text by slug and prayer book code
  def self.find_text(slug, prayer_book_code: "loc_2015")
    prayer_book = PrayerBook.find_by(code: prayer_book_code)
    find_by(slug: slug, prayer_book_id: prayer_book&.id)
  end

  # Helper to get content safely
  def text
    content
  end

  # Audio URL methods
  # Returns the full audio URL for a given voice
  # Behavior depends on environment and configuration:
  # 1. If AUDIO_CDN_HOST is set → returns CDN URL (e.g., https://cdn.estevao.app/audio/...)
  # 2. If production without CDN → returns APP_HOST URL (e.g., https://api.estevao.app/audio/...)
  # 3. Otherwise (development/test) → returns relative path (/audio/...)
  def audio_url_for_voice(voice_key)
    relative_url = audio_urls[voice_key.to_s]
    return nil if relative_url.blank?

    # In test environment, always return relative path for predictable assertions
    return relative_url if Rails.env.test?

    # Return full URL with CDN host or fallback to app host
    cdn_host = ENV.fetch("AUDIO_CDN_HOST", nil)

    if cdn_host.present?
      # CDN configured - return CDN URL
      "#{cdn_host}#{relative_url}"
    elsif Rails.env.production?
      # Production without CDN - use app host
      app_host = ENV.fetch("APP_HOST", "https://api.estevao.app")
      "#{app_host}#{relative_url}"
    else
      # Development/test - return relative path (will be served by local server)
      relative_url
    end
  end

  def set_audio_url(voice_key, url)
    self.audio_urls = audio_urls.merge(voice_key.to_s => url)
    save
  end

  def audio_filename(voice_key)
    "#{prayer_book.code}_#{id}_#{slug}.mp3"
  end

  def audio_filename_with_timestamp(voice_key)
    timestamp = Time.current.strftime("%Y%m%d%H%M%S")
    "#{prayer_book.code}_#{id}_#{slug}_#{timestamp}.mp3"
  end

  def voices_generated
    AVAILABLE_VOICES.select { |voice| audio_urls[voice].present? }
  end

  def voices_pending
    AVAILABLE_VOICES.reject { |voice| audio_urls[voice].present? }
  end
end
