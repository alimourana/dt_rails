# frozen_string_literal: true

namespace :kredis do
  desc "Demonstrate Kredis features"
  task demo: :environment do
    puts "🚀 Kredis Demo Starting..."
    
    # Find or create a test user
    user = User.find_by(email: 'admin@dtrails.gn') || User.first
    unless user
      puts "❌ No users found. Please run 'rails db:seed' first."
      exit
    end
    
    puts "👤 Using user: #{user.email}"
    
    # 1. User preferences (JSON)
    puts "\n1. 📝 User Preferences (JSON)"
    user.preferences.value = {
      theme: 'dark',
      language: 'en',
      notifications: true,
      created_at: Time.current.iso8601
    }
    puts "   Set preferences: #{user.preferences.value}"
    
    # 2. Page view counter
    puts "\n2. 📊 Page View Counter"
    puts "   Current page views: #{user.page_views.value}"
    5.times { user.page_views.increment }
    puts "   After 5 increments: #{user.page_views.value}"
    
    # 3. Recent searches (List)
    puts "\n3. 🔍 Recent Searches (List)"
    searches = ['oauth apps', 'user management', 'api documentation', 'redis features']
    searches.each { |search| user.recent_searches.prepend(search) }
    puts "   Recent searches: #{user.recent_searches.elements}"
    
    # 4. Favorite OAuth apps (Set)
    puts "\n4. ⭐ Favorite OAuth Apps (Set)"
    user.favorite_oauth_apps.add('test_app_123')
    user.favorite_oauth_apps.add('another_app')
    puts "   Favorite apps: #{user.favorite_oauth_apps.members}"
    
    # 5. Email notifications flag
    puts "\n5. 🔔 Email Notifications Flag"
    puts "   Notifications enabled: #{user.email_notifications.marked?}"
    user.email_notifications.mark
    puts "   After enabling: #{user.email_notifications.marked?}"
    
    # 6. OAuth Application features
    puts "\n6. 🔐 OAuth Application Features"
    app = OauthApplication.first
    if app
      puts "   App: #{app.name}"
      
      # API calls counter
      10.times { app.api_calls.increment }
      puts "   API calls: #{app.api_calls.value}"
      
      # Recent errors
      app.recent_errors.prepend("Test error #{Time.current.to_i}")
      puts "   Recent errors: #{app.recent_errors.elements.first(3)}"
      
      # Active scopes
      app.active_scopes.add('read', 'write', 'admin')
      puts "   Active scopes: #{app.active_scopes.members}"
      
      # Usage stats
      app.usage_stats.value = {
        total_requests: 1000,
        last_request: Time.current.iso8601,
        error_rate: 0.02
      }
      puts "   Usage stats: #{app.usage_stats.value}"
    end
    
    # 7. Global KredisService features
    puts "\n7. 🌐 Global KredisService Features"
    
    # Track some activities
    KredisService.track_api_request('/api/v1/users', user.id)
    KredisService.track_user_activity(user.id, 'demo_run', { feature: 'kredis_demo' })
    
    # Update system health
    KredisService.update_system_health
    health = KredisService.system_health.value
    puts "   System health updated: #{health['timestamp']}"
    
    # Global counters
    puts "   Total API requests: #{KredisService.total_api_requests.value}"
    puts "   Total OAuth tokens: #{KredisService.total_oauth_tokens_issued.value}"
    puts "   Total users registered: #{KredisService.total_users_registered.value}"
    
    # 8. Rate limiting demo
    puts "\n8. 🚦 Rate Limiting Demo"
    identifier = "demo_user:#{user.id}"
    puts "   Rate limit check for #{identifier}:"
    3.times do |i|
      allowed = KredisService.check_rate_limit(identifier, limit: 5, window: 1.minute)
      puts "   Attempt #{i + 1}: #{allowed ? '✅ Allowed' : '❌ Blocked'}"
    end
    
    # 9. Maintenance mode
    puts "\n9. 🔧 Maintenance Mode Demo"
    puts "   Maintenance mode: #{KredisService.maintenance_mode.marked?}"
    KredisService.enable_maintenance_mode
    puts "   After enabling: #{KredisService.maintenance_mode.marked?}"
    puts "   (Note: Flag unmarking requires different method - demo simplified)"
    
    puts "\n🎉 Kredis Demo Complete!"
    puts "\n📊 Summary:"
    puts "   - User page views: #{user.page_views.value}"
    puts "   - Recent searches: #{user.recent_searches.elements.size} items"
    puts "   - Favorite apps: #{user.favorite_oauth_apps.members.size} items"
    puts "   - Global API requests: #{KredisService.total_api_requests.value}"
    puts "   - System health: #{KredisService.system_health.value ? 'Updated' : 'Not set'}"
    
    puts "\n🔗 Try these URLs:"
    puts "   - Admin Dashboard: http://localhost:3000/admin/dashboard"
    puts "   - OAuth Apps: http://localhost:3000/oauth/applications"
    puts "   - User Profile: http://localhost:3000/users/edit"
  end
end
