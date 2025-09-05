# frozen_string_literal: true

require 'doorkeeper/grape/helpers'

module Endpoints
  module ApiDefault
    extend ActiveSupport::Concern

    included do
      version 'v1', using: :path
      format :json
      prefix :api

      helpers Doorkeeper::Grape::Helpers

      before do
        authorize!
        Current.api_actor = api_actor
        Current.user = current_owner
      end

      helpers do
        def authorize!
          anonymous = endpoint.route_setting(:anonymous)
  
          return if anonymous.present? && anonymous[:enabled]
  
          doorkeeper_authorize!
        end

        def current_application
          return nil if doorkeeper_token.blank?
  
          @_current_application ||= OauthApplication.find(doorkeeper_token.application_id)
        end

        def current_owner
          return nil if doorkeeper_token.blank?
  
          @_current_owner ||= current_application.owner || User.find(doorkeeper_token.resource_owner_id)
        end
  
        def endpoint_scopes
          endpoint.options[:route_options][:scopes]
        end

        def declared_params
          declared(params, include_missing: false)
        end

        def api_actor
          current_application
        end

        def api_error!(message, status:, log_message:)
          Rails.logger.info "[API Handled Error] #{status} | #{log_message}"
  
          error!(message, status)
        end
      end

      rescue_from ActiveRecord::RecordNotFound do |e|
        error_response(message: e.message, status: 404)
      end
  
      rescue_from ActiveRecord::RecordInvalid do |e|
        error_response(message: e.message, status: 422)
      end
    end
  end
end
