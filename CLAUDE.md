# CLAUDE.md

AI Assistant Instructions for the Estêvão API Project

## Project Overview

**estevao-api** is a Rails 8.1 REST API for the Ordo mobile app, providing complete liturgical services for Anglican spiritual life based on the Book of Common Prayer (Livro de Oração Comum).

### Core Purpose
This API serves Flutter mobile applications with:
- Daily Office prayers (Morning, Midday, Evening, Compline)
- Complete liturgical calendar with celebrations and seasons
- Bible readings (lectionary) organized by liturgical cycles
- Psalms with weekly/monthly reading cycles
- Collects and liturgical texts
- Premium audio features (AI-generated narration)
- User preferences for different Prayer Books
- Push notifications via Firebase Cloud Messaging
- Office completion tracking

## Technical Stack

**Core Technologies:**
- Ruby 3.2.3
- Rails 8.1.1
- PostgreSQL 16 (primary database)
- SQLite 3 (for external Bible translation files)
- Redis (caching in production)
- Docker & Docker Compose (development environment)

**Key Dependencies:**
- **Testing**: RSpec, FactoryBot, WebMock, SimpleCov, Parallel Tests
- **Code Quality**: RuboCop (rails-omakase), Brakeman, Bundler Audit
- **Rails 8**: Solid Cache, Solid Queue, Solid Cable
- **Server**: Puma + Thruster
- **External APIs**: Firebase (Auth & FCM), RevenueCat, ElevenLabs
- **Documentation**: Swagger/OpenAPI (rswag)
- **Monitoring**: Datadog APM & Logging

## Development Environment

### Critical: Docker-First Development

This project RUNS IN DOCKER COMPOSE. All Rails commands MUST be executed via the container.

**Container Services:**
- `web`: Rails application (port 3000) with VS Code debugger (port 1234)
- `db`: PostgreSQL 16 (port 5432)
- `datadog-agent`: APM and monitoring (optional in development)

**Shell Access Pattern:**
```bash
docker-compose exec -T web [command]
```

The `-T` flag disables TTY allocation and is required for non-interactive commands.

### Essential Commands

**Container Management:**
```bash
# Start all services (database + web + datadog)
docker-compose up -d

# Stop all services
docker-compose down

# View logs
docker-compose logs -f web

# Restart web service only
docker-compose restart web

# Rebuild after Gemfile changes
docker-compose up -d --build
```

**Rails Commands:**
```bash
# Console (interactive, omit -T flag)
docker-compose exec web bundle exec rails c

# Server (usually auto-starts via docker-compose up)
docker-compose exec -T web bundle exec rails s -b 0.0.0.0

# Database
docker-compose exec -T web bundle exec rails db:create
docker-compose exec -T web bundle exec rails db:migrate
docker-compose exec -T web bundle exec rails db:seed
docker-compose exec -T web bundle exec rails db:reset  # drop, create, migrate, seed

# Routes
docker-compose exec -T web bundle exec rails routes

# Generate
docker-compose exec -T web bundle exec rails generate model User name:string
```

**Bundle Commands:**
```bash
# Install gems (after updating Gemfile)
docker-compose exec -T web bundle install

# Update a specific gem
docker-compose exec -T web bundle update gem_name
```

**Debugging:**
The development container runs with `rdbg` (Ruby debugger) configured for VS Code remote debugging on port 1234. Set breakpoints in VS Code and attach to the running container.

## Code Quality & Testing

### MANDATORY Pre-Commit Workflow

Before committing ANY code, you MUST run:

1. **Tests (RSpec):**
   ```bash
   docker-compose exec -T web bundle exec rspec
   ```

2. **Code Style (RuboCop):**
   ```bash
   docker-compose exec -T web bundle exec rubocop
   ```

3. **Security Scans:**
   ```bash
   docker-compose exec -T web bundle exec brakeman --no-pager
   docker-compose exec -T web bundle exec bundler-audit
   ```

### Testing Philosophy

**Always Write Tests For:**
- New models (validations, associations, scopes)
- New services (business logic)
- New API endpoints (request specs)
- Background jobs
- Bug fixes (regression tests)

**Test Organization:**
```
spec/
├── factories/           # FactoryBot factories
├── fixtures/            # Static test data
├── models/              # Model specs
├── services/            # Service object specs
│   ├── daily_office/    # Daily office services
│   ├── liturgical/      # Liturgical calendar services
│   └── reading/         # Lectionary services
├── requests/            # API endpoint specs (integration)
│   └── api/v1/          # API v1 endpoints
├── jobs/                # Background job specs
├── lib/                 # Lib and rake task specs
└── support/             # Shared examples, helpers
```

