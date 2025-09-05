# frozen_string_literal: true

module Endpoints
  module V1
    module OauthApplications
      class List < Grape::API
        include V1::OauthApplications::Common

        resource :oauth_applications do
          desc 'Get all oauth applications', {
            summary: 'Get all oauth applications',
            detail: 'Get all oauth applications',
            success: [
              { code: 200, model: Entities::OauthApplications::ListResponse }
            ],
            failure: [
              { code: 403, message: 'You are not authorized to access this resource' },
            ]
          }
          get "", scopes: ["internal"] do
            return error!("Do not have access to this resource", 403) unless scope_policy.index?
    
            present applications_scope_class.application_resolve.includes(created_by: :profile),
              with: Entities::OauthApplications::ListResponse,
              current_owner: current_owner
          end
        end
      end
    end
  end
end