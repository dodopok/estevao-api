module Api
  module V1
    class AudioController < ApplicationController
      include Authenticatable

      before_action :authenticate_user!
      before_action :require_premium!, only: [ :url ]

      # GET /api/v1/audio/voice_samples
      # Returns voice samples and metadata (no premium required)
      def voice_samples
        samples = ElevenlabsAudioService::VOICES.map do |key, info|
          {
            key: key,
            name: info[:name],
            gender: info[:gender],
            sample_url: sample_url_for(key)
          }
        end

        render json: {
          voices: samples,
          default_voice: "male_1"
        }
      end

      # GET /api/v1/audio/url/:prayer_book/:voice/:slug
      # Returns audio URL for premium users
      def url
        prayer_book_code = params[:prayer_book]
        voice_key = params[:voice]
        slug = params[:slug]

        # Validate voice key
        unless LiturgicalText::AVAILABLE_VOICES.include?(voice_key)
          render json: {
            error: "Invalid voice",
            available_voices: LiturgicalText::AVAILABLE_VOICES
          }, status: :unprocessable_content
          return
        end

        # Find liturgical text
        text = LiturgicalText.find_text(slug, prayer_book_code: prayer_book_code)

        unless text
          render json: { error: "Liturgical text not found" }, status: :not_found
          return
        end

        # Get audio URL for requested voice
        audio_url = text.audio_url_for_voice(voice_key)

        if audio_url.present?
          # Return full URL (Railway will serve from /public/audio)
          full_url = request.base_url + audio_url

          render json: {
            audio_url: full_url,
            voice: voice_key,
            slug: slug,
            title: text.title
          }
        else
          render json: {
            error: "Audio not yet generated for this voice",
            voice: voice_key,
            available_voices: text.voices_generated
          }, status: :not_found
        end
      end

      private

      def sample_url_for(voice_key)
        "#{request.base_url}/audio/samples/sample_#{voice_key}.mp3"
      end
    end
  end
end
