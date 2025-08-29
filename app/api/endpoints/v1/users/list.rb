module Endpoints
  module V1
    module Users
      class List < Grape::API
        resource :users do
          namespace_setting(:category, "users")

          desc 'Get all users', {
            summary: 'Get all users',
            detail: 'Get all users',
            success: [
              { code: 200, model: Entities::Users }
            ],
            failure: [
              { code: 400, message: 'Bad Request' },
              { code: 401, message: 'Unauthorized' },
            ]
          }
          # endpoint "getAllUsers"
          get do
            users = User.all
            present users, with: Entities::Users
          end
        end
      end
    end
  end
end