# Prayer Intentions Feature - Setup Documentation

## Overview

This feature adds prayer intentions functionality to the Estêvão API with Perplexity API integration for AI-enriched spiritual insights.

## Implementation Status

### ✅ Phase 1: Database & Model (COMPLETED)

#### Files Created

1. **Migration**: `db/migrate/20260128033000_create_prayer_intentions.rb`
2. **Model**: `app/models/prayer_intention.rb`
3. **Tests**: `spec/models/prayer_intention_spec.rb`
4. **Factory**: `spec/factories/prayer_intentions.rb`

### ✅ Phase 2: Perplexity API Service (COMPLETED)

#### Files Created

1. **Service**: `app/services/perplexity_api_service.rb`
2. **Tests**: `spec/services/perplexity_api_service_spec.rb`
3. **Background Job**: `app/jobs/enrich_prayer_intention_job.rb`
4. **Job Tests**: `spec/jobs/enrich_prayer_intention_job_spec.rb`

### ✅ Phase 3: API Endpoints (COMPLETED)

#### Files Created

1. **Controller**: `app/controllers/api/v1/prayer_intentions_controller.rb`
   - RESTful actions (index, show, create, update, destroy)
   - Custom actions (enrich, mark_answered, record_prayer, archive)
   - Collection endpoints (categories, stats, community)
   - Filtering, pagination, and search
   - Authentication and authorization

2. **Routes**: `config/routes.rb` (updated)
   - Member routes for custom actions
   - Collection routes for categories, stats, community
   - RESTful resource routes

3. **Request Specs**: `spec/requests/api/v1/prayer_intentions_spec.rb`
   - 100% endpoint coverage
   - Authentication and authorization tests
   - Permission and privacy tests
   - Error handling tests

## API Endpoints

### RESTful Endpoints

```
GET    /api/v1/prayer_intentions          # List user's prayer intentions
POST   /api/v1/prayer_intentions          # Create a new intention
GET    /api/v1/prayer_intentions/:id      # Show specific intention
PATCH  /api/v1/prayer_intentions/:id      # Update intention
DELETE /api/v1/prayer_intentions/:id      # Delete intention
```

### Custom Actions (Member Routes)

```
POST   /api/v1/prayer_intentions/:id/enrich              # Trigger AI enrichment
POST   /api/v1/prayer_intentions/:id/mark_answered       # Mark as answered
POST   /api/v1/prayer_intentions/:id/record_prayer       # Record prayer
POST   /api/v1/prayer_intentions/:id/archive             # Archive intention
```

### Collection Endpoints

```
GET    /api/v1/prayer_intentions/categories    # List available categories
GET    /api/v1/prayer_intentions/stats         # User statistics
GET    /api/v1/prayer_intentions/community     # Public community intentions
```

## API Usage Examples

### Authentication

All endpoints require Firebase JWT authentication:

```bash
curl -H "Authorization: Bearer YOUR_JWT_TOKEN" \
     https://api.example.com/api/v1/prayer_intentions
```

### List Prayer Intentions

```bash
# Basic list
GET /api/v1/prayer_intentions

# With filters
GET /api/v1/prayer_intentions?status=active&category=personal

# With search
GET /api/v1/prayer_intentions?search=healing

# With pagination
GET /api/v1/prayer_intentions?page=2&per_page=20

# Only AI enriched
GET /api/v1/prayer_intentions?enriched=true

# Ordered by prayer count
GET /api/v1/prayer_intentions?order_by=prayer_count&direction=desc
```

**Response:**
```json
{
  "prayer_intentions": [
    {
      "id": 123,
      "title": "Healing for my mother",
      "description": "Praying for complete healing",
      "status": "praying",
      "category": "intercession",
      "ai_enrichment": {
        "spiritual_context": "...",
        "related_scriptures": [...],
        "enriched_at": "2026-01-28T03:00:00Z"
      },
      "metadata": {
        "prayer_count": 15,
        "last_prayed_at": "2026-01-27T10:00:00Z",
        "is_private": true
      }
    }
  ],
  "meta": {
    "current_page": 1,
    "total_pages": 3,
    "total_count": 45,
    "per_page": 20
  }
}
```

### Create Prayer Intention

```bash
POST /api/v1/prayer_intentions
Content-Type: application/json

{
  "prayer_intention": {
    "title": "Healing for my mother",
    "description": "Praying for complete healing and restoration",
    "category": "intercession",
    "is_private": true,
    "allow_community_prayer": false
  },
  "auto_enrich": true
}
```

**Response (201 Created):**
```json
{
  "prayer_intention": { ... },
  "message": "Prayer intention created successfully"
}
```

