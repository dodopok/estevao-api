require 'rails_helper'

RSpec.describe RevenueCatService do
  let(:service) { described_class.new }
  let(:user) { create(:user, revenue_cat_user_id: 'rc_user_123') }

  before do
    allow(ENV).to receive(:fetch).with("REVENUECAT_API_KEY", nil).and_return('test_api_key')
  end

  describe 'initialization' do
    it 'raises error when API key is not configured' do
      allow(ENV).to receive(:fetch).with("REVENUECAT_API_KEY", nil).and_return(nil)
      expect { described_class.new }.to raise_error(/REVENUECAT_API_KEY not configured/)
    end
  end

  describe '#verify_subscription' do
    let(:active_subscription_response) do
      {
        subscriber: {
          entitlements: {
            premium: {
              expires_date: 1.month.from_now.iso8601,
              product_identifier: 'premium_monthly',
              will_renew: true
            }
          }
        }
      }.to_json
    end

    it 'returns subscription info for active subscription' do
      stub_request(:get, "https://api.revenuecat.com/v1/subscribers/rc_user_123")
        .to_return(status: 200, body: active_subscription_response)

      result = service.verify_subscription('rc_user_123')

      expect(result).to be_present
      expect(result[:active]).to be true
      expect(result[:expires_at]).to be > Time.current
      expect(result[:product_identifier]).to eq('premium_monthly')
    end

    it 'returns nil for expired subscription' do
      expired_response = {
        subscriber: {
          entitlements: {
            premium: {
              expires_date: 1.day.ago.iso8601,
              product_identifier: 'premium_monthly',
              will_renew: false
            }
          }
        }
      }.to_json

      stub_request(:get, "https://api.revenuecat.com/v1/subscribers/rc_user_123")
        .to_return(status: 200, body: expired_response)

      result = service.verify_subscription('rc_user_123')

      expect(result).to be_present
      expect(result[:active]).to be false
    end

    it 'returns nil when user not found' do
      stub_request(:get, "https://api.revenuecat.com/v1/subscribers/nonexistent_user")
        .to_return(status: 404, body: '{"message":"Not found"}')

      result = service.verify_subscription('nonexistent_user')
      expect(result).to be_nil
    end

    it 'returns nil on API errors' do
      stub_request(:get, "https://api.revenuecat.com/v1/subscribers/rc_user_123")
        .to_return(status: 500, body: '{"message":"Server error"}')

      result = service.verify_subscription('rc_user_123')
      expect(result).to be_nil
    end
  end

  describe '#update_user_premium_status' do
    it 'returns false when user has no revenue_cat_user_id' do
      user.update(revenue_cat_user_id: nil)
      expect(service.update_user_premium_status(user)).to be false
    end

    it 'updates user with active subscription' do
      expires_at = 1.month.from_now
      subscription_info = {
        active: true,
        expires_at: expires_at,
        product_identifier: 'premium_monthly',
        will_renew: true
      }

      allow(service).to receive(:verify_subscription).and_return(subscription_info)

      result = service.update_user_premium_status(user)

      expect(result).to be true
      expect(user.reload.premium_expires_at).to be_within(1.second).of(expires_at)
      expect(user.premium?).to be true
    end

    it 'clears premium status for expired subscription' do
      user.update(premium_expires_at: 1.day.from_now)
      allow(service).to receive(:verify_subscription).and_return(nil)

      result = service.update_user_premium_status(user)

      expect(result).to be false
      expect(user.reload.premium_expires_at).to be_nil
    end

    it 'does not clear premium_expires_at if it was already nil' do
      user.update(premium_expires_at: nil)
      allow(service).to receive(:verify_subscription).and_return(nil)

      expect {
        service.update_user_premium_status(user)
      }.not_to change { user.reload.updated_at }
    end
  end
end
