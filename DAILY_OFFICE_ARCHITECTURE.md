# Daily Office Architecture

## Overview

The Daily Office system has been refactored to support multiple Prayer Book (LOC) implementations, each with potentially different liturgical structures. This allows each LOC to have its own unique Daily Office format while maintaining shared functionality.

## Architecture Pattern

We use a **hybrid Strategy + Configuration pattern** with the following components:

1. **Factory Service** (`DailyOfficeService`) - Routes requests to appropriate builders
2. **Base Builder** (`DailyOffice::Builders::BaseBuilder`) - Provides shared logic and default structure
3. **LOC-specific Builders** (e.g., `Loc2015Builder`) - Override base behavior for unique LOC requirements
4. **Component Builders** - Reusable components for psalms, canticles, readings, and prayers

## Directory Structure

```
app/services/
├── daily_office_service.rb          # Factory that routes to builders
├── daily_office/
│   ├── builders/
│   │   ├── base_builder.rb          # Base class with default structure
│   │   └── loc_2015_builder.rb      # LOC 2015 specific implementation
│   └── components/
│       ├── psalm_builder.rb         # Psalm assembly logic
│       ├── canticle_builder.rb      # Canticle assembly logic
│       ├── reading_builder.rb       # Scripture reading logic
│       └── prayer_builder.rb        # Prayers, collects, etc.
```

## How It Works

### 1. Factory Pattern (DailyOfficeService)

The main service delegates to appropriate builders based on `prayer_book_code`:

```ruby
class DailyOfficeService
  def call
    builder = builder_for_prayer_book
    builder.call
  end

  private

  def builder_for_prayer_book
    case prayer_book_code
    when "loc_2015"
      DailyOffice::Builders::Loc2015Builder
    when "loc_2019"
      DailyOffice::Builders::Loc2019Builder
    else
      DailyOffice::Builders::BaseBuilder
    end.new(date: date, office_type: office_type, preferences: preferences)
  end
end
```

### 2. Base Builder

Provides default structure for all office types:

```ruby
class BaseBuilder
  def assemble_morning_prayer
    return assemble_morning_prayer_family if preferences[:family_rite]

    [
      prayer_builder.build_opening_sentence(:morning),
      prayer_builder.build_confession,
      prayer_builder.build_absolution,
      prayer_builder.build_invocation,
      canticle_builder.build_invitatory,
      psalm_builder.build_psalms(:morning),
      reading_builder.build_first_reading,
      canticle_builder.build_first_canticle,
      reading_builder.build_second_reading,
      canticle_builder.build_second_canticle,
      prayer_builder.build_creed,
      prayer_builder.build_kyrie,
      prayer_builder.build_lords_prayer,
      prayer_builder.build_morning_suffrages,
      prayer_builder.build_collects,
      prayer_builder.build_general_thanksgiving,
      prayer_builder.build_chrysostom_prayer,
      prayer_builder.build_dismissal
    ].compact
  end
end
```

### 3. LOC-Specific Builders

Override base methods for unique LOC structures:

```ruby
class Loc2015Builder < BaseBuilder
  # Example: LOC 2015 has a different order or components
  def assemble_morning_prayer
    return super unless some_condition

    # Custom structure for LOC 2015
    [
      # Different order or components
    ].compact
  end
end
```

### 4. Component Builders

Reusable components for building specific parts:

- **PsalmBuilder**: Handles psalms, single psalms, compline psalms, etc.
- **CanticleBuilder**: Handles Magnificat, Benedictus, Te Deum, etc.
- **ReadingBuilder**: Handles scripture readings (first, second, short)
- **PrayerBuilder**: Handles prayers, collects, confessions, etc.

## Benefits

### 1. **Separation of Concerns**
- Factory handles routing
- Base builder provides default structure
- Component builders handle specific parts
- LOC builders customize as needed

### 2. **Easy to Extend**
To add a new LOC with unique structure:

```ruby
# 1. Create new builder
class Loc1662Builder < BaseBuilder
  def assemble_morning_prayer
    # 1662 BCP specific structure
  end
end

# 2. Register in factory
def builder_for_prayer_book
  case prayer_book_code
  when "loc_1662"
    DailyOffice::Builders::Loc1662Builder
  # ...
  end
end
```

### 3. **Code Reuse**
- Common components (psalms, canticles) are shared
- Only customize what's different
- Base builder provides sensible defaults

### 4. **Testability**
- Each component can be tested in isolation
- Builders can be tested independently
- Factory logic is simple and testable

### 5. **Maintainability**
- Reduced from 796 lines to ~60 lines in main service
- Clear responsibility boundaries
- Easy to understand and modify

## Usage Examples

### Basic Usage

```ruby
# Use default LOC (loc_2015)
service = DailyOfficeService.new(
  date: Date.today,
  office_type: :morning
)
result = service.call
```

### With Prayer Book Selection

```ruby
# Use specific LOC
service = DailyOfficeService.new(
  date: Date.today,
  office_type: :evening,
  preferences: { prayer_book_code: 'loc_2019' }
)
result = service.call
```

### With Family Rite

```ruby
# Use simplified family rite
service = DailyOfficeService.new(
  date: Date.today,
  office_type: :morning,
  preferences: {
    prayer_book_code: 'loc_2015',
    family_rite: true
  }
)
result = service.call
```

## Migration Notes

### Backward Compatibility

The new architecture maintains **100% backward compatibility**:

- All existing API endpoints work unchanged
- Same request/response format
- No database changes required
- All existing tests pass

### Legacy Service

The original monolithic service is preserved at:
- `app/services/daily_office_service_legacy.rb`

This can be removed once confidence in the new architecture is established.

## Testing

### Test Structure

```
spec/services/daily_office/
├── builders/
│   └── base_builder_spec.rb         # Tests for base builder
├── daily_office_service_spec.rb     # Tests for factory
└── components/                       # Component tests (optional)
```

### Running Tests

```bash
# All daily office tests
bundle exec rspec spec/services/daily_office/

# Specific builder
bundle exec rspec spec/services/daily_office/builders/base_builder_spec.rb

# Factory tests
bundle exec rspec spec/services/daily_office_service_spec.rb
```

## Future Enhancements

### 1. Add New LOC Builders

When supporting a new LOC with unique structure:

1. Create `app/services/daily_office/builders/loc_xxxx_builder.rb`
2. Extend `BaseBuilder` and override methods as needed
3. Register in `DailyOfficeService#builder_for_prayer_book`
4. Add tests in `spec/services/daily_office/builders/loc_xxxx_builder_spec.rb`

### 2. Add New Components

For new liturgical elements:

1. Create new component builder in `app/services/daily_office/components/`
2. Initialize in `BaseBuilder#initialize`
3. Use in assembly methods

### 3. Configuration-Based Customization

For simple structural differences, use Prayer Book `features` JSONB:

```ruby
def assemble_morning_prayer
  components = []
  components << prayer_builder.build_opening_sentence(:morning)

  # Conditional based on configuration
  if prayer_book.features.dig('daily_office', 'has_confession')
    components << prayer_builder.build_confession
  end

  # ...
end
```

## Performance Considerations

- Component builders are instantiated once per request
- Results are built on-demand (no caching needed for now)
- Database queries are optimized through ActiveRecord associations
- Future optimization: Consider caching liturgical texts

## Related Documentation

- [PRAYER_BOOK_PREFERENCES.md](PRAYER_BOOK_PREFERENCES.md) - Prayer Book features and user preferences system
- [README.md](README.md) - Main project documentation
