# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      include Authenticatable

      before_action :authenticate_user!

      # GET /api/v1/users/me
      # Returns current user profile
      def show
        render json: {
          id: current_user.id,
          email: current_user.email,
          name: current_user.name,
          photo_url: current_user.photo_url,
          preferences: current_user.preferences,
          current_streak: current_user.current_streak,
          longest_streak: current_user.longest_streak,
          last_completed_office_at: current_user.last_completed_office_at
        }
      end

      # PATCH /api/v1/users/preferences
      # Updates user preferences
      def update_preferences
        if current_user.update(preferences: merged_preferences)
          render json: {
            message: "Preferences updated successfully",
            preferences: current_user.preferences
          }
        else
          render json: { error: current_user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # GET /api/v1/users/completions
      # Returns user's completion history
      def completions
        completions = current_user.completions
                                  .order(date_reference: :desc, created_at: :desc)
                                  .limit(params[:limit] || 30)

        render json: {
          completions: completions.as_json(only: %i[id date_reference office_type duration_seconds created_at]),
          total_completions: current_user.completions.count,
          current_streak: current_user.current_streak,
          longest_streak: current_user.longest_streak
        }
      end

      # POST /api/v1/users/fcm_token
      # Saves or updates FCM token for push notifications
      def save_fcm_token
        token = fcm_token_params[:fcm_token]
        platform = fcm_token_params[:platform] || "android"

        if token.blank?
          return render json: { error: "FCM token is required" }, status: :unprocessable_entity
        end

        # Encontra ou cria o token
        fcm_token = current_user.fcm_tokens.find_or_initialize_by(token: token)
        fcm_token.platform = platform
        fcm_token.touch # Atualiza o updated_at

        if fcm_token.save
          render json: {
            message: "Token FCM salvo com sucesso",
            fcm_token: token
          }, status: :ok
        else
          render json: { error: fcm_token.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/users/fcm_token
      # Removes FCM token (when user logs out or disables notifications)
      def delete_fcm_token
        token = params[:fcm_token]

        if token.blank?
          return render json: { error: "FCM token is required" }, status: :unprocessable_entity
        end

        current_user.fcm_tokens.where(token: token).destroy_all

        render json: { message: "Token FCM removido com sucesso" }, status: :ok
      end

      private

      def merged_preferences
        current_user.preferences.merge(preferences_params)
      end

      def preferences_params
        params.require(:preferences).permit(
          :version,
          :prayer_book_code,
          :language,
          :bible_version,
          :lords_prayer_version,
          :creed_type,
          :confession_type,
          :notifications,
          :notifications_enabled,
          :streak_reminder_enabled,
          prayer_times: [
            :office_id,
            :office_name,
            :hour,
            :minute,
            :enabled
          ]
        ).to_h
      end

      def fcm_token_params
        params.permit(:fcm_token, :platform)
      end
    end
  end
end
