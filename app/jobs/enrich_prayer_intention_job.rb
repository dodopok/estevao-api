# frozen_string_literal: true

# Background job to enrich prayer intentions with AI-generated spiritual insights
# Uses Perplexity API to add context, scriptures, and theological insights
class EnrichPrayerIntentionJob < ApplicationJob
  queue_as :default
  
  # Retry strategy for API failures
  retry_on PerplexityApiService::PerplexityError, wait: :exponentially_longer, attempts: 3
  retry_on PerplexityApiService::RateLimitError, wait: 2.minutes, attempts: 5
  
  # Discard on authentication errors (no point retrying)
  discard_on PerplexityApiService::AuthenticationError
  
  # Maximum job execution time
  self.timeout = 2.minutes
  
  # Enrich a prayer intention with AI-generated insights
  #
  # @param prayer_intention_id [Integer] The ID of the prayer intention to enrich
  def perform(prayer_intention_id)
    prayer_intention = PrayerIntention.find(prayer_intention_id)
    
    Rails.logger.info "Starting AI enrichment for PrayerIntention ##{prayer_intention_id}"
    
    # Check if enrichment is actually needed
    unless prayer_intention.needs_ai_enrichment?
      Rails.logger.info "PrayerIntention ##{prayer_intention_id} already enriched, skipping"
      return
    end
    
    # Initialize Perplexity API service
    perplexity_service = PerplexityApiService.new
    
    # Get enrichment data from AI
    enrichment_data = perplexity_service.enrich_prayer_intention(prayer_intention)
    
    # Update prayer intention with enrichment data
    prayer_intention.update!(\n      spiritual_context: enrichment_data[:spiritual_context],
      related_scriptures: enrichment_data[:related_scriptures],
      suggested_prayers: enrichment_data[:suggested_prayers],
      theological_insights: enrichment_data[:theological_insights],
      reflection_prompts: enrichment_data[:reflection_prompts]
    )
    
    # Mark as enriched
    prayer_intention.mark_as_ai_enriched!(model_version: PerplexityApiService::DEFAULT_MODEL)
    
    Rails.logger.info \"Successfully enriched PrayerIntention ##{prayer_intention_id}\"
    
    # Notify user if they have FCM token (optional)
    notify_user_of_enrichment(prayer_intention) if prayer_intention.user.fcm_tokens.any?
    
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.error "PrayerIntention ##{prayer_intention_id} not found: #{e.message}"
    # Don't retry if record doesn't exist
  rescue StandardError => e
    Rails.logger.error "Failed to enrich PrayerIntention ##{prayer_intention_id}: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    raise # Re-raise for retry logic
  end
  
  private
  
  # Send notification to user about completed enrichment
  def notify_user_of_enrichment(prayer_intention)
    NotificationService.send_notification(
      user: prayer_intention.user,
      title: 'Prayer Enriched',
      body: "Your prayer '#{prayer_intention.title}' has been enriched with spiritual insights",
      data: {
        type: 'prayer_intention_enriched',
        prayer_intention_id: prayer_intention.id
      }
    )
  rescue StandardError => e
    # Don't fail the job if notification fails
    Rails.logger.warn "Failed to send enrichment notification: #{e.message}"
  end
end
