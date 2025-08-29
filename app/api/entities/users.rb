module Entities
  class Users < Grape::Entity
    present_collection true

    expose :items, using: Entities::User, documentation: { type: 'Array[User]', desc: 'Array of users' }
  end
end