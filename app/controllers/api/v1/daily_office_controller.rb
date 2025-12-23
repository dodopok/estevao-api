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
      #
      # CACHING: Uses two-layer cache strategy
      # - Layer 1: DailyOfficeService caches base office (shared between users)
      # - Layer 2: Controller adds user-specific data (completions, streaks)
      def today
        date = Date.today
        office_type = parse_office_type

        response = fetch_office(date, office_type)

        # Add user-specific data (not cached)
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

        response = fetch_office(date, office_type)

        # Add user-specific data (not cached)
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

        # Generate office with family_rite flag
        family_prefs = resolved_preferences.merge(family_rite: true)
        response = fetch_office(date, office_type, preferences: family_prefs)

        # Add user-specific data (not cached)
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

      # Fetch office using DailyOfficeService (which handles caching internally)
      def fetch_office(date, office_type, preferences: nil)
        prefs = preferences || resolved_preferences

        service = DailyOfficeService.new(
          date: date,
          office_type: office_type,
          preferences: prefs,
          current_user: current_user
        )

        service.call
      end

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

      # Adiciona dados do usuário autenticado na resposta
      # This data is NOT cached as it changes frequently
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
