# frozen_string_literal: true

module Api
  module V1
    class LifeRulesController < ApplicationController
      include Authenticatable

      before_action :authenticate_user!, except: %i[index show]
      before_action :authenticate_user_optional, only: %i[index show]

      before_action :set_life_rule, only: %i[show]
      before_action :set_life_rule_for_owner_action, only: %i[update destroy]
      before_action :set_life_rule_for_admin_action, only: %i[approve]
      before_action :authorize_owner!, only: %i[update destroy]
      before_action :authorize_admin!, only: %i[approve]

      # GET /api/v1/life_rules
      # Returns public approved rules + user's own rules
      def index
        # Build base query
        life_rules = LifeRule.where(user: current_user)
                             .or(LifeRule.public_rules)
                             .includes(:life_rule_steps)
                             .distinct

        # Apply filters
        life_rules = life_rules.search_by_title(params[:search]) if params[:search].present?
        life_rules = life_rules.by_popularity if params[:sort] == "popular"

        # Get total count before pagination
        total_count = life_rules.count(:id)

        # Parse and validate pagination parameters
        limit = parse_limit(params[:limit])
        offset = parse_offset(params[:offset])

        # Apply pagination
        paginated_rules = life_rules.limit(limit).offset(offset)

        # Render with pagination metadata
        render json: {
          life_rules: paginated_rules.map { |rule| serialize_life_rule(rule) },
          pagination: {
            total: total_count,
            limit: limit,
            offset: offset,
            count: paginated_rules.size
          }
        }
      end

      # GET /api/v1/life_rules/:my
      # Shows the user specific life rule
      def my
        life_rule = LifeRule.where(user: current_user).first!

        render json: {
          life_rule: serialize_life_rule(life_rule, include_steps: true)
        }
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Life rule not found" }, status: :not_found
      end

      # GET /api/v1/life_rules/:id
      # Shows a specific life rule (must be public approved or owned by user)
      def show
        render json: {
          life_rule: serialize_life_rule(@life_rule, include_steps: true)
        }
      end

      # POST /api/v1/life_rules
      # Creates a new life rule (replaces existing one if any)
      def create
        # Remove a regra anterior do usuário, se existir
        current_user.life_rule&.destroy

        life_rule = current_user.build_life_rule(life_rule_params)

        if life_rule.save
          render json: {
            message: "Life rule created successfully",
            life_rule: serialize_life_rule(life_rule, include_steps: true)
          }, status: :created
        else
          render json: { error: life_rule.errors.full_messages }, status: :unprocessable_content
        end
      end

      # PATCH /api/v1/life_rules/:id
      # Updates a life rule (only if owned by user)
      def update
        if @life_rule.update(life_rule_params)
          render json: {
            message: "Life rule updated successfully",
            life_rule: serialize_life_rule(@life_rule, include_steps: true)
          }
        else
          render json: { error: @life_rule.errors.full_messages }, status: :unprocessable_content
        end
      end

      # DELETE /api/v1/life_rules/:id
      # Deletes a life rule (only if owned by user)
      def destroy
        @life_rule.destroy!

        render json: {
          message: "Life rule deleted successfully"
        }
      end

      # POST /api/v1/life_rules/:id/adopt
      # Adopts a life rule (creates a copy for current user)
      def adopt
        original_rule = LifeRule.public_rules.find(params[:id])
        adopted_rule = original_rule.adopt_by(current_user)

        if adopted_rule.persisted?
          render json: {
            message: "Life rule adopted successfully",
            life_rule: serialize_life_rule(adopted_rule, include_steps: true)
          }, status: :created
        else
          render json: { error: adopted_rule.errors.full_messages }, status: :unprocessable_content
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Life rule not found or not public" }, status: :not_found
      end

      # POST /api/v1/life_rules/:id/approve
      # Approves a life rule (admin only)
      def approve
        @life_rule.update!(approved: true)

        render json: {
          message: "Life rule approved successfully",
          life_rule: serialize_life_rule(@life_rule, include_steps: true)
        }
      end

      private

      def set_life_rule
        @life_rule = LifeRule.where(user: current_user)
                             .or(LifeRule.public_rules)
                             .find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Life rule not found" }, status: :not_found
      end

      # Para update/destroy: busca qualquer regra para verificar ownership e retornar 403 se não for dono
      def set_life_rule_for_owner_action
        @life_rule = LifeRule.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Life rule not found" }, status: :not_found
      end

      # Para approve: admin pode aprovar qualquer regra pública (mesmo não aprovada)
      def set_life_rule_for_admin_action
        @life_rule = LifeRule.where(is_public: true).find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Life rule not found" }, status: :not_found
      end

      def authorize_owner!
        return if @life_rule.user_id == current_user.id

        render json: { error: "Unauthorized" }, status: :forbidden
      end

      def authorize_admin!
        return if current_user.admin?

        render json: { error: "Unauthorized - Admin only" }, status: :forbidden
      end

      def life_rule_params
        params.require(:life_rule).permit(
          :icon,
          :title,
          :description,
          :is_public,
          life_rule_steps_attributes: %i[id order title description _destroy]
        )
      end

      def serialize_life_rule(life_rule, include_steps: false)
        result = {
          id: life_rule.id,
          icon: life_rule.icon,
          title: life_rule.title,
          description: life_rule.description,
          is_public: life_rule.is_public,
          approved: life_rule.approved,
          adoption_count: life_rule.adoption_count,
          is_owner: life_rule.user_id == current_user&.id,
          created_at: life_rule.created_at
        }

        if include_steps
          result[:steps] = life_rule.life_rule_steps.map do |step|
            {
              id: step.id,
              order: step.order,
              title: step.title,
              description: step.description
            }
          end
        end

        result
      end

      def parse_limit(param)
        limit = (param || 20).to_i
        # Ensure limit is between 1 and 100
        [ [ limit, 1 ].max, 100 ].min
      end

      def parse_offset(param)
        offset = (param || 0).to_i
        # Ensure offset is non-negative
        [ offset, 0 ].max
      end
    end
  end
end