### Update Prayer Intention

```bash
PATCH /api/v1/prayer_intentions/123

{
  "prayer_intention": {
    "title": "Updated title",
    "allow_community_prayer": true
  }
}
```

### Trigger AI Enrichment

```bash
POST /api/v1/prayer_intentions/123/enrich

# Force re-enrichment
POST /api/v1/prayer_intentions/123/enrich?force=true
```

**Response (202 Accepted):**
```json
{
  "message": "AI enrichment started. This may take a few moments.",
  "prayer_intention": { ... }
}
```

### Mark as Answered

```bash
POST /api/v1/prayer_intentions/123/mark_answered

{
  "answer_notes": "God provided healing through medical treatment and prayer"
}
```

### Record Prayer

```bash
POST /api/v1/prayer_intentions/123/record_prayer
```

**Response:**
```json
{
  "message": "Prayer recorded",
  "prayer_intention": {
    "id": 123,
    "metadata": {
      "prayer_count": 16,
      "last_prayed_at": "2026-01-28T03:30:00Z"
    }
  }
}
```

### Get User Statistics

```bash
GET /api/v1/prayer_intentions/stats
```

**Response:**
```json
{
  "stats": {
    "total": 45,
    "active": 12,
    "answered": 28,
    "archived": 5,
    "ai_enriched": 40,
    "total_prayers": 345,
    "current_streak": 7,
    "by_category": {
      "personal": 15,
      "family": 10,
      "community": 8,
      "world": 5,
      "thanksgiving": 4,
      "intercession": 3
    }
  }
}
```

### Browse Community Prayers

```bash
GET /api/v1/prayer_intentions/community?category=world&per_page=10
```

**Response:**
```json
{
  "prayer_intentions": [
    {
      "id": 456,
      "title": "Peace in the world",
      "category": "world",
      "metadata": {
        "is_private": false,
        "allow_community_prayer": true,
        "prayer_count": 125
      }
    }
  ],
  "meta": { ... }
}
```

## Filtering & Query Options

### Status Filters
- `status=pending` - Only pending intentions
- `status=praying` - Currently praying for
- `status=answered` - Answered prayers
- `status=archived` - Archived intentions
- `status=active` - Both pending and praying

### Category Filters
- `category=personal`
- `category=family`
- `category=community`
- `category=world`
- `category=thanksgiving`
- `category=intercession`

### Enrichment Filters
- `enriched=true` - Only AI enriched
- `enriched=false` - Not yet enriched

### Search
- `search=healing` - Search in title and description

### Ordering
- `order_by=created_at` - Default, newest first
- `order_by=recently_prayed` - Most recently prayed
- `order_by=prayer_count` - By number of prayers
- `direction=asc` or `direction=desc`

### Pagination
- `page=2` - Page number (default: 1)
- `per_page=50` - Items per page (max: 100, default: 20)

## Security & Permissions

### Privacy Levels

1. **Private Intentions** (`is_private: true`)
   - Only viewable by owner
   - Not shown in community feed
   - Cannot be prayed for by others unless `allow_community_prayer: true`

2. **Public Intentions** (`is_private: false`)
   - Visible to all authenticated users
   - Shown in community feed
   - Can be prayed for if `allow_community_prayer: true`

### Permission Matrix

| Action | Owner | Other User (Private) | Other User (Public) | Other User (Community Prayer) |
|--------|-------|---------------------|---------------------|------------------------------|
| View | ✅ | ❌ | ✅ | ✅ |
| Edit | ✅ | ❌ | ❌ | ❌ |
| Delete | ✅ | ❌ | ❌ | ❌ |
| Enrich | ✅ | ❌ | ❌ | ❌ |
| Mark Answered | ✅ | ❌ | ❌ | ❌ |
| Archive | ✅ | ❌ | ❌ | ❌ |
| Record Prayer | ✅ | ❌ | ❌ | ✅ |

## Error Responses

### 401 Unauthorized
```json
{
  "error": "Authentication required"
}
```

### 403 Forbidden
```json
{
  "error": "You do not have permission to access this prayer intention"
}
```

### 404 Not Found
```json
{
  "error": "Prayer intention not found"
}
```

### 422 Unprocessable Entity
```json
{
  "errors": [
    "Title is too short (minimum is 3 characters)",
    "Category is not included in the list"
  ]
}
```

## Database Schema

[Same as before - see earlier sections]

## Environment Variables

```bash
# Perplexity API
PERPLEXITY_API_KEY=pplx-your-api-key-here
PERPLEXITY_API_URL=https://api.perplexity.ai
```

## Running Tests

