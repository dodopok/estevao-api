# frozen_string_literal: true

# Service for interacting with Perplexity API to enrich prayer intentions
# with spiritual context, scripture references, and theological insights
class PerplexityApiService
  include HTTParty
  
  base_uri ENV.fetch('PERPLEXITY_API_URL', 'https://api.perplexity.ai')
  
  # Rate limiting configuration
  MAX_REQUESTS_PER_MINUTE = 20
  RATE_LIMIT_WINDOW = 60.seconds
  
  # API configuration
  DEFAULT_MODEL = 'llama-3.1-sonar-large-128k-online'
  MAX_TOKENS = 2000
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
  
  # Main method to enrich a prayer intention with AI-generated insights
  #
  # @param prayer_intention [PrayerIntention] The prayer intention to enrich
  # @return [Hash] Enrichment data with spiritual_context, related_scriptures, etc.
  def enrich_prayer_intention(prayer_intention)
    Rails.logger.info "Enriching prayer intention ##{prayer_intention.id} with Perplexity AI"
    
    prayer_text = prayer_intention.full_text
    category = prayer_intention.category || 'general'
    
    # Generate all enrichment components
    enrichment_data = {
      spiritual_context: generate_spiritual_context(prayer_text, category),
      related_scriptures: find_related_scriptures(prayer_text, category),
      suggested_prayers: suggest_traditional_prayers(prayer_text, category),
      theological_insights: generate_theological_insights(prayer_text, category),
      reflection_prompts: generate_reflection_prompts(prayer_text, category)
    }
    
    Rails.logger.info "Successfully enriched prayer intention ##{prayer_intention.id}"
    enrichment_data
  rescue StandardError => e
    Rails.logger.error "Failed to enrich prayer intention ##{prayer_intention.id}: #{e.message}"
    raise PerplexityError, "Enrichment failed: #{e.message}"
  end
  
  # Generate spiritual context and biblical framework for the prayer
  #
  # @param prayer_text [String] The prayer text
  # @param category [String] The prayer category
  # @return [String] Spiritual context explanation
  def generate_spiritual_context(prayer_text, category = 'general')
    prompt = build_spiritual_context_prompt(prayer_text, category)
    response = make_api_request(prompt, max_tokens: 500)
    
    extract_text_from_response(response)
  end
  
  # Find related scripture passages for the prayer
  #
  # @param prayer_text [String] The prayer text
  # @param category [String] The prayer category
  # @return [Array<Hash>] Array of scripture references with book, chapter, verse, text
  def find_related_scriptures(prayer_text, category = 'general')
    prompt = build_scripture_prompt(prayer_text, category)
    response = make_api_request(prompt, max_tokens: 800)
    
    parse_scripture_response(extract_text_from_response(response))
  end
  
  # Suggest traditional prayers related to the intention
  #
  # @param prayer_text [String] The prayer text
  # @param category [String] The prayer category
  # @return [Array<Hash>] Array of suggested prayers with title and text
  def suggest_traditional_prayers(prayer_text, category = 'general')
    prompt = build_traditional_prayers_prompt(prayer_text, category)
    response = make_api_request(prompt, max_tokens: 600)
    
    parse_prayers_response(extract_text_from_response(response))
  end
  
  # Generate theological insights about the prayer
  #
  # @param prayer_text [String] The prayer text
  # @param category [String] The prayer category
  # @return [String] Theological insights and analysis
  def generate_theological_insights(prayer_text, category = 'general')
    prompt = build_theological_insights_prompt(prayer_text, category)
    response = make_api_request(prompt, max_tokens: 500)
    
    extract_text_from_response(response)
  end
  
  # Generate reflection prompts for meditation
  #
  # @param prayer_text [String] The prayer text
  # @param category [String] The prayer category
  # @return [Array<String>] Array of reflection questions
  def generate_reflection_prompts(prayer_text, category = 'general')
    prompt = build_reflection_prompts_prompt(prayer_text, category)
    response = make_api_request(prompt, max_tokens: 400)
    
    parse_reflection_prompts(extract_text_from_response(response))
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
  
  # System prompt for Anglican/Christian context
  def system_prompt
    <<~PROMPT
      You are a knowledgeable Anglican theologian and spiritual director with deep understanding of:
      - Holy Scripture (Bible)
      - Book of Common Prayer traditions
      - Christian theology and doctrine
      - Spiritual formation and prayer
      - Church history and liturgy
      
      Provide thoughtful, compassionate, and theologically sound guidance rooted in the Anglican tradition.
      Use accessible language while maintaining theological depth.
      Always ground your responses in Scripture and church tradition.
    PROMPT
  end
  
  # Prompt templates
  
  def build_spiritual_context_prompt(prayer_text, category)
    <<~PROMPT
      Analyze this #{category} prayer intention and provide spiritual context:
      
      "#{prayer_text}"
      
      Provide a 2-3 paragraph explanation that:
      1. Explains the biblical and theological foundation for this type of prayer
      2. Connects it to Christian spiritual tradition
      3. Offers encouragement and perspective
      
      Keep the tone pastoral, warm, and faith-building.
    PROMPT
  end
  
  def build_scripture_prompt(prayer_text, category)
    <<~PROMPT
      Find 3-5 relevant Bible verses for this #{category} prayer:
      
      "#{prayer_text}"
      
      For each verse, provide:
      - Book name
      - Chapter number
      - Verse number
      - The verse text
      - Brief reference (e.g., "Psalm 23:1")
      
      Format each as:
      SCRIPTURE:
      Book: [book name]
      Chapter: [number]
      Verse: [number]
      Reference: [Book Chapter:Verse]
      Text: [verse text]
      ---
      
      Choose verses that directly speak to the prayer need and offer comfort, hope, or guidance.
    PROMPT
  end
  
  def build_traditional_prayers_prompt(prayer_text, category)
    <<~PROMPT
      Suggest 1-2 traditional Christian prayers related to this #{category} intention:
      
      "#{prayer_text}"
      
      For each prayer, provide:
      - Prayer title (e.g., "Prayer for Healing - Book of Common Prayer")
      - The prayer text
      
      Format as:
      PRAYER:
      Title: [prayer title]
      Text: [prayer text]
      ---
      
      Prefer prayers from Book of Common Prayer, ancient liturgies, or well-known Christian prayers.
    PROMPT
  end
  
  def build_theological_insights_prompt(prayer_text, category)
    <<~PROMPT
      Provide theological insights for this #{category} prayer:
      
      "#{prayer_text}"
      
      Write 2-3 paragraphs addressing:
      1. Theological understanding of this prayer need
      2. How Christian tradition approaches this topic
      3. Balance between divine sovereignty and human response
      
      Be pastorally sensitive while theologically robust.
    PROMPT
  end
  
  def build_reflection_prompts_prompt(prayer_text, category)
    <<~PROMPT
      Create 3-4 reflection questions for someone praying about:
      
      "#{prayer_text}"
      
      Format each question on a new line starting with "Q:"
      
      Questions should:
      - Encourage deeper spiritual reflection
      - Connect to Scripture and tradition
      - Be personally applicable
      - Foster growth in faith
      
      Example format:
      Q: How does this prayer reflect your trust in God's timing?
      Q: What Scripture passages bring you comfort in this situation?
    PROMPT
  end
  
  # Response parsers
  
  def parse_scripture_response(text)
    scriptures = []
    
    text.split('---').each do |section|
      next unless section.include?('SCRIPTURE:')
      
      scripture = {}
      section.scan(/Book:\s*(.+)/) { |m| scripture[:book] = m[0].strip }
      section.scan(/Chapter:\s*(\d+)/) { |m| scripture[:chapter] = m[0].to_i }
      section.scan(/Verse:\s*(\d+)/) { |m| scripture[:verse] = m[0].to_i }
      section.scan(/Reference:\s*(.+)/) { |m| scripture[:reference] = m[0].strip }
      section.scan(/Text:\s*(.+?)(?=Book:|Chapter:|Verse:|Reference:|---|$)/m) { |m| scripture[:text] = m[0].strip }
      
      scriptures << scripture if scripture[:book] && scripture[:text]
    end
    
    scriptures.presence || default_scriptures
  end
  
  def parse_prayers_response(text)
    prayers = []
    
    text.split('---').each do |section|
      next unless section.include?('PRAYER:')
      
      prayer = {}
      section.scan(/Title:\s*(.+)/) { |m| prayer[:title] = m[0].strip }
      section.scan(/Text:\s*(.+?)(?=Title:|---|$)/m) { |m| prayer[:text] = m[0].strip }
      
      prayers << prayer if prayer[:title] && prayer[:text]
    end
    
    prayers.presence || default_prayers
  end
  
  def parse_reflection_prompts(text)
    prompts = text.scan(/Q:\s*(.+)/).flatten.map(&:strip)
    prompts.presence || default_reflection_prompts
  end
  
  # Fallback defaults if parsing fails
  
  def default_scriptures
    [
      {
        book: 'Philippians',
        chapter: 4,
        verse: 6,
        reference: 'Philippians 4:6',
        text: 'Do not be anxious about anything, but in every situation, by prayer and petition, with thanksgiving, present your requests to God.'
      }
    ]
  end
  
  def default_prayers
    [
      {
        title: 'Collect for Peace (Book of Common Prayer)',
        text: 'O God, the author of peace and lover of concord, to know you is eternal life and to serve you is perfect freedom...'
      }
    ]
  end
  
  def default_reflection_prompts
    [
      'How does this prayer deepen your relationship with God?',
      'What Scripture passages speak to your heart about this need?',
      'In what ways can you trust God while waiting for an answer?'
    ]
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
