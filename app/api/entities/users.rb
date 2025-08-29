module Entities
  class Users < Grape::Entity
    expose :items, using: Entities::User
  end
end