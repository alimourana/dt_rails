# frozen_string_literal: true

Rails.application.routes.draw do
  use_doorkeeper do
    controllers :applications => 'oauth/applications'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Authentication routes
  get 'sign_in', to: 'auth/sessions#new', as: :new_auth_session
  post 'sign_in', to: 'auth/sessions#create', as: :auth_session
  delete 'sign_out', to: 'auth/sessions#destroy', as: :destroy_auth_session
  get 'sign_up', to: 'auth/registrations#new', as: :new_auth_registration
  post 'sign_up', to: 'auth/registrations#create', as: :auth_registration

  # OAuth application management routes
  resources :oauth_applications, path: 'oauth/applications'

  mount ::Endpoints::Base => '/'
  # Defines the root path route ("/")
  root "home#index"
end
