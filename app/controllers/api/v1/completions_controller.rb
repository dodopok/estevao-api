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
    end
  end
end
