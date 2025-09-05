# frozen_string_literal: true

module Endpoints
  module V1
    class Oauth < Grape::API
      version 'v1', using: :path
      format :json

      # OAuth token endpoint
      desc 'Get access token'
      params do
        requires :grant_type, type: String, desc: 'Grant type'
        optional :client_id, type: String, desc: 'Client ID'
        optional :client_secret, type: String, desc: 'Client Secret'
        optional :username, type: String, desc: 'Username (for password grant)'
        optional :password, type: String, desc: 'Password (for password grant)'
        optional :code, type: String, desc: 'Authorization code (for authorization code grant)'
        optional :redirect_uri, type: String, desc: 'Redirect URI'
        optional :scope, type: String, desc: 'Requested scopes'
      end
      post :token do
        case params[:grant_type]
        when 'client_credentials'
          handle_client_credentials_grant
        when 'password'
          handle_password_grant
        when 'authorization_code'
          handle_authorization_code_grant
        when 'refresh_token'
          handle_refresh_token_grant
        else
          error!('Unsupported grant type', 400)
        end
      end

      # OAuth authorization endpoint
      desc 'Authorize application'
      params do
        requires :client_id, type: String, desc: 'Client ID'
        requires :response_type, type: String, desc: 'Response type'
        requires :redirect_uri, type: String, desc: 'Redirect URI'
        optional :scope, type: String, desc: 'Requested scopes'
        optional :state, type: String, desc: 'State parameter'
      end
      get :authorize do
        application = OauthApplication.find_by(uid: params[:client_id])
        error!('Invalid client', 400) unless application

        if params[:response_type] == 'code'
          # Generate authorization code
          code = Doorkeeper::AccessGrant.create!(
            application: application,
            resource_owner_id: current_user.id,
            expires_in: 600, # 10 minutes
            redirect_uri: params[:redirect_uri],
            scopes: params[:scope] || ''
          )

          redirect_uri = URI.parse(params[:redirect_uri])
          redirect_uri.query = {
            code: code.token,
            state: params[:state]
          }.compact.to_query

          redirect redirect_uri.to_s
        else
          error!('Unsupported response type', 400)
        end
      end

      # OAuth token introspection endpoint
      desc 'Introspect token'
      params do
        requires :token, type: String, desc: 'Token to introspect'
        optional :token_type_hint, type: String, desc: 'Token type hint'
      end
      post :introspect do
        token = Doorkeeper::AccessToken.find_by(token: params[:token])
        
        if token&.acceptable?(nil)
          {
            active: true,
            scope: token.scopes.to_s,
            client_id: token.application.uid,
            username: token.resource_owner&.email,
            exp: token.expires_at&.to_i,
            iat: token.created_at.to_i,
            sub: token.resource_owner_id
          }
        else
          { active: false }
        end
      end

      # OAuth token revocation endpoint
      desc 'Revoke token'
      params do
        requires :token, type: String, desc: 'Token to revoke'
        optional :token_type_hint, type: String, desc: 'Token type hint'
      end
      post :revoke do
        token = Doorkeeper::AccessToken.find_by(token: params[:token])
        token&.revoke!
        
        status 200
        { message: 'Token revoked successfully' }
      end

      private

      def handle_client_credentials_grant
        application = OauthApplication.find_by(uid: params[:client_id])
        error!('Invalid client', 400) unless application
        error!('Invalid client secret', 400) unless application.secret == params[:client_secret]

        token = Doorkeeper::AccessToken.create!(
          application: application,
          resource_owner_id: nil,
          scopes: params[:scope] || '',
          expires_in: 3600 # 1 hour
        )

        {
          access_token: token.token,
          token_type: 'Bearer',
          expires_in: token.expires_in,
          scope: token.scopes.to_s
        }
      end

      def handle_password_grant
        user = User.find_by(email: params[:username])
        error!('Invalid credentials', 400) unless user&.valid_password?(params[:password]) && user.active_for_authentication?

        application = OauthApplication.find_by(uid: params[:client_id])
        error!('Invalid client', 400) unless application

        token = Doorkeeper::AccessToken.create!(
          application: application,
          resource_owner_id: user.id,
          scopes: params[:scope] || '',
          expires_in: 3600 # 1 hour
        )

        {
          access_token: token.token,
          token_type: 'Bearer',
          expires_in: token.expires_in,
          scope: token.scopes.to_s,
          refresh_token: token.refresh_token
        }
      end

      def handle_authorization_code_grant
        grant = Doorkeeper::AccessGrant.find_by(token: params[:code])
        error!('Invalid authorization code', 400) unless grant
        error!('Authorization code expired', 400) if grant.expired?

        application = OauthApplication.find_by(uid: params[:client_id])
        error!('Invalid client', 400) unless application
        error!('Invalid redirect URI', 400) unless grant.redirect_uri == params[:redirect_uri]

        token = Doorkeeper::AccessToken.create!(
          application: application,
          resource_owner_id: grant.resource_owner_id,
          scopes: grant.scopes,
          expires_in: 3600 # 1 hour
        )

        grant.destroy

        {
          access_token: token.token,
          token_type: 'Bearer',
          expires_in: token.expires_in,
          scope: token.scopes.to_s,
          refresh_token: token.refresh_token
        }
      end

      def handle_refresh_token_grant
        token = Doorkeeper::AccessToken.find_by(refresh_token: params[:refresh_token])
        error!('Invalid refresh token', 400) unless token&.acceptable?(nil)

        new_token = Doorkeeper::AccessToken.create!(
          application: token.application,
          resource_owner_id: token.resource_owner_id,
          scopes: token.scopes,
          expires_in: 3600 # 1 hour
        )

        token.revoke!

        {
          access_token: new_token.token,
          token_type: 'Bearer',
          expires_in: new_token.expires_in,
          scope: new_token.scopes.to_s,
          refresh_token: new_token.refresh_token
        }
      end
    end
  end
end
