# frozen_string_literal: true

class UserOnboarding < ApplicationRecord
  VALID_MODES = %w[basic advanced].freeze

  belongs_to :user
  belongs_to :prayer_book
  belongs_to :bible_version

  validates :user_id, uniqueness: true
  validates :mode, presence: true, inclusion: { in: VALID_MODES }
  validate :validate_preferences_against_definitions

  before_save :apply_defaults_for_basic_mode
  before_save :set_completed_at

  # Get a specific preference value with fallback to default
  def preference_value(key)
    key_str = key.to_s
    return preferences[key_str] if preferences.key?(key_str)

    # Find the default from preference definitions
    definition = find_definition_by_key(key_str)
    definition&.typed_default_value
  end

  # Get all preferences with defaults applied
  def preferences_with_defaults
    all_prefs = {}

    prayer_book.preference_categories.includes(:preference_definitions).each do |category|
      category.preference_definitions.each do |definition|
        key = definition.key
        all_prefs[key] = preferences.key?(key) ? preferences[key] : definition.typed_default_value
      end
    end

    all_prefs
  end

  private

  def apply_defaults_for_basic_mode
    return unless mode == "basic"
    return if preferences.present? && preferences.any?

    self.preferences = build_default_preferences
  end

  def build_default_preferences
    defaults = {}

    prayer_book.preference_categories.includes(:preference_definitions).each do |category|
      category.preference_definitions.each do |definition|
        defaults[definition.key] = definition.typed_default_value
      end
    end

    defaults
  end

  def set_completed_at
    self.completed_at ||= Time.current if onboarding_completed
  end

  def validate_preferences_against_definitions
    return if mode == "basic" && preferences.blank?
    return if preferences.blank?

    all_definitions = prayer_book.preference_categories
                                 .includes(:preference_definitions)
                                 .flat_map(&:preference_definitions)
    valid_keys = all_definitions.map(&:key)
    definitions_by_key = all_definitions.index_by(&:key)

    preferences.each do |key, value|
      unless valid_keys.include?(key)
        errors.add(:preferences, "key '#{key}' does not exist for this prayer book")
        next
      end

      definition = definitions_by_key[key]
      next if definition.nil?

      unless definition.valid_value?(value)
        if definition.pref_type == "select_one"
          errors.add(:preferences, "invalid value '#{value}' for '#{key}'. Allowed values: #{definition.valid_option_values.join(', ')}")
        else
          errors.add(:preferences, "invalid value '#{value}' for '#{key}' (expected #{definition.pref_type})")
        end
      end
    end
  end

  def find_definition_by_key(key)
    prayer_book.preference_categories
               .includes(:preference_definitions)
               .flat_map(&:preference_definitions)
               .find { |d| d.key == key }
  end
end
