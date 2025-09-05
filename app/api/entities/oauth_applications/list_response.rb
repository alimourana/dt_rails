# frozen_string_literal: true

module Entities
  module OauthApplications
    class ListResponse < BaseEntity
      present_collection true
      expose :items, using: Entities::OauthApplications::Response, documentation: { type: 'Array[OauthApplication]', desc: 'Array of oauth applications' }
    end
  end
end