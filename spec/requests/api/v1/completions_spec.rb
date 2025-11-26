# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/completions', type: :request do
  def self.api_tags
    'Completions'
  end

  def self.content_type
    'application/json'
  end

  path '/api/v1/completions' do
    post('Mark office as completed') do
      tags api_tags
      produces content_type
      consumes content_type
      description 'Marks a Daily Office as completed for the authenticated user and updates streak'
      security [ { bearer_auth: [] } ]

      parameter name: 'Authorization',
                in: :header,
                type: :string,
                description: 'Firebase ID Token (format: Bearer <token>)',
                required: true

      parameter name: :completion, in: :body, schema: {
        type: :object,
        properties: {
          completion: {
            type: :object,
            properties: {
              office_type: {
                type: :string,
                enum: %w[morning midday evening compline],
                example: 'morning'
              },
              duration_seconds: {
                type: :integer,
                example: 600,
                description: 'Optional: duration in seconds spent on the office'
              }
            },
            required: [ 'office_type' ]
          }
        },
        required: [ 'completion' ]
      }

      response(201, 'created') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:completion) { { completion: { office_type: 'morning', duration_seconds: 600 } } }

        before do
          user = create(:user)
          allow_any_instance_of(Api::V1::CompletionsController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::CompletionsController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 message: { type: :string, example: 'Office completed successfully' },
                 completion: {
                   type: :object,
                   properties: {
                     id: { type: :integer, example: 1 },
                     date_reference: { type: :string, format: :date, example: '2025-11-22' },
                     office_type: { type: :string, example: 'morning' },
                     duration_seconds: { type: :integer, example: 600, nullable: true },
                     created_at: { type: :string, format: 'date-time', example: '2025-11-22T08:30:00Z' }
                   }
                 },
                 current_streak: { type: :integer, example: 8 },
                 longest_streak: { type: :integer, example: 15 }
               }

        run_test!
      end

      response(401, 'unauthorized') do
        let(:Authorization) { '' }
        let(:completion) { { completion: { office_type: 'morning' } } }

        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Unauthorized' }
               }

        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:completion) { { completion: { office_type: '' } } }

        before do
          user = create(:user)
          allow_any_instance_of(Api::V1::CompletionsController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::CompletionsController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Validation failed: User already completed this office today' }
               }

        run_test!
      end
    end
  end

  path '/api/v1/completions/{id}' do
    parameter name: 'id', in: :path, type: :integer, description: 'Completion ID', required: true

    delete('Remove completion') do
      tags api_tags
      produces content_type
      description 'Removes a completion (in case of mistake) and recalculates streak'
      security [ { bearer_auth: [] } ]

      parameter name: 'Authorization',
                in: :header,
                type: :string,
                description: 'Firebase ID Token (format: Bearer <token>)',
                required: true

      response(200, 'successful') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:id) do
          user = create(:user)
          completion = create(:completion, user: user)
          allow_any_instance_of(Api::V1::CompletionsController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::CompletionsController).to receive(:current_user).and_return(user)
          completion.id
        end

        schema type: :object,
               properties: {
                 message: { type: :string, example: 'Completion removed successfully' },
                 current_streak: { type: :integer, example: 7 },
                 longest_streak: { type: :integer, example: 15 }
               }

        run_test!
      end

      response(401, 'unauthorized') do
        let(:Authorization) { '' }
        let(:id) { 1 }

        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Unauthorized' }
               }

        run_test!
      end

      response(404, 'not found') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:id) { 99999 }

        before do
          user = create(:user)
          allow_any_instance_of(Api::V1::CompletionsController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::CompletionsController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Completion not found' }
               }

        run_test!
      end
    end
  end
end
