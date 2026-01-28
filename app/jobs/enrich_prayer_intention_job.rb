# frozen_string_literal: true

# Background job to generate Anglican-style prayer for prayer intentions
# Uses Perplexity API to create complete formatted prayers
class EnrichPrayerIntentionJob < ApplicationJob
  queue_as :default
  
  # Retry strategy for API failures
  retry_on PerplexityApiService::PerplexityError, wait: :exponentially_longer, attempts: 3
  retry_on PerplexityApiService::RateLimitError, wait: 2.minutes, attempts: 5
  
  # Discard on authentication errors (no point retrying)
  discard_on PerplexityApiService::AuthenticationError
  
  # Maximum job execution time
  self.timeout = 2.minutes
  
  # Generate Anglican-style prayer for a prayer intention
  #
  # @param prayer_intention_id [Integer] The ID of the prayer intention
  def perform(prayer_intention_id)
    prayer_intention = PrayerIntention.find(prayer_intention_id)
    
    Rails.logger.info "Starting prayer generation for PrayerIntention ##{prayer_intention_id}"
    
    # Check if enrichment is actually needed
    unless prayer_intention.needs_ai_enrichment?
      Rails.logger.info "PrayerIntention ##{prayer_intention_id} already has prayer, skipping"
      return
    end
    
    # Initialize Perplexity API service
    perplexity_service = PerplexityApiService.new
    
    # Generate prayer from AI
    generated_prayer = perplexity_service.generate_prayer(prayer_intention)
    
    # Update prayer intention with generated prayer
    prayer_intention.update!(generated_prayer: generated_prayer)
    
    # Mark as enriched
    prayer_intention.mark_as_ai_enriched!(model_version: PerplexityApiService::DEFAULT_MODEL)
    
    Rails.logger.info "Successfully generated prayer for PrayerIntention ##{prayer_intention_id}"
    
    # Notify user if they have FCM token (optional)
    notify_user_of_prayer(prayer_intention) if prayer_intention.user.fcm_tokens.any?
    
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.error "PrayerIntention ##{prayer_intention_id} not found: #{e.message}"
    # Don't retry if record doesn't exist
  rescue StandardError => e
    Rails.logger.error "Failed to generate prayer for PrayerIntention ##{prayer_intention_id}: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    raise # Re-raise for retry logic
  end
  
  private
  
  # Send notification to user about completed prayer generation
  def notify_user_of_prayer(prayer_intention)
    NotificationService.send_notification(
      user: prayer_intention.user,
      title: 'Prayer Generated',
      body: "A prayer has been composed for '#{prayer_intention.title}'",
      data: {
        type: 'prayer_intention_generated',
        prayer_intention_id: prayer_intention.id
      }
    )
  rescue StandardError => e
    # Don't fail the job if notification fails
    Rails.logger.warn "Failed to send prayer generation notification: #{e.message}"
  end
end
