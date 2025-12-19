# frozen_string_literal: true

module Api
  module V1
    class PrayerBooksController < ApplicationController
      include Authenticatable

      before_action :authenticate_user_optional

      # GET /api/v1/prayer_books
      # Lista todos os livros de oração disponíveis
      # Params: language (optional) - filter by language (pt-BR, en, es)
      def index
        prayer_books = if params[:language].present?
                         PrayerBook.by_language(params[:language])
        else
                         PrayerBook.all
        end

        prayer_books = prayer_books.order(is_recommended: :desc, year: :desc)

        expires_in 1.hour, public: true
        if stale?(etag: cache_key(prayer_books, current_user))
          render json: {
            data: prayer_books.map { |pb| serialize_prayer_book(pb) }
          }, status: :ok
        end
      end

      # GET /api/v1/prayer_books/:code
      # Mostra detalhes de um livro de oração específico
      def show
        prayer_book = PrayerBook.find_by(code: params[:code])

        unless prayer_book
          render json: {
            error: {
              code: "PRAYER_BOOK_NOT_FOUND",
              message: "Prayer Book with code '#{params[:code]}' not found"
            }
          }, status: :not_found
          return
        end

        expires_in 1.hour, public: true
        if stale?(etag: "prayer-book-#{prayer_book.code}-#{prayer_book.updated_at.to_i}")
          render json: { data: serialize_prayer_book(prayer_book) }, status: :ok
        end
      end

      private

      def serialize_prayer_book(prayer_book)
        {
          id: prayer_book.code,
          code: prayer_book.code,
          name: prayer_book.name,
          full_name: prayer_book.name,
          description: prayer_book.description,
          language: prayer_book.language,
          jurisdiction: prayer_book.jurisdiction,
          year: prayer_book.year,
          is_recommended: prayer_book.is_recommended || false,
          premium_required: prayer_book.premium_required,
          is_accessible: prayer_book.accessible_by?(current_user),
          image_url: prayer_book.image_url,
          thumbnail_url: prayer_book.thumbnail_url,
          pdf_url: prayer_book.pdf_url,
          created_at: prayer_book.created_at.iso8601,
          updated_at: prayer_book.updated_at.iso8601
        }
      end

      def cache_key(prayer_books, user)
        user_suffix = user&.premium? ? "-premium" : "-free"
        "prayer-books-list-v2-#{prayer_books.maximum(:updated_at)&.to_i}#{user_suffix}"
      end
    end
  end
end
