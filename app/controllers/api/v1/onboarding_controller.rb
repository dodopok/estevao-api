# frozen_string_literal: true

module Api
  module V1
    class OnboardingController < ApplicationController
      include Authenticatable

      before_action :authenticate_user!

      # POST /api/v1/users/onboarding
      # Salva as preferências do onboarding do usuário
      def create
        prayer_book = PrayerBook.find_by(code: onboarding_params[:prayer_book_id])
        bible_version = BibleVersion.find_by(code: onboarding_params[:bible_version_id])

        # Validate prayer_book and bible_version exist
        unless prayer_book && bible_version
          render json: {
            success: false,
            error: {
              code: "RESOURCE_NOT_FOUND",
              message: "Prayer Book or Bible version not found",
              details: {
                prayer_book_id: onboarding_params[:prayer_book_id],
                bible_version_id: onboarding_params[:bible_version_id]
              }
            }
          }, status: :not_found
          return
        end

        # Find or initialize onboarding record
        onboarding = current_user.user_onboarding || current_user.build_user_onboarding

        onboarding.assign_attributes(
          prayer_book: prayer_book,
          bible_version: bible_version,
          mode: onboarding_params[:mode] || "basic",
          preferences: onboarding_params[:preferences] || {},
          onboarding_completed: true,
          completed_at: onboarding_params[:completed_at] || Time.current
        )

        if onboarding.save
          render json: {
            success: true,
            message: "Onboarding preferences saved successfully",
            data: serialize_onboarding(onboarding)
          }, status: :ok
        else
          render json: {
            success: false,
            error: {
              code: "INVALID_PREFERENCES",
              message: "Some preferences are invalid for the selected Prayer Book",
              details: {
                prayer_book_id: prayer_book.code,
                invalid_preferences: onboarding.errors.full_messages
              }
            }
          }, status: :bad_request
        end
      end

      # GET /api/v1/users/me/onboarding
      # Retorna as preferências de onboarding do usuário
      def show
        onboarding = current_user.user_onboarding

        unless onboarding
          render json: {
            success: false,
            error: {
              code: "ONBOARDING_NOT_FOUND",
              message: "User has not completed onboarding yet"
            }
          }, status: :not_found
          return
        end

        render json: {
          success: true,
          data: serialize_onboarding(onboarding)
        }, status: :ok
      end

      private

      def onboarding_params
        params.permit(
          :prayer_book_id,
          :bible_version_id,
          :mode,
          :completed_at,
          preferences: {}
        )
      end

      def serialize_onboarding(onboarding)
        {
          id: "onb_#{onboarding.id}",
          user_id: current_user.provider_uid,
          prayer_book_id: onboarding.prayer_book.code,
          bible_version_id: onboarding.bible_version.code,
          mode: onboarding.mode,
          preferences: onboarding.preferences_with_defaults,
          onboarding_completed: onboarding.onboarding_completed,
          completed_at: onboarding.completed_at&.iso8601,
          created_at: onboarding.created_at.iso8601,
          updated_at: onboarding.updated_at.iso8601
        }
      end
    end
  end
end
