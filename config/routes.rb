# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  use_doorkeeper do
    controllers :applications => 'oauth/applications'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # OAuth application management routes
  resources :oauth_applications, path: 'oauth/applications'

  # Admin routes
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    post 'dashboard/toggle_maintenance_mode', to: 'dashboard#toggle_maintenance_mode'
    post 'dashboard/update_system_health', to: 'dashboard#update_system_health'
  end

  mount ::Endpoints::Base => '/'
  # Defines the root path route ("/")
  root "home#index"
end
