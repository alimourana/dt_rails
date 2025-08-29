module Endpoints
  module V1
    module Users
      class Delete < Grape::API
        resource :users do
          namespace_setting(:category, "users")
          
          desc 'Delete a user', {
            summary: 'Delete a user',
            detail: 'Delete a user with the given ID',
            success: [
              { code: 200, message: 'User deleted successfully' }
            ],
            failure: [
              { code: 400, message: 'Bad Request' },
              { code: 401, message: 'Unauthorized' },
              { code: 404, message: 'Not Found' },
              { code: 500, message: 'Internal Server Error' }
            ]
          }
          # endpoint "deleteUser"
          params do
            requires :id, type: Integer, desc: 'User ID'
          end
          delete ':id' do
            user = User.find(params[:id])
            user.destroy!
            { message: 'User deleted successfully' }
          end
        end
      end
    end
  end
end