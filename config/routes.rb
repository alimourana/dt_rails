# frozen_string_literal: true

Rails.application.routes.draw do
  use_doorkeeper do
    controllers :applications => 'oauth/applications'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  mount ::Endpoints::Base => '/'
  # Defines the root path route ("/")
  root "home#index"
end
