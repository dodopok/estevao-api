require 'rails_helper'

RSpec.describe PerplexityApiService do
  let(:api_key) { 'test_api_key' }
  let(:service) { described_class.new(api_key: api_key) }
  let(:user) { create(:user) }
  let(:prayer_intention) { create(:prayer_intention, user: user, title: 'Healing', description: 'For my mother') }
  
  before do
    allow(ENV).to receive(:[]).with('PERPLEXITY_API_KEY').and_return(api_key)
    allow(ENV).to receive(:[]).with('PERPLEXITY_API_URL').and_return('https://api.perplexity.ai')
    allow(ENV).to receive(:fetch).with('PERPLEXITY_API_URL', 'https://api.perplexity.ai').and_return('https://api.perplexity.ai')
  end
  
  describe '#initialize' do
    it 'initializes with API key' do
      expect(service.instance_variable_get(:@api_key)).to eq(api_key)
    end
    
    it 'raises error when API key is missing' do
      allow(ENV).to receive(:[]).with('PERPLEXITY_API_KEY').and_return(nil)
      expect { described_class.new }.to raise_error(PerplexityApiService::PerplexityError, 'Perplexity API key not configured')
    end
    
    it 'sets up rate limiting' do
      expect(service.instance_variable_get(:@request_count)).to eq(0)
      expect(service.instance_variable_get(:@rate_limit_reset_at)).to be_present
    end
  end
  
  describe '#enrich_prayer_intention' do
    let(:mock_spiritual_context) { 'This prayer reflects trust in God as healer...' }
    let(:mock_scriptures) do
      [
        {
          book: 'James',
          chapter: 5,
          verse: 14,
          reference: 'James 5:14',
          text: 'Is anyone among you sick? Let them call the elders...'
        }
      ]
    end
    let(:mock_prayers) do
      [
        {
          title: 'Prayer for Healing (BCP)',
          text: 'Heavenly Father, giver of life and health...'
        }
      ]
    end
    let(:mock_insights) { 'Christian theology understands healing as both physical and spiritual...' }
    let(:mock_prompts) { ['How can you support your loved one?', 'What comfort do you find in Scripture?'] }
    
    before do
      allow(service).to receive(:generate_spiritual_context).and_return(mock_spiritual_context)
      allow(service).to receive(:find_related_scriptures).and_return(mock_scriptures)
      allow(service).to receive(:suggest_traditional_prayers).and_return(mock_prayers)
      allow(service).to receive(:generate_theological_insights).and_return(mock_insights)
      allow(service).to receive(:generate_reflection_prompts).and_return(mock_prompts)
    end
    
    it 'enriches prayer intention with all components' do
      result = service.enrich_prayer_intention(prayer_intention)
      
      expect(result[:spiritual_context]).to eq(mock_spiritual_context)
      expect(result[:related_scriptures]).to eq(mock_scriptures)
      expect(result[:suggested_prayers]).to eq(mock_prayers)
      expect(result[:theological_insights]).to eq(mock_insights)
      expect(result[:reflection_prompts]).to eq(mock_prompts)
    end
    
    it 'logs the enrichment process' do
      expect(Rails.logger).to receive(:info).with(/Enriching prayer intention ##{prayer_intention.id}/)
      expect(Rails.logger).to receive(:info).with(/Successfully enriched prayer intention ##{prayer_intention.id}/)
      
      service.enrich_prayer_intention(prayer_intention)
    end
    
    it 'handles errors gracefully' do
      allow(service).to receive(:generate_spiritual_context).and_raise(StandardError, 'API Error')
      
      expect(Rails.logger).to receive(:error).with(/Failed to enrich prayer intention/)
      expect { service.enrich_prayer_intention(prayer_intention) }
        .to raise_error(PerplexityApiService::PerplexityError, /Enrichment failed: API Error/)
    end
  end
  
  describe '#generate_spiritual_context' do
    let(:mock_response) do
      {
        'choices' => [
          {
            'message' => {
              'content' => 'Biblical perspective on healing...'
            }
          }
        ]
      }
    end
    
    before do
      allow(service).to receive(:make_api_request).and_return(mock_response)
    end
    
    it 'generates spiritual context' do
      result = service.generate_spiritual_context('Prayer for healing', 'intercession')
      expect(result).to eq('Biblical perspective on healing...')
    end
    
    it 'calls API with appropriate prompt' do
      expect(service).to receive(:make_api_request).with(
        include('prayer intention'),
        max_tokens: 500
      ).and_return(mock_response)
      
      service.generate_spiritual_context('Prayer text', 'personal')
    end
  end
  
  describe '#find_related_scriptures' do
    let(:scripture_text) do
      <<~TEXT
        SCRIPTURE:
        Book: Psalms
        Chapter: 23
        Verse: 1
        Reference: Psalm 23:1
        Text: The Lord is my shepherd; I shall not want.
        ---
        SCRIPTURE:
        Book: Matthew
        Chapter: 6
        Verse: 9
        Reference: Matthew 6:9
        Text: Our Father in heaven, hallowed be your name.
      TEXT
    end
    
    let(:mock_response) do
      {
        'choices' => [
          {
            'message' => {
              'content' => scripture_text
            }
          }
        ]
      }
    end
    
    before do
      allow(service).to receive(:make_api_request).and_return(mock_response)
    end
    
    it 'finds and parses related scriptures' do
      result = service.find_related_scriptures('Prayer text', 'thanksgiving')
      
      expect(result).to be_an(Array)
      expect(result.length).to eq(2)
      expect(result.first[:book]).to eq('Psalms')
      expect(result.first[:chapter]).to eq(23)
      expect(result.first[:verse]).to eq(1)
      expect(result.first[:text]).to include('shepherd')
    end
    
    it 'returns default scriptures if parsing fails' do
      allow(service).to receive(:make_api_request).and_return({
        'choices' => [{ 'message' => { 'content' => 'Invalid format' } }]
      })
      
      result = service.find_related_scriptures('Prayer text', 'personal')
      expect(result).to be_an(Array)
      expect(result.first[:book]).to eq('Philippians')
    end
  end
  
  describe '#suggest_traditional_prayers' do
    let(:prayers_text) do
      <<~TEXT
        PRAYER:
        Title: Collect for Peace (BCP)
        Text: O God, the author of peace and lover of concord...
        ---
        PRAYER:
        Title: Prayer for Guidance
        Text: Direct us, O Lord, in all our doings...
      TEXT
    end
    
    let(:mock_response) do
      {
        'choices' => [
          {
            'message' => {
              'content' => prayers_text
            }
          }
        ]
      }
    end
    
    before do
      allow(service).to receive(:make_api_request).and_return(mock_response)
    end
    
    it 'suggests and parses traditional prayers' do
      result = service.suggest_traditional_prayers('Prayer text', 'community')
      
      expect(result).to be_an(Array)
      expect(result.length).to eq(2)
      expect(result.first[:title]).to eq('Collect for Peace (BCP)')
      expect(result.first[:text]).to include('author of peace')
    end
  end
  
  describe '#generate_theological_insights' do
    let(:mock_response) do
      {
        'choices' => [
          {
            'message' => {
              'content' => 'Theological understanding of prayer...'
            }
          }
        ]
      }
    end
    
    before do
      allow(service).to receive(:make_api_request).and_return(mock_response)
    end
    
    it 'generates theological insights' do
      result = service.generate_theological_insights('Prayer text', 'world')
      expect(result).to eq('Theological understanding of prayer...')
    end
  end
  
  describe '#generate_reflection_prompts' do
    let(:prompts_text) do
      <<~TEXT
        Q: How does this prayer reflect your trust in God?
        Q: What Scripture passages bring you comfort?
        Q: In what ways can you grow through this situation?
      TEXT
    end
    
    let(:mock_response) do
      {
        'choices' => [
          {
            'message' => {
              'content' => prompts_text
            }
          }
        ]
      }
    end
    
    before do
      allow(service).to receive(:make_api_request).and_return(mock_response)
    end
    
    it 'generates and parses reflection prompts' do
      result = service.generate_reflection_prompts('Prayer text', 'family')
      
      expect(result).to be_an(Array)
      expect(result.length).to eq(3)
      expect(result.first).to eq('How does this prayer reflect your trust in God?')
    end
  end
  
  describe 'API request handling' do
    let(:valid_response) do
      instance_double(HTTParty::Response, code: 200, parsed_response: {
        'choices' => [{ 'message' => { 'content' => 'Response text' } }]
      })
    end
    
    before do
      allow(described_class).to receive(:post).and_return(valid_response)
    end
    
    it 'makes successful API request' do
      result = service.send(:make_api_request, 'Test prompt')
      expect(result['choices']).to be_present
    end
    
    it 'includes authorization header' do
      expect(described_class).to receive(:post).with(
        anything,
        hash_including(headers: hash_including('Authorization' => "Bearer #{api_key}")),
        anything
      ).and_return(valid_response)
      
      service.send(:make_api_request, 'Test prompt')
    end
    
    it 'uses correct model and parameters' do
      expect(described_class).to receive(:post).with(
        anything,
        hash_including(body: include('llama-3.1-sonar-large-128k-online')),
        anything
      ).and_return(valid_response)
      
      service.send(:make_api_request, 'Test prompt')
    end
  end
  
  describe 'error handling' do
    it 'handles authentication errors' do
      error_response = instance_double(HTTParty::Response, code: 401, parsed_response: {})
      allow(described_class).to receive(:post).and_return(error_response)
      
      expect { service.send(:make_api_request, 'Test') }
        .to raise_error(PerplexityApiService::AuthenticationError, 'Invalid API key')
    end
    
    it 'handles rate limit errors' do
      error_response = instance_double(HTTParty::Response, code: 429, parsed_response: {})
      allow(described_class).to receive(:post).and_return(error_response)
      
      expect { service.send(:make_api_request, 'Test') }
        .to raise_error(PerplexityApiService::RateLimitError, 'Rate limit exceeded')
    end
    
    it 'handles server errors' do
      error_response = instance_double(HTTParty::Response, code: 500, parsed_response: {})
      allow(described_class).to receive(:post).and_return(error_response)
      
      expect { service.send(:make_api_request, 'Test') }
        .to raise_error(PerplexityApiService::PerplexityError, 'Perplexity API server error')
    end
    
    it 'handles invalid response format' do
      invalid_response = { 'invalid' => 'structure' }
      
      expect { service.send(:extract_text_from_response, invalid_response) }
        .to raise_error(PerplexityApiService::InvalidResponseError, 'Invalid response format')
    end
  end
  
  describe 'rate limiting' do
    it 'tracks request count' do
      allow(described_class).to receive(:post).and_return(
        instance_double(HTTParty::Response, code: 200, parsed_response: {
          'choices' => [{ 'message' => { 'content' => 'Text' } }]
        })
      )
      
      expect { service.send(:make_api_request, 'Test') }
        .to change { service.instance_variable_get(:@request_count) }.by(1)
    end
    
    it 'raises error when rate limit exceeded' do
      service.instance_variable_set(:@request_count, 20)
      service.instance_variable_set(:@rate_limit_reset_at, 1.minute.from_now)
      
      expect { service.send(:check_rate_limit!) }
        .to raise_error(PerplexityApiService::RateLimitError, /Rate limit exceeded/)
    end
    
    it 'resets rate limit after time window' do
      service.instance_variable_set(:@request_count, 20)
      service.instance_variable_set(:@rate_limit_reset_at, 1.second.ago)
      
      service.send(:reset_rate_limit_if_needed!)
      expect(service.instance_variable_get(:@request_count)).to eq(0)
    end
  end
  
  describe 'system prompt' do
    it 'includes Anglican theological context' do
      prompt = service.send(:system_prompt)
      expect(prompt).to include('Anglican theologian')
      expect(prompt).to include('Book of Common Prayer')
      expect(prompt).to include('Holy Scripture')
    end
  end
  
  describe 'prompt builders' do
    it 'builds spiritual context prompt' do
      prompt = service.send(:build_spiritual_context_prompt, 'Healing prayer', 'intercession')
      expect(prompt).to include('Healing prayer')
      expect(prompt).to include('intercession')
      expect(prompt).to include('biblical')
    end
    
    it 'builds scripture prompt' do
      prompt = service.send(:build_scripture_prompt, 'Prayer text', 'thanksgiving')
      expect(prompt).to include('Bible verses')
      expect(prompt).to include('thanksgiving')
    end
    
    it 'builds traditional prayers prompt' do
      prompt = service.send(:build_traditional_prayers_prompt, 'Prayer text', 'family')
      expect(prompt).to include('traditional Christian prayers')
      expect(prompt).to include('Book of Common Prayer')
    end
    
    it 'builds theological insights prompt' do
      prompt = service.send(:build_theological_insights_prompt, 'Prayer text', 'world')
      expect(prompt).to include('theological')
      expect(prompt).to include('Christian tradition')
    end
    
    it 'builds reflection prompts prompt' do
      prompt = service.send(:build_reflection_prompts_prompt, 'Prayer text', 'personal')
      expect(prompt).to include('reflection questions')
      expect(prompt).to include('spiritual reflection')
    end
  end
  
  describe 'default fallbacks' do
    it 'provides default scriptures' do
      scriptures = service.send(:default_scriptures)
      expect(scriptures).to be_an(Array)
      expect(scriptures.first).to have_key(:book)
      expect(scriptures.first).to have_key(:text)
    end
    
    it 'provides default prayers' do
      prayers = service.send(:default_prayers)
      expect(prayers).to be_an(Array)
      expect(prayers.first).to have_key(:title)
      expect(prayers.first).to have_key(:text)
    end
    
    it 'provides default reflection prompts' do
      prompts = service.send(:default_reflection_prompts)
      expect(prompts).to be_an(Array)
      expect(prompts.first).to be_a(String)
    end
  end
end
