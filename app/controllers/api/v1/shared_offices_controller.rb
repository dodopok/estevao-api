# frozen_string_literal: true

module Api
  module V1
    class SharedOfficesController < ApplicationController
      include Authenticatable

      before_action :authenticate_user_optional
      before_action :set_shared_office, only: [ :show ]

      # POST /api/v1/shared_offices
      # Creates a new shared office link
      def create
        validate_create_params!

        service = SharedOfficeService.new(
          date: params[:date],
          office_type: params[:office_type],
          prayer_book_code: params[:prayer_book_code],
          seed: params[:seed],
          preferences: params[:preferences]&.to_unsafe_h || {},
          user: current_user
        )

        shared_office = service.create

        render json: {
          short_code: shared_office.short_code,
          share_path: shared_office.share_path,
          expires_at: shared_office.expires_at.iso8601,
          date: shared_office.date.to_s,
          office_type: shared_office.office_type,
          prayer_book_code: shared_office.prayer_book_code
        }, status: :created
      rescue ActiveRecord::RecordInvalid => e
        render json: { error: e.message }, status: :unprocessable_entity
      rescue ArgumentError => e
        render json: { error: e.message }, status: :bad_request
      end

      # GET /api/v1/shared_offices/:code
      # Returns the shared office data for a given short code
      def show
        render json: {
          short_code: @shared_office.short_code,
          date: @shared_office.date.to_s,
          office_type: @shared_office.office_type,
          prayer_book_code: @shared_office.prayer_book_code,
          seed: @shared_office.seed,
          preferences: @shared_office.preferences,
          expires_at: @shared_office.expires_at.iso8601,
          created_by: @shared_office.user&.name
        }
      end

      private

      def set_shared_office
        @shared_office = SharedOffice.find_active(params[:code])

        return if @shared_office

        # Check if it exists but is expired
        expired = SharedOffice.expired.find_by(short_code: params[:code])

        if expired
          render json: { error: "Este link expirou" }, status: :gone
        else
          render json: { error: "Link não encontrado" }, status: :not_found
        end
      end

      def validate_create_params!
        required = [ :date, :office_type, :prayer_book_code, :seed ]
        missing = required.select { |key| params[key].blank? }

        if missing.any?
          raise ArgumentError, "Parâmetros obrigatórios faltando: #{missing.join(', ')}"
        end

        # Validate office type
        unless SharedOffice::VALID_OFFICE_TYPES.include?(params[:office_type])
          raise ArgumentError, "Tipo de ofício inválido. Use: #{SharedOffice::VALID_OFFICE_TYPES.join(', ')}"
        end

        # Validate date format
        begin
          Date.parse(params[:date])
        rescue ArgumentError
          raise ArgumentError, "Formato de data inválido. Use: YYYY-MM-DD"
        end
      end
    end
  end
end
