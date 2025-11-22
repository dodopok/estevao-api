# frozen_string_literal: true

require "net/http"
require "json"
require "jwt"

class FirebaseAuthService
  GOOGLE_CERTS_URL = "https://www.googleapis.com/robot/v1/metadata/x509/securetoken@system.gserviceaccount.com"
  CACHE_KEY = "firebase_public_keys"
  CACHE_EXPIRATION = 1.hour

  class InvalidTokenError < StandardError; end

  class << self
    # Verifica token Firebase e retorna ou cria usuário
    def verify_and_get_user(token)
      payload = verify_token(token)
      find_or_create_user(payload)
    end

    # Verifica token Firebase
    def verify_token(token)
      raise InvalidTokenError, "Token is blank" if token.blank?

      # Decodifica o token sem verificar (para pegar o kid - Key ID)
      unverified_payload = JWT.decode(token, nil, false)
      header = unverified_payload.last

      # Busca a chave pública correta
      public_key = fetch_public_key(header["kid"])
      raise InvalidTokenError, "Public key not found" if public_key.nil?

      # Verifica o token com a chave pública
      decoded_token = JWT.decode(
        token,
        public_key,
        true,
        {
          algorithm: "RS256",
          verify_iat: true,
          verify_expiration: true,
          iss: "https://securetoken.google.com/#{firebase_project_id}",
          aud: firebase_project_id,
          verify_iss: true,
          verify_aud: true
        }
      )

      decoded_token.first
    rescue JWT::DecodeError => e
      raise InvalidTokenError, "Token decode error: #{e.message}"
    rescue StandardError => e
      raise InvalidTokenError, "Token verification error: #{e.message}"
    end

    private

    def find_or_create_user(payload)
      user = User.find_by(provider_uid: payload["sub"])

      if user
        # Atualiza informações se mudaram
        user.update(
          email: payload["email"],
          name: payload["name"],
          photo_url: payload["picture"]
        )
        user
      else
        # Cria novo usuário
        User.create!(
          provider_uid: payload["sub"],
          email: payload["email"] || "#{payload['sub']}@firebase.user",
          name: payload["name"],
          photo_url: payload["picture"]
        )
      end
    end

    def fetch_public_key(kid)
      certs = fetch_google_certificates
      cert_string = certs[kid]
      return nil if cert_string.nil?

      OpenSSL::X509::Certificate.new(cert_string).public_key
    end

    def fetch_google_certificates
      # Tenta buscar do cache
      cached = Rails.cache.read(CACHE_KEY)
      return cached if cached.present?

      # Busca do Google
      uri = URI(GOOGLE_CERTS_URL)
      response = Net::HTTP.get_response(uri)
      raise InvalidTokenError, "Failed to fetch Google certificates" unless response.is_a?(Net::HTTPSuccess)

      certificates = JSON.parse(response.body)

      # Armazena no cache
      Rails.cache.write(CACHE_KEY, certificates, expires_in: CACHE_EXPIRATION)

      certificates
    rescue StandardError => e
      Rails.logger.error("Failed to fetch Google certificates: #{e.message}")
      {}
    end

    def firebase_project_id
      ENV.fetch("FIREBASE_PROJECT_ID", nil)
    end
  end
end
