class HomeController < ApplicationController
  def index
    render json: {
      api: "Calendário Litúrgico Anglicano",
      version: "1.0",
      documentation: "/api-docs",
      endpoints: {
        calendar: {
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
        }
      }
    }
  end
end
