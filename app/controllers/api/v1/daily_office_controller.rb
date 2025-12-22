module Api
  module V1
    class DailyOfficeController < ApplicationController
      include Authenticatable
      include Concerns::PreferencesResolver
      include DateValidations

      before_action :authenticate_user_optional
      before_action :validate_preferences!, except: [ :preferences ]
      before_action :authorize_prayer_book_access!, except: [ :preferences ]

      # GET /api/v1/daily_office/today/:office_type
      # Returns today's office
      def today
        date = Date.today
        office_type = parse_office_type
        cache_key = build_office_cache_key(date, office_type)

        response = Rails.cache.fetch(cache_key, expires_in: 1.day) do
          service = DailyOfficeService.new(
            date: date,
            office_type: office_type,
            preferences: resolved_preferences,
            current_user: current_user
          )
          service.call
        end

        # Adiciona dados do usuário se autenticado
        response = add_user_data(response, date, office_type) if current_user

        render json: response
      rescue ArgumentError => e
        render json: { error: "Erro ao buscar ofício: #{e.message}" }, status: :bad_request
      end

      # GET /api/v1/daily_office/:year/:month/:day/:office_type
      # Returns office for a specific date
      def show
        date = parse_date
        office_type = parse_office_type
        cache_key = build_office_cache_key(date, office_type)

        response = Rails.cache.fetch(cache_key, expires_in: 1.day) do
          service = DailyOfficeService.new(
            date: date,
            office_type: office_type,
            preferences: resolved_preferences,
            current_user: current_user
          )
          service.call
        end

        # Adiciona dados do usuário se autenticado
        response = add_user_data(response, date, office_type) if current_user

        render json: response
      rescue ArgumentError => e
        render json: { error: "Erro ao buscar ofício: #{e.message}" }, status: :bad_request
      end

      # GET /api/v1/daily_office/:year/:month/:day/:office_type/family
      # Returns family rite version of the office
      def family_rite
        date = parse_date
        office_type = parse_office_type
        prayer_book = resolved_prayer_book

        # Verifica se o Prayer Book suporta rito familiar
        unless prayer_book.supports_family_rite?
          return render json: {
            error: "O Prayer Book '#{resolved_prayer_book_code}' não suporta rito familiar"
          }, status: :unprocessable_content
        end

        # Gera o ofício com flag de rito familiar
        family_prefs = resolved_preferences.merge(family_rite: true)
        cache_key = build_office_cache_key(date, office_type, family: true)

        response = Rails.cache.fetch(cache_key, expires_in: 1.day) do
          service = DailyOfficeService.new(
            date: date,
            office_type: office_type,
            preferences: family_prefs,
            current_user: current_user
          )
          service.call
        end

        # Adiciona dados do usuário se autenticado
        response = add_user_data(response, date, office_type) if current_user

        render json: response
      rescue ArgumentError => e
        render json: { error: "Erro ao buscar ofício: #{e.message}" }, status: :bad_request
      end

      # GET /api/v1/daily_office/preferences
      # Returns available preferences options
      def preferences
        render json: {
          versions: PrayerBook.active.pluck(:code),
          languages: [ "pt-BR", "en" ],
          bible_versions: BibleVersion.active.pluck(:code),
          lords_prayer_versions: [ "traditional", "contemporary" ],
          creed_types: [ "apostles", "nicene" ],
          confession_types: [ "long", "short" ],
          office_types: [ "morning", "midday", "evening", "compline" ]
        }
      end

      private

      def parse_office_type
        office_type = params[:office_type]&.to_sym || :morning
        valid_types = [ :morning, :midday, :evening, :compline ]

        unless valid_types.include?(office_type)
          raise ArgumentError, "Invalid office type. Must be one of: #{valid_types.join(', ')}"
        end

        office_type
      end

      # Authorize user access to the requested prayer book
      def authorize_prayer_book_access!
        prayer_book = resolved_prayer_book

        return if prayer_book.accessible_by?(current_user)

        render json: {
          success: false,
          error: {
            code: "PREMIUM_REQUIRED",
            message: "O Prayer Book '#{prayer_book.name}' requer assinatura premium",
            prayer_book_code: prayer_book.code,
            premium_required: true
          }
        }, status: :forbidden
      end

      # Build cache key with relevant preferences for Daily Office
      # Includes user_id and audio preferences for premium users
      # Version v2 to invalidate old cache after adding premium/language fields
      # Strategy: Hash only preferences that affect the office content, not presentation
      # This maximizes cache hit rate while keeping personalization
      def build_office_cache_key(date, office_type, family: false)
        relevant_prefs = resolved_preferences.slice(
          :prayer_book_code,
          :bible_version,
          :lords_prayer_version,
          :confession_type,
          :creed_type
        ).sort.to_h

        # Add audio voice preference for premium users (affects audio URLs)
        if current_user&.premium?
          relevant_prefs[:preferred_audio_voice] = current_user.preferred_audio_voice
          user_suffix = "/user_#{current_user.id}"
        else
          user_suffix = ""
        end

        prefs_hash = Digest::MD5.hexdigest(relevant_prefs.to_json)[0..7]
        family_suffix = family ? "/family" : ""

        "daily_office/v2/#{date}/#{office_type}/#{prefs_hash}#{user_suffix}#{family_suffix}"
      end

      # Adiciona dados do usuário autenticado na resposta
      def add_user_data(response, date, office_type)
        completion = current_user.completions.find_by(
          date_reference: date,
          office_type: office_type.to_s
        )

        response.merge(
          user: {
            current_streak: current_user.current_streak,
            longest_streak: current_user.longest_streak,
            completed: completion.present?,
            completed_at: completion&.created_at
          }
        )
      end
    end
  end
end
