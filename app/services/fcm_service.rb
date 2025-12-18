# frozen_string_literal: true

require "googleauth"
require "net/http"
require "json"

class FcmService
  FCM_V1_URL = "https://fcm.googleapis.com/v1/projects/%s/messages:send"

  class << self
    # Envia notificação para um usuário específico
    def send_to_user(user, notification)
      unless configured?
        return { success: false, error: "FCM not configured. Set FIREBASE_CREDENTIALS or GOOGLE_APPLICATION_CREDENTIALS" }
      end

      tokens = user.fcm_tokens.active.pluck(:token)
      return { success: false, error: "No active tokens" } if tokens.empty?

      # Envia para todos os tokens ativos do usuário
      results = tokens.map do |token|
        send_to_token(token, notification)
      end

      # Remove tokens inválidos
      invalid_tokens = results.select { |r| r[:invalid_token] }.map { |r| r[:token] }
      if invalid_tokens.any?
        user.fcm_tokens.where(token: invalid_tokens).destroy_all
        Rails.logger.info("Removed #{invalid_tokens.size} invalid FCM tokens for user #{user.id}")
      end

      success_count = results.count { |r| r[:success] }
      if success_count > 0
        { success: true, sent: success_count, total: tokens.size }
      else
        { success: false, error: results.first&.dig(:error) || "All tokens failed" }
      end
    rescue StandardError => e
      Rails.logger.error("FCM Error for user #{user.id}: #{e.message}")
      Rails.logger.error(e.backtrace.first(5).join("\n"))
      { success: false, error: e.message }
    end

    # Envia notificação para um token específico
    def send_to_token(token, notification)
      message = build_message(token, notification)

      uri = URI(FCM_V1_URL % project_id)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri)
      request["Authorization"] = "Bearer #{access_token}"
      request["Content-Type"] = "application/json"
      request.body = { message: message }.to_json

      response = http.request(request)

      if response.code.to_i == 200
        Rails.logger.info("FCM sent successfully to token #{token[0..20]}...")
        { success: true, token: token }
      else
        error_body = JSON.parse(response.body) rescue {}
        error_msg = error_body.dig("error", "message") || response.body

        # Verifica se é token inválido para remoção
        invalid = error_body.dig("error", "details")&.any? { |d| d["errorCode"] == "UNREGISTERED" }
        invalid ||= error_msg.include?("not a valid FCM registration token")
        invalid ||= response.code.to_i == 404

        Rails.logger.warn("FCM failed for token #{token[0..20]}...: #{error_msg}")
        { success: false, token: token, error: error_msg, invalid_token: invalid }
      end
    rescue StandardError => e
      Rails.logger.error("FCM send error: #{e.message}")
      { success: false, token: token, error: e.message, invalid_token: false }
    end

    # Envia notificação para múltiplos usuários
    def send_batch(users, notification)
      results = { success: 0, failed: 0, errors: [] }

      users.find_each do |user|
        response = send_to_user(user, notification)
        if response[:success]
          results[:success] += 1
        else
          results[:failed] += 1
          results[:errors] << { user_id: user.id, error: response[:error] }
        end
      end

      results
    end

    # Verifica se o FCM está configurado
    def configured?
      credentials_json.present? && project_id.present?
    end

    # Retorna informações de configuração para debug
    def configuration_status
      {
        configured: configured?,
        has_credentials: credentials_json.present?,
        has_project_id: project_id.present?,
        project_id: project_id,
        credentials_source: credentials_source
      }
    end

    private

    def build_message(token, notification)
      {
        token: token,
        notification: {
          title: notification[:title],
          body: notification[:body]
        },
        data: (notification[:data] || {}).transform_values(&:to_s),
        android: {
          priority: "high",
          notification: {
            channel_id: "ordo_channel",
            sound: "default",
            default_vibrate_timings: true,
            default_light_settings: true
          }
        },
        apns: {
          headers: {
            "apns-priority": "10",
            "apns-push-type": "alert"
          },
          payload: {
            aps: {
              alert: {
                title: notification[:title],
                body: notification[:body]
              },
              sound: "default",
              badge: 1,
              "mutable-content": 1
            }
          }
        }
      }
    end

    def access_token
      @authorizer ||= Google::Auth::ServiceAccountCredentials.make_creds(
        json_key_io: StringIO.new(credentials_json),
        scope: "https://www.googleapis.com/auth/firebase.messaging"
      )
      @authorizer.fetch_access_token!
      @authorizer.access_token
    end

    def credentials_json
      @credentials_json ||= begin
        # Prioridade 1: FIREBASE_CREDENTIALS (JSON string)
        if ENV["FIREBASE_CREDENTIALS"].present?
          ENV["FIREBASE_CREDENTIALS"]
        # Prioridade 2: GOOGLE_APPLICATION_CREDENTIALS (path to file)
        elsif ENV["GOOGLE_APPLICATION_CREDENTIALS"].present? && File.exist?(ENV["GOOGLE_APPLICATION_CREDENTIALS"])
          File.read(ENV["GOOGLE_APPLICATION_CREDENTIALS"])
        else
          nil
        end
      end
    end

    def credentials_source
      if ENV["FIREBASE_CREDENTIALS"].present?
        "FIREBASE_CREDENTIALS env var"
      elsif ENV["GOOGLE_APPLICATION_CREDENTIALS"].present?
        "GOOGLE_APPLICATION_CREDENTIALS file"
      else
        "not configured"
      end
    end

    def project_id
      @project_id ||= begin
        # Prioridade 1: FIREBASE_PROJECT_ID explícito
        if ENV["FIREBASE_PROJECT_ID"].present?
          ENV["FIREBASE_PROJECT_ID"]
        # Prioridade 2: extrair do credentials JSON
        elsif credentials_json.present?
          JSON.parse(credentials_json)["project_id"]
        else
          nil
        end
      rescue JSON::ParserError
        nil
      end
    end
  end
end
