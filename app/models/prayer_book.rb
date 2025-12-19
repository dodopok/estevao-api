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
  # Version v2 to invalidate old cache after adding premium/language fields
  def self.find_by_code(code)
    Rails.cache.fetch("prayer_book/#{code}/v2", expires_in: 1.day) do
      find_by(code: code)
    end
  end

  def self.find_by_code!(code)
    prayer_book = find_by_code(code)
    if prayer_book.nil?
      # Invalidate cache and retry with fresh database lookup
      Rails.cache.delete("prayer_book/#{code}/v2")
      prayer_book = find_by(code: code)
      raise(ActiveRecord::RecordNotFound, "Couldn't find PrayerBook with code=#{code}") if prayer_book.nil?
      # Update cache with fresh data
      Rails.cache.write("prayer_book/#{code}/v2", prayer_book, expires_in: 1.day)
    end
    prayer_book
  end

  def self.find_by_code_or_default(code)
    code.present? ? find_by_code(code) || default.first : default.first
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
    !premium_required || user&.premium?
  end
end
