# frozen_string_literal: true

module Authenticatable
  extend ActiveSupport::Concern

  included do
    attr_reader :current_user
  end

  # Autenticação OPCIONAL - continua mesmo sem token
  def authenticate_user_optional
    token = extract_token_from_header
    @current_user = FirebaseAuthService.verify_and_get_user(token) if token.present?
    
    # Mock user in development when MOCK_PREMIUM is enabled
    if @current_user.nil? && Rails.env.development? && ENV["MOCK_PREMIUM"] == "true"
      @current_user = find_or_create_mock_user
      Rails.logger.info "[MOCK_PREMIUM] Using mock user: #{@current_user.email}"
    end
  rescue FirebaseAuthService::InvalidTokenError => e
    Rails.logger.warn("Optional auth failed: #{e.message}")
    @current_user = nil
  end

  # Autenticação OBRIGATÓRIA - retorna erro 401 sem token válido
  def authenticate_user!
    token = extract_token_from_header
    @current_user = FirebaseAuthService.verify_and_get_user(token) if token.present?

    return if @current_user

    render json: { error: "Unauthorized" }, status: :unauthorized
  rescue FirebaseAuthService::InvalidTokenError => e
    render json: { error: "Authentication failed: #{e.message}" }, status: :unauthorized
  end

  # Verificação de assinatura premium
  def require_premium!
    unless current_user&.premium?
      render json: {
        error: "Premium subscription required",
        premium: false,
        message: "This feature requires an active premium subscription"
      }, status: :forbidden
    else
      # Log quando estiver usando mock premium em development
      if Rails.env.development? && ENV["MOCK_PREMIUM"] == "true"
        Rails.logger.info "[MOCK_PREMIUM] User #{current_user.id} being treated as premium"
      end
    end
  end

  private

  def extract_token_from_header
    auth_header = request.headers["Authorization"]
    return nil if auth_header.blank?

    # Formato esperado: "Bearer <token>"
    auth_header.split("Bearer ").last if auth_header.start_with?("Bearer ")
  end

  def find_or_create_mock_user
    User.find_or_create_by!(
      email: "mock_premium@dev.local",
      provider_uid: "mock_premium_uid"
    ) do |user|
      user.timezone = "America/Sao_Paulo"
      user.preferences = {
        "notifications" => true,
        "notifications_enabled" => true,
        "streak_reminder_enabled" => true,
        "prayer_times" => [],
        "version" => "loc_2015",
        "prayer_book_code" => "loc_2015",
        "language" => "pt-BR",
        "bible_version" => "nvi",
        "preferred_audio_voice" => "femal"
      }
      user.premium_expires_at = 1.year.from_now
      user.build_user_onboarding(
        onboarding_completed: true,
        completed_at: Time.current,
        mode: "basic",
        prayer_book: PrayerBook.find_by(code: "loc_2015"),
        bible_version: BibleVersion.find_by(code: "nvi"),
        preferences: {}
      )
    end
  end
end
