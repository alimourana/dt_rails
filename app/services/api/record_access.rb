# frozen_string_literal: true

# Stores the api applications call count in redis every time the "record_access" is called. A background job is run to save them in the database every night.
#
# @!attribute oauth_applications
#   @return [OauthApplication] The current OauthApplication.

class Api::RecordAccess
  include Callable
  attr_reader :oauth_application

  def initialize(oauth_application:)
    @oauth_application = oauth_application
  end

  def call
    return if oauth_application.blank?

    store = Redis.new
    store.incr("api_applications:#{oauth_application.id}")
  end
end
