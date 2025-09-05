# frozen_string_literal: true

class Auth::GenerateAccessToken
  include Callable

  def initialize(application:, user:, scopes:)
    @application = application
    @user = user
    @scopes = scopes
  end

  def call
    Doorkeeper::AccessToken.find_or_create_for(
      application: application,
      resource_owner: user,
      scopes: scopes,
      expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
      use_refresh_token: true,
    )
  end

  private

  attr_reader :application, :user, :scopes
end
