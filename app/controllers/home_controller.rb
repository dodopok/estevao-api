class HomeController < ApplicationController
  def index
    render json: {
      api: "Calendário Litúrgico Anglicano",
      version: "1.0",
      docs: "/api-docs",
      endpoints: {
        calendar: {
          today: "/api/v1/calendar/today",
          day: "/api/v1/calendar/:year/:month/:day",
          month: "/api/v1/calendar/:year/:month",
          year: "/api/v1/calendar/:year"
        },
        celebrations: {
          list: "/api/v1/celebrations",
          details: "/api/v1/celebrations/:id",
          search: "/api/v1/celebrations/search?q=term",
          by_date: "/api/v1/celebrations/date/:month/:day",
          types: "/api/v1/celebrations/types"
        },
        lectionary: {
          day: "/api/v1/lectionary/:year/:month/:day",
          all_services: "/api/v1/lectionary/:year/:month/:day/all_services",
          cycle: "/api/v1/lectionary/cycle/:year"
        },
        daily_office: {
          today: "/api/v1/daily_office/today/:office_type",
          show: "/api/v1/daily_office/:year/:month/:day/:office_type",
          family: "/api/v1/daily_office/:year/:month/:day/:office_type/family",
          preferences: "/api/v1/daily_office/preferences"
        },
        users: {
          me: "GET /api/v1/users/me",
          delete_account: "DELETE /api/v1/users/me",
          update_preferences: "PATCH /api/v1/users/preferences",
          update_timezone: "PATCH /api/v1/users/timezone",
          completions: "GET /api/v1/users/completions",
          save_fcm_token: "POST /api/v1/users/fcm_token",
          delete_fcm_token: "DELETE /api/v1/users/fcm_token"
        },
        onboarding: {
          create: "POST /api/v1/users/onboarding",
          show: "GET /api/v1/users/me/onboarding"
        },
        completions: {
          create: "POST /api/v1/completions",
          destroy: "DELETE /api/v1/completions/:id",
          show: "/api/v1/completions/:year/:month/:day/:office_type"
        },
        journals: {
          create: "POST /api/v1/journals",
          update: "PATCH /api/v1/journals/:id",
          destroy: "DELETE /api/v1/journals/:id",
          day: "/api/v1/journals/:year/:month/:day",
          month: "/api/v1/journals/:year/:month"
        },
        notifications: {
          send: "POST /api/v1/notifications/send (admin)",
          broadcast: "POST /api/v1/notifications/broadcast (admin)"
        },
        prayer_books: {
          list: "/api/v1/prayer_books",
          show: "/api/v1/prayer_books/:code",
          preferences: "/api/v1/prayer_books/:code/preferences"
        },
        bible_versions: {
          list: "/api/v1/bible_versions"
        },
        shared_offices: {
          create: "POST /api/v1/shared_offices",
          show: "/api/v1/shared_offices/:code"
        },
        life_rules: {
          list: "/api/v1/life_rules",
          my: "/api/v1/life_rules/my",
          show: "/api/v1/life_rules/:id",
          create: "POST /api/v1/life_rules",
          update: "PATCH /api/v1/life_rules/:id",
          destroy: "DELETE /api/v1/life_rules/:id",
          adopt: "POST /api/v1/life_rules/:id/adopt",
          approve: "POST /api/v1/life_rules/:id/approve (admin)"
        }
      }
    }
  end
end
