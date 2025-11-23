# frozen_string_literal: true

class NotificationService
  class << self
    # Envia lembrete de streak para um usuário
    def send_streak_reminder(user)
      notification = {
        title: "Mantenha seu Streak! 🔥",
        body: "Não perca seu streak! Complete pelo menos um ofício hoje.",
        data: {
          type: "streak_reminder",
          click_action: "FLUTTER_NOTIFICATION_CLICK"
        }
      }

      send_notification_with_log(
        user: user,
        notification: notification,
        notification_type: "streak_reminder"
      )
    end

    # Envia notificação de novo recurso
    def send_new_feature(user, feature_title, feature_description, url = nil)
      notification = {
        title: "Novo recurso disponível! 🎉",
        body: "#{feature_title}: #{feature_description}",
        data: {
          type: "new_feature",
          url: url,
          click_action: "FLUTTER_NOTIFICATION_CLICK"
        }.compact
      }

      send_notification_with_log(
        user: user,
        notification: notification,
        notification_type: "new_feature"
      )
    end

    # Envia anúncio geral
    def send_announcement(user, title, body, url = nil)
      notification = {
        title: title,
        body: body,
        data: {
          type: "announcement",
          url: url,
          click_action: "FLUTTER_NOTIFICATION_CLICK"
        }.compact
      }

      send_notification_with_log(
        user: user,
        notification: notification,
        notification_type: "announcement"
      )
    end

    # Envia notificação para múltiplos usuários
    def send_to_users(user_ids, title, body, data = {})
      users = User.where(id: user_ids).includes(:fcm_tokens)

      notification = {
        title: title,
        body: body,
        data: data.merge(click_action: "FLUTTER_NOTIFICATION_CLICK")
      }

      results = { success: 0, failed: 0 }

      users.find_each do |user|
        result = send_notification_with_log(
          user: user,
          notification: notification,
          notification_type: data[:type] || "custom"
        )

        if result[:sent]
          results[:success] += 1
        else
          results[:failed] += 1
        end
      end

      results
    end

    # Broadcast para todos os usuários com tokens ativos
    def broadcast(title, body, data = {})
      users = User.joins(:fcm_tokens)
                  .where("fcm_tokens.updated_at > ?", 60.days.ago)
                  .distinct

      notification = {
        title: title,
        body: body,
        data: data.merge(click_action: "FLUTTER_NOTIFICATION_CLICK")
      }

      total_users = users.count

      # Processa em lotes para não sobrecarregar
      batch_size = 100
      results = { success: 0, failed: 0 }

      users.find_in_batches(batch_size: batch_size) do |batch|
        batch.each do |user|
          result = send_notification_with_log(
            user: user,
            notification: notification,
            notification_type: data[:type] || "broadcast"
          )

          if result[:sent]
            results[:success] += 1
          else
            results[:failed] += 1
          end
        end
      end

      {
        total_users: total_users,
        success: results[:success],
        failed: results[:failed]
      }
    end

    private

    # Envia notificação e registra no log
    def send_notification_with_log(user:, notification:, notification_type:)
      # Verifica se usuário tem notificações habilitadas
      if user.preferences.dig("notifications") == false
        return {
          sent: false,
          error: "Notifications disabled for user"
        }
      end

      response = FcmService.send_to_user(user, notification)

      # Cria log de notificação
      log = NotificationLog.create!(
        user: user,
        notification_type: notification_type,
        title: notification[:title],
        body: notification[:body],
        data: notification[:data],
        sent: response[:success] != false,
        error_message: response[:error]
      )

      {
        sent: log.sent,
        error: log.error_message
      }
    rescue StandardError => e
      Rails.logger.error("Error sending notification to user #{user.id}: #{e.message}")
      Rails.logger.error(e.backtrace.join("\n"))

      # Tenta criar log de erro
      begin
        NotificationLog.create!(
          user: user,
          notification_type: notification_type,
          title: notification[:title],
          body: notification[:body],
          data: notification[:data],
          sent: false,
          error_message: e.message
        )
      rescue StandardError => log_error
        Rails.logger.error("Failed to create notification log: #{log_error.message}")
      end

      {
        sent: false,
        error: e.message
      }
    end
  end
end
