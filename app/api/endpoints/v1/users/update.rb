module Endpoints
  module V1
    module Users
      class Update < Grape::API
      
        resource :users do
          namespace_setting(:category, "users")
          
          desc 'Update a user', {
            summary: 'Update a user',
            detail: 'Update a user with the given ID and parameters',
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
          # endpoint "updateUser"
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
            user = User.find(params[:id])
            update_params = {}
            update_params[:first_name] = params[:first_name] if params[:first_name]
            update_params[:last_name] = params[:last_name] if params[:last_name]
            update_params[:email] = params[:email] if params[:email]
            update_params[:phone_number] = params[:phone_number] if params[:phone_number]
            update_params[:address_line] = params[:address_line] if params[:address_line]
            update_params[:city] = params[:city] if params[:city]
            update_params[:state] = params[:state] if params[:state]
            update_params[:country] = params[:country] if params[:country]
            update_params[:role] = params[:role] if params[:role]
            update_params[:is_active] = params[:is_active] unless params[:is_active].nil?
            
            user.update!(update_params)
            present user, with: Entities::User
          end
        end
      end
    end
  end
end


