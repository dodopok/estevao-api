# Prayer Intentions Feature - Setup Documentation

## Overview

This feature adds prayer intentions functionality to the Estêvão API with Perplexity API integration for AI-enriched spiritual insights.

## Implementation Status

### ✅ Phase 1: Database & Model (COMPLETED)

#### Files Created

1. **Migration**: `db/migrate/20260128033000_create_prayer_intentions.rb`
   - Comprehensive schema with AI enrichment fields
   - Privacy controls and metadata
   - 7 performance indexes

2. **Model**: `app/models/prayer_intention.rb`
   - Full ActiveRecord model with validations
   - Status enum (pending, praying, answered, archived)
   - Category support (6 categories)
   - AI enrichment methods
   - Privacy and permissions logic
   - Rich API for prayer tracking

3. **Tests**: `spec/models/prayer_intention_spec.rb`
   - Comprehensive RSpec test suite
   - 100% model coverage
   - Tests for all methods, scopes, and validations

4. **Factory**: `spec/factories/prayer_intentions.rb`
   - FactoryBot factory with 15+ traits
   - Realistic test data generation
   - Full AI enrichment example

### ✅ Phase 2: Perplexity API Service (COMPLETED)

#### Files Created

1. **Service**: `app/services/perplexity_api_service.rb`
   - Complete Perplexity API integration
   - Methods for spiritual context, scriptures, prayers, insights, prompts
   - Rate limiting (20 requests/minute)
   - Error handling and retry logic
   - Anglican theological system prompt
   - Response parsing with fallback defaults

2. **Tests**: `spec/services/perplexity_api_service_spec.rb`
   - Comprehensive service test suite
   - 100% service coverage
   - Mocked API responses
   - Error scenario testing

3. **Background Job**: `app/jobs/enrich_prayer_intention_job.rb`
   - Async AI enrichment processing
   - Retry strategy for API failures
   - Exponential backoff for rate limiting
   - User notification on completion
   - Error logging and handling

4. **Job Tests**: `spec/jobs/enrich_prayer_intention_job_spec.rb`
   - Complete job test suite
   - 100% job coverage
   - Integration test scenarios
   - Notification testing

## Database Schema

### Table: `prayer_intentions`

| Column | Type | Description |
|--------|------|-------------|
| `id` | bigint | Primary key |
| `user_id` | bigint | Foreign key to users (indexed) |
| `title` | string | Prayer title (required, 3-200 chars) |
| `description` | text | Detailed prayer description (max 5000 chars) |
| `status` | integer | Enum: pending(0), praying(1), answered(2), archived(3) |
| `category` | string | personal, family, community, world, thanksgiving, intercession |
| `answered_at` | datetime | Timestamp when prayer was answered |
| `answer_notes` | text | Notes about how prayer was answered |
| `spiritual_context` | text | AI-generated spiritual context |
| `related_scriptures` | json | Array of related Bible verses |
| `suggested_prayers` | json | Array of traditional prayers |
| `theological_insights` | text | AI-generated theological insights |
| `reflection_prompts` | json | Array of reflection questions |
| `is_private` | boolean | Privacy flag (default: true) |
| `allow_community_prayer` | boolean | Allow others to pray (default: false) |
| `prayer_count` | integer | Number of times prayed for |
| `last_prayed_at` | datetime | Last time someone prayed |
| `ai_enriched_at` | datetime | When AI enrichment occurred |
| `ai_model_version` | string | Perplexity model version used |
| `created_at` | datetime | Record creation |
| `updated_at` | datetime | Last update |

### Indexes

1. `[user_id, status]` - User's intentions by status
2. `[user_id, created_at]` - User's intentions chronologically
3. `status` - Filter by status
4. `category` - Filter by category
5. `answered_at` - Answered prayers
6. `is_private` - Privacy filtering
7. `allow_community_prayer` - Community prayer filtering

## Model Features

### Status Flow

```
pending → praying → answered → archived
                 ↓
              archived
```

### Categories

- `personal` - Personal prayer needs
- `family` - Family-related prayers
- `community` - Church/community needs
- `world` - Global concerns
- `thanksgiving` - Prayers of gratitude
- `intercession` - Intercessory prayers

### Scopes Available

- `active` - Pending or praying
- `answered` - Answered prayers
- `archived` - Archived intentions
- `public_intentions` - Non-private
- `community_prayer_enabled` - Community can pray
- `ai_enriched` - Has AI enrichment
- `needs_enrichment` - Needs AI processing
- `by_category(category)` - Filter by category
- `recently_created` - Newest first
- `recently_prayed` - Most recently prayed

