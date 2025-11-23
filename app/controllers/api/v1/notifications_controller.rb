# frozen_string_literal: true

module Api
  module V1
    class NotificationsController < ApplicationController
      include Authenticatable

      before_action :authenticate_user!
      before_action :verify_admin!, only: [ :send_to_users, :broadcast ]

      # POST /api/v1/notifications/send
      # Envia notificações para usuários específicos (Admin apenas)
      def send_to_users
        user_ids = notification_params[:user_ids]
        title = notification_params[:title]
        body = notification_params[:body]
        data = notification_params[:data] || {}

        if user_ids.blank? || title.blank? || body.blank?
          return render json: {
            error: "user_ids, title, and body are required"
          }, status: :unprocessable_entity
        end

        results = NotificationService.send_to_users(user_ids, title, body, data)

        render json: {
          message: "Notificações enviadas",
          sent_count: results[:success],
          failed_count: results[:failed]
        }, status: :ok
      end

      # POST /api/v1/notifications/broadcast
      # Envia notificação para todos os usuários (Admin apenas)
      def broadcast
        title = broadcast_params[:title]
        body = broadcast_params[:body]
        data = broadcast_params[:data] || {}

        if title.blank? || body.blank?
          return render json: {
            error: "title and body are required"
          }, status: :unprocessable_entity
        end

        # Executa em background se disponível, senão executa síncrono
        if defined?(ActiveJob)
          BroadcastNotificationJob.perform_later(title, body, data)
          total_users = User.joins(:fcm_tokens).distinct.count

          render json: {
            message: "Broadcast iniciado em background",
            total_users: total_users
          }, status: :accepted
        else
          results = NotificationService.broadcast(title, body, data)

          render json: {
            message: "Broadcast concluído",
            total_users: results[:total_users],
            sent_count: results[:success],
            failed_count: results[:failed]
          }, status: :ok
        end
      end

      private

      # Verifica se o usuário é admin
      # Nota: Ajuste esta lógica de acordo com seu sistema de permissões
      def verify_admin!
        # Por enquanto, vamos verificar se existe um campo 'role' ou 'admin' nas preferências
        # Você pode ajustar isso para usar uma gem como Pundit ou CanCanCan
        is_admin = current_user.preferences.dig("admin") == true

        unless is_admin
          render json: { error: "Unauthorized - Admin access required" }, status: :forbidden
        end
      end

      def notification_params
        params.permit(:title, :body, user_ids: [], data: {})
      end

      def broadcast_params
        params.permit(:title, :body, data: {})
      end
    end
  end
end
