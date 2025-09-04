# frozen_string_literal: true

# Update the user application
#
# @param user [Doorkeeper::Application] Application for updating
# @param params [Hash] Applications params
#
# @result [Doorkeeper::UpdateApplication::Result] Result of the operation
#   on success operation, returns success status as a true and updated application as an object
#   on failed result, returns success status as a false and string with error message as an object
class Doorkeeper::UpdateApplication
  include Callable

  USER_SCOPES = %w[read write].freeze
  Result = Struct.new(:success?, :object)

  attr_reader :application, :params, :owner

  def initialize(application:, params:, owner: nil)
    @application = application
    @params = params
    @owner = owner
  end

  def call
    application.assign_attributes(application_params)

    update_owner if owner.present?

    if application.valid?
      application.save
      Result.new(true, application)
    else
      Result.new(false, application.errors.map(&:full_message).join(". "))
    end
  end

  private

  def update_owner
    application.owner = owner
  end

  def application_params
    {
      name: params[:name],
      scopes: params[:scopes].filter { |item| ::ApiSettings::USER_SCOPES.include?(item) },
    }
  end
end
