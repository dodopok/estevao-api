# frozen_string_literal: true

module Api
  module V1
    class PrayerBookUserPreferencesController < ApplicationController
      include Authenticatable

      before_action :authenticate_user!, except: [ :features ]
      before_action :set_prayer_book, only: [ :show, :update ]

      # GET /api/v1/prayer_books/:prayer_book_code/preferences
      # Retorna as preferências do usuário para um Prayer Book específico
      def show
        preference = current_user.prayer_book_user_preferences.find_by(prayer_book: @prayer_book)

        if preference
          render json: {
            prayer_book_code: @prayer_book.code,
            options: preference.options_with_defaults,
            available_features: @prayer_book.features
          }
        else
          # Retorna as opções padrão se o usuário ainda não configurou
          render json: {
            prayer_book_code: @prayer_book.code,
            options: @prayer_book.default_options,
            available_features: @prayer_book.features
          }
        end
      end

      # PATCH /api/v1/prayer_books/:prayer_book_code/preferences
      # Atualiza as preferências do usuário para um Prayer Book específico
      def update
        preference = current_user.prayer_book_user_preferences.find_or_initialize_by(
          prayer_book: @prayer_book
        )

        # Merge das opções existentes com as novas
        merged_options = (preference.options || {}).deep_merge(options_params.to_h)
        preference.options = merged_options

        if preference.save
          render json: {
            message: "Preferências atualizadas com sucesso",
            prayer_book_code: @prayer_book.code,
            options: preference.options_with_defaults
          }
        else
          render json: {
            error: "Erro ao atualizar preferências",
            messages: preference.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      # GET /api/v1/prayer_books/:prayer_book_code/features
      # Retorna as features disponíveis para um Prayer Book
      def features
        prayer_book = PrayerBook.find_by!(code: params[:prayer_book_code])

        render json: {
          prayer_book_code: prayer_book.code,
          prayer_book_name: prayer_book.name,
          features: prayer_book.features,
          default_options: prayer_book.default_options,
          capabilities: {
            supports_family_rite: prayer_book.supports_family_rite?,
            supports_vigil: prayer_book.supports_vigil?,
            available_reading_types: prayer_book.available_reading_types,
            readings_per_week: prayer_book.lectionary_features["readings_per_week"]
          }
        }
      end

      private

      def set_prayer_book
        @prayer_book = PrayerBook.find_by!(code: params[:prayer_book_code])
      end

      def options_params
        params.require(:options).permit(
          lectionary: [ :reading_type ],
          daily_office: [ :use_family_rite ]
        )
      end
    end
  end
end
