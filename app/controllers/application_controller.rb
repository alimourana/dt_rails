# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    session[:user_id] = nil
    nil
  end

  def authenticate_user!
    redirect_to sign_in_path unless current_user
  end

  def sign_in_path
    new_auth_session_path
  end

  def stored_location
    session[:stored_location]
  end

  def store_location
    session[:stored_location] = request.fullpath
  end

  def configure_permitted_parameters
    # This method is here for compatibility but not used in this implementation
  end

  helper_method :current_user, :user_signed_in?

  def user_signed_in?
    current_user.present?
  end
end
