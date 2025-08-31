# frozen_string_literal: true

module Endpoints
  module V1
    module Users
      class Create < Grape::API
        include V1::Users::Common

        before do
          user_exists!
        end

        resource :users do
          namespace_setting(:category, 'users')

          desc 'Create a new user', {
            summary: 'Create a new user',
            detail: 'Create a new user with the given parameters',
            success: [
              { code: 200, model: Entities::User }
            ],
            failure: [
              { code: 401, message: Strings::ERROR_USER_EXISTS }
            ]
          }

          params do
            requires :first_name, type: String, desc: 'First name'
            requires :last_name, type: String, desc: 'Last name'
            requires :email, type: String, desc: 'Email address'
            requires :encrypted_password, type: String, desc: 'Encrypted password'
            requires :phone_number, type: String, desc: 'Phone number'
            requires :address_line, type: String, desc: 'Address line'
            requires :city, type: String, desc: 'City'
            requires :state, type: String, desc: 'State'
            requires :country, type: String, desc: 'Country'
            optional :role, type: String, values: %w(user admin manager), desc: 'User role', default: 'user'
            optional :is_active, type: Boolean, desc: 'Active status', default: true
          end
          post 'create' do
            user = User.create!(declared_params)
            present user, with: Entities::User
          end
        end
      end
    end
  end
end
