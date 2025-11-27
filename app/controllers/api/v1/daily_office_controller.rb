module Api
  module V1
    class DailyOfficeController < ApplicationController
      include Authenticatable

      before_action :authenticate_user_optional

      # GET /api/v1/daily_office/today/:office_type
      # Returns today's office
      def today
        date = Date.today
        office_type = parse_office_type

        response = Rails.cache.fetch("daily_office_#{date}_#{office_type}_#{preferences_hash}", expires_in: 1.day) do
          service = DailyOfficeService.new(
            date: date,
            office_type: office_type,
            preferences: user_preferences
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

        response = Rails.cache.fetch("daily_office_#{date}_#{office_type}_#{preferences_hash}", expires_in: 1.day) do
          service = DailyOfficeService.new(
            date: date,
            office_type: office_type,
            preferences: user_preferences
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
        prayer_book_code = user_preferences[:prayer_book_code]

        # Verifica se o Prayer Book suporta rito familiar
        prayer_book = PrayerBook.find_by(code: prayer_book_code)
        unless prayer_book&.supports_family_rite?
          return render json: {
            error: "O Prayer Book '#{prayer_book_code}' não suporta rito familiar"
          }, status: :unprocessable_entity
        end

        # Gera o ofício com flag de rito familiar
        preferences = user_preferences.merge(family_rite: true)
        response = Rails.cache.fetch("daily_office_family_#{date}_#{office_type}_#{preferences.hash}", expires_in: 1.day) do
          service = DailyOfficeService.new(
            date: date,
            office_type: office_type,
            preferences: preferences
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
          versions: [ "loc_2015" ],
          languages: [ "pt-BR", "en" ],
          bible_versions: [ "nvi", "ntlh", "arc" ],
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

      def parse_date
        year = params[:year].to_i
        month = params[:month].to_i
        day = params[:day].to_i

        validate_year_month_day(year, month, day)

        Date.new(year, month, day)
      end

      def validate_year(year)
        raise ArgumentError, "Year must be between 1900 and 2200" unless year.between?(1900, 2200)
      end

      def validate_year_month(year, month)
        validate_year(year)
        raise ArgumentError, "Month must be between 1 and 12" unless month.between?(1, 12)
      end

      def validate_year_month_day(year, month, day)
        validate_year_month(year, month)
        raise ArgumentError, "Invalid day for the specified month" unless day.between?(1, 31)
      end

      def user_preferences
        # Se usuário autenticado, usa preferências dele (params sobrescrevem)
        if current_user
          prefs = current_user.preferences.symbolize_keys
          prayer_book_code = params[:prayer_book_code] || prefs[:prayer_book_code] || "loc_2015"

          # Busca as preferências específicas do Prayer Book do usuário
          pb_prefs = current_user.prayer_book_preferences_for(prayer_book_code)

          # Merge de preferências: globais < específicas do PB < params
          base_prefs = {
            prayer_book_code: prayer_book_code,
            language: params[:language] || prefs[:language] || "pt-BR",
            bible_version: params[:bible_version] || prefs[:bible_version] || "nvi",
            lords_prayer_version: params[:lords_prayer_version] || prefs[:lords_prayer_version] || "traditional",
            creed_type: (params[:creed_type]&.to_sym || prefs[:creed_type]&.to_sym || :apostles),
            confession_type: params[:confession_type] || prefs[:confession_type] || "long"
          }

          # Adiciona seed se fornecido via params (para compartilhamento via QR code/link)
          base_prefs[:seed] = params[:seed].to_i if params[:seed].present?

          # Adiciona as opções específicas do Prayer Book
          base_prefs.merge(pb_prefs.symbolize_keys)
        else
          # Usuário não autenticado - usa defaults ou params
          prayer_book_code = params[:prayer_book_code] || "loc_2015"
          prayer_book = PrayerBook.find_by(code: prayer_book_code)

          base_prefs = {
            prayer_book_code: prayer_book_code,
            language: params[:language] || "pt-BR",
            bible_version: params[:bible_version] || "nvi",
            lords_prayer_version: params[:lords_prayer_version] || "traditional",
            creed_type: (params[:creed_type]&.to_sym || :apostles),
            confession_type: params[:confession_type] || "long"
          }.merge(prayer_book&.default_options&.symbolize_keys || {})

          # Adiciona seed se fornecido via params (para compartilhamento via QR code/link)
          base_prefs[:seed] = params[:seed].to_i if params[:seed].present?

          base_prefs
        end
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

      # Create a hash of preferences for cache key
      def preferences_hash
        Digest::MD5.hexdigest(user_preferences.to_json)
      end
    end
  end
end
