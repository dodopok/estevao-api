# estevao-api

API para Calendário Litúrgico

## Description

A simple API-only application built with Rails 8.1.1.

## Ruby version

Ruby 3.2.3

## System dependencies

- Rails 8.1.1
- SQLite3
- Bundler

## Setup

Install dependencies:

```bash
bundle install
```

## Database creation

```bash
bin/rails db:create
bin/rails db:migrate
```

## How to run the test suite

```bash
bin/rails test
```

## Services

This is a simple API-only Rails application using:
- Puma web server
- SQLite3 database
- Solid Cache for caching
- Solid Queue for background jobs
- Solid Cable for Action Cable

## Running the application

```bash
bin/rails server
```

The API will be available at `http://localhost:3000`

## Deploy to Render

### Environment Variables Required

Configure the following environment variables in your Render dashboard:

1. **SECRET_KEY_BASE** (Required)

   Generate a secure secret key by running:
   ```bash
   bin/rails secret
   ```

   Copy the generated key and add it as an environment variable in Render.

2. **DATABASE_URL** (Required)

   This is automatically provided by Render when you add a PostgreSQL database.

3. **RAILS_ENV** (Required)
   ```
   production
   ```

### Build Command

```bash
./bin/render-build.sh
```

### Start Command

```bash
bundle exec puma -C config/puma.rb
```

### Important Notes

- This is an API-only Rails application (no assets or views)
- Make sure to add a PostgreSQL database in Render before deploying
- The `render-build.sh` script will run migrations automatically
