# frozen_string_literal: true

module Endpoints
  module V1
    module OauthApplications
      class Update < Grape::API
        include V1::OauthApplications::Common

        resource :oauth_applications do
          desc 'Update an oauth application', {
            summary: 'Update an oauth application',
            detail: 'Update an oauth application',
            success: [
              { code: 200, model: Entities::OauthApplications::Response }
            ],
            failure: [
              { code: 403, message: 'You are not authorized to access this resource' },
              { code: 400, message: 'Validation error' },
            ]
          }
          params do
            requires :name, type: String, desc: 'Application name'
            requires :scopes, type: Array, desc: 'Application scopes'
            optional :owner_id, type: Integer, desc: 'Application owner id'
          end
          put ':id/update' do
            return error!("You are not authorized to access this resource", 403) unless scope_policy.update?

            result = Doorkeeper::UpdateApplication.call(
              application: current_record,
              params: application_params,
              owner: params[:owner_id] if params[:owner_id].present?,
            )

            if result.success
              present result.object, with: Entities::OauthApplications::Response
            else
              error!(result.object, 400)
            end
          end
        end
      end
    end
  end
end