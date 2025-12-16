# Daily Office Performance Optimizations

This document describes the performance optimizations implemented for the Daily Office, Reading, and Calendar services.

## Overview

The Daily Office API is one of the most frequently used endpoints in the application. Performance optimizations ensure fast response times and efficient resource usage.

## Database Optimizations

### Added Indexes (Migration: 20251213043607)

1. **LectionaryReading Composite Index**
   - Columns: `[:cycle, :service_type, :prayer_book_id, :date_reference]`
   - Purpose: Optimizes the most common reading lookup pattern
   - Impact: Reduces query time for `Reading::Query.find_by_reference`

2. **Celebration calculation_rule Index**
   - Column: `calculation_rule`
   - Purpose: Speeds up movable feast lookups
   - Impact: Faster resolution of Easter-dependent celebrations

3. **Celebration prayer_book Composite Indexes**
   - `[:prayer_book_id, :movable]` - For filtering movable celebrations
   - `[:prayer_book_id, :can_be_transferred]` - For finding transferable celebrations
   - Purpose: Optimize CelebrationResolver queries
   - Impact: Reduces database load when resolving celebration candidates

## Query Optimizations

### 1. CelebrationResolver Memoization

**File:** `app/services/liturgical/celebration_resolver.rb`

- Memoized `movable_celebrations_for_prayer_book`
- Memoized `transferable_celebrations_for_prayer_book`
- **Impact:** Avoids repeated database queries when collecting celebration candidates

### 2. LiturgicalCalendar Optimization

**File:** `app/services/liturgical_calendar.rb`

- Memoized `celebration_resolver` instance
- **Impact:** Reuses CelebrationResolver across multiple `day_info` calls

### 3. Reading::Query Direct WHERE Clauses

**File:** `app/services/reading/query.rb`

- Replaced chainable scopes with direct `where` clauses
- **Impact:** More efficient SQL generation, better use of composite indexes

### 4. ReadingService Prayer Book Filtering

**File:** `app/services/reading_service.rb`

- Added `for_prayer_book_id` filter to `find_by_celebration`
- **Impact:** Reduces result set before further processing

### 5. PrayerBook Caching

**File:** `app/models/prayer_book.rb`

- Added Rails.cache for `find_by_code` lookups
- Cache expiration: 1 day
- **Impact:** Eliminates repeated database queries for prayer book lookups

## Application-Level Caching

### Controller-Level Cache

**File:** `app/controllers/api/v1/daily_office_controller.rb`

- Daily Office responses are cached with 1-day expiration
- Cache key includes: date, office_type, and relevant preferences
- **Impact:** Subsequent requests for the same office return cached data

## Performance Testing

### Benchmark Specs

**File:** `spec/performance/daily_office_performance_spec.rb`

Performance tests measure:

1. **DailyOfficeService**
   - Average time for single office generation (target: < 500ms)
   - Time for all 4 office types (target: < 2s)

2. **LiturgicalCalendar**
   - Day info generation (target: < 100ms)
   - Month calendar generation (target: < 2s)

3. **ReadingService**
   - Single reading lookup (target: < 100ms)
   - 7 consecutive days (target: < 1s)

4. **Database Query Count**
   - Total queries for one daily office (target: < 50 queries)

### Running Performance Tests

```bash
# Run performance specs
docker compose exec -T web bundle exec rspec spec/performance/

# Run with detailed output
docker compose exec -T web bundle exec rspec spec/performance/ --format documentation
```

## Expected Performance Improvements

### Before Optimizations
- Multiple database queries per request (N+1 issues)
- Repeated PrayerBook lookups
- No caching of celebration candidates
- Response times: 300-800ms (without cache)

### After Optimizations
- Reduced database queries through memoization
- Cached PrayerBook lookups
- Optimized indexes for common queries
- Expected response times: 100-300ms (without cache), < 50ms (with cache)

## Monitoring and Maintenance

### Cache Invalidation

PrayerBook cache is automatically invalidated after 1 day. Manual invalidation:

```ruby
Rails.cache.delete("prayer_book/loc_2015")
```

### Query Analysis

To analyze query performance:

```ruby
# In Rails console
ActiveRecord::Base.logger = Logger.new(STDOUT)

# Then run a Daily Office request
service = DailyOfficeService.new(date: Date.today, office_type: :morning)
service.call
```

### Future Optimization Opportunities

1. **Eager Loading**
   - Preload associated records when building daily office
   - Especially for liturgical texts and collects

2. **Fragment Caching**
   - Cache individual sections of the daily office
   - Allow more granular cache invalidation

3. **Database Connection Pooling**
   - Monitor connection pool usage under load
   - Adjust pool size if needed

4. **Background Processing**
   - Pre-generate daily offices for upcoming days
   - Store in cache during off-peak hours

5. **CDN/Edge Caching**
   - Cache responses at CDN level for anonymous users
   - Reduce server load for frequently accessed dates

## Additional Notes

- All optimizations maintain backward compatibility
- No breaking changes to API responses
- Existing tests continue to pass
- RuboCop compliance maintained
