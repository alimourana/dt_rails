module Endpoints
  module V1
    module Users
      class Create < Grape::API
        
        resource :users do
          namespace_setting(:category, "users")
          
          desc 'Create a new user', {
            summary: 'Create a new user',
            detail: 'Create a new user with the given parameters',
            success: [
              { code: 200, model: Entities::User }
            ],
            failure: [
              { code: 400, message: 'Bad Request' },
              { code: 401, message: 'Unauthorized' },
              { code: 404, message: 'Not Found' },
              { code: 500, message: 'Internal Server Error' }
            ]
          }
          # endpoint "createUser"
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
            optional :role, type: String, desc: 'User role', default: 'user'
            optional :is_active, type: Boolean, desc: 'Active status', default: true
          end
          post do
            user_params = {
              first_name: params[:first_name],
              last_name: params[:last_name],
              email: params[:email],
              encrypted_password: params[:encrypted_password],
              phone_number: params[:phone_number],
              address_line: params[:address_line],
              city: params[:city],
              state: params[:state],
              country: params[:country],
              role: params[:role] || 'user',
              is_active: params[:is_active].nil? ? true : params[:is_active]
            }
            user = User.create!(user_params)
            present user, with: Entities::User
          end
        end
      end
    end
  end
end


