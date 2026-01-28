# frozen_string_literal: true

# Service for interacting with Perplexity API to generate Anglican-style prayers
# for prayer intentions
class PerplexityApiService
  include HTTParty
  
  base_uri ENV.fetch('PERPLEXITY_API_URL', 'https://api.perplexity.ai')
  
  # Rate limiting configuration
  MAX_REQUESTS_PER_MINUTE = 20
  RATE_LIMIT_WINDOW = 60.seconds
  
  # API configuration
  DEFAULT_MODEL = 'llama-3.1-sonar-large-128k-online'
  MAX_TOKENS = 1000
  TEMPERATURE = 0.7
  
  class PerplexityError < StandardError; end
  class RateLimitError < PerplexityError; end
  class AuthenticationError < PerplexityError; end
  class InvalidResponseError < PerplexityError; end
  
  def initialize(api_key: nil)
    @api_key = api_key || ENV['PERPLEXITY_API_KEY']
    raise PerplexityError, 'Perplexity API key not configured' if @api_key.blank?
    @request_count = 0
    @rate_limit_reset_at = Time.current + RATE_LIMIT_WINDOW
  end
  
  # Generate a complete Anglican daily office style prayer for the intention
  #
  # @param prayer_intention [PrayerIntention] The prayer intention
  # @return [String] Complete formatted prayer text
  def generate_prayer(prayer_intention)
    Rails.logger.info "Generating Anglican prayer for intention ##{prayer_intention.id}"
    
    prayer_text = prayer_intention.full_text
    category = prayer_intention.category || 'general'
    
    prompt = build_prayer_prompt(prayer_text, category)
    response = make_api_request(prompt, max_tokens: MAX_TOKENS)
    
    generated_prayer = extract_text_from_response(response)
    
    Rails.logger.info "Successfully generated prayer for intention ##{prayer_intention.id}"
    generated_prayer
  rescue StandardError => e
    Rails.logger.error "Failed to generate prayer for intention ##{prayer_intention.id}: #{e.message}"
    raise PerplexityError, "Prayer generation failed: #{e.message}"
  end
  
  private
  
  # Make API request to Perplexity
  def make_api_request(prompt, max_tokens: MAX_TOKENS, temperature: TEMPERATURE)
    check_rate_limit!
    
    headers = {
      'Authorization' => "Bearer #{@api_key}",
      'Content-Type' => 'application/json'
    }
    
    body = {
      model: DEFAULT_MODEL,
      messages: [
        {
          role: 'system',
          content: system_prompt
        },
        {
          role: 'user',
          content: prompt
        }
      ],
      max_tokens: max_tokens,
      temperature: temperature,
      top_p: 0.9,
      return_citations: false,
      return_images: false
    }
    
    Rails.logger.debug "Making Perplexity API request: #{prompt[0..100]}..."
    
    response = self.class.post(
      '/chat/completions',
      headers: headers,
      body: body.to_json,
      timeout: 30
    )
    
    increment_request_count!
    
    handle_response(response)
  rescue HTTParty::Error => e
    Rails.logger.error "Perplexity API request failed: #{e.message}"
    raise PerplexityError, "API request failed: #{e.message}"
  end
  
  # Handle API response and errors
  def handle_response(response)
    case response.code
    when 200
      response.parsed_response
    when 401
      raise AuthenticationError, 'Invalid API key'
    when 429
      raise RateLimitError, 'Rate limit exceeded'
    when 400..499
      error_message = response.parsed_response&.dig('error', 'message') || 'Client error'
      raise PerplexityError, error_message
    when 500..599
      raise PerplexityError, 'Perplexity API server error'
    else
      raise PerplexityError, "Unexpected response code: #{response.code}"
    end
  end
  
  # Extract text content from API response
  def extract_text_from_response(response)
    response.dig('choices', 0, 'message', 'content') || 
      raise(InvalidResponseError, 'Invalid response format')
  end
  
  # System prompt for Anglican prayer composition
  def system_prompt
    <<~PROMPT
      You are an Anglican priest and spiritual director skilled in composing prayers in the style of the Book of Common Prayer.
      
      Your task is to write complete, well-structured prayers that:
      - Follow traditional Anglican collect format when appropriate
      - Use reverent, dignified language
      - Include biblical imagery and themes
      - Are pastorally sensitive and theologically sound
      - Can be prayed aloud in daily office or private devotion
      
      Draw from the rich tradition of Anglican liturgy while making prayers personal and heartfelt.
    PROMPT
  end
  
  # Build prompt for prayer generation
  def build_prayer_prompt(prayer_text, category)
    <<~PROMPT
      Write a complete Anglican-style prayer for this #{category} prayer intention:
      
      "#{prayer_text}"
      
      Compose a prayer in the traditional Book of Common Prayer style that:
      1. Opens with an invocation addressing God with appropriate titles
      2. Acknowledges God's attributes relevant to this need
      3. States the petition clearly and specifically
      4. Includes thanksgiving or expression of trust
      5. Closes with a proper doxology ("through Jesus Christ our Lord" or similar)
      
      The prayer should be 3-5 sentences, suitable for daily office or personal devotion.
      Write only the prayer text, without commentary or explanation.
    PROMPT
  end
  
  # Rate limiting
  
  def check_rate_limit!
    reset_rate_limit_if_needed!
    
    if @request_count >= MAX_REQUESTS_PER_MINUTE
      wait_time = (@rate_limit_reset_at - Time.current).to_i
      raise RateLimitError, "Rate limit exceeded. Retry in #{wait_time} seconds"
    end
  end
  
  def increment_request_count!
    @request_count += 1
  end
  
  def reset_rate_limit_if_needed!
    if Time.current >= @rate_limit_reset_at
      @request_count = 0
      @rate_limit_reset_at = Time.current + RATE_LIMIT_WINDOW
    end
  end
end
