# frozen_string_literal: true

module Endpoints
  module V1
    module OauthApplications
      class Delete < Grape::API
        include V1::OauthApplications::Common

        resource :oauth_applications do
          desc 'Delete an oauth application', {
            summary: 'Delete an oauth application',
            detail: 'Delete an oauth application',
            success: [
              { code: 200, message: 'Oauth application deleted successfully' }
            ],
            failure: [
              { code: 403, message: 'You are not authorized to access this resource' },
            ]
          }
          delete ':id/delete' do
            return error!("You are not authorized to access this resource", 403) unless scope_policy.destroy?
            current_record.destroy!

            { code: 200, message: "Oauth application with id #{current_record.id} has been successfully deleted" }
          end
        end
      end
    end
  end
end