# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do
  def self.api_tags
    'Users'
  end

  def self.content_type
    'application/json'
  end

  path '/api/v1/users/me' do
    get('Get current user profile') do
      tags api_tags
      produces content_type
      description 'Returns the authenticated user profile including preferences and streak information'
      security [ { bearer_auth: [] } ]

      parameter name: 'Authorization',
                in: :header,
                type: :string,
                description: 'Firebase ID Token (format: Bearer <token>)',
                required: true

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 id: { type: :integer, example: 1 },
                 email: { type: :string, example: 'user@example.com' },
                 name: { type: :string, example: 'João Silva' },
                 photo_url: { type: :string, example: 'https://example.com/photo.jpg', nullable: true },
                 preferences: {
                   type: :object,
                   properties: {
                     version: { type: :string, example: 'loc_2015' },
                     language: { type: :string, example: 'pt-BR' },
                     bible_version: { type: :string, example: 'nvi' },
                     lords_prayer_version: { type: :string, example: 'traditional' },
                     creed_type: { type: :string, example: 'apostles' },
                     confession_type: { type: :string, example: 'long' },
                     notifications: { type: :boolean, example: true }
                   }
                 },
                 current_streak: { type: :integer, example: 7 },
                 longest_streak: { type: :integer, example: 15 },
                 last_completed_office_at: { type: :string, format: 'date-time', example: '2025-11-22T08:30:00Z',
                                              nullable: true }
               }

        run_test!
      end

      response(401, 'unauthorized') do
        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Unauthorized' }
               }

        run_test!
      end
    end
  end

  path '/api/v1/users/preferences' do
    patch('Update user preferences') do
      tags api_tags
      produces content_type
      consumes content_type
      description 'Updates user preferences for customizing the Daily Office experience'
      security [ { bearer_auth: [] } ]

      parameter name: 'Authorization',
                in: :header,
                type: :string,
                description: 'Firebase ID Token (format: Bearer <token>)',
                required: true

      parameter name: :preferences, in: :body, schema: {
        type: :object,
        properties: {
          preferences: {
            type: :object,
            properties: {
              version: { type: :string, example: 'loc_2015' },
              language: { type: :string, example: 'pt-BR' },
              bible_version: { type: :string, example: 'nvi' },
              lords_prayer_version: { type: :string, example: 'traditional' },
              creed_type: { type: :string, example: 'apostles' },
              confession_type: { type: :string, example: 'long' },
              notifications: { type: :boolean, example: true }
            }
          }
        },
        required: [ 'preferences' ]
      }

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 message: { type: :string, example: 'Preferences updated successfully' },
                 preferences: {
                   type: :object,
                   properties: {
                     version: { type: :string },
                     language: { type: :string },
                     bible_version: { type: :string },
                     lords_prayer_version: { type: :string },
                     creed_type: { type: :string },
                     confession_type: { type: :string },
                     notifications: { type: :boolean }
                   }
                 }
               }

        run_test!
      end

      response(401, 'unauthorized') do
        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Unauthorized' }
               }

        run_test!
      end
    end
  end

  path '/api/v1/users/completions' do
    get('Get user completion history') do
      tags api_tags
      produces content_type
      description 'Returns the authenticated user completion history with streak information'
      security [ { bearer_auth: [] } ]

      parameter name: 'Authorization',
                in: :header,
                type: :string,
                description: 'Firebase ID Token (format: Bearer <token>)',
                required: true

      parameter name: :limit, in: :query, type: :integer, description: 'Limit number of results (default: 30)',
                required: false

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 completions: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer, example: 1 },
                       date_reference: { type: :string, format: :date, example: '2025-11-22' },
                       office_type: { type: :string, example: 'morning' },
                       duration_seconds: { type: :integer, example: 600, nullable: true },
                       created_at: { type: :string, format: 'date-time', example: '2025-11-22T08:30:00Z' }
                     }
                   }
                 },
                 total_completions: { type: :integer, example: 42 },
                 current_streak: { type: :integer, example: 7 },
                 longest_streak: { type: :integer, example: 15 }
               }

        run_test!
      end

      response(401, 'unauthorized') do
        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Unauthorized' }
               }

        run_test!
      end
    end
  end
end
