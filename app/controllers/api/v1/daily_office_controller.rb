module Api
  module V1
    class DailyOfficeController < ApplicationController
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
        {
          version: params[:version] || "loc_2015",
          language: params[:language] || "pt-BR",
          bible_version: params[:bible_version] || "nvi",
          lords_prayer_version: params[:lords_prayer_version] || "traditional",
          creed_type: (params[:creed_type]&.to_sym || :apostles),
          confession_type: params[:confession_type] || "long"
        }
      end

      # Create a hash of preferences for cache key
      def preferences_hash
        Digest::MD5.hexdigest(user_preferences.to_json)
      end
    end
  end
end
