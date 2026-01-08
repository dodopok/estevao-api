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
  # Uses v5 cache with prayer_book.updated_at versioning and 30-day TTL
  def self.find_psalm(number, prayer_book_code: "loc_2015")
    psalms_cache_for(prayer_book_code)[number]
  end

  # Cache all psalms for a prayer book indexed by number
  # Dramatically reduces queries when building daily offices
  def self.psalms_cache_for(prayer_book_code)
    prayer_book = PrayerBook.find_by_code(prayer_book_code)
    return {} unless prayer_book

    cache_key = "v5/psalms/#{prayer_book_code}/pb_#{prayer_book.updated_at.to_i}"

    Rails.cache.fetch(cache_key, expires_in: 30.days) do
      record_cache_event(:psalms, :miss, prayer_book_code)
      where(prayer_book_id: prayer_book.id).index_by(&:number)
    end
  end

  # Record cache events for Datadog metrics
  def self.record_cache_event(category, event, prayer_book_code)
    return unless defined?(Datadog) && Datadog.respond_to?(:statsd)

    Datadog.statsd.increment(
      "cache.#{event}",
      tags: [ "cache_category:#{category}", "prayer_book:#{prayer_book_code}" ]
    )
  rescue StandardError
    # Don't let metrics failures affect the app
  end

  # Touch prayer book when psalm is updated to invalidate cache
  after_commit :touch_prayer_book_for_cache_invalidation

  def touch_prayer_book_for_cache_invalidation
    prayer_book.touch if prayer_book.present?
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
