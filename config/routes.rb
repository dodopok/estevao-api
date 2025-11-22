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
      get "calendar/today", to: "calendar#today"
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

      # Rotas do Ofício Diário
      get "daily_office/today/:office_type", to: "daily_office#today"
      get "daily_office/:year/:month/:day/:office_type", to: "daily_office#show"
      get "daily_office/preferences", to: "daily_office#preferences"
    end
  end

  # Rota raiz com informações da API
  root "home#index"
end
