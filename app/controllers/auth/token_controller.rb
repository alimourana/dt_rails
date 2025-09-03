# frozen_string_literal: true

# Handles issuing tokens for first-party applications
class Auth::TokenController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: %i[issue]

  # Action to issue a new token for first-party applications using the primary internal application
  def issue
    access_token = Auth::GenerateAccessToken.call(
      application: application,
      user: current_user,
      scopes: application.scopes,
    )

    render json: Auth::AccessToken::Params.call(access_token: access_token)
  end

  private

  def application
    @_application ||= OauthApplication.find_by(uid: Auth::Constants::INTERNAL_APPLICATION_UID)
  end
end
