# frozen_string_literal: true

module Api
  module V1
    class CompletionsController < ApplicationController
      include Authenticatable

      before_action :authenticate_user!

      # POST /api/v1/completions
      # Marks an office as completed for the current user
      def create
        completion = current_user.complete_office!(
          completion_params[:office_type],
          date: completion_params[:date],
          duration_seconds: completion_params[:duration_seconds]
        )

        render json: {
          message: "Office completed successfully",
          completion: completion.as_json(only: %i[id date_reference office_type duration_seconds created_at]),
          current_streak: current_user.current_streak,
          longest_streak: current_user.longest_streak
        }, status: :created
      rescue ActiveRecord::RecordInvalid => e
        render json: { error: e.message }, status: :unprocessable_entity
      end

      # GET /api/v1/completions/:year/:month/:day/:office_type
      # Shows if an office was completed
      def show
        date = parse_date
        office_type = parse_office_type

        completion = current_user.completions.find_by!(
          date_reference: date,
          office_type: office_type
        )

        render json: {
          message: "Office completed",
          completion: completion.as_json(only: %i[id created_at])
        }, status: :ok
      rescue ActiveRecord::RecordNotFound => e
        render json: {}, status: :not_found
      end

      # DELETE /api/v1/completions/:id
      # Removes a completion (in case of mistake)
      def destroy
        completion = current_user.completions.find(params[:id])
        completion.destroy!

        # Recalcula streak após remover completion
        current_user.update_streak!

        render json: {
          message: "Completion removed successfully",
          current_streak: current_user.current_streak,
          longest_streak: current_user.longest_streak
        }
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Completion not found" }, status: :not_found
      end

      private

      def completion_params
        params.permit(:office_type, :date, :duration_seconds)
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

      def parse_office_type
        office_type = params[:office_type].to_s
        valid_types = %w[morning midday evening compline]

        unless valid_types.include?(office_type)
          raise ArgumentError, "Invalid office type. Must be one of: #{valid_types.join(', ')}"
        end

        office_type
      end
    end
  end
end
