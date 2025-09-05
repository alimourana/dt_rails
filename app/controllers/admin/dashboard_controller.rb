# frozen_string_literal: true

class Admin::DashboardController < ApplicationController
  before_action :ensure_admin!

  def index
    @system_health = KredisService.system_health.value || {}
    @recent_activities = KredisService.recent_activities.elements.first(10)
    @total_stats = {
      api_requests: KredisService.total_api_requests.value,
      oauth_tokens: KredisService.total_oauth_tokens_issued.value,
      users_registered: KredisService.total_users_registered.value
    }
    @maintenance_mode = KredisService.maintenance_mode.marked?
  end

  def toggle_maintenance_mode
    if KredisService.maintenance_mode.marked?
      KredisService.disable_maintenance_mode
      flash[:notice] = 'Maintenance mode disabled'
    else
      KredisService.enable_maintenance_mode
      flash[:notice] = 'Maintenance mode enabled'
    end
    
    redirect_to admin_dashboard_path
  end

  def update_system_health
    KredisService.update_system_health
    flash[:notice] = 'System health updated'
    redirect_to admin_dashboard_path
  end

  private

  def ensure_admin!
    redirect_to root_path unless current_user&.admin?
  end
end
