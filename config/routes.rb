# frozen_string_literal: true

Rails.application.routes.draw do
  ActiveAdmin.routes(self)

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
    get 'system_dashboard', to: 'system_dashboard#index'
    post 'system_dashboard/toggle_maintenance_mode', to: 'system_dashboard#toggle_maintenance_mode'
    post 'system_dashboard/update_system_health', to: 'system_dashboard#update_system_health'
  end

  mount ::Endpoints::Base => '/'
  # Defines the root path route ("/")
  root "home#index"
end
