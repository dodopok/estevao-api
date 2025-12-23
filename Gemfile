source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.1.1"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Redis for caching in production
gem "redis", ">= 4.0.1"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

gem "rswag"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
gem "rack-cors"

# Rate limiting and throttling
gem "rack-attack"

# JWT for Firebase Authentication token verification
gem "jwt"

# HTTP client for API requests
gem "http"

# Firebase Cloud Messaging for push notifications
gem "fcm"
gem "googleauth" # For FCM v1 API authentication

# Excel file generation and reading
gem "caxlsx"
gem "caxlsx_rails"
gem "write_xlsx"
gem "roo"

# SQLite for reading external Bible translation files
gem "sqlite3", "~> 2.0"

# Datadog APM, Logging, and Error Tracking
gem "datadog", "~> 2.0"
gem "dogstatsd-ruby", "~> 5.6"  # For custom metrics

gem 'connection_pool', '< 3.0'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug"

  # Audits gems for known security defects (use config/bundler-audit.yml to ignore issues)
  gem "bundler-audit", require: false

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false

  # RSpec for testing
  gem "rspec-rails", "~> 8.0"
  gem "rswag-specs"

  # Parallel test execution
  gem "parallel_tests"

  # Test data factories
  gem "factory_bot_rails"

  # Additional RSpec matchers
  gem "shoulda-matchers", "~> 7.0"

  # HTTP request stubbing for tests
  gem "webmock"

  # Code coverage
  gem "simplecov", require: false
end
