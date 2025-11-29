# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/prayer_book_user_preferences', type: :request do
  # Setup basic liturgical data before all tests
  before(:all) do
    setup_liturgical_foundation
  end

  def self.api_tags
    'Prayer Book Preferences'
  end

  def self.content_type
    'application/json'
  end

  path '/api/v1/prayer_books/{prayer_book_code}/features' do
    parameter name: 'prayer_book_code', in: :path, type: :string, description: 'Prayer book code (e.g., loc_2015, loc_2019)', required: true

    get('Get prayer book features and capabilities') do
      tags api_tags
      produces content_type
      description 'Returns available features and options for a specific Prayer Book. This endpoint does not require authentication.'

      response(200, 'successful') do
        let(:prayer_book_code) { 'loc_2015' }

        schema type: :object,
               properties: {
                 prayer_book_code: { type: :string, example: 'loc_2015' },
                 prayer_book_name: { type: :string, example: 'Livro de Oração Comum - IEAB - 2015' },
                 features: {
                   type: :object,
                   properties: {
                     lectionary: {
                       type: :object,
                       properties: {
                         reading_types: { type: :array, items: { type: :string }, example: %w[semicontinuous complementary] },
                         default_reading_type: { type: :string, example: 'semicontinuous' },
                         readings_per_week: { type: :integer, example: 4 },
                         supports_vigil: { type: :boolean, example: false }
                       }
                     },
                     daily_office: {
                       type: :object,
                       properties: {
                         supports_family_rite: { type: :boolean, example: true },
                         available_confession_types: { type: :array, items: { type: :string }, example: %w[long short] },
                         available_lords_prayer: { type: :array, items: { type: :string }, example: %w[traditional contemporary] }
                       }
                     },
                     psalter: {
                       type: :object,
                       properties: {
                         cycle_length: { type: :integer, example: 30 },
                         supports_seasonal_variations: { type: :boolean, example: true }
                       }
                     }
                   }
                 },
                 capabilities: {
                   type: :object,
                   description: 'Flattened view of capabilities for easier frontend consumption',
                   properties: {
                     supports_family_rite: { type: :boolean, example: true },
                     available_reading_types: { type: :array, items: { type: :string }, example: %w[semicontinuous complementary] }
                   }
                 }
               }

        run_test!
      end

      response(404, 'Prayer book not found') do
        let(:prayer_book_code) { 'nonexistent' }

        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Prayer book not found' }
               }

        run_test!
      end
    end
  end

  path '/api/v1/prayer_books/{prayer_book_code}/preferences' do
    parameter name: 'prayer_book_code', in: :path, type: :string, description: 'Prayer book code (e.g., loc_2015, loc_2019)', required: true

    get('Get user preferences for a prayer book') do
      tags api_tags
      produces content_type
      description "Returns user's saved preferences for a specific Prayer Book, merged with defaults"
      security [ bearer_auth: [] ]
      parameter name: 'Authorization', in: :header, type: :string, description: 'Firebase ID Token (format: Bearer <token>)', required: true

      response(200, 'successful') do
        let(:prayer_book_code) { 'loc_2015' }
        let(:Authorization) { 'Bearer mock-token' }

        before do
          user = create(:user)
          allow_any_instance_of(Api::V1::PrayerBookUserPreferencesController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::PrayerBookUserPreferencesController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 prayer_book_code: { type: :string, example: 'loc_2015' },
                 prayer_book_name: { type: :string, example: 'Livro de Oração Comum - IEAB - 2015' },
                 options: {
                   type: :object,
                   properties: {
                     lectionary: {
                       type: :object,
                       properties: {
                         reading_type: { type: :string, example: 'complementary' }
                       }
                     },
                     daily_office: {
                       type: :object,
                       properties: {
                         use_family_rite: { type: :boolean, example: true }
                       }
                     }
                   }
                 },
                 available_features: {
                   type: :object,
                   description: 'Available features for this Prayer Book'
                 }
               }

        run_test! do
          # Needs auth mocking in test
        end
      end

      response(401, 'Unauthorized') do
        let(:prayer_book_code) { 'loc_2015' }
        let(:Authorization) { 'Bearer invalid-token' }

        run_test! do
          # No auth provided
        end
      end

      response(404, 'Prayer book not found') do
        let(:prayer_book_code) { 'nonexistent' }
        let(:Authorization) { 'Bearer mock-token' }

        before do
          user = create(:user)
          allow_any_instance_of(Api::V1::PrayerBookUserPreferencesController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::PrayerBookUserPreferencesController).to receive(:current_user).and_return(user)
        end

        run_test! do
          # Needs auth mocking in test
        end
      end
    end

    patch('Update user preferences for a prayer book') do
      tags api_tags
      consumes content_type
      produces content_type
      description 'Updates or creates user preferences for a specific Prayer Book'
      security [ bearer_auth: [] ]
      parameter name: 'Authorization', in: :header, type: :string, description: 'Firebase ID Token (format: Bearer <token>)', required: true
      parameter name: :options, in: :body, schema: {
        type: :object,
        properties: {
          options: {
            type: :object,
            properties: {
              lectionary: {
                type: :object,
                properties: {
                  reading_type: { type: :string, enum: %w[semicontinuous complementary], example: 'complementary' }
                }
              },
              daily_office: {
                type: :object,
                properties: {
                  use_family_rite: { type: :boolean, example: true }
                }
              }
            }
          }
        },
        example: {
          options: {
            lectionary: {
              reading_type: 'complementary'
            },
            daily_office: {
              use_family_rite: true
            }
          }
        }
      }

      response(200, 'successful') do
        let(:prayer_book_code) { 'loc_2015' }
        let(:Authorization) { 'Bearer mock-token' }
        let(:options) do
          {
            options: {
              lectionary: {
                reading_type: 'complementary'
              }
            }
          }
        end

        before do
          user = create(:user)
          allow_any_instance_of(Api::V1::PrayerBookUserPreferencesController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::PrayerBookUserPreferencesController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 message: { type: :string, example: 'Preferências salvas com sucesso' },
                 options: {
                   type: :object,
                   description: 'Updated preferences'
                 }
               }

        run_test! do
          # Needs auth mocking in test
        end
      end

      response(401, 'Unauthorized') do
        let(:prayer_book_code) { 'loc_2015' }
        let(:Authorization) { 'Bearer invalid-token' }
        let(:options) { { options: {} } }

        run_test! do
          # No auth provided
        end
      end

      response(404, 'Prayer book not found') do
        let(:prayer_book_code) { 'nonexistent' }
        let(:Authorization) { 'Bearer mock-token' }
        let(:options) { { options: {} } }

        before do
          user = create(:user)
          allow_any_instance_of(Api::V1::PrayerBookUserPreferencesController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::PrayerBookUserPreferencesController).to receive(:current_user).and_return(user)
        end

        run_test! do
          # Needs auth mocking in test
        end
      end

      response(422, 'Unprocessable entity - invalid options') do
        let(:prayer_book_code) { 'loc_2015' }
        let(:Authorization) { 'Bearer mock-token' }
        let(:options) do
          {
            options: {
              lectionary: {
                reading_type: 'invalid_type'
              }
            }
          }
        end

        before do
          user = create(:user)
          allow_any_instance_of(Api::V1::PrayerBookUserPreferencesController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::PrayerBookUserPreferencesController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Opções inválidas' },
                 messages: {
                   type: :array,
                   items: { type: :string },
                   example: [ "reading_type 'invalid' não é suportado por este Prayer Book" ]
                 }
               }

        run_test! do
          # Needs auth mocking in test
        end
      end
    end
  end
end
