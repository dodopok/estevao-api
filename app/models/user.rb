# frozen_string_literal: true

class User < ApplicationRecord
  has_many :completions, dependent: :destroy
  has_many :fcm_tokens, dependent: :destroy
  has_many :notification_logs, dependent: :destroy
  has_many :journals, dependent: :destroy
  has_many :shared_offices, dependent: :destroy
  has_one :user_onboarding, dependent: :destroy
  has_one :life_rule, dependent: :destroy

  # Active Storage para upload de foto
  has_one_attached :avatar

  validates :email, presence: true, uniqueness: true
  validates :provider_uid, presence: true
  validates :timezone, presence: true
  validate :valid_timezone
  validate :valid_audio_voice_preference

  # Preferências padrões
  DEFAULT_PREFERENCES = {
    "notifications" => true,
    "notifications_enabled" => true,
    "streak_reminder_enabled" => true,
    "prayer_times" => [],
    "version" => "loc_2015",
    "prayer_book_code" => "loc_2015",
    "language" => "pt-BR",
    "bible_version" => "nvi",
    "preferred_audio_voice" => "male_1"
  }.freeze

  # Callbacks
  before_save :set_default_preferences, if: :new_record?
  before_save :sync_bible_version_language, if: :preferences_changed?
  after_update :clear_daily_office_cache, if: :preferences_changed?

  # Syncs Bible version language with Prayer Book language
  def sync_bible_version_language
    # Skip if preferences haven't changed
    return unless preferences_changed?

    old_prefs = preferences_was || {}
    new_prefs = preferences || {}

    # Only sync if prayer_book_code or bible_version or language changed
    return unless old_prefs["prayer_book_code"] != new_prefs["prayer_book_code"] ||
                  old_prefs["language"] != new_prefs["language"] ||
                  new_prefs["bible_version"].blank?

    prayer_book_code = new_prefs["prayer_book_code"]
    return if prayer_book_code.blank?

    prayer_book = PrayerBook.find_by_code(prayer_book_code)
    return unless prayer_book

    current_bible_code = new_prefs["bible_version"]
    current_bible = BibleVersion.find_by_code(current_bible_code)

    # If Bible language doesn't match Prayer Book language, switch to a recommended version of that language
    if current_bible.nil? || current_bible.language != prayer_book.language
      new_bible = BibleVersion.where(language: prayer_book.language, is_active: true)
                              .order(is_recommended: :desc, name: :asc).first
      if new_bible
        self.preferences["bible_version"] = new_bible.code
        self.preferences["language"] = prayer_book.language # Sync general language too
      end
    end
  end

  # Retorna a URL da foto do perfil (prioriza avatar uploaded, depois photo_url do OAuth)
  def profile_photo_url
    if avatar.attached?
      # For public disk storage in production, use direct URL
      # Files are stored in public/storage with subdirectories based on key
      # Example key: "abc123def456" -> stored at public/storage/ab/c1/abc123def456
      if Rails.application.config.active_storage.service == :production
        key = avatar.key
        # ActiveStorage Disk service stores files in nested directories: first 2 chars / next 2 chars / full key
        path = "storage/#{key[0..1]}/#{key[2..3]}/#{key}"
        "#{default_url_host}/#{path}"
      else
        # Development: use standard ActiveStorage URL
        Rails.application.routes.url_helpers.rails_blob_url(avatar, host: default_url_host)
      end
    else
      photo_url
    end
  end

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
      longest_streak: [ 1, longest_streak ].max,
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

  # Check if user has active premium subscription
  def premium?
    # Mock premium in development if MOCK_PREMIUM is set
    return true if Rails.env.development? && ENV["MOCK_PREMIUM"] == "true"

    return false if premium_expires_at.nil?
    premium_expires_at > Time.current
  end

  # Get preferred audio voice from preferences
  def preferred_audio_voice
    preferences["preferred_audio_voice"] || "male_1"
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

  def valid_audio_voice_preference
    voice = preferences&.dig("preferred_audio_voice")
    return if voice.blank?
    return if LiturgicalText::AVAILABLE_VOICES.include?(voice)

    errors.add(:preferences, "preferred_audio_voice must be one of: #{LiturgicalText::AVAILABLE_VOICES.join(', ')}")
  end

  # Clear cached daily office data when preferences change
  # This ensures users get updated audio URLs and content based on new preferences
  def clear_daily_office_cache
    return unless premium? # Only premium users have personalized cache

    Rails.logger.info "Clearing daily office cache for user #{id} due to preference change"

    # Clear cache for last 30 days and next 7 days
    date_range = (30.days.ago.to_date..7.days.from_now.to_date)
    office_types = [ :morning, :midday, :evening, :compline ]

    date_range.each do |date|
      office_types.each do |office_type|
        # We can't rebuild the exact cache key without knowing all preference combinations,
        # so we delete by pattern matching user_id
        Rails.cache.delete_matched("daily_office/#{date}/#{office_type}/*user_#{id}*")
      end
    end
  end

  def default_url_host
    ENV.fetch("APP_HOST", "http://localhost:3000")
  end
end
