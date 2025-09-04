# frozen_string_literal: true

module Endpoints
  module V1
    module OauthApplications
      module Common
        extend ActiveSupport::Concern

        included do
          include Endpoints::ApiDefault
        end

        helpers do
          def applications_scope_class
            @_applications_policy_class ||= OauthApplicationPolicy::Scope.new(current_owner, OauthApplication.all)
          end
    
          def applications_scope
            applications_scope_class.resolve
          end
    
          def scope_policy
            @_scope_policy ||= policy(OauthApplication)
          end
    
          def current_record
            @_current_record ||= applications_scope.find(params[:id])
          end
    
          def record_policy
            @_record_policy ||= policy(current_record)
          end
    
          def application_params
            {
              name: params[:name],
              scopes: params[:scopes],
            }
          end
        end
      end
    end
  end
end