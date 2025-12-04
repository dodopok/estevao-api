# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/life_rules', type: :request do
  def self.api_tags
    'Life Rules'
  end

  def self.content_type
    'application/json'
  end

  path '/api/v1/life_rules' do
    get('List life rules') do
      tags api_tags
      produces content_type
      description 'Returns public approved life rules and user\'s own life rules'
      security [ { bearer_auth: [] } ]

      parameter name: 'Authorization',
                in: :header,
                type: :string,
                description: 'Firebase ID Token (format: Bearer <token>)',
                required: true

      parameter name: :search,
                in: :query,
                type: :string,
                description: 'Search by title',
                required: false

      parameter name: :sort,
                in: :query,
                type: :string,
                description: 'Sort by popularity (value: "popular")',
                required: false

      parameter name: :limit,
                in: :query,
                type: :integer,
                description: 'Number of results to return (default: 20, max: 100)',
                required: false

      parameter name: :offset,
                in: :query,
                type: :integer,
                description: 'Number of results to skip (default: 0)',
                required: false

      response(200, 'successful') do
        let(:Authorization) { 'Bearer mock-token' }

        before do
          user = create(:user)
          create(:life_rule, :public_approved)
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 life_rules: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       icon: { type: :string },
                       title: { type: :string },
                       description: { type: :string },
                       is_public: { type: :boolean },
                       approved: { type: :boolean },
                       adoption_count: { type: :integer },
                       is_owner: { type: :boolean },
                       created_at: { type: :string, format: 'date-time' }
                     }
                   }
                 },
                 pagination: {
                   type: :object,
                   properties: {
                     total: { type: :integer },
                     limit: { type: :integer },
                     offset: { type: :integer },
                     count: { type: :integer }
                   },
                   required: %w[total limit offset count]
                 }
               },
               required: %w[life_rules pagination]

        run_test!
      end

      context 'with pagination' do
        let(:Authorization) { 'Bearer mock-token' }

        before do
          user = create(:user)
          # Create 25 public approved rules
          create_list(:life_rule, 25, :public_approved)
          # Create user's own rule
          create(:life_rule, user: user)

          allow_any_instance_of(Api::V1::LifeRulesController)
            .to receive(:authenticate_user!)
            .and_return(true)
          allow_any_instance_of(Api::V1::LifeRulesController)
            .to receive(:current_user)
            .and_return(user)
        end

        it 'returns first 20 items with correct metadata' do
          get '/api/v1/life_rules', headers: { 'Authorization' => 'Bearer mock-token' }

          data = JSON.parse(response.body)
          expect(response.status).to eq(200)
          expect(data['life_rules'].size).to eq(20)
          expect(data['pagination']['total']).to eq(26)
          expect(data['pagination']['limit']).to eq(20)
          expect(data['pagination']['offset']).to eq(0)
          expect(data['pagination']['count']).to eq(20)
        end

        it 'returns correct page with custom limit and offset' do
          get '/api/v1/life_rules?limit=5&offset=10', headers: { 'Authorization' => 'Bearer mock-token' }

          data = JSON.parse(response.body)
          expect(response.status).to eq(200)
          expect(data['life_rules'].size).to eq(5)
          expect(data['pagination']['limit']).to eq(5)
          expect(data['pagination']['offset']).to eq(10)
        end

        it 'returns empty array with offset beyond total' do
          get '/api/v1/life_rules?offset=100', headers: { 'Authorization' => 'Bearer mock-token' }

          data = JSON.parse(response.body)
          expect(response.status).to eq(200)
          expect(data['life_rules']).to be_empty
          expect(data['pagination']['total']).to eq(26)
          expect(data['pagination']['count']).to eq(0)
        end

        it 'caps limit at 100' do
          get '/api/v1/life_rules?limit=500', headers: { 'Authorization' => 'Bearer mock-token' }

          data = JSON.parse(response.body)
          expect(response.status).to eq(200)
          expect(data['pagination']['limit']).to eq(100)
        end
      end

      context 'with search filter' do
        let(:Authorization) { 'Bearer mock-token' }

        before do
          user = create(:user)
          create(:life_rule, :public_approved, title: 'Morning Prayer')
          create(:life_rule, :public_approved, title: 'Evening Prayer')
          create(:life_rule, :public_approved, title: 'Daily Reading')

          allow_any_instance_of(Api::V1::LifeRulesController)
            .to receive(:authenticate_user!)
            .and_return(true)
          allow_any_instance_of(Api::V1::LifeRulesController)
            .to receive(:current_user)
            .and_return(user)
        end

        it 'paginates filtered results correctly' do
          get '/api/v1/life_rules?search=Prayer', headers: { 'Authorization' => 'Bearer mock-token' }

          data = JSON.parse(response.body)
          expect(response.status).to eq(200)
          expect(data['pagination']['total']).to eq(2)
          expect(data['life_rules'].size).to eq(2)
        end
      end
    end

    post('Create a life rule') do
      tags api_tags
      produces content_type
      consumes content_type
      description 'Creates a new life rule for the authenticated user (replaces existing one)'
      security [ { bearer_auth: [] } ]

      parameter name: 'Authorization',
                in: :header,
                type: :string,
                description: 'Firebase ID Token (format: Bearer <token>)',
                required: true

      parameter name: :life_rule, in: :body, schema: {
        type: :object,
        properties: {
          icon: { type: :string, example: '📖' },
          title: { type: :string, example: 'Morning Routine' },
          description: { type: :string, example: 'My daily morning routine' },
          is_public: { type: :boolean, example: false },
          life_rule_steps_attributes: {
            type: :array,
            items: {
              type: :object,
              properties: {
                order: { type: :integer, example: 1 },
                title: { type: :string, example: 'Wake up early' },
                description: { type: :string, example: 'Wake up at 6 AM' }
              }
            }
          }
        },
        required: %w[icon title]
      }

      response(201, 'created') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:life_rule) do
          {
            icon: '📖',
            title: 'Test Rule',
            description: 'Test Description',
            is_public: false,
            life_rule_steps_attributes: [
              { order: 1, title: 'Step 1', description: 'First step' }
            ]
          }
        end

        before do
          user = create(:user)
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 message: { type: :string },
                 life_rule: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     icon: { type: :string },
                     title: { type: :string },
                     description: { type: :string },
                     is_public: { type: :boolean },
                     approved: { type: :boolean },
                     adoption_count: { type: :integer },
                     is_owner: { type: :boolean },
                     created_at: { type: :string, format: 'date-time' },
                     steps: {
                       type: :array,
                       items: {
                         type: :object,
                         properties: {
                           id: { type: :integer },
                           order: { type: :integer },
                           title: { type: :string },
                           description: { type: :string }
                         }
                       }
                     }
                   }
                 }
               }

        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:life_rule) { { icon: '', title: '' } }

        before do
          user = create(:user)
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 error: { type: :array, items: { type: :string } }
               }

        run_test!
      end
    end
  end

  path '/api/v1/life_rules/my' do
    get('Get current user\'s life rule') do
      tags api_tags
      produces content_type
      description 'Returns the life rule owned by the current authenticated user'
      security [ { bearer_auth: [] } ]

      parameter name: 'Authorization',
                in: :header,
                type: :string,
                description: 'Firebase ID Token (format: Bearer <token>)',
                required: true

      response(200, 'successful') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:user) { create(:user) }

        before do
          create(:life_rule, :with_steps, user: user)
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 life_rule: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     icon: { type: :string },
                     title: { type: :string },
                     description: { type: :string },
                     is_public: { type: :boolean },
                     approved: { type: :boolean },
                     adoption_count: { type: :integer },
                     is_owner: { type: :boolean },
                     created_at: { type: :string, format: 'date-time' },
                     steps: {
                       type: :array,
                       items: {
                         type: :object,
                         properties: {
                           id: { type: :integer },
                           order: { type: :integer },
                           title: { type: :string },
                           description: { type: :string }
                         }
                       }
                     }
                   }
                 }
               }

        run_test!
      end

      response(404, 'not found') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:user) { create(:user) }

        before do
          # User has no life rule
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 error: { type: :string }
               }

        run_test!
      end
    end
  end

  path '/api/v1/life_rules/{id}' do
    parameter name: :id, in: :path, type: :integer

    get('Show a life rule') do
      tags api_tags
      produces content_type
      description 'Shows a specific life rule (must be public approved or owned by user)'
      security [ { bearer_auth: [] } ]

      parameter name: 'Authorization',
                in: :header,
                type: :string,
                description: 'Firebase ID Token (format: Bearer <token>)',
                required: true

      response(200, 'successful') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:user) { create(:user) }
        let(:life_rule_record) { create(:life_rule, :with_steps, :public_approved) }
        let(:id) { life_rule_record.id }

        before do
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 life_rule: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     icon: { type: :string },
                     title: { type: :string },
                     description: { type: :string },
                     is_public: { type: :boolean },
                     approved: { type: :boolean },
                     adoption_count: { type: :integer },
                     is_owner: { type: :boolean },
                     created_at: { type: :string, format: 'date-time' },
                     steps: { type: :array }
                   }
                 }
               }

        run_test!
      end

      response(404, 'not found') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:id) { 999999 }

        before do
          user = create(:user)
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 error: { type: :string }
               }

        run_test!
      end
    end

    patch('Update a life rule') do
      tags api_tags
      produces content_type
      consumes content_type
      description 'Updates a life rule (only if owned by user)'
      security [ { bearer_auth: [] } ]

      parameter name: 'Authorization',
                in: :header,
                type: :string,
                description: 'Firebase ID Token (format: Bearer <token>)',
                required: true

      parameter name: :life_rule, in: :body, schema: {
        type: :object,
        properties: {
          icon: { type: :string },
          title: { type: :string },
          description: { type: :string },
          is_public: { type: :boolean }
        }
      }

      response(200, 'successful') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:user) { create(:user) }
        let(:life_rule_record) { create(:life_rule, user: user) }
        let(:id) { life_rule_record.id }
        let(:life_rule) { { title: 'Updated Title' } }

        before do
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 message: { type: :string },
                 life_rule: { type: :object }
               }

        run_test!
      end

      response(403, 'forbidden') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:user) { create(:user) }
        let(:other_user) { create(:user) }
        let(:life_rule_record) { create(:life_rule, user: other_user) }
        let(:id) { life_rule_record.id }
        let(:life_rule) { { title: 'Updated Title' } }

        before do
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 error: { type: :string }
               }

        run_test!
      end
    end

    delete('Delete a life rule') do
      tags api_tags
      produces content_type
      description 'Deletes a life rule (only if owned by user)'
      security [ { bearer_auth: [] } ]

      parameter name: 'Authorization',
                in: :header,
                type: :string,
                description: 'Firebase ID Token (format: Bearer <token>)',
                required: true

      response(200, 'successful') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:user) { create(:user) }
        let(:life_rule_record) { create(:life_rule, user: user) }
        let(:id) { life_rule_record.id }

        before do
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 message: { type: :string }
               }

        run_test!
      end

      response(403, 'forbidden') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:user) { create(:user) }
        let(:other_user) { create(:user) }
        let(:life_rule_record) { create(:life_rule, user: other_user) }
        let(:id) { life_rule_record.id }

        before do
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 error: { type: :string }
               }

        run_test!
      end
    end
  end

  path '/api/v1/life_rules/{id}/adopt' do
    parameter name: :id, in: :path, type: :integer

    post('Adopt a life rule') do
      tags api_tags
      produces content_type
      description 'Adopts a public approved life rule (creates a copy for current user)'
      security [ { bearer_auth: [] } ]

      parameter name: 'Authorization',
                in: :header,
                type: :string,
                description: 'Firebase ID Token (format: Bearer <token>)',
                required: true

      response(201, 'created') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:user) { create(:user) }
        let(:life_rule_record) { create(:life_rule, :with_steps, :public_approved) }
        let(:id) { life_rule_record.id }

        before do
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 message: { type: :string },
                 life_rule: { type: :object }
               }

        run_test!
      end

      response(404, 'not found') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:id) { 999999 }

        before do
          user = create(:user)
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 error: { type: :string }
               }

        run_test!
      end
    end
  end

  path '/api/v1/life_rules/{id}/approve' do
    parameter name: :id, in: :path, type: :integer

    post('Approve a life rule') do
      tags api_tags
      produces content_type
      description 'Approves a life rule (admin only)'
      security [ { bearer_auth: [] } ]

      parameter name: 'Authorization',
                in: :header,
                type: :string,
                description: 'Firebase ID Token (format: Bearer <token>)',
                required: true

      response(200, 'successful') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:admin_user) { create(:user, :admin) }
        let(:life_rule_record) { create(:life_rule, :public) }
        let(:id) { life_rule_record.id }

        before do
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:current_user).and_return(admin_user)
        end

        schema type: :object,
               properties: {
                 message: { type: :string },
                 life_rule: { type: :object }
               }

        run_test!
      end

      response(403, 'forbidden') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:user) { create(:user) }
        let(:life_rule_record) { create(:life_rule, :public) }
        let(:id) { life_rule_record.id }

        before do
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::LifeRulesController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 error: { type: :string }
               }

        run_test!
      end
    end
  end
end