**Running Tests:**
```bash
# All specs
docker-compose exec -T web bundle exec rspec

# Specific file
docker-compose exec -T web bundle exec rspec spec/models/user_spec.rb

# Specific line
docker-compose exec -T web bundle exec rspec spec/models/user_spec.rb:23

# By pattern
docker-compose exec -T web bundle exec rspec spec/models/
docker-compose exec -T web bundle exec rspec spec/services/

# Parallel execution (CI)
docker-compose exec -T web bundle exec parallel_rspec -n 2 spec/

# With coverage report
docker-compose exec -T web COVERAGE=true bundle exec rspec
```

**Code Coverage:**
SimpleCov generates coverage reports in `coverage/index.html` when `COVERAGE=true` is set.

### RuboCop (Code Style)

This project uses `rubocop-rails-omakase` - the official Rails style guide.

```bash
# Check all files
docker-compose exec -T web bundle exec rubocop

# Auto-fix safe violations
docker-compose exec -T web bundle exec rubocop -a

# Auto-fix all violations (including unsafe)
docker-compose exec -T web bundle exec rubocop -A

# Check specific files
docker-compose exec -T web bundle exec rubocop app/models/user.rb

# Check specific directory
docker-compose exec -T web bundle exec rubocop app/services/
```

**Configuration:** `.rubocop.yml` (inherits from rubocop-rails-omakase)

### Security Scanning

**Brakeman (Static Analysis):**
```bash
docker-compose exec -T web bundle exec brakeman --no-pager
```

**Bundler Audit (Known Vulnerabilities):**
```bash
docker-compose exec -T web bundle exec bundler-audit
```

## Project Structure

```
app/
├── controllers/
│   ├── api/v1/              # API endpoints (versioned)
│   └── concerns/            # Controller concerns
├── models/
│   └── concerns/            # Model concerns (validations, scopes)
├── services/                # Business logic (SERVICE OBJECTS)
│   ├── concerns/            # Service concerns
│   ├── daily_office/        # Daily office assembly & components
│   │   ├── builders/        # Office type builders (morning, evening, etc.)
│   │   └── components/      # Office components (psalms, readings, prayers)
│   ├── liturgical/          # Liturgical calendar calculations
│   │   ├── easter_calculator.rb
│   │   ├── celebration_resolver.rb
│   │   ├── color_determinator.rb
│   │   └── season_determinator.rb
│   └── reading/             # Lectionary and Bible text services
├── jobs/                    # Background jobs (Solid Queue)
├── helpers/                 # View helpers (minimal, API-only)
└── views/                   # Minimal (API responses use Jbuilder/JSON)

config/
├── environments/            # Environment configs
├── initializers/            # Initializers (CORS, inflections, etc.)
├── routes.rb               # API routes
└── database.yml            # Database configuration

db/
├── migrate/                # Database migrations
├── seeds/                  # Seed data (organized by entity)
└── schema.rb               # Current database schema (auto-generated)

lib/
└── tasks/                  # Rake tasks
    ├── audio.rake          # Audio generation tasks
    ├── bible_import.rake   # Bible translation imports
    ├── cache.rake          # Cache management
    ├── import_collects.rake # Import collects
    └── notifications.rake  # Notification tasks

spec/
├── factories/              # FactoryBot definitions
├── fixtures/               # Static test data (JSON, files)
├── models/                 # Model specs
├── services/               # Service specs
├── requests/               # API integration specs
├── jobs/                   # Job specs
├── lib/                    # Lib and task specs
└── support/                # Test helpers, shared contexts
```

## Architectural Patterns

### Service Objects

Complex business logic MUST be extracted into service objects under `app/services/`.

**When to Use Services:**
- Complex calculations (liturgical calendar, dates)
- Multi-model operations
- External API integrations
- Anything beyond simple CRUD

**Naming Convention:**
- `VerbNounService` (e.g., `CalculateEasterService`, `GenerateAudioService`)
- Group related services in subdirectories

**Example:**
```ruby
# app/services/liturgical/easter_calculator.rb
module Liturgical
  class EasterCalculator
    def self.calculate(year)
      new(year).calculate
    end

    def initialize(year)
      @year = year
    end

    def calculate
      # Implementation using Computus algorithm
    end
  end
end
```

### Controller Responsibilities

Controllers should be THIN. They:
1. Authenticate/authorize
2. Parse parameters
3. Call service objects
4. Return JSON responses
5. Handle errors

**What Controllers Should NOT Do:**
- Complex business logic
- Multi-model operations
- Calculations
- External API calls

