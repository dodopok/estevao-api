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
      get "daily_office/:year/:month/:day/:office_type/family", to: "daily_office#family_rite"
      get "daily_office/preferences", to: "daily_office#preferences"

      # Rotas de autenticação e usuários
      get "users/me", to: "users#show"
      delete "users/me", to: "users#destroy"
      patch "users/preferences", to: "users#update_preferences"
      patch "users/timezone", to: "users#update_timezone"
      get "users/completions", to: "users#completions"
      post "users/fcm_token", to: "users#save_fcm_token"
      delete "users/fcm_token", to: "users#delete_fcm_token"

      # Rotas de onboarding
      post "users/onboarding", to: "onboarding#create"
      get "users/me/onboarding", to: "onboarding#show"

      # Rotas de completions (marcar ofícios como completados)
      resources :completions, only: [ :create, :destroy ]
      get "completions/:year/:month/:day/:office_type", to: "completions#show"

      # Rotas de anotações/diário (journals)
      resources :journals, only: [ :create, :update, :destroy ]
      get "journals/:year/:month/:day", to: "journals#day"
      get "journals/:year/:month", to: "journals#month"

      # Rotas de notificações (admin apenas)
      post "notifications/send", to: "notifications#send_to_users"
      post "notifications/broadcast", to: "notifications#broadcast"

      # Rotas de livros de oração
      resources :prayer_books, only: [ :index ], param: :code do
        collection do
          get ":code", to: "prayer_books#show", as: :show
        end
      end

      # Rotas de preferências dinâmicas por Prayer Book
      get "prayer_books/:prayer_book_code/preferences", to: "preferences#show"

      # Rotas de versões de Bíblia
      resources :bible_versions, only: [ :index ]

      # Rotas de compartilhamento de ofício
      post "shared_offices", to: "shared_offices#create"
      get "shared_offices/:code", to: "shared_offices#show"

      # Rotas de subscription (RevenueCat)
      post "subscription/verify", to: "subscriptions#verify"
      get "subscription/premium_status", to: "subscriptions#premium_status"

      # Rotas de audio
      get "audio/voice_samples", to: "audio#voice_samples"
      get "audio/url/:prayer_book/:voice/:slug", to: "audio#url"

      # Rotas de admin
      namespace :admin do
        get "audio/generation_status", to: "audio#generation_status"
      end

      # Rotas de regras de vida
      resources :life_rules, only: [ :index, :show, :create, :update, :destroy ] do
        collection do
          get :my
        end
        member do
          post :adopt
          post :approve
        end
      end
    end
  end

  # Rota raiz com informações da API
  root "home#index"
end
