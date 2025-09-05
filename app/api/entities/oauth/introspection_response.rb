# frozen_string_literal: true

module Api
  module Entities
    module Oauth
      class IntrospectionResponse < Grape::Entity
        expose :active, documentation: { type: Boolean, desc: 'Whether the token is active' }
        expose :scope, documentation: { type: String, desc: 'Token scopes' }
        expose :client_id, documentation: { type: String, desc: 'Client ID' }
        expose :username, documentation: { type: String, desc: 'Username' }
        expose :exp, documentation: { type: Integer, desc: 'Expiration timestamp' }
        expose :iat, documentation: { type: Integer, desc: 'Issued at timestamp' }
        expose :sub, documentation: { type: Integer, desc: 'Subject (user ID)' }
      end
    end
  end
end
