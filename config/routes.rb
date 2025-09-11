# config/routes.rb

begin
  require 'sidekiq/web'
rescue LoadError
  # Sidekiq is not available
end


Rails.application.routes.draw do
  # Health check endpoint
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA support
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Products + nested competitor products
  resources :products, only: [:index, :show] do
    # Import feed (POST with feed_url or feed_file)
    post :import_feed, on: :collection

    # Refresh competitor data for a single product (enqueues job for all competitors that have ASIN)
    post :refresh_competitors, on: :member

    # Nested CRUD for competitor products belonging to a product
    resources :competitor_products, only: [:create, :update, :destroy]
  end

  # Dashboard view (myupchar product vs competition)
  get 'dashboard', to: 'dashboard#index', as: :dashboard

  root "products#index"

  # Sidekiq dashboard
  if Rails.env.development?
    mount Sidekiq::Web => '/sidekiq'
  end
end
