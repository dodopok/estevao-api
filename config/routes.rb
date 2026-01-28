Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Root path
  root "home#index"

  # API routes
  namespace :api do
    namespace :v1 do
      # Prayer Intentions
      resources :prayer_intentions do
        member do
          post :enrich
          post :mark_answered
          post :record_prayer
          post :archive
        end
        
        collection do
          get :categories
          get :stats
          get :community
        end
      end
      
      # Calendar routes
      get 'calendar/today', to: 'calendar#today'
      get 'calendar/:year/:month/:day', to: 'calendar#show'
      get 'calendar/:year/:month', to: 'calendar#month'
      get 'calendar/:year', to: 'calendar#year'
      
      # Celebrations
      resources :celebrations, only: [:index, :show] do
        collection do
          get :search
          get :types
          get 'date/:month/:day', to: 'celebrations#by_date'
        end
      end
      
      # Lectionary
      get 'lectionary/:year/:month/:day', to: 'lectionary#show'
      get 'lectionary/:year/:month/:day/all_services', to: 'lectionary#all_services'
      get 'lectionary/cycle/:year', to: 'lectionary#cycle'
      
      # Daily Office
      get 'daily_office/today/:office_type', to: 'daily_office#today'
      get 'daily_office/:year/:month/:day/:office_type', to: 'daily_office#show'
      get 'daily_office/:year/:month/:day/:office_type/family', to: 'daily_office#family'
      get 'daily_office/preferences', to: 'daily_office#preferences'
      
      # Users
      get 'users/me', to: 'users#me'
      patch 'users/preferences', to: 'users#update_preferences'
      get 'users/completions', to: 'users#completions'
      post 'users/fcm_token', to: 'users#register_fcm_token'
      delete 'users/fcm_token', to: 'users#remove_fcm_token'
      
      # Completions
      resources :completions, only: [:create, :destroy]
      get 'completions/:year/:month/:day/:office_type', to: 'completions#status'
      
      # Life Rules
      resources :life_rules do
        member do
          post :adopt
          post :approve
        end
      end
      
      # Prayer Books
      resources :prayer_books, only: [:index, :show], param: :code do
        member do
          get :features
          get :preferences
          patch :preferences, action: :update_preferences
        end
      end
      
      # Subscription
      post 'subscription/verify', to: 'subscription#verify'
      get 'subscription/premium_status', to: 'subscription#premium_status'
      
      # Audio
      get 'audio/voice_samples', to: 'audio#voice_samples'
      get 'audio/url/:prayer_book/:voice/:slug', to: 'audio#url'
      
      # Admin - Audio
      namespace :admin do
        get 'audio/generation_status', to: 'audio#generation_status'
      end
      
      # Notifications (Admin)
      post 'notifications/send', to: 'notifications#send_notification'
      post 'notifications/broadcast', to: 'notifications#broadcast'
    end
  end
  
  # Swagger/OpenAPI documentation
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
end
