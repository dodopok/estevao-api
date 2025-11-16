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
