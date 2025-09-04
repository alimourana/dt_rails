# frozen_string_literal: true

module Auth
  module AccessToken
    # Returns a hash with the access token params.
    #
    # @!attribute access_token
    #   @return [Doorkeeper::AccessToken] The access token
    # @return [Hash] A hash with the access token params
    class Params
      include Callable

      def initialize(access_token:)
        @access_token = access_token
      end

      def call
        {
          access_token: access_token.token,
          token_type: "bearer",
          expires_in: access_token.expires_in,
          created_at: access_token.created_at.to_time.to_i,
          refresh_token: access_token.refresh_token,
          scopes: access_token.scopes,
          owner_id: access_token.resource_owner_id,
        }
      end

      private

      attr_reader :access_token
    end
  end
end
