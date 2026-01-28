# frozen_string_literal: true

module Api
  module V1
    # API Controller for managing prayer intentions
    # Provides CRUD operations plus AI enrichment and prayer tracking
    class PrayerIntentionsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_prayer_intention, only: [:show, :update, :destroy, :enrich, :mark_answered, :record_prayer, :archive]
      before_action :authorize_prayer_intention!, only: [:show, :update, :destroy, :enrich, :mark_answered, :archive]
      
      # GET /api/v1/prayer_intentions
      # List user's prayer intentions with filtering and pagination
      def index
        intentions = current_user.prayer_intentions
        
        # Apply filters
        intentions = apply_filters(intentions)
        
        # Pagination
        page = params[:page]&.to_i || 1
        per_page = [params[:per_page]&.to_i || 20, 100].min
        
        paginated_intentions = intentions.page(page).per(per_page)
        
        render json: {
          prayer_intentions: paginated_intentions.map(&:as_json_api),
          meta: pagination_meta(paginated_intentions)
        }, status: :ok
      end
      
      # GET /api/v1/prayer_intentions/:id
      # Show a specific prayer intention
      def show
        render json: {
          prayer_intention: @prayer_intention.as_json_api
        }, status: :ok
      end
      
      # POST /api/v1/prayer_intentions
      # Create a new prayer intention
      def create
        intention = current_user.prayer_intentions.build(prayer_intention_params)
        
        if intention.save
          # Optionally trigger async enrichment
          if params[:auto_enrich] == true || params[:auto_enrich] == 'true'
            EnrichPrayerIntentionJob.perform_later(intention.id)
          end
          
          render json: {
            prayer_intention: intention.as_json_api,
            message: 'Prayer intention created successfully'
          }, status: :created
        else
          render json: {
            errors: intention.errors.full_messages
          }, status: :unprocessable_entity
        end
      end
      
      # PATCH/PUT /api/v1/prayer_intentions/:id
      # Update a prayer intention
      def update
        if @prayer_intention.update(prayer_intention_params)
          render json: {
            prayer_intention: @prayer_intention.as_json_api,
            message: 'Prayer intention updated successfully'
          }, status: :ok
        else
          render json: {
            errors: @prayer_intention.errors.full_messages
          }, status: :unprocessable_entity
        end
      end
      
      # DELETE /api/v1/prayer_intentions/:id
      # Delete a prayer intention
      def destroy
        @prayer_intention.destroy
        
        render json: {
          message: 'Prayer intention deleted successfully'
        }, status: :ok
      end
      
      # POST /api/v1/prayer_intentions/:id/enrich
      # Trigger AI enrichment for a prayer intention
      def enrich
        if @prayer_intention.ai_enriched? && !params[:force]
          return render json: {
            message: 'Prayer intention already enriched. Use force=true to re-enrich.',
            prayer_intention: @prayer_intention.as_json_api
          }, status: :ok
        end
        
        # Queue enrichment job
        EnrichPrayerIntentionJob.perform_later(@prayer_intention.id)
        
        render json: {
          message: 'AI enrichment started. This may take a few moments.',
          prayer_intention: @prayer_intention.as_json_api
        }, status: :accepted
      end
      
      # POST /api/v1/prayer_intentions/:id/mark_answered
      # Mark a prayer intention as answered
      def mark_answered
        answer_notes = params[:answer_notes]
        
        @prayer_intention.mark_as_answered!(notes: answer_notes)
        
        render json: {
          prayer_intention: @prayer_intention.reload.as_json_api,
          message: 'Prayer marked as answered'
        }, status: :ok
      rescue StandardError => e
        render json: {
          error: e.message
        }, status: :unprocessable_entity
      end
      
      # POST /api/v1/prayer_intentions/:id/record_prayer
      # Record that someone prayed for this intention
      def record_prayer
        # Anyone who can view the intention can pray for it
        unless @prayer_intention.prayable_by?(current_user)
          return render json: {
            error: 'You do not have permission to pray for this intention'
          }, status: :forbidden
        end
        
        @prayer_intention.record_prayer!
        
        render json: {
          prayer_intention: @prayer_intention.reload.as_json_api,
          message: 'Prayer recorded'
        }, status: :ok
      end
      
      # POST /api/v1/prayer_intentions/:id/archive
      # Archive a prayer intention
      def archive
        @prayer_intention.archive!
        
        render json: {
          prayer_intention: @prayer_intention.reload.as_json_api,
          message: 'Prayer intention archived'
        }, status: :ok
      end
      
      # GET /api/v1/prayer_intentions/categories
      # List available prayer categories
      def categories
        render json: {
          categories: PrayerIntention.categories.map { |cat|
            {
              value: cat,
              label: cat.titleize
            }
          }
        }, status: :ok
      end
      
      # GET /api/v1/prayer_intentions/stats
      # Get user's prayer intention statistics
      def stats
        intentions = current_user.prayer_intentions
        
        stats = {
          total: intentions.count,
          active: intentions.active.count,
          answered: intentions.answered.count,
          archived: intentions.archived.count,
          ai_enriched: intentions.ai_enriched.count,
          by_category: {},
          total_prayers: intentions.sum(:prayer_count),
          current_streak: calculate_current_streak(intentions)
        }
        
        # Count by category
        PrayerIntention.categories.each do |category|
          stats[:by_category][category] = intentions.by_category(category).count
        end
        
        render json: { stats: stats }, status: :ok
      end
      
      # GET /api/v1/prayer_intentions/community
      # Get public prayer intentions from the community
      def community
        intentions = PrayerIntention.public_intentions.community_prayer_enabled
        
        # Apply filters
        intentions = intentions.by_category(params[:category]) if params[:category].present?
        intentions = intentions.where(status: params[:status]) if params[:status].present?
        
        # Pagination
        page = params[:page]&.to_i || 1
        per_page = [params[:per_page]&.to_i || 20, 100].min
        
        paginated_intentions = intentions.recently_created.page(page).per(per_page)
        
        render json: {
          prayer_intentions: paginated_intentions.map(&:as_json_api),
          meta: pagination_meta(paginated_intentions)
        }, status: :ok
      end
      
      private
      
      def set_prayer_intention
        @prayer_intention = PrayerIntention.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: {
          error: 'Prayer intention not found'
        }, status: :not_found
      end
      
      def authorize_prayer_intention!
        unless @prayer_intention.viewable_by?(current_user)
          render json: {
            error: 'You do not have permission to access this prayer intention'
          }, status: :forbidden
        end
      end
      
      def prayer_intention_params
        params.require(:prayer_intention).permit(
          :title,
          :description,
          :category,
          :status,
          :is_private,
          :allow_community_prayer,
          :answer_notes
        )
      end
      
      def apply_filters(intentions)
        # Filter by status
        if params[:status].present?
          intentions = case params[:status]
          when 'active'
            intentions.active
          when 'answered'
            intentions.answered
          when 'archived'
            intentions.archived
          else
            intentions.where(status: params[:status])
          end
        end
        
        # Filter by category
        intentions = intentions.by_category(params[:category]) if params[:category].present?
        
        # Filter by AI enrichment
        if params[:enriched] == 'true' || params[:enriched] == true
          intentions = intentions.ai_enriched
        elsif params[:enriched] == 'false' || params[:enriched] == false
          intentions = intentions.needs_enrichment
        end
        
        # Search by title/description
        if params[:search].present?
          search_term = "%#{params[:search]}%"
          intentions = intentions.where(
            'title ILIKE ? OR description ILIKE ?',
            search_term,
            search_term
          )
        end
        
        # Ordering
        intentions = case params[:order_by]
        when 'recently_prayed'
          intentions.recently_prayed
        when 'created_at'
          intentions.order(created_at: params[:direction] == 'asc' ? :asc : :desc)
        when 'prayer_count'
          intentions.order(prayer_count: params[:direction] == 'asc' ? :asc : :desc)
        else
          intentions.recently_created
        end
        
        intentions
      end
      
      def pagination_meta(collection)
        {
          current_page: collection.current_page,
          total_pages: collection.total_pages,
          total_count: collection.total_count,
          per_page: collection.limit_value
        }
      end
      
      def calculate_current_streak(intentions)
        # Simple streak calculation based on consecutive days with prayers
        # This is a placeholder - implement more sophisticated logic as needed
        recent_prayers = intentions.where.not(last_prayed_at: nil)
                                  .order(last_prayed_at: :desc)
                                  .limit(30)
        
        return 0 if recent_prayers.empty?
        
        streak = 0
        current_date = Date.current
        
        recent_prayers.each do |intention|
          prayer_date = intention.last_prayed_at.to_date
          break if prayer_date < current_date - streak.days
          
          if prayer_date == current_date - streak.days
            streak += 1
          end
        end
        
        streak
      end
    end
  end
end
