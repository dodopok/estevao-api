# frozen_string_literal: true

class PrayerBook < ApplicationRecord
  has_many :collects, dependent: :restrict_with_error
  has_many :lectionary_readings, dependent: :restrict_with_error
  has_many :liturgical_texts, dependent: :restrict_with_error
  has_many :psalms, dependent: :restrict_with_error
  has_many :psalm_cycles, dependent: :restrict_with_error
  has_many :celebrations, dependent: :restrict_with_error
  has_many :preference_categories, -> { order(:position) }, dependent: :destroy
  has_many :preference_definitions, through: :preference_categories
  has_many :user_onboardings, dependent: :restrict_with_error

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :year, numericality: { only_integer: true, allow_nil: true }
  validates :language, presence: true, inclusion: {
    in: %w[pt-BR en es],
    message: "%{value} is not a valid language"
  }

  scope :active, -> { all } # All prayer books are active for now
  scope :recommended, -> { where(is_recommended: true) }
  scope :default, -> { where(is_recommended: true) } # Alias for backwards compatibility
  scope :premium, -> { where(premium_required: true) }
  scope :free, -> { where(premium_required: false) }
  scope :by_language, ->(lang) { where(language: lang) }
  scope :available_for_user, lambda { |user|
    if user&.premium?
      all
    else
      where(premium_required: false)
    end
  }

  # Cache prayer books by code for better performance
  # Version v4 for new caching strategy
  def self.find_by_code(code)
    Rails.cache.fetch("v4/prayer_book/#{code}", expires_in: 1.day) do
      record_cache_event(:prayer_book, :miss, code)
      find_by(code: code)
    end
  end

  def self.find_by_code!(code)
    prayer_book = find_by_code(code)
    if prayer_book.nil?
      # Invalidate cache and retry with fresh database lookup
      Rails.cache.delete("v4/prayer_book/#{code}")
      prayer_book = find_by(code: code)
      raise(ActiveRecord::RecordNotFound, "Couldn't find PrayerBook with code=#{code}") if prayer_book.nil?
      # Update cache with fresh data
      Rails.cache.write("v4/prayer_book/#{code}", prayer_book, expires_in: 1.day)
    end
    prayer_book
  end

  def self.find_by_code_or_default(code)
    code.present? ? find_by_code(code) || default.first : default.first
  end

  # Cache all active prayer books
  def self.all_cached
    Rails.cache.fetch("v4/prayer_books/all", expires_in: 1.day) do
      record_cache_event(:prayer_book, :miss, "all")
      active.to_a
    end
  end

  # Record cache events for Datadog metrics
  def self.record_cache_event(category, event, identifier)
    return unless defined?(Datadog) && Datadog.respond_to?(:statsd)

    Datadog.statsd.increment(
      "cache.#{event}",
      tags: [ "cache_category:#{category}", "identifier:#{identifier}" ]
    )
  rescue StandardError
    # Don't let metrics failures affect the app
  end

  # Clear all caches when prayer book is updated
  after_commit :clear_prayer_book_caches

  def clear_prayer_book_caches
    Rails.cache.delete("v4/prayer_book/#{code}")
    Rails.cache.delete("v4/prayer_books/all")
  end

  # Retorna as features do Prayer Book (lectionary, daily_office, etc.)
  def lectionary_features
    features.dig("lectionary") || {}
  end

  def daily_office_features
    features.dig("daily_office") || {}
  end

  def psalter_features
    features.dig("psalter") || {}
  end

  # Verifica se o Prayer Book suporta determinada feature
  def supports_feature?(feature_path)
    keys = feature_path.split(".")
    value = features
    keys.each do |key|
      value = value&.dig(key)
      return false if value.nil?
    end
    value == true || value.present?
  end

  def supports_family_rite?
    features.dig("daily_office", "supports_family_rite") == true
  end

  def supports_vigil?
    features.dig("lectionary", "supports_vigil") == true
  end

  # Retorna as opções padrão para este Prayer Book
  def default_options
    {
      "lectionary" => {
        "reading_type" => lectionary_features["default_reading_type"] || "semicontinuous"
      },
      "daily_office" => {
        "use_family_rite" => false
      }
    }
  end

  # Retorna os reading_types disponíveis
  def available_reading_types
    lectionary_features["reading_types"] || []
  end

  # Premium access control
  def requires_premium?
    premium_required
  end

  def accessible_by?(user)
    return true unless premium_required

    user&.premium? || false
  end
end
