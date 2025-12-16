require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'associations' do
    it { should have_many(:completions) }
    it { should have_many(:fcm_tokens) }
    it { should have_many(:journals) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:provider_uid) }
    it { should validate_presence_of(:timezone) }
  end

  describe '#premium?' do
    it 'returns false when premium_expires_at is nil' do
      user.update(premium_expires_at: nil)
      expect(user.premium?).to be false
    end

    it 'returns false when premium_expires_at is in the past' do
      user.update(premium_expires_at: 1.day.ago)
      expect(user.premium?).to be false
    end

    it 'returns true when premium_expires_at is in the future' do
      user.update(premium_expires_at: 1.day.from_now)
      expect(user.premium?).to be true
    end
  end

  describe '#preferred_audio_voice' do
    it 'returns default voice when not set' do
      expect(user.preferred_audio_voice).to eq('male_1')
    end

    it 'returns user preference when set' do
      user.preferences['preferred_audio_voice'] = 'female_1'
      expect(user.preferred_audio_voice).to eq('female_1')
    end
  end

  describe 'audio voice preference validation' do
    it 'allows valid voice preferences' do
      user.preferences['preferred_audio_voice'] = 'female_1'
      expect(user).to be_valid
    end

    it 'rejects invalid voice preferences' do
      user.preferences['preferred_audio_voice'] = 'invalid_voice'
      expect(user).not_to be_valid
      expect(user.errors[:preferences]).to include(/must be one of/)
    end

    it 'allows blank voice preference' do
      user.preferences.delete('preferred_audio_voice')
      expect(user).to be_valid
    end
  end

  describe 'default preferences' do
    it 'includes preferred_audio_voice' do
      new_user = build(:user)
      expect(new_user.preferences['preferred_audio_voice']).to eq('male_1')
    end
  end
end
