# frozen_string_literal: true

# Redis configuration
redis_config = Rails.application.config_for(:redis)

# Create a Redis connection instance
$redis = Redis.new(redis_config)

# For Rails 7+ compatibility, also set up Redis for Action Cable
Rails.application.configure do
  config.action_cable.url = ENV.fetch("ACTION_CABLE_URL", "ws://localhost:3000/cable")
  config.action_cable.allowed_request_origins = [
    /http:\/\/localhost.*/,
    /https:\/\/.*\.herokuapp\.com/,
    /https:\/\/.*\.ngrok\.io/
  ]
end