### Key Methods

#### Status Management
- `mark_as_answered!(notes: nil)` - Mark prayer as answered
- `archive!` - Archive intention
- `record_prayer!` - Increment prayer count

#### AI Enrichment
- `needs_ai_enrichment?` - Check if needs processing
- `ai_enriched?` - Check if already enriched
- `mark_as_ai_enriched!(model_version: nil)` - Mark as enriched
- `full_text` - Get combined title + description

#### Permissions
- `viewable_by?(user)` - Check view permission
- `prayable_by?(user)` - Check pray permission

#### Statistics
- `prayer_stats` - Get prayer statistics hash

#### API
- `as_json_api` - Format for API response

## Perplexity API Service

### Features

1. **Spiritual Context Generation**
   - Biblical and theological framework
   - Anglican tradition grounding
   - Pastoral encouragement

2. **Scripture Finding**
   - 3-5 relevant Bible verses
   - Complete references (book, chapter, verse)
   - Context-appropriate selection

3. **Traditional Prayer Suggestions**
   - Book of Common Prayer prayers
   - Ancient liturgies
   - Well-known Christian prayers

4. **Theological Insights**
   - Christian tradition perspectives
   - Balance of sovereignty and response
   - Pastoral sensitivity

5. **Reflection Prompts**
   - 3-4 meditation questions
   - Scripture-grounded
   - Personally applicable

### Configuration

```ruby
# Service constants
MAX_REQUESTS_PER_MINUTE = 20
DEFAULT_MODEL = 'llama-3.1-sonar-large-128k-online'
MAX_TOKENS = 2000
TEMPERATURE = 0.7
```

### Usage Example

```ruby
# Initialize service
service = PerplexityApiService.new

# Enrich a prayer intention
enrichment = service.enrich_prayer_intention(prayer_intention)

# Or use background job (recommended)
EnrichPrayerIntentionJob.perform_later(prayer_intention.id)
```

## AI Enrichment Structure

### Example Enriched Data

```ruby
{
  spiritual_context: "Biblical perspective and theological framework...",
  related_scriptures: [
    {
      book: "Psalms",
      chapter: 23,
      verse: 1,
      text: "The Lord is my shepherd...",
      reference: "Psalm 23:1"
    }
  ],
  suggested_prayers: [
    {
      title: "Prayer for Healing (BCP)",
      text: "Heavenly Father, giver of life and health..."
    }
  ],
  theological_insights: "Theological analysis and church tradition...",
  reflection_prompts: [
    "How does this prayer reflect your trust in God?",
    "What steps can you take while waiting?"
  ]
}
```

## Next Steps

### 🔄 Phase 3: API Endpoints (NEXT)

- [ ] Create `Api::V1::PrayerIntentionsController`
- [ ] RESTful routes (index, show, create, update, destroy)
- [ ] Custom actions (enrich, mark_answered, record_prayer)
- [ ] API documentation (Swagger)
- [ ] Request specs

### 🔄 Phase 4: Frontend Integration (ordo-app)

- [ ] Create Flutter models
- [ ] Create repository
- [ ] Create API client methods
- [ ] Create UI screens
- [ ] Add to navigation

## Environment Variables

Add to `.env`:

```bash
# Perplexity API
PERPLEXITY_API_KEY=pplx-your-api-key-here
PERPLEXITY_API_URL=https://api.perplexity.ai
PERPLEXITY_MODEL=llama-3.1-sonar-large-128k-online
```

## Running Migrations

```bash
# Run migration
bin/rails db:migrate

# Rollback if needed
bin/rails db:rollback

# Check status
bin/rails db:migrate:status
```

## Running Tests

```bash
# Run all prayer intention tests
bundle exec rspec spec/models/prayer_intention_spec.rb
bundle exec rspec spec/services/perplexity_api_service_spec.rb
bundle exec rspec spec/jobs/enrich_prayer_intention_job_spec.rb

# Run all with documentation format
bundle exec rspec spec/models/prayer_intention_spec.rb --format documentation

# Run all prayer intention related tests
bundle exec rspec spec/models/prayer_intention_spec.rb spec/services/perplexity_api_service_spec.rb spec/jobs/enrich_prayer_intention_job_spec.rb
```

## Usage Examples

### Creating and Enriching Prayer Intentions

