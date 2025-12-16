# frozen_string_literal: true

module Api
  module V1
    class JournalsController < ApplicationController
      include Authenticatable

      before_action :authenticate_user!
      before_action :set_journal, only: %i[update destroy]

      rescue_from ArgumentError, with: :handle_argument_error

      # POST /api/v1/journals
      # Creates a journal entry
      def create
        journal = current_user.journals.build(journal_params)

        if journal.save
          render json: {
            message: "Journal entry created successfully",
            journal: journal_response(journal)
          }, status: :created
        else
          render json: { error: journal.errors.full_messages.join(", ") }, status: :unprocessable_content
        end
      end

      # GET /api/v1/journals/:year/:month/:day
      # Gets all journal entries for a specific day
      def day
        date = parse_date
        journals = current_user.journals.for_date(date).ordered_by_date

        render json: {
          date: date.to_s,
          count: journals.count,
          entries: journals.map { |j| journal_response(j) }
        }
      end

      # GET /api/v1/journals/:year/:month
      # Gets month overview with entry counts
      def month
        year = params[:year].to_i
        month = params[:month].to_i

        validate_year_month(year, month)

        journals = current_user.journals.for_month(year, month)

        # Group by date and count entries
        entries_by_date = journals.group_by(&:date_reference).transform_values do |entries|
          {
            count: entries.count,
            types: entries.group_by(&:entry_type).transform_values(&:count)
          }
        end

        render json: {
          year: year,
          month: month,
          total_entries: journals.count,
          dates_with_entries: entries_by_date.keys.map(&:to_s).sort,
          entries_by_date: entries_by_date.transform_keys(&:to_s)
        }
      end

      # PATCH/PUT /api/v1/journals/:id
      # Updates a journal entry
      def update
        if @journal.update(journal_params)
          render json: {
            message: "Journal entry updated successfully",
            journal: journal_response(@journal)
          }
        else
          render json: { error: @journal.errors.full_messages.join(", ") }, status: :unprocessable_content
        end
      end

      # DELETE /api/v1/journals/:id
      # Deletes a journal entry
      def destroy
        @journal.destroy!
        render json: { message: "Journal entry deleted successfully" }
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Journal entry not found" }, status: :not_found
      end

      private

      def set_journal
        @journal = current_user.journals.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Journal entry not found" }, status: :not_found
      end

      def journal_params
        params.require(:journal).permit(:date_reference, :entry_type, :office_type, :content)
      rescue ActionController::ParameterMissing
        params.permit(:date_reference, :entry_type, :office_type, :content)
      end

      def journal_response(journal)
        {
          id: journal.id,
          date_reference: journal.date_reference,
          entry_type: journal.entry_type,
          office_type: journal.office_type,
          content: journal.content,
          created_at: journal.created_at,
          updated_at: journal.updated_at
        }
      end

      def parse_date
        year = params[:year].to_i
        month = params[:month].to_i
        day = params[:day].to_i

        validate_year_month_day(year, month, day)
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

        # Validate the actual date is valid for the given month/year
        Date.new(year, month, day)
      rescue Date::Error
        raise ArgumentError, "Invalid date: #{year}-#{month}-#{day}"
      end

      def handle_argument_error(exception)
        render json: { error: exception.message }, status: :bad_request
      end
    end
  end
end
