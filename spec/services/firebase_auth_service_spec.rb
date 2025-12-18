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

  describe '.verify_and_get_user' do
    let(:firebase_payload) do
      {
        'sub' => 'firebase_uid_123',
        'email' => 'user@example.com',
        'name' => 'Firebase User',
        'picture' => 'https://firebase.com/photo.jpg'
      }
    end

    before do
      allow(described_class).to receive(:verify_token).and_return(firebase_payload)
    end

    context 'when user does not exist' do
      it 'creates a new user with Firebase data' do
        expect {
          user = described_class.verify_and_get_user('mock-token')
          expect(user.email).to eq('user@example.com')
          expect(user.name).to eq('Firebase User')
          expect(user.photo_url).to eq('https://firebase.com/photo.jpg')
          expect(user.provider_uid).to eq('firebase_uid_123')
        }.to change(User, :count).by(1)
      end
    end

    context 'when user exists with empty name and photo' do
      let!(:existing_user) do
        create(:user,
          provider_uid: 'firebase_uid_123',
          email: 'user@example.com',
          name: nil,
          photo_url: nil
        )
      end

      it 'updates name and photo from Firebase' do
        user = described_class.verify_and_get_user('mock-token')

        expect(user.id).to eq(existing_user.id)
        expect(user.name).to eq('Firebase User')
        expect(user.photo_url).to eq('https://firebase.com/photo.jpg')
      end
    end

    context 'when user exists with custom name' do
      let!(:existing_user) do
        create(:user,
          provider_uid: 'firebase_uid_123',
          email: 'user@example.com',
          name: 'Custom Name',
          photo_url: nil
        )
      end

      it 'preserves custom name and updates empty photo' do
        user = described_class.verify_and_get_user('mock-token')

        expect(user.id).to eq(existing_user.id)
        expect(user.name).to eq('Custom Name')
        expect(user.photo_url).to eq('https://firebase.com/photo.jpg')
      end
    end

    context 'when user exists with custom photo_url' do
      let!(:existing_user) do
        create(:user,
          provider_uid: 'firebase_uid_123',
          email: 'user@example.com',
          name: nil,
          photo_url: 'https://custom.com/my-photo.jpg'
        )
      end

      it 'preserves custom photo and updates empty name' do
        user = described_class.verify_and_get_user('mock-token')

        expect(user.id).to eq(existing_user.id)
        expect(user.name).to eq('Firebase User')
        expect(user.photo_url).to eq('https://custom.com/my-photo.jpg')
      end
    end

    context 'when user exists with both custom name and photo' do
      let!(:existing_user) do
        create(:user,
          provider_uid: 'firebase_uid_123',
          email: 'user@example.com',
          name: 'Custom Name',
          photo_url: 'https://custom.com/my-photo.jpg'
        )
      end

      it 'preserves both custom name and photo' do
        user = described_class.verify_and_get_user('mock-token')

        expect(user.id).to eq(existing_user.id)
        expect(user.name).to eq('Custom Name')
        expect(user.photo_url).to eq('https://custom.com/my-photo.jpg')
      end

      it 'still updates email if changed' do
        firebase_payload['email'] = 'newemail@example.com'

        user = described_class.verify_and_get_user('mock-token')

        expect(user.email).to eq('newemail@example.com')
        expect(user.name).to eq('Custom Name')
      end
    end

    context 'when user exists with avatar attached' do
      let!(:existing_user) do
        create(:user,
          provider_uid: 'firebase_uid_123',
          email: 'user@example.com',
          name: 'User Name',
          photo_url: nil
        )
      end

      before do
        existing_user.avatar.attach(
          io: File.open(Rails.root.join('spec/fixtures/files/test_avatar.jpg')),
          filename: 'avatar.jpg',
          content_type: 'image/jpeg'
        )
      end

      it 'does not update photo_url when avatar is attached' do
        user = described_class.verify_and_get_user('mock-token')

        expect(user.id).to eq(existing_user.id)
        expect(user.photo_url).to be_nil
        expect(user.avatar).to be_attached
      end
    end

    context 'when user is found by email instead of provider_uid' do
      let!(:existing_user) do
        create(:user,
          provider_uid: 'old_provider_uid',
          email: 'user@example.com',
          name: 'Existing Name',
          photo_url: 'https://existing.com/photo.jpg'
        )
      end

      it 'updates provider_uid but preserves custom name and photo' do
        user = described_class.verify_and_get_user('mock-token')

        expect(user.id).to eq(existing_user.id)
        expect(user.provider_uid).to eq('firebase_uid_123')
        expect(user.name).to eq('Existing Name')
        expect(user.photo_url).to eq('https://existing.com/photo.jpg')
      end
    end
  end
end
