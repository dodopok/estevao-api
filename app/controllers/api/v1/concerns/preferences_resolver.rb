# frozen_string_literal: true

module Api
  module V1
    module Concerns
      module PreferencesResolver
        extend ActiveSupport::Concern

        private

        # Resolve and memoize preferences from user onboarding or params
        def resolved_preferences
          @resolved_preferences ||= build_resolved_preferences
        end

        # Convenience accessors for common preferences
        def resolved_prayer_book_code
          resolved_preferences[:prayer_book_code]
        end

        def resolved_bible_version
          resolved_preferences[:bible_version]
        end

        def resolved_prayer_book
          @resolved_prayer_book ||= PrayerBook.find_by_code!(resolved_prayer_book_code)
        end

        def resolved_bible_version_record
          @resolved_bible_version_record ||= BibleVersion.find_by_code!(resolved_bible_version)
        end

        # Build cache key based on preferences that affect the endpoint
        def preferences_cache_key(relevant_keys = nil)
          prefs = if relevant_keys
            resolved_preferences.slice(*relevant_keys)
          else
            resolved_preferences
          end

          Digest::MD5.hexdigest(prefs.sort.to_h.to_json)[0..7]
        end

        # Validate required preferences - call this in before_action where needed
        def validate_preferences!
          if current_user
            # Logged in user must have completed onboarding
            unless current_user.onboarding_completed?
              render json: {
                success: false,
                error: {
                  code: "ONBOARDING_REQUIRED",
                  message: "Você precisa completar o onboarding antes de usar este recurso"
                }
              }, status: :precondition_required
              nil
            end
          else
            # Anonymous user must provide prayer_book_code
            unless preferences_param[:prayer_book_code].present?
              render json: {
                success: false,
                error: {
                  code: "PRAYER_BOOK_REQUIRED",
                  message: "O parâmetro preferences[prayer_book_code] é obrigatório"
                }
              }, status: :bad_request
              return
            end

            # Validate prayer_book_code exists
            unless PrayerBook.exists?(code: preferences_param[:prayer_book_code])
              render json: {
                success: false,
                error: {
                  code: "INVALID_PRAYER_BOOK",
                  message: "Prayer Book '#{preferences_param[:prayer_book_code]}' não encontrado"
                }
              }, status: :bad_request
              return
            end

            # Validate bible_version if provided
            if preferences_param[:bible_version].present?
              unless BibleVersion.active.exists?(code: preferences_param[:bible_version])
                render json: {
                  success: false,
                  error: {
                    code: "INVALID_BIBLE_VERSION",
                    message: "Versão da Bíblia '#{preferences_param[:bible_version]}' não encontrada"
                  }
                }, status: :bad_request
                nil
              end
            end
          end
        end

        def build_resolved_preferences
          if current_user
            build_authenticated_preferences
          else
            build_anonymous_preferences
          end
        end

        def build_authenticated_preferences
          onboarding = current_user.user_onboarding

          # Start with onboarding preferences (with defaults applied)
          base = onboarding.preferences_with_defaults.symbolize_keys

          # Add core fields from onboarding relations
          base[:prayer_book_code] = onboarding.prayer_book.code
          base[:bible_version] = onboarding.bible_version.code
          base[:mode] = onboarding.mode

          base
        end

        def build_anonymous_preferences
          prayer_book_code = preferences_param[:prayer_book_code]
          prayer_book = PrayerBook.find_by_code!(prayer_book_code)

          # Start with prayer book default options
          defaults = prayer_book_defaults(prayer_book)

          # Merge with provided preferences (preferences param takes precedence)
          defaults.merge(preferences_param.to_h.symbolize_keys)
        end

        def prayer_book_defaults(prayer_book)
          {
            prayer_book_code: prayer_book.code,
            bible_version: "nvi",
            language: "pt-BR",
            reading_type: prayer_book.lectionary_features["default_reading_type"] || "semicontinuous",
            lords_prayer_version: prayer_book.daily_office_features["available_lords_prayer"]&.first || "traditional",
            confession_type: prayer_book.daily_office_features["available_confession_types"]&.first || "long",
            creed_type: "apostles"
          }
        end

        # Parse preferences from params (supports both JSON string and nested params)
        def preferences_param
          @preferences_param ||= parse_preferences_param
        end

        def parse_preferences_param
          if params[:preferences].is_a?(String)
            # JSON string: ?preferences={"prayer_book_code":"loc_2015"}
            begin
              JSON.parse(params[:preferences]).with_indifferent_access
            rescue JSON::ParserError
              {}
            end
          elsif params[:preferences].is_a?(ActionController::Parameters) || params[:preferences].is_a?(Hash)
            # Nested params: ?preferences[prayer_book_code]=loc_2015
            params[:preferences].to_unsafe_h.with_indifferent_access
          else
            {}
          end
        end
      end
    end
  end
end