### Factory Pattern (Tests)

Use FactoryBot for all test data. Never create records manually in specs.

```ruby
# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    firebase_uid { "firebase_#{SecureRandom.hex(10)}" }
    email { "user_#{SecureRandom.hex(5)}@example.com" }
    preferred_voice { "male_1" }

    trait :premium do
      revenue_cat_user_id { "rc_#{SecureRandom.hex(10)}" }
      premium_expires_at { 1.month.from_now }
    end
  end
end

# Usage in specs
let(:user) { create(:user) }
let(:premium_user) { create(:user, :premium) }
```

## Code Conventions

### General Principles

1. **Simplicity Over Cleverness**: Write clear, obvious code
2. **Service Objects for Logic**: Keep models and controllers thin
3. **Test Everything**: No untested code
4. **Security First**: Never trust user input, validate everything
5. **Performance Matters**: Use caching, optimize database queries
6. **No Over-Engineering**: Solve current problems, not hypothetical ones

### Specific Rules

**Models:**
- Keep models focused on data and simple scopes
- Use concerns for shared behavior
- Always add database constraints (NOT NULL, foreign keys, unique indexes)

**Services:**
- One public method per service (or clearly related methods)
- Prefer keyword arguments for clarity
- Return meaningful objects (not just true/false)

**Controllers:**
- Use `before_action` for authentication
- Strong parameters for all inputs
- Consistent JSON response format

**Tests:**
- Use descriptive `describe` and `context` blocks
- One assertion per `it` block when possible
- Use `let` for setup, avoid `before` blocks when possible
- Mock external HTTP calls (WebMock)

**Security:**
- NEVER expose sensitive data in logs or errors
- Always validate and sanitize user input
- Use parameterized queries (ActiveRecord handles this)
- Avoid command injection (use array form for shell commands)
- Validate file uploads

**Performance:**
- Use `includes` to avoid N+1 queries
- Cache expensive operations (especially liturgical calendar)
- Use database indexes for frequently queried columns
- Monitor with Datadog in production

## Key Domain Concepts

### Liturgical Calendar

The heart of this application. Key services:
- `Liturgical::EasterCalculator`: Computes Easter using Computus algorithm
- `Liturgical::CelebrationResolver`: Resolves celebration precedence and conflicts
- `Liturgical::ColorDeterminator`: Determines liturgical colors
- `Liturgical::SeasonDeterminator`: Identifies liturgical seasons
- `LiturgicalCalendar`: Main service that orchestrates all calendar calculations

**Important Rules:**
- Principal Feasts override everything
- Sundays in major seasons override festivals
- Transferable celebrations move if they conflict
- Liturgical year starts on Advent Sunday (not January 1)

### Daily Office

Multi-component system for assembling prayers:
- `DailyOfficeService`: Main orchestrator
- `DailyOffice::Builders::*`: Type-specific builders (Morning, Evening, etc.)
- `DailyOffice::Components::*`: Individual components (psalms, readings, prayers)

**Office Types:**
- `morning`: Morning Prayer (Oração da Manhã)
- `midday`: Midday Prayer (Oração do Meio-Dia)
- `evening`: Evening Prayer (Oração da Tarde)
- `compline`: Compline (Completas)

### Premium Audio System

AI-generated audio for liturgical texts:
- `ElevenlabsAudioService`: Integrates with ElevenLabs API
- `BatchAudioGeneratorService`: Generates audio in bulk
- `RevenueCatService`: Verifies premium subscriptions
- `GenerateLiturgicalAudioJob`: Background job for audio generation

**Important:**
- Text is sanitized before generation (removes Markdown and Bible references)
- Files are stored in `/app/public/audio/`
- Premium status checked via RevenueCat API
- 3 voices available: `male_1`, `female_1`, `male_2`

## Environment Variables

Required variables in `.env` (see `.env.example`):

**Core:**
- `RAILS_ENV`: development, test, or production
- `SECRET_KEY_BASE`: Secret key for sessions
- `DATABASE_URL`: PostgreSQL connection string (auto in Docker)

**Firebase:**
- `FIREBASE_PROJECT_ID`: Firebase project ID
- `FIREBASE_CLIENT_EMAIL`: Service account email
- `FIREBASE_PRIVATE_KEY`: Service account private key

**External APIs:**
- `ELEVENLABS_API_KEY`: ElevenLabs API key (audio generation)
- `REVENUECAT_API_KEY`: RevenueCat API key (subscriptions)
- `AUDIO_CDN_HOST`: CDN host for audio files (optional)

