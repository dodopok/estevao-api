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
        let(:Authorization) { 'Bearer mock-token' }

        before do
          user = create(:user)
          allow_any_instance_of(Api::V1::UsersController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::UsersController).to receive(:current_user).and_return(user)
        end

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
                     notifications: { type: :boolean, example: true },
                     notifications_enabled: { type: :boolean, example: true },
                     streak_reminder_enabled: { type: :boolean, example: true },
                     prayer_times: {
                       type: :array,
                       items: {
                         type: :object,
                         properties: {
                           office_id: { type: :string, example: '1' },
                           office_name: { type: :string, example: 'Matutino' },
                           hour: { type: :integer, example: 6 },
                           minute: { type: :integer, example: 0 },
                           enabled: { type: :boolean, example: true }
                         }
                       }
                     }
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
        let(:Authorization) { '' }

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
              notifications: { type: :boolean, example: true },
              notifications_enabled: { type: :boolean, example: true },
              streak_reminder_enabled: { type: :boolean, example: true },
              prayer_times: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    office_id: { type: :string, example: '1' },
                    office_name: { type: :string, example: 'Matutino' },
                    hour: { type: :integer, example: 6 },
                    minute: { type: :integer, example: 0 },
                    enabled: { type: :boolean, example: true }
                  }
                }
              }
            }
          }
        },
        required: [ 'preferences' ]
      }

      response(200, 'successful') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:preferences) { { preferences: { version: 'loc_2015', language: 'pt-BR' } } }

        before do
          user = create(:user)
          allow_any_instance_of(Api::V1::UsersController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::UsersController).to receive(:current_user).and_return(user)
        end

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
        let(:Authorization) { '' }
        let(:preferences) { { preferences: { version: 'loc_2015' } } }

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
        let(:Authorization) { 'Bearer mock-token' }
        let(:limit) { 30 }

        before do
          user = create(:user)
          allow_any_instance_of(Api::V1::UsersController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::UsersController).to receive(:current_user).and_return(user)
        end

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
        let(:Authorization) { '' }
        let(:limit) { 30 }

        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Unauthorized' }
               }

        run_test!
      end
    end
  end

  path '/api/v1/users/fcm_token' do
    post('Save FCM token for push notifications') do
      tags api_tags
      produces content_type
      consumes content_type
      description 'Saves or updates the FCM (Firebase Cloud Messaging) token for the authenticated user to enable push notifications'
      security [ { bearer_auth: [] } ]

      parameter name: 'Authorization',
                in: :header,
                type: :string,
                description: 'Firebase ID Token (format: Bearer <token>)',
                required: true

      parameter name: :fcm_token_data, in: :body, schema: {
        type: :object,
        properties: {
          fcm_token: { type: :string, example: 'fK8x9y2ZqR3...' },
          platform: { type: :string, enum: [ 'android', 'ios', 'web' ], example: 'android' }
        },
        required: [ 'fcm_token' ]
      }

      response(200, 'successful') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:fcm_token_data) { { fcm_token: 'test-token-123', platform: 'android' } }

        before do
          user = create(:user)
          allow_any_instance_of(Api::V1::UsersController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::UsersController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 message: { type: :string, example: 'Token FCM salvo com sucesso' },
                 fcm_token: { type: :string, example: 'fK8x9y2ZqR3...' }
               }

        run_test!
      end

      response(401, 'unauthorized') do
        let(:Authorization) { '' }
        let(:fcm_token_data) { { fcm_token: 'test-token-123' } }

        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Unauthorized' }
               }

        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:fcm_token_data) { { platform: 'android' } }

        before do
          user = create(:user)
          allow_any_instance_of(Api::V1::UsersController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::UsersController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 error: { type: :string, example: 'FCM token is required' }
               }

        run_test!
      end
    end

    delete('Remove FCM token') do
      tags api_tags
      produces content_type
      description 'Removes the FCM token for the authenticated user (e.g., when logging out or disabling notifications)'
      security [ { bearer_auth: [] } ]

      parameter name: 'Authorization',
                in: :header,
                type: :string,
                description: 'Firebase ID Token (format: Bearer <token>)',
                required: true

      parameter name: :fcm_token, in: :query, type: :string, description: 'FCM token to remove', required: true

      response(200, 'successful') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:fcm_token) { 'test-token-123' }

        before do
          user = create(:user)
          user.fcm_tokens.create!(token: 'test-token-123', platform: 'android')
          allow_any_instance_of(Api::V1::UsersController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::UsersController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 message: { type: :string, example: 'Token FCM removido com sucesso' }
               }

        run_test!
      end

      response(401, 'unauthorized') do
        let(:Authorization) { '' }
        let(:fcm_token) { 'test-token-123' }

        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Unauthorized' }
               }

        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:fcm_token) { '' }

        before do
          user = create(:user)
          allow_any_instance_of(Api::V1::UsersController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::UsersController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 error: { type: :string, example: 'FCM token is required' }
               }

        run_test!
      end
    end
  end

  path '/api/v1/users/me' do
    delete('Delete user account') do
      tags api_tags
      produces content_type
      description 'Permanently deletes the user account and all associated data. ' \
                  'This also removes the user from Firebase Authentication. ' \
                  'This action is irreversible and complies with Apple App Store Guidelines 5.1.1(v).'
      security [ { bearer_auth: [] } ]

      parameter name: 'Authorization',
                in: :header,
                type: :string,
                description: 'Firebase ID Token (format: Bearer <token>)',
                required: true

      response(200, 'successful') do
        let(:Authorization) { 'Bearer mock-token' }

        before do
          @user = create(:user)
          # Cria dados associados para verificar que são deletados
          create(:completion, user: @user)
          create(:journal, user: @user)
          create(:fcm_token, user: @user)

          allow_any_instance_of(Api::V1::UsersController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::UsersController).to receive(:current_user).and_return(@user)
          allow(FirebaseAuthService).to receive(:delete_user).and_return({ success: true })
        end

        schema type: :object,
               properties: {
                 message: { type: :string, example: 'Account deleted successfully' }
               }

        run_test! do |response|
          expect(User.find_by(id: @user.id)).to be_nil
          expect(Completion.where(user_id: @user.id).count).to eq(0)
          expect(Journal.where(user_id: @user.id).count).to eq(0)
          expect(FcmToken.where(user_id: @user.id).count).to eq(0)
        end
      end

      response(401, 'unauthorized') do
        let(:Authorization) { '' }

        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Unauthorized' }
               }

        run_test!
      end

      response(502, 'bad gateway - firebase error') do
        let(:Authorization) { 'Bearer mock-token' }

        before do
          user = create(:user)
          allow_any_instance_of(Api::V1::UsersController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::UsersController).to receive(:current_user).and_return(user)
          allow(FirebaseAuthService).to receive(:delete_user).and_return({
            success: false,
            error: 'USER_NOT_FOUND'
          })
        end

        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Failed to delete account from Firebase: USER_NOT_FOUND' }
               }

        run_test!
      end
    end
  end
end
