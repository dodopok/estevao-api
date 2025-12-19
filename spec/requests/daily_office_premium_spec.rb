# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Daily Office Premium Authorization', type: :request do
  let!(:free_book) { create(:prayer_book, code: 'loc_2015', name: 'LOC 2015', premium_required: false, language: 'pt-BR') }
  let!(:premium_book) { create(:prayer_book, code: 'loc_2019', name: 'LOC 2019', premium_required: true, language: 'pt-BR') }

  # Note: These tests focus on premium authorization logic
  # Full integration tests with liturgical data are in other spec files

  describe 'Premium authorization behavior' do
    before do
      # Mock the PreferencesResolver to bypass onboarding validation for these tests
      allow_any_instance_of(Api::V1::Concerns::PreferencesResolver).to receive(:validate_preferences!).and_return(true)
      allow_any_instance_of(Api::V1::Concerns::PreferencesResolver).to receive(:resolved_prayer_book).and_return(premium_book)
      allow_any_instance_of(Api::V1::Concerns::PreferencesResolver).to receive(:resolved_preferences).and_return({
                                                                                                                      prayer_book_code: 'loc_2019',
                                                                                                                      bible_version: 'nvi',
                                                                                                                      language: 'pt-BR'
                                                                                                                    })
    end

    context 'when user is not premium' do
      let(:user) { create(:user, premium_expires_at: nil) }

      before do
        allow_any_instance_of(Api::V1::DailyOfficeController).to receive(:current_user).and_return(user)
        get '/api/v1/daily_office/today/morning'
      end

      it 'returns 403 Forbidden' do
        expect(response).to have_http_status(:forbidden)
      end

      it 'returns PREMIUM_REQUIRED error code' do
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:success]).to be false
        expect(json[:error][:code]).to eq('PREMIUM_REQUIRED')
      end

      it 'includes prayer book information in error' do
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:error][:prayer_book_code]).to eq('loc_2019')
        expect(json[:error][:premium_required]).to be true
        expect(json[:error][:message]).to include('LOC 2019')
      end
    end

    context 'when user is premium' do
      let(:user) { create(:user, premium_expires_at: 1.year.from_now) }

      before do
        allow_any_instance_of(Api::V1::DailyOfficeController).to receive(:current_user).and_return(user)

        # Mock DailyOfficeService to avoid needing full liturgical data
        mock_response = {
          date: Date.today.to_s,
          office_type: 'morning',
          metadata: { prayer_book_code: 'loc_2019' }
        }
        allow_any_instance_of(DailyOfficeService).to receive(:call).and_return(mock_response)

        get '/api/v1/daily_office/today/morning'
      end

      it 'does not return 403' do
        expect(response).not_to have_http_status(:forbidden)
      end

      it 'allows access to premium prayer book' do
        # Should not have PREMIUM_REQUIRED error
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:error]).to be_nil
      end
    end

    context 'when premium has expired' do
      let(:user) { create(:user, premium_expires_at: 1.day.ago) }

      before do
        allow_any_instance_of(Api::V1::DailyOfficeController).to receive(:current_user).and_return(user)
        get '/api/v1/daily_office/today/morning'
      end

      it 'returns 403 Forbidden' do
        expect(response).to have_http_status(:forbidden)
      end

      it 'returns PREMIUM_REQUIRED error' do
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:error][:code]).to eq('PREMIUM_REQUIRED')
      end
    end
  end

  describe 'Authorization with free prayer book' do
    before do
      allow_any_instance_of(Api::V1::Concerns::PreferencesResolver).to receive(:validate_preferences!).and_return(true)
      allow_any_instance_of(Api::V1::Concerns::PreferencesResolver).to receive(:resolved_prayer_book).and_return(free_book)
      allow_any_instance_of(Api::V1::Concerns::PreferencesResolver).to receive(:resolved_preferences).and_return({
                                                                                                                      prayer_book_code: 'loc_2015',
                                                                                                                      bible_version: 'nvi',
                                                                                                                      language: 'pt-BR'
                                                                                                                    })

      # Mock DailyOfficeService
      mock_response = { date: Date.today.to_s, office_type: 'morning' }
      allow_any_instance_of(DailyOfficeService).to receive(:call).and_return(mock_response)
    end

    it 'allows non-premium users to access free prayer books' do
      user = create(:user, premium_expires_at: nil)
      allow_any_instance_of(Api::V1::DailyOfficeController).to receive(:current_user).and_return(user)

      get '/api/v1/daily_office/today/morning'

      expect(response).not_to have_http_status(:forbidden)
    end

    it 'allows unauthenticated users to access free prayer books' do
      get '/api/v1/daily_office/today/morning'

      expect(response).not_to have_http_status(:forbidden)
    end
  end
end
