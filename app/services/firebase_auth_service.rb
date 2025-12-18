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

    # Deleta um usuário do Firebase Authentication
    # @param uid [String] O Firebase UID (provider_uid) do usuário
    # @return [Hash] { success: true } ou { success: false, error: String }
    # @raise [ArgumentError] se o UID for vazio
    def delete_user(uid)
      raise ArgumentError, "UID is required" if uid.blank?

      access_token = fetch_admin_access_token
      uri = URI("https://identitytoolkit.googleapis.com/v1/projects/#{firebase_project_id}/accounts:delete")

      request = Net::HTTP::Post.new(uri)
      request["Authorization"] = "Bearer #{access_token}"
      request["Content-Type"] = "application/json"
      request.body = { localId: uid }.to_json

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

      if response.is_a?(Net::HTTPSuccess)
        Rails.logger.info("Firebase user #{uid} deleted successfully")
        { success: true }
      else
        error_body = JSON.parse(response.body) rescue { "error" => { "message" => response.body } }
        error_message = error_body.dig("error", "message") || "Unknown error"
        Rails.logger.error("Firebase delete_user failed for #{uid}: #{error_message}")
        { success: false, error: error_message }
      end
    rescue ArgumentError
      raise
    rescue StandardError => e
      Rails.logger.error("Firebase delete_user error: #{e.message}")
      { success: false, error: e.message }
    end

    # Verifica token Firebase
    def verify_token(token)
      raise InvalidTokenError, "Token is blank" if token.blank?

      # Valida se Firebase Project ID está configurado
      project_id = firebase_project_id
      if project_id.blank?
        raise InvalidTokenError, "FIREBASE_PROJECT_ID environment variable is not set. " \
                                 "Please configure it in your environment."
      end

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
          iss: "https://securetoken.google.com/#{project_id}",
          aud: project_id,
          verify_iss: true,
          verify_aud: true
        }
      )

      decoded_token.first
    rescue JWT::DecodeError => e
      raise InvalidTokenError, "Token decode error: #{e.message}. " \
                               "Make sure FIREBASE_PROJECT_ID matches your Firebase project."
    rescue StandardError => e
      raise InvalidTokenError, "Token verification error: #{e.message}"
    end

    private

    def find_or_create_user(payload)
      # Primeiro tenta encontrar por provider_uid (Firebase UID)
      user = User.find_by(provider_uid: payload["sub"])

      # Se não encontrar por provider_uid, tenta por email
      user ||= User.find_by(email: payload["email"]) if payload["email"].present?

      if user
        # Atualiza apenas provider_uid e email (identificadores)
        # NÃO sobrescreve name e photo_url que o usuário pode ter personalizado
        updates = {
          provider_uid: payload["sub"],
          email: payload["email"]
        }

        # Só atualiza name/photo_url se estiverem vazios (primeira vez)
        updates[:name] = payload["name"] if user.name.blank? && payload["name"].present?
        updates[:photo_url] = payload["picture"] if user.photo_url.blank? && payload["picture"].present? && !user.avatar.attached?

        user.update(updates)
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

    # Obtém token de acesso OAuth2 usando credenciais do service account
    def fetch_admin_access_token
      client_email = ENV.fetch("FIREBASE_CLIENT_EMAIL", nil)
      private_key = ENV.fetch("FIREBASE_PRIVATE_KEY", nil)

      if client_email.blank? || private_key.blank?
        raise "Firebase service account credentials not configured. " \
              "Set FIREBASE_CLIENT_EMAIL and FIREBASE_PRIVATE_KEY environment variables."
      end

      credentials = {
        "type" => "service_account",
        "project_id" => firebase_project_id,
        "client_email" => client_email,
        "private_key" => private_key.gsub('\\n', "\n")
      }

      require "googleauth"
      authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
        json_key_io: StringIO.new(credentials.to_json),
        scope: "https://www.googleapis.com/auth/identitytoolkit"
      )
      authorizer.fetch_access_token!["access_token"]
    end
  end
end
