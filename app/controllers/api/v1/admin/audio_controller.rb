module Api
  module V1
    module Admin
      class AudioController < ApplicationController
        include Authenticatable

        before_action :authenticate_user!
        # TODO: Add admin authentication check
        # before_action :require_admin!

        # GET /api/v1/admin/audio/generation_status
        # Returns status of audio generation sessions
        def generation_status
          sessions = AudioGenerationSession
            .order(created_at: :desc)
            .limit(10)

          active_session = AudioGenerationSession.running.first

          # Count overall progress
          total_texts = LiturgicalText.count
          total_voices = LiturgicalText::AVAILABLE_VOICES.count
          total_possible = total_texts * total_voices

          # Count completed audio files using SQL
          # A text is complete when audio_urls has all 3 voice keys
          voice_keys = LiturgicalText::AVAILABLE_VOICES
          completed_texts = LiturgicalText
            .where("audio_urls ?& array[:keys]", keys: voice_keys)
            .count

          completed_count = completed_texts * total_voices

          render json: {
            overall_progress: {
              total_texts: total_texts,
              total_voices: total_voices,
              total_possible_audio_files: total_possible,
              completed_audio_files: completed_count,
              completion_percentage: total_possible > 0 ? (completed_count.to_f / total_possible * 100).round(2) : 0
            },
            active_session: active_session ? session_summary(active_session) : nil,
            recent_sessions: sessions.map { |s| session_summary(s) },
            available_voices: ElevenlabsAudioService::VOICES.map { |k, v| { key: k, name: v[:name] } }
          }
        end

        private

        def session_summary(session)
          progress_percentage = session.total_texts > 0 ?
            (session.processed_count.to_f / session.total_texts * 100).round(2) : 0

          {
            id: session.id,
            prayer_book_code: session.prayer_book_code,
            voice_keys: session.voice_keys,
            status: session.status,
            current_voice: session.current_voice_key,
            current_text_id: session.current_text_id,
            total_texts: session.total_texts,
            processed_count: session.processed_count,
            failed_count: session.failed_count,
            progress_percentage: progress_percentage,
            started_at: session.started_at,
            completed_at: session.completed_at,
            error_log: session.error_log
          }
        end
      end
    end
  end
end
