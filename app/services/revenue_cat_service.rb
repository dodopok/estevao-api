class RevenueCatService
  API_BASE_URL = "https://api.revenuecat.com/v1"

  def initialize
    @api_key = ENV.fetch("REVENUECAT_API_KEY", nil)
    raise "REVENUECAT_API_KEY not configured" if @api_key.blank?
  end

  # Verify subscription status for a user via RevenueCat API
  # Returns subscription info or nil if not found/expired
  def verify_subscription(revenue_cat_user_id)
    url = "#{API_BASE_URL}/subscribers/#{revenue_cat_user_id}"

    response = HTTP.auth("Bearer #{@api_key}")
      .headers("Content-Type" => "application/json")
      .get(url)

    case response.code
    when 200
      parse_subscription_response(response)
    when 404
      Rails.logger.warn "RevenueCat user not found: #{revenue_cat_user_id}"
      nil
    else
      error_message = parse_error(response)
      Rails.logger.error "RevenueCat API error (#{response.code}): #{error_message}"
      nil
    end
  rescue StandardError => e
    Rails.logger.error "RevenueCat verification failed: #{e.message}"
    nil
  end

  # Update user's premium status based on RevenueCat verification
  def update_user_premium_status(user)
    return false unless user.revenue_cat_user_id.present?

    subscription_info = verify_subscription(user.revenue_cat_user_id)

    if subscription_info && subscription_info[:active]
      user.update(premium_expires_at: subscription_info[:expires_at])
      true
    else
      # Subscription expired or not found
      user.update(premium_expires_at: nil) if user.premium_expires_at.present?
      false
    end
  end

  private

  def parse_subscription_response(response)
    data = JSON.parse(response.body.to_s)
    subscriber = data["subscriber"]

    return nil unless subscriber

    # Check for any active entitlement (e.g., "premium", "pro", etc.)
    entitlements = subscriber.dig("entitlements") || {}
    active_entitlement = entitlements.values.find { |e| e["expires_date"].present? }

    if active_entitlement
      expires_at = Time.parse(active_entitlement["expires_date"])
      is_active = expires_at > Time.current

      {
        active: is_active,
        expires_at: expires_at,
        product_identifier: active_entitlement["product_identifier"],
        will_renew: active_entitlement["will_renew"]
      }
    else
      nil
    end
  rescue JSON::ParserError, StandardError => e
    Rails.logger.error "Failed to parse RevenueCat response: #{e.message}"
    nil
  end

  def parse_error(response)
    JSON.parse(response.body.to_s)["message"] || response.body.to_s
  rescue JSON::ParserError
    response.body.to_s
  end
end
