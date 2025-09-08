# config/routes.rb

require 'sidekiq/web'   # <- move this to the top

Rails.application.routes.draw do

  # resources :products
  # resources :competitor_products
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  

  # Health check endpoint
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA support
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  get "dashboard/index"
  root "products#index"

  # Sidekiq dashboard
  if Rails.env.development?
    mount Sidekiq::Web => '/sidekiq'
  end
end