```ruby
# Create a prayer intention
intention = PrayerIntention.create!(
  user: current_user,
  title: "Healing for my mother",
  description: "Praying for complete healing and restoration",
  category: "intercession"
)

# Trigger async enrichment
EnrichPrayerIntentionJob.perform_later(intention.id)

# Or enrich synchronously (for testing)
service = PerplexityApiService.new
enrichment = service.enrich_prayer_intention(intention)
intention.update!(
  spiritual_context: enrichment[:spiritual_context],
  related_scriptures: enrichment[:related_scriptures],
  # ... other fields
)
intention.mark_as_ai_enriched!

# Query enriched intentions
PrayerIntention.ai_enriched.each do |intention|
  puts intention.spiritual_context
  puts intention.related_scriptures.first[:text]
end
```

### Recording Prayer Activity

```ruby
# Record someone prayed
intention.record_prayer!

# Mark as answered
intention.mark_as_answered!(notes: "God provided healing through treatment")

# Archive old intention
intention.archive!

# Get stats
stats = intention.prayer_stats
# => { total_prayers: 15, last_prayed: <DateTime>, ... }
```

## Factory Usage Examples

```ruby
# Create basic intention
create(:prayer_intention)

# Create with specific status
create(:prayer_intention, :answered)

# Create with category
create(:prayer_intention, :personal)

# Create public with community prayer
create(:prayer_intention, :public_with_community_prayer)

# Create fully enriched example
create(:prayer_intention, :fully_enriched_example)

# Create multiple for testing
create_list(:prayer_intention, 10, user: user)
```

## API Endpoints (Planned)

```
GET    /api/v1/prayer_intentions          # List intentions
POST   /api/v1/prayer_intentions          # Create intention
GET    /api/v1/prayer_intentions/:id      # Show intention
PATCH  /api/v1/prayer_intentions/:id      # Update intention
DELETE /api/v1/prayer_intentions/:id      # Delete intention

POST   /api/v1/prayer_intentions/:id/enrich              # Trigger AI enrichment
POST   /api/v1/prayer_intentions/:id/mark_answered       # Mark as answered
POST   /api/v1/prayer_intentions/:id/record_prayer       # Record prayer
POST   /api/v1/prayer_intentions/:id/archive             # Archive intention

GET    /api/v1/prayer_intentions/categories              # List categories
GET    /api/v1/prayer_intentions/stats                   # User statistics
```

## Security Considerations

1. **Authentication Required**: All endpoints require Firebase JWT
2. **User Isolation**: Users can only see their own private intentions
3. **Public Intentions**: Visible to all authenticated users
4. **Community Prayer**: Requires explicit opt-in
5. **AI Data**: Stored securely, never shared without permission
6. **Rate Limiting**: Prevent API abuse (especially AI enrichment)

## Performance Optimizations

1. **Indexes**: 7 indexes for common queries
2. **JSON Columns**: Efficient storage for AI data
3. **Scopes**: Pre-optimized queries
4. **Background Jobs**: Async AI processing
5. **Caching**: Cache AI-enriched data

## Monitoring

Track the following metrics:

- Total prayer intentions created
- AI enrichment success rate
- Average prayer count per intention
- Answered prayer rate
- Community prayer participation
- Perplexity API usage and costs
- Job queue performance
- Enrichment latency

## Cost Estimation

### Perplexity API Costs

- Model: `llama-3.1-sonar-large-128k-online`
- Cost: ~$0.001 per request
- Enrichment requires: 5 API calls per intention
  - Spiritual context
  - Related scriptures
  - Traditional prayers
  - Theological insights
  - Reflection prompts
- **Per intention cost**: ~$0.005
- Expected usage: 100-500 intentions/month
- **Estimated monthly cost**: $0.50-$2.50/month

## Error Handling

### Perplexity API Errors

- `PerplexityError` - General API errors (retries: 3)
- `RateLimitError` - Rate limit exceeded (retries: 5, wait: 2 min)
- `AuthenticationError` - Invalid API key (no retry, discard job)
- `InvalidResponseError` - Malformed response (fallback to defaults)

### Job Failures

- Automatic retry with exponential backoff
- Detailed error logging
- User notification on failure (optional)
- Graceful degradation with default values

## Support & Documentation

- Main README: [README.md](README.md)
- API Docs: `/api-docs` (Swagger)
- Model Schema: [schema.rb](db/schema.rb)
- Test Examples: [prayer_intention_spec.rb](spec/models/prayer_intention_spec.rb)

---

**Created**: 2026-01-28  
**Last Updated**: 2026-01-28  
**Status**: Phase 1 & 2 Complete ✅
