# frozen_string_literal: true

module Api
  module V1
    class PreferencesController < ApplicationController
      # GET /api/v1/prayer_books/:prayer_book_code/preferences
      # Retorna todas as categorias e preferências para um Prayer Book específico
      def show
        prayer_book = PrayerBook.find_by(code: params[:prayer_book_code])

        unless prayer_book
          render json: {
            error: {
              code: "PRAYER_BOOK_NOT_FOUND",
              message: "Prayer Book with code '#{params[:prayer_book_code]}' not found"
            }
          }, status: :not_found
          return
        end

        categories = prayer_book.preference_categories.includes(:preference_definitions)

        expires_in 30.minutes, public: true
        if stale?(etag: cache_key(prayer_book, categories))
          render json: {
            prayer_book_id: prayer_book.code,
            prayer_book_name: prayer_book.name,
            categories: categories.map(&:as_json_for_api),
            metadata: {
              total_categories: categories.count,
              total_preferences: categories.sum { |c| c.preference_definitions.count },
              last_updated: categories.flat_map(&:preference_definitions).map(&:updated_at).max&.iso8601,
              version: "1.0"
            }
          }, status: :ok
        end
      end

      private

      def cache_key(prayer_book, categories)
        max_updated = [
          prayer_book.updated_at,
          categories.map(&:updated_at).max,
          categories.flat_map { |c| c.preference_definitions.map(&:updated_at) }.max
        ].compact.max

        "prayer-book-#{prayer_book.code}-prefs-v1-#{max_updated&.to_i}"
      end
    end
  end
end
