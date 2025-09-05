# frozen_string_literal: true

# Track when the new token has been created or refreshed and update last usage information for the application
#
# @param context [Doorkeeper::OAuth::Hooks::Context] Context info for action which created or refresh the token.
class Doorkeeper::TrackTokenCreation
  include Callable

  attr_reader :context

  def initialize(context:)
    @context = context
  end

  def call
    return if token.blank? || application.internal?

    application.last_used_at = token.created_at
    application.save
  end

  private

  def token
    @_token ||= context&.auth&.token
  end

  def application
    @_application ||= token.application
  end
end
