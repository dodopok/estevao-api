# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/notifications', type: :request do
  def self.api_tags
    'Notifications'
  end

  def self.content_type
    'application/json'
  end

  path '/api/v1/notifications/send' do
    post('Send notifications to specific users') do
      tags api_tags
      produces content_type
      consumes content_type
      description 'Sends push notifications to specific users (Admin only)'
      security [ { bearer_auth: [] } ]

      parameter name: 'Authorization',
                in: :header,
                type: :string,
                description: 'Firebase ID Token (format: Bearer <token>) - Must be admin user',
                required: true

      parameter name: :notification, in: :body, schema: {
        type: :object,
        properties: {
          user_ids: {
            type: :array,
            items: { type: :integer },
            example: [ 1, 2, 3 ]
          },
          title: { type: :string, example: 'Título da notificação' },
          body: { type: :string, example: 'Corpo da notificação' },
          data: {
            type: :object,
            properties: {
              type: { type: :string, example: 'new_feature' },
              url: { type: :string, example: '/path/to/feature' }
            }
          }
        },
        required: [ 'user_ids', 'title', 'body' ]
      }

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 message: { type: :string, example: 'Notificações enviadas' },
                 sent_count: { type: :integer, example: 3 },
                 failed_count: { type: :integer, example: 0 }
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

      response(403, 'forbidden') do
        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Unauthorized - Admin access required' }
               }

        run_test!
      end

      response(422, 'unprocessable entity') do
        schema type: :object,
               properties: {
                 error: { type: :string, example: 'user_ids, title, and body are required' }
               }

        run_test!
      end
    end
  end

  path '/api/v1/notifications/broadcast' do
    post('Broadcast notification to all users') do
      tags api_tags
      produces content_type
      consumes content_type
      description 'Sends push notification to all users with active FCM tokens (Admin only)'
      security [ { bearer_auth: [] } ]

      parameter name: 'Authorization',
                in: :header,
                type: :string,
                description: 'Firebase ID Token (format: Bearer <token>) - Must be admin user',
                required: true

      parameter name: :notification, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string, example: 'Novo recurso disponível!' },
          body: { type: :string, example: 'Confira as novas funcionalidades do Ordo' },
          data: {
            type: :object,
            properties: {
              type: { type: :string, example: 'announcement' },
              url: { type: :string, example: '/announcements/123' }
            }
          }
        },
        required: [ 'title', 'body' ]
      }

      response(202, 'accepted - broadcast started in background') do
        schema type: :object,
               properties: {
                 message: { type: :string, example: 'Broadcast iniciado em background' },
                 total_users: { type: :integer, example: 1500 }
               }

        run_test!
      end

      response(200, 'successful - broadcast completed') do
        schema type: :object,
               properties: {
                 message: { type: :string, example: 'Broadcast concluído' },
                 total_users: { type: :integer, example: 1500 },
                 sent_count: { type: :integer, example: 1450 },
                 failed_count: { type: :integer, example: 50 }
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

      response(403, 'forbidden') do
        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Unauthorized - Admin access required' }
               }

        run_test!
      end

      response(422, 'unprocessable entity') do
        schema type: :object,
               properties: {
                 error: { type: :string, example: 'title and body are required' }
               }

        run_test!
      end
    end
  end
end
