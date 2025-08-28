module Endpoints
  module V1
    module Users
      class List < Grape::API
        resource :users do
          desc 'Get all users'
          get do
            users = User.all
            present users, with: Entities::User
          end
        end
      end
    end
  end
end