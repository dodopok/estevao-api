module Api
  module V1
    class SubscriptionsController < ApplicationController
      include Authenticatable

      before_action :authenticate_user!

      # POST /api/v1/subscription/verify
      # Verify subscription status with RevenueCat and update user
      def verify
        unless params[:revenue_cat_user_id].present?
          render json: { error: "revenue_cat_user_id is required" }, status: :unprocessable_content
          return
        end

        current_user.update!(revenue_cat_user_id: params[:revenue_cat_user_id])

        service = RevenueCatService.new
        success = service.update_user_premium_status(current_user)

        if success
          render json: {
            premium: current_user.premium?,
            expires_at: current_user.premium_expires_at,
            preferred_voice: current_user.preferred_audio_voice
          }
        else
          render json: {
            premium: false,
            expires_at: nil,
            preferred_voice: current_user.preferred_audio_voice,
            message: "No active subscription found"
          }
        end
      rescue StandardError => e
        Rails.logger.error "Subscription verification failed: #{e.message}"
        render json: { error: "Failed to verify subscription" }, status: :internal_server_error
      end

      # GET /api/v1/subscription/premium_status
      # Get current premium status
      def premium_status
        render json: {
          premium: current_user.premium?,
          expires_at: current_user.premium_expires_at,
          preferred_voice: current_user.preferred_audio_voice,
          available_voices: voice_info
        }
      end

      private

      def voice_info
        ElevenlabsAudioService::VOICES.map do |key, info|
          {
            key: key,
            name: info[:name],
            gender: info[:gender]
          }
        end
      end
    end
  end
end
