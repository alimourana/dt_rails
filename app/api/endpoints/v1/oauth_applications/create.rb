# frozen_string_literal: true

module Endpoints
  module V1
    module OauthApplications
      class Create < Grape::API
        include V1::OauthApplications::Common

        resource :oauth_applications do
          desc 'Create a new oauth application', {
            summary: 'Create a new oauth application',
            detail: 'Create a new oauth application',
            security: [{ oauth: [] }],
            success: [
              { code: 200, model: Entities::OauthApplications::CreateResponse }
            ],
            failure: [
              { code: 403, message: 'You are not authorized to access this resource' },
              { code: 400, message: 'Validation error' },
            ]
          }
          params do
            requires :name, type: String, desc: 'Application name'
            requires :scopes, type: Array, desc: 'Application scopes'
          end
          post "" do
            return error!("You are not authorized to access this resource", 403) unless scope_policy.create?

            application = Doorkeeper::CreateApplication.call(user: current_owner, params: application_params)
            present application, with: Entities::OauthApplications::CreateResponse
          end
        end
      end
    end
  end
end