# frozen_string_literal: true

module Endpoints
  module ApiDefault
    extend ActiveSupport::Concern

    included do
      version 'v1', using: :path
      format :json
      prefix :api

      helpers do
        def declared_params
          declared(params, include_missing: false)
        end
      end
    end
  end
end
