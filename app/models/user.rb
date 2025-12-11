# frozen_string_literal: true

class User < ApplicationRecord
  has_many :completions, dependent: :destroy
  has_many :fcm_tokens, dependent: :destroy
  has_many :notification_logs, dependent: :destroy
  has_many :journals, dependent: :destroy
  has_many :shared_offices, dependent: :destroy
  has_one :user_onboarding, dependent: :destroy
  has_one :life_rule, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :provider_uid, presence: true
  validates :timezone, presence: true
  validate :valid_timezone

  # Preferências padrões
  DEFAULT_PREFERENCES = {
    "notifications" => true,
    "notifications_enabled" => true,
    "streak_reminder_enabled" => true,
    "prayer_times" => [],
    "version" => "loc_2015",
    "prayer_book_code" => "loc_2015",
    "language" => "pt-BR",
    "bible_version" => "nvi"
  }.freeze

  # Define preferências padrão ao criar usuário
  after_initialize :set_default_preferences, if: :new_record?

  # Retorna a data de "hoje" no fuso horário do usuário
  def user_today
    Time.current.in_time_zone(timezone).to_date
  end

  # Retorna a data de "ontem" no fuso horário do usuário
  def user_yesterday
    user_today - 1.day
  end

  # Verifica se completou algum ofício hoje (baseado no timezone do usuário)
  def completed_today?
    completions.where(date_reference: user_today).exists?
  end

  # Marca um ofício como completo e atualiza streak
  def complete_office!(office_type, date: nil, duration_seconds: nil)
    date_reference = date.present? ? Date.parse(date.to_s) : user_today

    completion = completions.create!(
      date_reference:,
      office_type:,
      duration_seconds:
    )

    update_streak!
    completion
  end

  # Atualiza o streak baseado na última completion (timezone-aware)
  def update_streak!
    return reset_streak! if last_completed_office_at.nil?

    last_completed_date = last_completed_office_at.in_time_zone(timezone).to_date
    today = user_today

    days_since_last = (today - last_completed_date).to_i

    case days_since_last
    when 0
      # Completou hoje (não incrementa, já incrementou)
      update!(last_completed_office_at: Time.current)
    when 1
      # Completou ontem, mantém streak e incrementa
      increment!(:current_streak)
      update!(
        longest_streak: [ current_streak, longest_streak ].max,
        last_completed_office_at: Time.current
      )
    else
      # Perdeu o streak (mais de 1 dia sem completar)
      reset_streak!
    end
  end

  # Reseta o streak para 1 (nova série começando)
  def reset_streak!
    update!(
      current_streak: 1,
      longest_streak: [ current_streak, longest_streak ].max,
      last_completed_office_at: Time.current
    )
  end

  # Verifica se perdeu o streak (mais de 1 dia sem completar, baseado no timezone)
  def missed_streak?
    return false if last_completed_office_at.nil?

    last_completed_date = last_completed_office_at.in_time_zone(timezone).to_date
    (user_today - last_completed_date).to_i > 1
  end

  # Check if user has completed onboarding
  def onboarding_completed?
    user_onboarding&.onboarding_completed || false
  end

  # Get onboarding preferences for a specific key
  def onboarding_preference(key)
    user_onboarding&.preference_value(key)
  end

  # Get all effective preferences (from onboarding with defaults applied)
  def effective_preferences
    return {} unless user_onboarding

    prefs = user_onboarding.preferences_with_defaults.symbolize_keys
    prefs[:prayer_book_code] = user_onboarding.prayer_book.code
    prefs[:bible_version] = user_onboarding.bible_version.code
    prefs[:mode] = user_onboarding.mode
    prefs
  end

  # Legacy method for backwards compatibility - delegates to effective_preferences
  def prayer_book_preferences_for(_prayer_book_code)
    effective_preferences
  end

  private

  def set_default_preferences
    self.preferences = DEFAULT_PREFERENCES.merge(preferences || {})
  end

  def valid_timezone
    return if timezone.blank?
    return if ActiveSupport::TimeZone[timezone].present?

    errors.add(:timezone, "is not a valid timezone (e.g., 'America/Sao_Paulo', 'Europe/London')")
  end
end
