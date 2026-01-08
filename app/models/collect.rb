class Collect < ApplicationRecord
  # Relacionamentos - celebration e season são opcionais
  # pois uma coleta pode ser de uma celebração OU de um domingo/quadra
  belongs_to :celebration, optional: true
  belongs_to :season, class_name: "LiturgicalSeason", optional: true
  belongs_to :prayer_book

  # Validações
  validates :text, presence: true
  validates :language, presence: true, if: -> { prayer_book.nil? }
  validate :must_have_celebration_or_season_or_sunday

  # Callbacks
  before_validation :set_language_from_prayer_book, if: -> { language.blank? && prayer_book.present? }

  # Scopes
  scope :for_celebration, ->(celebration_id) { where(celebration_id: celebration_id) }
  scope :for_season, ->(season_id) { where(season_id: season_id) }
  scope :for_sunday, ->(sunday_ref) { where(sunday_reference: sunday_ref) }
  scope :in_language, ->(lang) { where(language: lang) }
  scope :for_prayer_book_id, ->(prayer_book_id) { where(prayer_book_id: prayer_book_id) }
  scope :for_prayer_book, ->(code) {
    prayer_book = PrayerBook.find_by(code: code)
    where(prayer_book_id: prayer_book&.id)
  }

  # Cache all collects for a prayer book indexed by celebration_id and sunday_reference
  # Uses v5 cache key with prayer_book.updated_at versioning and 30-day TTL
  def self.collects_cache_for(prayer_book_code)
    prayer_book = PrayerBook.find_by_code(prayer_book_code)
    return { by_celebration: {}, by_sunday: {} } unless prayer_book

    cache_key = "v5/collects/#{prayer_book_code}/pb_#{prayer_book.updated_at.to_i}"

    Rails.cache.fetch(cache_key, expires_in: 30.days) do
      record_cache_event(:collects, :miss, prayer_book_code)

      collects = where(prayer_book_id: prayer_book.id).to_a

      {
        by_celebration: collects.select { |c| c.celebration_id.present? }
                                .group_by(&:celebration_id),
        by_sunday: collects.select { |c| c.sunday_reference.present? }
                           .group_by(&:sunday_reference),
        by_season: collects.select { |c| c.season_id.present? }
                           .group_by(&:season_id)
      }
    end
  end

  # Find collects by celebration ID using cache
  def self.find_by_celebration_cached(celebration_id, prayer_book_code: "loc_2015")
    cache = collects_cache_for(prayer_book_code)
    cache[:by_celebration][celebration_id] || []
  end

  # Find collects by sunday reference using cache
  def self.find_by_sunday_cached(sunday_ref, prayer_book_code: "loc_2015")
    cache = collects_cache_for(prayer_book_code)
    cache[:by_sunday][sunday_ref] || []
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

  # Touch prayer book when collect is updated to invalidate cache
  after_commit :touch_prayer_book_for_cache_invalidation

  def touch_prayer_book_for_cache_invalidation
    prayer_book.touch if prayer_book.present?
  end

  private

  def set_language_from_prayer_book
    self.language = prayer_book.language
  end

  def must_have_celebration_or_season_or_sunday
    if celebration_id.blank? && season_id.blank? && sunday_reference.blank?
      errors.add(:base, "Coleta deve ter uma celebração, quadra ou referência de domingo")
    end
  end
end
