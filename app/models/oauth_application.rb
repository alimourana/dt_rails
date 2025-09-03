# frozen_string_literal: true

class OauthApplication < ApplicationRecord
  include Doorkeeper::Orm::ActiveRecord::Mixins::Application
  include Doorkeeper::Models::Ownership

  self.table_name = "oauth_applications"
end