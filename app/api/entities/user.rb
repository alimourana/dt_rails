# frozen_string_literal: true

module Entities
  class User < Grape::Entity
    expose :id, documentation: { type: 'Integer', desc: 'User ID' }
    expose :first_name, documentation: { type: 'String', desc: 'User first name' }
    expose :last_name, documentation: { type: 'String', desc: 'User last name' }
    expose :email, documentation: { type: 'String', desc: 'User email' }
    expose :phone_number, documentation: { type: 'String', desc: 'User phone number' }
    expose :role, documentation: { type: 'String', desc: 'User role' }
    expose :is_active, documentation: { type: 'Boolean', desc: 'User is active' }
    expose :address_line, documentation: { type: 'String', desc: 'User address line' }
    expose :city, documentation: { type: 'String', desc: 'User city' }
    expose :state, documentation: { type: 'String', desc: 'User state' }
    expose :country, documentation: { type: 'String', desc: 'User country' }
  end
end
