# frozen_string_literal: true

class PreferenceDefinition < ApplicationRecord
  VALID_TYPES = %w[select_one toggle time text number].freeze

  belongs_to :preference_category
  has_one :prayer_book, through: :preference_category

  validates :key, presence: true, uniqueness: { scope: :preference_category_id }
  validates :name, presence: true
  validates :pref_type, presence: true, inclusion: { in: VALID_TYPES }
  validates :position, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :validate_options_for_select_one

  # Coerce default_value based on pref_type
  def typed_default_value
    case pref_type
    when "toggle"
      ActiveModel::Type::Boolean.new.cast(default_value)
    when "number"
      default_value.to_i
    else
      default_value
    end
  end

  # Validate a value against this preference definition
  def valid_value?(value)
    case pref_type
    when "select_one"
      valid_option_values.include?(value.to_s)
    when "toggle"
      [ true, false, "true", "false" ].include?(value)
    when "time"
      value.nil? || value.to_s.match?(/^([01]\d|2[0-3]):([0-5]\d)$/)
    when "number"
      value.nil? || value.to_s.match?(/^\d+$/)
    else
      true
    end
  end

  def valid_option_values
    return [] unless pref_type == "select_one"

    (options || []).map { |opt| opt["value"].to_s }
  end

  def as_json_for_api
    base = {
      id: key,
      key: key,
      name: name,
      description: description,
      type: pref_type,
      required: required,
      default_value: typed_default_value
    }

    if pref_type == "select_one"
      base[:options] = (options || []).map do |opt|
        {
          value: opt["value"],
          label: opt["label"],
          description: opt["description"],
          is_default: opt["value"].to_s == default_value.to_s
        }
      end
    end

    base[:depends_on] = depends_on if depends_on.present?

    base
  end

  private

  def validate_options_for_select_one
    return unless pref_type == "select_one"

    if options.blank? || !options.is_a?(Array) || options.empty?
      errors.add(:options, "must be a non-empty array for select_one type")
      return
    end

    options.each_with_index do |opt, idx|
      unless opt.is_a?(Hash) && opt["value"].present? && opt["label"].present?
        errors.add(:options, "option at index #{idx} must have 'value' and 'label'")
      end
    end
  end
end
