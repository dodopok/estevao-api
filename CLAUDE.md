# CLAUDE.md

## Build & Run Commands
- Server: docker-compose exec -T web bundle exec rails s -b 0.0.0.0
- Console: docker-compose exec -T web bundle exec rails c
- Migrate: docker-compose exec -T web bundle exec rails db:migrate
- Test: docker-compose exec -T web bundle exec rspec
- Bundle: docker-compose exec -T web bundle install

## Environment
- Runtime: Ruby on Rails via Docker Compose
- Shell: Bash
- Use `docker-compose exec -T web` for all commands that require the rails environment.