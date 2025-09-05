# frozen_string_literal: true

class OauthApplication < ApplicationRecord
  include Doorkeeper::Orm::ActiveRecord::Mixins::Application
  include Doorkeeper::Models::Ownership

  self.table_name = "oauth_applications"

  # Kredis data structures
  kredis_counter "api_calls"
  kredis_list "recent_errors"
  kredis_set "active_scopes"
  kredis_flag "rate_limited"
  kredis_json "usage_stats"
end