# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/journals', type: :request do
  def self.api_tags
    'Journals'
  end

  def self.content_type
    'application/json'
  end

  path '/api/v1/journals' do
    post('Create journal entry') do
      tags api_tags
      produces content_type
      consumes content_type
      description 'Creates a journal/diary entry for a specific date'
      security [ { bearer_auth: [] } ]

      parameter name: 'Authorization',
                in: :header,
                type: :string,
                description: 'Firebase ID Token (format: Bearer <token>)',
                required: true

      parameter name: :journal, in: :body, schema: {
        type: :object,
        properties: {
          date_reference: {
            type: :string,
            format: :date,
            example: '2025-12-10',
            description: 'Date for the journal entry'
          },
          entry_type: {
            type: :string,
            enum: %w[daily_office life_rule],
            example: 'daily_office',
            description: 'Type of journal entry'
          },
          office_type: {
            type: :string,
            enum: %w[morning midday evening compline],
            example: 'morning',
            description: 'Office type (required when entry_type is daily_office)'
          },
          content: {
            type: :string,
            example: 'Today I reflected on the importance of prayer in my daily life.',
            description: 'Content of the journal entry (max 10,000 characters)'
          }
        },
        required: %w[date_reference entry_type content]
      }

      response(201, 'created') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:journal) do
          {
            date_reference: '2025-12-10',
            entry_type: 'daily_office',
            office_type: 'morning',
            content: 'Today I reflected on the importance of prayer.'
          }
        end

        before do
          user = create(:user)
          allow_any_instance_of(Api::V1::JournalsController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::JournalsController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 message: { type: :string, example: 'Journal entry created successfully' },
                 journal: {
                   type: :object,
                   properties: {
                     id: { type: :integer, example: 1 },
                     date_reference: { type: :string, format: :date, example: '2025-12-10' },
                     entry_type: { type: :string, example: 'daily_office' },
                     office_type: { type: :string, example: 'morning', nullable: true },
                     content: { type: :string, example: 'Today I reflected on the importance of prayer.' },
                     created_at: { type: :string, format: 'date-time' },
                     updated_at: { type: :string, format: 'date-time' }
                   }
                 }
               }

        run_test!
      end

      response(401, 'unauthorized') do
        let(:Authorization) { '' }
        let(:journal) do
          {
            date_reference: '2025-12-10',
            entry_type: 'daily_office',
            office_type: 'morning',
            content: 'Content'
          }
        end

        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Unauthorized' }
               }

        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:journal) do
          {
            date_reference: '2025-12-10',
            entry_type: 'invalid_type',
            content: 'Content'
          }
        end

        before do
          user = create(:user)
          allow_any_instance_of(Api::V1::JournalsController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::JournalsController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 error: { type: :string }
               }

        run_test!
      end
    end
  end

  path '/api/v1/journals/{year}/{month}/{day}' do
    parameter name: 'year', in: :path, type: :integer, description: 'Year', required: true, example: 2025
    parameter name: 'month', in: :path, type: :integer, description: 'Month', required: true, example: 12
    parameter name: 'day', in: :path, type: :integer, description: 'Day', required: true, example: 10

    get('Get journal entries for a day') do
      tags api_tags
      produces content_type
      description 'Gets all journal entries for a specific date'
      security [ { bearer_auth: [] } ]

      parameter name: 'Authorization',
                in: :header,
                type: :string,
                description: 'Firebase ID Token (format: Bearer <token>)',
                required: true

      response(200, 'successful') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:year) { 2025 }
        let(:month) { 12 }
        let(:day) { 10 }

        before do
          user = create(:user)
          create(:journal, user: user, date_reference: Date.new(2025, 12, 10))
          create(:journal, :life_rule, user: user, date_reference: Date.new(2025, 12, 10))
          allow_any_instance_of(Api::V1::JournalsController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::JournalsController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 date: { type: :string, format: :date, example: '2025-12-10' },
                 count: { type: :integer, example: 2 },
                 entries: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       date_reference: { type: :string, format: :date },
                       entry_type: { type: :string },
                       office_type: { type: :string, nullable: true },
                       content: { type: :string },
                       created_at: { type: :string, format: 'date-time' },
                       updated_at: { type: :string, format: 'date-time' }
                     }
                   }
                 }
               }

        run_test!
      end

      response(401, 'unauthorized') do
        let(:Authorization) { '' }
        let(:year) { 2025 }
        let(:month) { 12 }
        let(:day) { 10 }

        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Unauthorized' }
               }

        run_test!
      end
    end
  end

  path '/api/v1/journals/{year}/{month}' do
    parameter name: 'year', in: :path, type: :integer, description: 'Year', required: true, example: 2025
    parameter name: 'month', in: :path, type: :integer, description: 'Month', required: true, example: 12

    get('Get month overview with entry counts') do
      tags api_tags
      produces content_type
      description 'Gets a calendar overview for a month showing which dates have journal entries and their counts'
      security [ { bearer_auth: [] } ]

      parameter name: 'Authorization',
                in: :header,
                type: :string,
                description: 'Firebase ID Token (format: Bearer <token>)',
                required: true

      response(200, 'successful') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:year) { 2025 }
        let(:month) { 12 }

        before do
          user = create(:user)
          create(:journal, user: user, date_reference: Date.new(2025, 12, 10))
          create(:journal, :life_rule, user: user, date_reference: Date.new(2025, 12, 10))
          create(:journal, user: user, date_reference: Date.new(2025, 12, 15))
          allow_any_instance_of(Api::V1::JournalsController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::JournalsController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 year: { type: :integer, example: 2025 },
                 month: { type: :integer, example: 12 },
                 total_entries: { type: :integer, example: 3 },
                 dates_with_entries: {
                   type: :array,
                   items: { type: :string, format: :date },
                   example: [ '2025-12-10', '2025-12-15' ]
                 },
                 entries_by_date: {
                   type: :object,
                   additionalProperties: {
                     type: :object,
                     properties: {
                       count: { type: :integer, example: 2 },
                       types: {
                         type: :object,
                         additionalProperties: { type: :integer },
                         example: { 'daily_office' => 1, 'life_rule' => 1 }
                       }
                     }
                   },
                   example: {
                     '2025-12-10' => {
                       count: 2,
                       types: { 'daily_office' => 1, 'life_rule' => 1 }
                     },
                     '2025-12-15' => {
                       count: 1,
                       types: { 'daily_office' => 1 }
                     }
                   }
                 }
               }

        run_test!
      end

      response(401, 'unauthorized') do
        let(:Authorization) { '' }
        let(:year) { 2025 }
        let(:month) { 12 }

        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Unauthorized' }
               }

        run_test!
      end
    end
  end

  path '/api/v1/journals/{id}' do
    parameter name: 'id', in: :path, type: :integer, description: 'Journal ID', required: true

    patch('Update journal entry') do
      tags api_tags
      produces content_type
      consumes content_type
      description 'Updates an existing journal entry'
      security [ { bearer_auth: [] } ]

      parameter name: 'Authorization',
                in: :header,
                type: :string,
                description: 'Firebase ID Token (format: Bearer <token>)',
                required: true

      parameter name: :journal, in: :body, schema: {
        type: :object,
        properties: {
          content: {
            type: :string,
            example: 'Updated reflection on today\'s prayer.',
            description: 'Updated content of the journal entry'
          }
        }
      }

      response(200, 'successful') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:id) do
          user = create(:user)
          journal = create(:journal, user: user)
          allow_any_instance_of(Api::V1::JournalsController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::JournalsController).to receive(:current_user).and_return(user)
          journal.id
        end
        let(:journal) { { content: 'Updated content' } }

        schema type: :object,
               properties: {
                 message: { type: :string, example: 'Journal entry updated successfully' },
                 journal: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     date_reference: { type: :string, format: :date },
                     entry_type: { type: :string },
                     office_type: { type: :string, nullable: true },
                     content: { type: :string },
                     created_at: { type: :string, format: 'date-time' },
                     updated_at: { type: :string, format: 'date-time' }
                   }
                 }
               }

        run_test!
      end

      response(401, 'unauthorized') do
        let(:Authorization) { '' }
        let(:id) { 1 }
        let(:journal) { { content: 'Updated content' } }

        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Unauthorized' }
               }

        run_test!
      end

      response(404, 'not found') do
        let(:Authorization) { 'Bearer mock-token' }
        let(:id) { 99999 }
        let(:journal) { { content: 'Updated content' } }

        before do
          user = create(:user)
          allow_any_instance_of(Api::V1::JournalsController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::JournalsController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Journal entry not found' }
               }

        run_test!
      end
    end

    delete('Delete journal entry') do
      tags api_tags
      produces content_type
      description 'Deletes a journal entry'
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
          journal = create(:journal, user: user)
          allow_any_instance_of(Api::V1::JournalsController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::JournalsController).to receive(:current_user).and_return(user)
          journal.id
        end

        schema type: :object,
               properties: {
                 message: { type: :string, example: 'Journal entry deleted successfully' }
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
          allow_any_instance_of(Api::V1::JournalsController).to receive(:authenticate_user!).and_return(true)
          allow_any_instance_of(Api::V1::JournalsController).to receive(:current_user).and_return(user)
        end

        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Journal entry not found' }
               }

        run_test!
      end
    end
  end
end
