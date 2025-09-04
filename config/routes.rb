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

  mount ::Endpoints::Base => '/'
  # Defines the root path route ("/")
  root "home#index"
end
