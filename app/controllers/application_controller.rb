# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :track_page_view, if: :user_signed_in?
  before_action :check_rate_limit, if: :should_rate_limit?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone_number, :address_line, :city, :state, :country, :role, :is_active])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone_number, :address_line, :city, :state, :country, :role, :is_active])
  end

  def track_page_view
    return unless current_user

    # Track page view for current user
    current_user.page_views.increment

    # Track global API request
    KredisService.track_api_request(request.path, current_user.id)

    # Track user activity
    KredisService.track_user_activity(
      current_user.id,
      'page_view',
      {
        controller: controller_name,
        action: action_name,
        path: request.path,
        method: request.method
      }
    )
  end

  def check_rate_limit
    return unless current_user

    identifier = "#{current_user.id}:#{request.remote_ip}"
    
    unless KredisService.check_rate_limit(identifier, limit: 1000, window: 1.hour)
      render json: { error: 'Rate limit exceeded' }, status: 429
    end
  end

  def should_rate_limit?
    # Only rate limit API endpoints
    request.path.start_with?('/api/') || request.path.start_with?('/oauth/')
  end
end
