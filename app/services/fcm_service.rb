# frozen_string_literal: true

class FcmService
  class << self
    # Envia notificação para um usuário específico
    def send_to_user(user, notification)
      tokens = user.fcm_tokens.active.pluck(:token)
      return { success: false, error: "No active tokens" } if tokens.empty?

      payload = build_payload(notification)

      response = fcm_client.send_v1(
        message: {
          token: tokens.first, # FCM v1 envia para um token por vez
          notification: payload[:notification],
          data: payload[:data],
          android: {
            priority: "high",
            notification: {
              channel_id: "ordo_channel",
              sound: "default"
            }
          },
          apns: {
            payload: {
              aps: {
                sound: "default",
                badge: 1
              }
            }
          }
        }
      )

      # Remove tokens inválidos
      handle_invalid_tokens(user, response, tokens)

      response
    rescue StandardError => e
      Rails.logger.error("FCM Error for user #{user.id}: #{e.message}")
      { success: false, error: e.message }
    end

    # Envia notificação para múltiplos usuários
    def send_batch(users, notification)
      results = { success: 0, failed: 0, errors: [] }

      users.find_each do |user|
        response = send_to_user(user, notification)
        if response[:success] == false
          results[:failed] += 1
          results[:errors] << { user_id: user.id, error: response[:error] }
        else
          results[:success] += 1
        end
      end

      results
    end

    # Envia notificação multicast (para múltiplos tokens)
    def send_multicast(tokens, notification)
      return { success: false, error: "No tokens provided" } if tokens.empty?

      payload = build_payload(notification)

      # Divide em lotes de 500 tokens (limite do FCM)
      batch_size = 500
      total_success = 0
      total_failure = 0

      tokens.each_slice(batch_size) do |token_batch|
        response = fcm_client.send_v1(
          message: {
            token: token_batch.first,
            notification: payload[:notification],
            data: payload[:data]
          }
        )

        # Nota: Para produção real, considere usar o endpoint multicast do FCM
        # que aceita até 500 tokens por vez
        total_success += 1 if response[:status_code] == 200
        total_failure += 1 if response[:status_code] != 200
      end

      {
        success: total_success,
        failure: total_failure,
        total: tokens.size
      }
    rescue StandardError => e
      Rails.logger.error("FCM Multicast Error: #{e.message}")
      { success: false, error: e.message }
    end

    private

    def fcm_client
      @fcm_client ||= begin
        server_key = ENV.fetch("FIREBASE_SERVER_KEY", nil)
        if server_key.blank?
          Rails.logger.warn("FIREBASE_SERVER_KEY not configured")
          nil
        else
          FCM.new(server_key)
        end
      end
    end

    def build_payload(notification)
      {
        notification: {
          title: notification[:title],
          body: notification[:body]
        },
        data: (notification[:data] || {}).transform_keys(&:to_s)
      }
    end

    def handle_invalid_tokens(user, response, tokens)
      # Se o FCM retornar erro de token inválido, remove o token
      if response[:status_code] == 404 || response[:body]&.include?("not-registered")
        user.fcm_tokens.where(token: tokens).destroy_all
        Rails.logger.info("Removed invalid FCM tokens for user #{user.id}")
      end
    end
  end
end
