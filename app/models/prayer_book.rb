# frozen_string_literal: true

class PrayerBook < ApplicationRecord
  has_many :collects, dependent: :restrict_with_error
  has_many :lectionary_readings, dependent: :restrict_with_error
  has_many :liturgical_texts, dependent: :restrict_with_error
  has_many :psalms, dependent: :restrict_with_error
  has_many :psalm_cycles, dependent: :restrict_with_error
  has_many :prayer_book_user_preferences, dependent: :destroy

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :year, numericality: { only_integer: true, allow_nil: true }

  scope :default, -> { where(is_default: true) }

  def self.find_by_code!(code)
    find_by!(code: code)
  end

  def self.find_by_code_or_default(code)
    code.present? ? find_by(code: code) || default.first : default.first
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
end
