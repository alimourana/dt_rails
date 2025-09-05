# frozen_string_literal: true

class KredisService
  # Global application counters
  def self.total_api_requests
    @total_api_requests ||= Kredis.counter("total_api_requests")
  end

  def self.total_oauth_tokens_issued
    @total_oauth_tokens_issued ||= Kredis.counter("total_oauth_tokens_issued")
  end

  def self.total_users_registered
    @total_users_registered ||= Kredis.counter("total_users_registered")
  end

  # Global application flags
  def self.maintenance_mode
    @maintenance_mode ||= Kredis.flag("maintenance_mode")
  end

  def self.rate_limiting_enabled
    @rate_limiting_enabled ||= Kredis.flag("rate_limiting_enabled")
  end

  # Global application data
  def self.system_health
    @system_health ||= Kredis.json("system_health")
  end

  def self.recent_activities
    @recent_activities ||= Kredis.list("recent_activities")
  end

  def self.active_sessions
    @active_sessions ||= Kredis.set("active_sessions")
  end

  class << self
    # Track API usage
    def track_api_request(endpoint, user_id = nil)
      total_api_requests.increment
      
      # Track per-user API usage
      if user_id
        user = User.find(user_id)
        user.page_views.increment
      end

      # Log recent activity
      activity = {
        endpoint: endpoint,
        user_id: user_id,
        timestamp: Time.current.iso8601,
        ip: nil
      }
      recent_activities.prepend(activity.to_json)
    end

    # Track OAuth token issuance
    def track_oauth_token_issuance(application_id, user_id)
      total_oauth_tokens_issued.increment
      
      # Track per-application usage
      app = OauthApplication.find(application_id)
      app.api_calls.increment
      
      # Update usage stats
      stats = app.usage_stats.value || {}
      stats[:tokens_issued] = (stats[:tokens_issued] || 0) + 1
      stats[:last_token_issued] = Time.current.iso8601
      app.usage_stats.value = stats
    end

    # Track user registration
    def track_user_registration(user_id)
      total_users_registered.increment
      
      user = User.find(user_id)
      user.preferences.value = {
        theme: 'light',
        language: 'en',
        timezone: 'UTC',
        created_at: Time.current.iso8601
      }
    end

    # Rate limiting
    def check_rate_limit(identifier, limit: 100, window: 1.hour)
      return true unless rate_limiting_enabled.marked?

      key = "rate_limit:#{identifier}:#{window.to_i}"
      current = RedisService.get(key).to_i
      
      if current >= limit
        return false
      else
        RedisService.setex(key, window.to_i, current + 1)
        return true
      end
    end

    # System health monitoring
    def update_system_health
      health_data = {
        timestamp: Time.current.iso8601,
        total_users: User.count,
        total_oauth_apps: OauthApplication.count,
        total_api_requests: total_api_requests.value,
        redis_connected: RedisService.ping == 'PONG',
        database_connected: ActiveRecord::Base.connection.active?,
        maintenance_mode: maintenance_mode.marked?
      }
      
      system_health.value = health_data
    end

    # User activity tracking
    def track_user_activity(user_id, action, details = {})
      user = User.find(user_id)
      
      activity = {
        action: action,
        details: details,
        timestamp: Time.current.iso8601,
        ip: nil
      }
      
      user.recent_searches.prepend(activity.to_json)
    end

    # OAuth application monitoring
    def track_oauth_error(application_id, error_message)
      app = OauthApplication.find(application_id)
      
      error_data = {
        message: error_message,
        timestamp: Time.current.iso8601,
        application_id: application_id
      }
      
      app.recent_errors.prepend(error_data.to_json)
      
      # Check if we should rate limit this app
      if app.recent_errors.elements.size > 10
        app.rate_limited.mark!
      end
    end

    # Session management
    def track_user_session(user_id, session_id)
      active_sessions.add("#{user_id}:#{session_id}")
    end

    def remove_user_session(user_id, session_id)
      active_sessions.remove("#{user_id}:#{session_id}")
    end

    # Maintenance mode
    def enable_maintenance_mode
      maintenance_mode.mark
      system_health.value = (system_health.value || {}).merge(
        maintenance_mode: true,
        maintenance_enabled_at: Time.current.iso8601
      )
    end

    def disable_maintenance_mode
      maintenance_mode.delete
      system_health.value = (system_health.value || {}).merge(
        maintenance_mode: false,
        maintenance_disabled_at: Time.current.iso8601
      )
    end

    # Analytics helpers
    def get_user_analytics(user_id)
      user = User.find(user_id)
      {
        page_views: user.page_views.value,
        recent_searches: user.recent_searches.elements,
        preferences: user.preferences.value,
        email_notifications: user.email_notifications.marked?,
        favorite_apps: user.favorite_oauth_apps.members
      }
    end

    def get_application_analytics(application_id)
      app = OauthApplication.find(application_id)
      {
        api_calls: app.api_calls.value,
        recent_errors: app.recent_errors.elements,
        active_scopes: app.active_scopes.members,
        rate_limited: app.rate_limited.marked?,
        usage_stats: app.usage_stats.value
      }
    end
  end
end
