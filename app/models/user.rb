# frozen_string_literal: true

class User < ApplicationRecord
  has_many :completions, dependent: :destroy
  has_many :fcm_tokens, dependent: :destroy
  has_many :notification_logs, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :provider_uid, presence: true

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
    "lords_prayer_version" => "traditional",
    "creed_type" => "apostles",
    "confession_type" => "long"
  }.freeze

  # Define preferências padrão ao criar usuário
  after_initialize :set_default_preferences, if: :new_record?

  # Verifica se completou algum ofício hoje
  def completed_today?
    completions.where(date_reference: Date.today).exists?
  end

  # Marca um ofício como completo e atualiza streak
  def complete_office!(office_type, duration_seconds: nil)
    completion = completions.create!(
      date_reference: Date.today,
      office_type:,
      duration_seconds:
    )

    update_streak!
    completion
  end

  # Atualiza o streak baseado na última completion
  def update_streak!
    return reset_streak! if last_completed_office_at.nil?

    days_since_last = (Date.today - last_completed_office_at.to_date).to_i

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
      # Perdeu o streak
      reset_streak!
    end
  end

  # Reseta o streak (usado pelo job noturno)
  def reset_streak!
    update!(
      current_streak: 1,
      longest_streak: [ current_streak, longest_streak ].max,
      last_completed_office_at: Time.current
    )
  end

  # Verifica se perdeu o streak (mais de 1 dia sem completar)
  def missed_streak?
    return false if last_completed_office_at.nil?

    (Date.today - last_completed_office_at.to_date).to_i > 1
  end

  private

  def set_default_preferences
    self.preferences = DEFAULT_PREFERENCES.merge(preferences || {})
  end
end
