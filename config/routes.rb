Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # API routes
  namespace :api do
    namespace :v1 do
      # Rotas do calendário litúrgico
      get "calendar/:year/:month/:day", to: "calendar#day"
      get "calendar/:year/:month", to: "calendar#month"
      get "calendar/:year", to: "calendar#year"

      # Rotas de celebrações
      resources :celebrations, only: [ :index, :show ] do
        collection do
          get :search
          get :types
          get "date/:month/:day", to: "celebrations#by_date"
        end
      end

      # Rotas do lecionário (leituras)
      get "lectionary/:year/:month/:day", to: "lectionary#day"
      get "lectionary/:year/:month/:day/all_services", to: "lectionary#all_services"
      get "lectionary/cycle/:year", to: "lectionary#cycle_info"
    end
  end

  # Rota raiz com informações da API
  root to: proc {
    [ 200, { "Content-Type" => "application/json" }, [
      {
        api: "Calendário Litúrgico Anglicano",
        version: "1.0",
        docs: "/api-docs",
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
      }.to_json
    ] ]
  }
end
