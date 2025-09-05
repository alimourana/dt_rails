# frozen_string_literal: true

# API entity for oauth applications response
module Entities
  module OauthApplications
    class Response < BaseEntity
      READ_AND_WRITE_PERMISSION = "2"
      READ_ONLY_PERMISSION = "1"
      NONE_PERMISSION = "0"

      expose :id, documentation: {type: "Integer", desc: "Application id"}
      expose :name, documentation: {type: "String", desc: "Application Name"}
      expose :uid, documentation: {type: "String", desc: "Application Public Key"}
      expose :scopes, documentation: {type: "Array<String>", desc: "Application Scopes"}
      expose :created_by, documentation: {type: "String", desc: "Creator of the application"}
      expose :can_edit, documentation: {type: "Boolean", desc: "Can the owner edit or delete the application"}
      expose :owner_id, documentation: {type: "Integer", desc: "Application owner id"}

      with_options(format_with: :iso8601) do
        expose :created_at, documentation: {type: "DateTime", desc: "The creation time."}
        expose :last_used_at, documentation: {type: "DateTime", desc: "Last time application was used."}
      end

      def created_by
        object.created_by&.full_name
      end

      def can_edit
        OauthApplicationPolicy.new(current_owner, object).update?
      end
    end
  end
end