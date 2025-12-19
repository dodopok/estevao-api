# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Prayer Books Premium Access', type: :request do
  let!(:free_book) { create(:prayer_book, code: 'test_free', name: 'Free Book', premium_required: false, language: 'pt-BR') }
  let!(:premium_book) { create(:prayer_book, code: 'test_premium', name: 'Premium Book', premium_required: true, language: 'pt-BR') }
  let!(:english_book) { create(:prayer_book, code: 'test_premium_en', name: 'Premium EN', premium_required: true, language: 'en') }

  describe 'GET /api/v1/prayer_books' do
    context 'when user is not authenticated' do
      before { get '/api/v1/prayer_books' }

      it 'returns 200 OK' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns all prayer books' do
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:data].size).to be >= 3
      end

      it 'marks premium books as not accessible' do
        json = JSON.parse(response.body, symbolize_names: true)
        premium = json[:data].find { |pb| pb[:code] == 'test_premium' }

        expect(premium[:premium_required]).to be true
        expect(premium[:is_accessible]).to be false
      end

      it 'marks free books as accessible' do
        json = JSON.parse(response.body, symbolize_names: true)
        free = json[:data].find { |pb| pb[:code] == 'test_free' }

        expect(free[:premium_required]).to be false
        expect(free[:is_accessible]).to be true
      end

      it 'includes language field' do
        json = JSON.parse(response.body, symbolize_names: true)
        pt_book = json[:data].find { |pb| pb[:code] == 'test_free' }
        en_book = json[:data].find { |pb| pb[:code] == 'test_premium_en' }

        expect(pt_book[:language]).to eq('pt-BR')
        expect(en_book[:language]).to eq('en')
      end
    end

    context 'when user is non-premium' do
      let(:user) { create(:user, premium_expires_at: nil) }

      before do
        allow_any_instance_of(Api::V1::PrayerBooksController).to receive(:current_user).and_return(user)
        get '/api/v1/prayer_books'
      end

      it 'marks premium books as not accessible' do
        json = JSON.parse(response.body, symbolize_names: true)
        premium = json[:data].find { |pb| pb[:code] == 'test_premium' }

        expect(premium[:premium_required]).to be true
        expect(premium[:is_accessible]).to be false
      end

      it 'marks free books as accessible' do
        json = JSON.parse(response.body, symbolize_names: true)
        free = json[:data].find { |pb| pb[:code] == 'test_free' }

        expect(free[:premium_required]).to be false
        expect(free[:is_accessible]).to be true
      end
    end

    context 'when user is premium' do
      let(:user) { create(:user, premium_expires_at: 1.year.from_now) }

      before do
        allow_any_instance_of(Api::V1::PrayerBooksController).to receive(:current_user).and_return(user)
        get '/api/v1/prayer_books'
      end

      it 'marks all books as accessible' do
        json = JSON.parse(response.body, symbolize_names: true)

        json[:data].each do |book|
          expect(book[:is_accessible]).to be true
        end
      end
    end

    context 'when filtering by language' do
      before { get '/api/v1/prayer_books', params: { language: 'en' } }

      it 'returns only English prayer books' do
        json = JSON.parse(response.body, symbolize_names: true)
        languages = json[:data].map { |pb| pb[:language] }.uniq

        expect(languages).to eq(['en'])
      end

      it 'includes the English prayer book' do
        json = JSON.parse(response.body, symbolize_names: true)
        codes = json[:data].map { |pb| pb[:code] }

        expect(codes).to include('test_premium_en')
      end
    end

    context 'when filtering by Portuguese' do
      before { get '/api/v1/prayer_books', params: { language: 'pt-BR' } }

      it 'returns only Portuguese prayer books' do
        json = JSON.parse(response.body, symbolize_names: true)
        languages = json[:data].map { |pb| pb[:language] }.uniq

        expect(languages).to eq(['pt-BR'])
      end
    end
  end
end
