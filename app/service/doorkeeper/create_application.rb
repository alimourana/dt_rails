# frozen_string_literal: true

# Create a new user application
#
# @param user [User] User which creates the application. If owner is not passed, this parameter is an application owner.
# @param owner [User, Enterprise] (optional) Owner of the application
# @param params [Hash] Applications params
#
# @result [Doorkeeper::CreateApplication::Result] Result of the operation
#   on success operation, returns success status as a true and created application as an object
#   on failed result, returns success status as a false and string with error message as an object
class Doorkeeper::CreateApplication
  include Callable

  USER_SCOPES = %w[read write].freeze
  Result = Struct.new(:success?, :object)

  def initialize(user:, params:, owner: nil)
    @user = user
    @owner = owner
    @params = params
  end

  def call
    application = OauthApplication.new(application_params)

    if application.valid?
      application.save
      Result.new(true, application)
    else
      Result.new(false, application.errors.map(&:full_message).join(". "))
    end
  end

  private

  attr_reader :user, :params, :owner

  def application_owner
    owner || user
  end

  def application_params
    {
      name: params[:name],
      scopes: params[:scopes].filter { |item| ::ApiSettings::USER_SCOPES.include?(item) },
      created_by: user,
      owner: application_owner,
    }
  end
end
