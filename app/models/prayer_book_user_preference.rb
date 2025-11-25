# frozen_string_literal: true

class PrayerBookUserPreference < ApplicationRecord
  belongs_to :user
  belongs_to :prayer_book

  validates :user_id, uniqueness: { scope: :prayer_book_id }
  validate :validate_options_against_features

  # Retorna as opções com fallback para os defaults do Prayer Book
  def options_with_defaults
    prayer_book.default_options.merge(options || {})
  end

  private

  def validate_options_against_features
    return if options.blank?

    features = prayer_book.features
    return if features.blank?

    # Valida lectionary options
    validate_lectionary_options(features["lectionary"]) if options["lectionary"].present?

    # Valida daily_office options
    validate_daily_office_options(features["daily_office"]) if options["daily_office"].present?
  end

  def validate_lectionary_options(lectionary_features)
    return unless lectionary_features.present?

    lectionary_opts = options["lectionary"] || {}

    # Valida reading_type
    if lectionary_opts["reading_type"].present?
      valid_types = lectionary_features["reading_types"] || []
      unless valid_types.include?(lectionary_opts["reading_type"])
        errors.add(:options, "reading_type '#{lectionary_opts['reading_type']}' não é suportado por este Prayer Book. Opções válidas: #{valid_types.join(', ')}")
      end
    end
  end

  def validate_daily_office_options(daily_office_features)
    return unless daily_office_features.present?

    office_opts = options["daily_office"] || {}

    # Valida family_rite
    if office_opts["use_family_rite"] == true && !daily_office_features["supports_family_rite"]
      errors.add(:options, "rito familiar não é suportado por este Prayer Book")
    end
  end
end