```bash
# All prayer intention tests
bundle exec rspec spec/models/prayer_intention_spec.rb \
                   spec/services/perplexity_api_service_spec.rb \
                   spec/jobs/enrich_prayer_intention_job_spec.rb \
                   spec/requests/api/v1/prayer_intentions_spec.rb

# Request specs only
bundle exec rspec spec/requests/api/v1/prayer_intentions_spec.rb

# With documentation format
bundle exec rspec spec/requests/api/v1/prayer_intentions_spec.rb --format documentation
```

## Next Steps

### 🔄 Phase 4: Frontend Integration (ordo-app) - NEXT

- [ ] Create Flutter models (PrayerIntention, PrayerIntentionRepository)
- [ ] Create API client methods
- [ ] Create UI screens (list, detail, create/edit)
- [ ] Add to navigation
- [ ] Implement state management (Provider)
- [ ] Add local caching with Isar
- [ ] Create widgets for AI enrichment display

## Deployment Checklist

Before deploying to production:

- [ ] Run migrations: `bin/rails db:migrate`
- [ ] Set environment variables (PERPLEXITY_API_KEY)
- [ ] Configure background job queue (Solid Queue)
- [ ] Set up monitoring for job failures
- [ ] Configure rate limiting for API endpoints
- [ ] Test Firebase authentication integration
- [ ] Verify permissions and privacy logic
- [ ] Test AI enrichment with real API key
- [ ] Review and update API documentation
- [ ] Set up error tracking (Sentry, Datadog, etc.)

## Performance Considerations

### Indexes
- All 7 database indexes are in place
- Query performance optimized for common filters

### Caching
- Consider caching:
  - AI-enriched data (already stored in DB)
  - User statistics
  - Community prayer list
  - Categories list

### Background Jobs
- AI enrichment runs async (doesn't block requests)
- Retry logic handles API failures
- Rate limiting prevents API abuse

### Pagination
- Default: 20 items per page
- Maximum: 100 items per page
- Prevents loading too much data at once

## Monitoring Metrics

Track these in production:

- **API Performance**
  - Request latency (p50, p95, p99)
  - Error rates by endpoint
  - Authentication failures

- **Prayer Intentions**
  - Total created per day/week
  - Answered prayer rate
  - Average prayer count
  - Community participation

- **AI Enrichment**
  - Enrichment success rate
  - Average enrichment time
  - Perplexity API costs
  - Failed enrichments

- **Background Jobs**
  - Queue depth
  - Job success/failure rate
  - Average processing time
  - Retry frequency

## Cost Estimation

### Perplexity API
- **Per intention**: ~$0.005 (5 API calls)
- **100 intentions/month**: $0.50
- **500 intentions/month**: $2.50
- **1,000 intentions/month**: $5.00

### Database Storage
- Minimal cost (text and JSON fields)
- Estimate: ~1KB per intention
- 10,000 intentions ≈ 10MB

## Support & Documentation

- Main README: [README.md](README.md)
- API Docs: `/api-docs` (Swagger - TBD)
- Model Schema: [schema.rb](db/schema.rb)
- Example Requests: This document

---

**Created**: 2026-01-28  
**Last Updated**: 2026-01-28  
**Status**: Phase 1, 2 & 3 Complete ✅  
**Next**: Phase 4 (Frontend Integration)

## Quick Start Guide

### 1. Run Migrations

```bash
bin/rails db:migrate
```

### 2. Set Environment Variables

```bash
echo "PERPLEXITY_API_KEY=your-key-here" >> .env
```

### 3. Start Rails Server

```bash
bin/rails server
```

### 4. Test Endpoints

```bash
# Get auth token (via your auth system)
TOKEN="your_jwt_token"

# Create a prayer intention
curl -X POST http://localhost:3000/api/v1/prayer_intentions \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "prayer_intention": {
      "title": "Healing prayer",
      "description": "For my family",
      "category": "family"
    },
    "auto_enrich": true
  }'

# List your intentions
curl http://localhost:3000/api/v1/prayer_intentions \
  -H "Authorization: Bearer $TOKEN"

# Get your stats
curl http://localhost:3000/api/v1/prayer_intentions/stats \
  -H "Authorization: Bearer $TOKEN"
```

### 5. Monitor Background Jobs

```bash
# Check job queue
bin/rails solid_queue:status

# Watch logs
tail -f log/development.log
```

---

**Backend Implementation Complete!** 🎉

All core functionality is ready:
- ✅ Database & Models
- ✅ AI Enrichment Service
- ✅ Background Processing
- ✅ RESTful API
- ✅ Comprehensive Tests

Ready for frontend integration! 🚀
