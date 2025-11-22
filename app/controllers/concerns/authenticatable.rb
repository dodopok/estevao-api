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

  private

  def extract_token_from_header
    auth_header = request.headers["Authorization"]
    return nil if auth_header.blank?

    # Formato esperado: "Bearer <token>"
    auth_header.split("Bearer ").last if auth_header.start_with?("Bearer ")
  end
end
