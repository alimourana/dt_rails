# frozen_string_literal: true

module Api
  module Entities
    module Oauth
      class TokenResponse < Grape::Entity
        expose :access_token, documentation: { type: String, desc: 'Access token' }
        expose :token_type, documentation: { type: String, desc: 'Token type (Bearer)' }
        expose :expires_in, documentation: { type: Integer, desc: 'Token expiration time in seconds' }
        expose :scope, documentation: { type: String, desc: 'Granted scopes' }
        expose :refresh_token, documentation: { type: String, desc: 'Refresh token (if applicable)' }
      end
    end
  end
end
