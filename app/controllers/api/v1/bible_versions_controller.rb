# frozen_string_literal: true

module Api
  module V1
    class BibleVersionsController < ApplicationController
      # GET /api/v1/bible_versions
      # Lista todas as versões de Bíblia disponíveis
      def index
        bible_versions = BibleVersion.active
        bible_versions = bible_versions.where(language: params[:language]) if params[:language].present?
        bible_versions = bible_versions.order(is_recommended: :desc, name: :asc)

        expires_in 1.hour, public: true
        if stale?(etag: cache_key(bible_versions, params[:language]))
          render json: {
            data: bible_versions.map { |bv| serialize_bible_version(bv) },
            metadata: {
              total: bible_versions.count,
              last_updated: bible_versions.maximum(:updated_at)&.iso8601,
              language: params[:language]
            }
          }, status: :ok
        end
      end

      private

      def serialize_bible_version(bible_version)
        {
          id: bible_version.code,
          code: bible_version.code.upcase,
          name: bible_version.name,
          full_name: bible_version.full_name,
          language: bible_version.language,
          description: bible_version.description,
          publisher: bible_version.publisher,
          year: bible_version.year,
          is_recommended: bible_version.is_recommended,
          license: bible_version.license,
          created_at: bible_version.created_at.iso8601
        }
      end

      def cache_key(bible_versions, language = nil)
        "bible-versions-v1-#{language}-#{bible_versions.maximum(:updated_at)&.to_i}"
      end
    end
  end
end
