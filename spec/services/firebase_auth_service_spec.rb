# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FirebaseAuthService do
  describe '.delete_user' do
    let(:uid) { 'firebase_uid_123' }

    before do
      allow(ENV).to receive(:fetch).and_call_original
      allow(ENV).to receive(:fetch).with('FIREBASE_PROJECT_ID', nil).and_return('test-project')
      allow(ENV).to receive(:fetch).with('FIREBASE_CLIENT_EMAIL', nil).and_return('test@test-project.iam.gserviceaccount.com')
      allow(ENV).to receive(:fetch).with('FIREBASE_PRIVATE_KEY', nil).and_return('fake-private-key')
    end

    context 'when deletion is successful' do
      before do
        allow(described_class).to receive(:fetch_admin_access_token).and_return('mock-access-token')

        # Mock HTTP response
        mock_response = instance_double(Net::HTTPSuccess, is_a?: true, body: '{}')
        allow(mock_response).to receive(:is_a?).with(Net::HTTPSuccess).and_return(true)
        allow(Net::HTTP).to receive(:start).and_return(mock_response)
      end

      it 'returns success' do
        result = described_class.delete_user(uid)
        expect(result[:success]).to be true
      end
    end

    context 'when user is not found in Firebase' do
      before do
        allow(described_class).to receive(:fetch_admin_access_token).and_return('mock-access-token')

        # Mock HTTP error response
        mock_response = instance_double(Net::HTTPBadRequest, body: { error: { message: 'USER_NOT_FOUND' } }.to_json)
        allow(mock_response).to receive(:is_a?).with(Net::HTTPSuccess).and_return(false)
        allow(Net::HTTP).to receive(:start).and_return(mock_response)
      end

      it 'returns error with message' do
        result = described_class.delete_user(uid)
        expect(result[:success]).to be false
        expect(result[:error]).to eq('USER_NOT_FOUND')
      end
    end

    context 'when UID is blank' do
      it 'raises ArgumentError for nil' do
        expect { described_class.delete_user(nil) }.to raise_error(ArgumentError, 'UID is required')
      end

      it 'raises ArgumentError for empty string' do
        expect { described_class.delete_user('') }.to raise_error(ArgumentError, 'UID is required')
      end
    end

    context 'when Firebase credentials are not configured' do
      before do
        allow(ENV).to receive(:fetch).with('FIREBASE_CLIENT_EMAIL', nil).and_return(nil)
        allow(ENV).to receive(:fetch).with('FIREBASE_PRIVATE_KEY', nil).and_return(nil)
      end

      it 'returns error about missing credentials' do
        result = described_class.delete_user(uid)
        expect(result[:success]).to be false
        expect(result[:error]).to include('Firebase service account credentials not configured')
      end
    end

    context 'when network error occurs' do
      before do
        allow(described_class).to receive(:fetch_admin_access_token).and_return('mock-access-token')
        allow(Net::HTTP).to receive(:start).and_raise(SocketError.new('Connection failed'))
      end

      it 'returns error with message' do
        result = described_class.delete_user(uid)
        expect(result[:success]).to be false
        expect(result[:error]).to include('Connection failed')
      end
    end
  end
end