**Datadog (Production):**
- `DD_API_KEY`: Datadog API key
- `DD_SITE`: Datadog site (datadoghq.com)
- `DD_ENV`: Environment name

**Development:**
- `MOCK_PREMIUM`: Set to `true` to bypass premium checks

## Common Rake Tasks

**Database:**
```bash
docker-compose exec -T web bundle exec rails db:verify     # Verify data integrity
```

**Bible:**
```bash
docker-compose exec -T web bundle exec rails bible:setup   # Download & import all translations
docker-compose exec -T web bundle exec rails bible:stats   # Show import statistics
```

**Audio:**
```bash
docker-compose exec -T web bundle exec rails audio:estimate[loc_2015,male_1]  # Estimate costs
docker-compose exec -T web bundle exec rails audio:generate[loc_2015,male_1]  # Generate audio
docker-compose exec -T web bundle exec rails audio:stats                      # Show statistics
```

**Cache:**
```bash
docker-compose exec -T web bundle exec rails cache:warm                       # Warm today's cache
docker-compose exec -T web bundle exec rails cache:warm[2025-12-25]           # Warm specific date
docker-compose exec -T web bundle exec rails cache:clear_all                  # Clear all cache
docker-compose exec -T web bundle exec rails cache:stats                      # Show cache stats
```

**Notifications:**
```bash
docker-compose exec -T web bundle exec rails notifications:test_notification[user@example.com]
```

See `lib/tasks/*.rake` for full list and documentation.

## Continuous Integration (CI/CD)

GitHub Actions runs three jobs on every PR and push to main:

1. **scan_ruby**: Security scanning (Brakeman + Bundler Audit)
2. **lint**: Code style checking (RuboCop)
3. **test**: Full test suite with PostgreSQL

All jobs must pass before merging.

**Local CI Simulation:**
```bash
# Run all CI checks locally
docker-compose exec -T web bundle exec brakeman --no-pager
docker-compose exec -T web bundle exec bundler-audit
docker-compose exec -T web bundle exec rubocop
docker-compose exec -T web bundle exec parallel_rspec -n 2 spec/
```

## Debugging

**Rails Console:**
```bash
docker-compose exec web bundle exec rails c
```

**Logs:**
```bash
# Follow all logs
docker-compose logs -f

# Web service only
docker-compose logs -f web

# Database
docker-compose logs -f db
```

**VS Code Remote Debugging:**
The web container runs with `rdbg` on port 1234. Configure VS Code launch.json:
```json
{
  "type": "rdbg",
  "request": "attach",
  "rdbgPath": "bundle exec rdbg",
  "debugPort": "localhost:1234"
}
```

**Database Access:**
```bash
# Via Rails console
docker-compose exec web bundle exec rails db

# Via psql directly
docker-compose exec db psql -U postgres -d estevao_api_development
```

## Common Workflows

### Adding a New API Endpoint

1. Define route in `config/routes.rb`
2. Create controller action in `app/controllers/api/v1/`
3. Extract logic to service object in `app/services/`
4. Write request spec in `spec/requests/api/v1/`
5. Run tests and RuboCop
6. Update Swagger documentation if needed

### Adding a New Model

1. Generate migration: `docker-compose exec -T web bundle exec rails g migration CreateUsers`
2. Run migration: `docker-compose exec -T web bundle exec rails db:migrate`
3. Create model: `app/models/user.rb`
4. Add validations, associations
5. Create factory: `spec/factories/users.rb`
6. Write model spec: `spec/models/user_spec.rb`
7. Run tests

### Implementing a Feature

1. Write failing test first (TDD)
2. Implement minimum code to pass test
3. Refactor if needed
4. Run full test suite
5. Run RuboCop and fix violations
6. Commit with descriptive message

## Additional Documentation

- `README.md`: Project overview and setup
- `ROADMAP.md`: Development roadmap
- `TODO.md`: Upcoming improvements

## Best Practices Summary

**DO:**
- Run tests and RuboCop before every commit
- Use service objects for complex logic
- Write descriptive commit messages
- Use FactoryBot for test data
- Cache expensive operations
- Validate all user input
- Use keyword arguments for clarity
- Write self-documenting code

**DON'T:**
- Commit without running tests
- Put business logic in controllers or models
- Skip writing tests
- Ignore RuboCop violations
- Expose sensitive data in logs
- Use string interpolation for SQL queries
- Over-engineer solutions
- Bypass security scans

## Getting Help

- Check existing specs for patterns
- Review service objects for architectural examples
- Consult the liturgical domain documentation
- Review GitHub Actions for CI requirements
- Ask questions with specific error messages and context
