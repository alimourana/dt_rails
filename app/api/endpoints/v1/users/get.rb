module Endpoints
  module V1
    module Users
      class Get < Grape::API
      
        resource :users do
          namespace_setting(:category, "users")
        
          desc 'Get a specific user', {
            summary: 'Get a specific user',
            detail: 'Get a specific user with the given ID',
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
          # endpoint "getUser"
          params do
            requires :id, type: Integer, desc: 'User ID'
          end
          get ':id' do
            user = User.find(params[:id])
            present user, with: Entities::User
          end
        end
      end
    end
  end
end


