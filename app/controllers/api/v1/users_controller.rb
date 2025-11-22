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

      private

      def merged_preferences
        current_user.preferences.merge(preferences_params)
      end

      def preferences_params
        params.require(:preferences).permit(
          :version,
          :language,
          :bible_version,
          :lords_prayer_version,
          :creed_type,
          :confession_type,
          :notifications
        ).to_h
      end
    end
  end
end
