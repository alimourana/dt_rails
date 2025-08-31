# frozen_string_literal: true

module Endpoints
  module V1
    module Users
      class Update < Grape::API
        include V1::Users::Common

        before do
          user_exists!
        end

        resource :users do
          namespace_setting(:category, 'users')

          desc 'Update a user', {
            summary: 'Update a user',
            detail: 'Update a user with the given ID and parameters',
            success: [
              { code: 200, model: Entities::User }
            ],
            failure: [
              { code: 400, message: 'Bad Request' },
              { code: 401, message: 'Unauthorized' },
              { code: 404, message: 'Not Found' }
            ]
          }

          params do
            requires :id, type: Integer, desc: 'User ID'
            optional :last_name, type: String, desc: 'Last name'
            optional :email, type: String, desc: 'Email address'
            optional :phone_number, type: String, desc: 'Phone number'
            optional :address_line, type: String, desc: 'Address line'
            optional :city, type: String, desc: 'City'
            optional :state, type: String, desc: 'State'
            optional :country, type: String, desc: 'Country'
            optional :role, type: String, desc: 'User role'
            optional :is_active, type: Boolean, desc: 'Active status'
          end
          patch ':id/update' do
            response = Users::Update.call(params: declared_params)

            if response.success
              present response.object, with: Entities::User
            else
              error!(response.object, 400)
            end
          end
        end
      end
    end
  end
end
