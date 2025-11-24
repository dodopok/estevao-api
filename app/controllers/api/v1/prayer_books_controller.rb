# frozen_string_literal: true

module Api
  module V1
    class PrayerBooksController < ApplicationController
      # GET /api/v1/prayer_books
      # Lista todos os livros de oração disponíveis
      def index
        prayer_books = PrayerBook.order(is_default: :desc, year: :desc)

        render json: {
          prayer_books: prayer_books.map do |pb|
            {
              code: pb.code,
              name: pb.name,
              year: pb.year,
              jurisdiction: pb.jurisdiction,
              description: pb.description,
              thumbnail_url: pb.thumbnail_url,
              pdf_url: pb.pdf_url,
              is_default: pb.is_default
            }
          end
        }, status: :ok
      end

      # GET /api/v1/prayer_books/:code
      # Mostra detalhes de um livro de oração específico
      def show
        prayer_book = PrayerBook.find_by!(code: params[:code])

        render json: {
          code: prayer_book.code,
          name: prayer_book.name,
          year: prayer_book.year,
          jurisdiction: prayer_book.jurisdiction,
          description: prayer_book.description,
          thumbnail_url: prayer_book.thumbnail_url,
          pdf_url: prayer_book.pdf_url,
          is_default: prayer_book.is_default
        }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Prayer book not found" }, status: :not_found
      end
    end
  end
end
