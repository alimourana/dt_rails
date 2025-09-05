# DT Rails - Dockerized Ruby on Rails Application

A modern, dockerized Ruby on Rails 7.1 application with PostgreSQL database, designed for easy development and deployment.

## 🚀 Features

- **Ruby 3.2.2** - Latest stable Ruby version
- **Rails 7.1** - Modern Rails framework with latest features
- **MySQL 8.0** - Robust, production-ready database
- **Redis 7** - High-performance in-memory data store for caching
- **Kredis** - High-level Redis data structures and Rails integration
- **OAuth2 Authentication** - Complete OAuth2 server implementation with Doorkeeper
- **Docker & Docker Compose** - Containerized development environment
- **Puma** - High-performance web server
- **Hot Reloading** - Automatic code reloading in development
- **Modern UI** - Clean, responsive interface with Bootstrap 5

## 🐳 Prerequisites

- Docker
- Docker Compose
- Make (optional, for using the Makefile commands)

## 🚀 Quick Start

### 1. Clone and Navigate
```bash
cd dt-rails
```

### 2. Start the Application
```bash
make start
```

This will:
- Build the Docker images
- Start MySQL database
- Start Redis server
- Start the Rails application
- Make it available at http://localhost:3000

### 3. View the Application
Open your browser and navigate to [http://localhost:3000](http://localhost:3000)

## 📋 Available Commands

The application includes a comprehensive Makefile for easy management:

```bash
# Start the application
make start          # or: make up

# Stop the application
make stop           # or: make down

# View application logs
make logs

# View database logs
make db-logs

# Open Rails console
make console

# Open database console
make db-console

# Open Redis console
make redis-console

# View Redis logs
make redis-logs

# Restart the application
make restart

# View container status
make status

# Clean up containers and volumes
make clean

# Show all available commands
make help
```

## 🏗️ Project Structure

```
dt-rails/
├── app/                    # Application code
│   ├── controllers/        # Controllers
│   ├── views/             # Views and templates
│   ├── assets/            # Stylesheets, JavaScript, images
│   └── models/            # ActiveRecord models
├── config/                 # Configuration files
│   ├── database.yml       # Database configuration
│   ├── routes.rb          # Route definitions
│   └── environments/      # Environment-specific configs
├── Dockerfile             # Docker image definition
├── docker-compose.yml     # Multi-container setup
├── Makefile               # Development commands
├── Gemfile                # Ruby dependencies
└── README.md              # This file
```

## 🔧 Configuration

### Database
The application uses MySQL with the following default configuration:
- **Host**: `db` (Docker service name)
- **Port**: `3306`
- **Database**: `dt_rails_development`
- **Username**: `rails`
- **Password**: `password`

### Redis
The application uses Redis for caching and session storage:
- **Host**: `redis` (Docker service name)
- **Port**: `6379`
- **Database**: `0` (default)
- **URL**: `redis://redis:6379/0`

### Environment Variables
Key environment variables can be configured in `docker-compose.yml`:
- `RAILS_ENV`: Application environment (development/production)
- `DATABASE_URL`: Database connection string
- `REDIS_URL`: Redis connection string
- `PORT`: Application port (default: 3000)

## 🛠️ Development

### Adding New Gems
1. Add gems to `Gemfile`
2. **Option A**: Rebuild the Docker image: `make build` (uses cache)
3. **Option B**: Force rebuild without cache: `make build-no-cache` (recommended for new gems)
4. Restart the application: `make restart`

**Automatic Gem Installation**: The Docker container automatically checks for missing gems on startup and installs them if needed. This means you can add gems to your Gemfile and restart the container without rebuilding.

### Testing with RSpec
The application includes RSpec for testing. To set up RSpec for the first time:

```bash
# Setup RSpec and testing gems
make test-setup

# Run tests
make test

# Run tests in watch mode
make test-watch

# Run tests with coverage
make test-coverage
```

**Note**: If you encounter gem installation issues, you can install gems directly in the container:
```bash
make test-install
```

### Gem Management Commands
```bash
# Check if all gems are properly installed
make gems-check

# Install missing gems in the container
make gems-install

# Force rebuild when adding new gems (recommended)
make build-no-cache
```

### Database Migrations
```bash
# Create a new migration
make console
rails generate migration CreateUsers name:string email:string

# Run migrations
make console
rails db:migrate
```

### Redis Usage
The application includes both low-level Redis operations and high-level Kredis abstractions:

#### Basic Redis Operations (RedisService)
```ruby
# Basic operations
RedisService.set('key', 'value')
RedisService.get('key')
RedisService.delete('key')
RedisService.exists?('key')

# Caching with expiration
RedisService.cache('expensive_operation', expire_in: 1.hour) do
  # Expensive computation here
  result
end

# JSON caching
RedisService.cache_json('user_data', { name: 'John', age: 30 })
user_data = RedisService.get_json('user_data')

# Server info
RedisService.ping
RedisService.info
```

#### Kredis High-Level Data Structures
```ruby
# User model with Kredis
user = User.find(1)

# JSON data (preferences, settings)
user.preferences.value = { theme: 'dark', language: 'en' }
prefs = user.preferences.value

# Counters (page views, API calls)
user.page_views.increment
user.page_views.value # => 42

# Lists (recent searches, activities)
user.recent_searches.prepend('search term')
user.recent_searches.elements # => ['search term', ...]

# Sets (favorite apps, tags)
user.favorite_oauth_apps.add('app_id')
user.favorite_oauth_apps.members # => ['app_id', ...]

# Flags (boolean settings)
user.email_notifications.mark!
user.email_notifications.marked? # => true
```

#### Global KredisService Features
```ruby
# Track API usage
KredisService.track_api_request('/api/v1/users', user_id)

# Track OAuth token issuance
KredisService.track_oauth_token_issuance(app_id, user_id)

# Rate limiting
KredisService.check_rate_limit(identifier, limit: 100, window: 1.hour)

# System health monitoring
KredisService.update_system_health
health = KredisService.system_health.value

# Maintenance mode
KredisService.enable_maintenance_mode
KredisService.disable_maintenance_mode
```

#### Demo Kredis Features
```bash
# Run the Kredis demonstration
docker-compose exec web rails kredis:demo

# Access Redis directly
make redis-console

# View Redis logs
make redis-logs
```

### Viewing Logs
```bash
# Application logs
make logs

# Database logs
make db-logs
```

## 🐛 Troubleshooting

### Common Issues

**Port already in use**
```bash
# Check what's using port 3000
lsof -i :3000

# Stop the application and restart
make stop
make start
```

**Database connection issues**
```bash
# Restart the database service
docker-compose restart db

# Check database logs
make db-logs

# Wait for MySQL to be ready (can take a few seconds)
sleep 10
```

**Permission issues with entrypoint script**
```bash
# Make the script executable
chmod +x entrypoint.sh
```

### Reset Everything
```bash
# Stop and remove all containers, networks, and volumes
make clean

# Start fresh
make start
```

## 🔐 OAuth2 Authentication

This application includes a complete OAuth2 server implementation using Doorkeeper. You can use it to authenticate third-party applications and manage API access.

### OAuth2 Features

- **Authorization Code Flow** - For web applications
- **Client Credentials Flow** - For server-to-server authentication
- **Refresh Tokens** - For long-lived access
- **Token Introspection** - For token validation
- **Token Revocation** - For security
- **Scoped Access** - Fine-grained permissions (read, write)

### OAuth2 Endpoints

The following OAuth2 endpoints are available:

- `POST /oauth/token` - Token endpoint
- `GET /oauth/authorize` - Authorization endpoint
- `POST /oauth/introspect` - Token introspection
- `POST /oauth/revoke` - Token revocation

### Managing OAuth Applications

1. **Sign up/Sign in** to the application
2. Navigate to **OAuth Apps** in the navigation
3. Create new OAuth applications with:
   - Application name
   - Redirect URI
   - Scopes (read, write)
   - Confidentiality setting

### OAuth2 Usage Examples

#### Client Credentials Flow (Server-to-Server)

```bash
curl -X POST http://localhost:3000/oauth/token \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=client_credentials&client_id=YOUR_CLIENT_ID&client_secret=YOUR_CLIENT_SECRET&scope=read"
```

#### Authorization Code Flow (Web Applications)

1. **Authorization Request:**
```bash
curl "http://localhost:3000/oauth/authorize?client_id=YOUR_CLIENT_ID&response_type=code&redirect_uri=YOUR_REDIRECT_URI&scope=read"
```

2. **Token Exchange:**
```bash
curl -X POST http://localhost:3000/oauth/token \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=authorization_code&client_id=YOUR_CLIENT_ID&client_secret=YOUR_CLIENT_SECRET&code=AUTHORIZATION_CODE&redirect_uri=YOUR_REDIRECT_URI"
```

#### Token Introspection

```bash
curl -X POST http://localhost:3000/oauth/introspect \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "token=YOUR_ACCESS_TOKEN"
```

#### Using Access Tokens

```bash
curl -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  http://localhost:3000/api/v1/users
```

### Test Credentials

After running `make seed`, you can use these test credentials:

- **Test OAuth Application:**
  - Client ID: `test_app_123`
  - Client Secret: `test_secret_456`
  - Redirect URI: `http://localhost:3000/callback`

- **Admin User:**
  - Email: `admin@dtrails.gn`
  - Password: `admin123`

### OAuth2 Scopes

- `read` - Read access to resources
- `write` - Write access to resources

## 🚀 Production Deployment

For production deployment:

1. **Environment Variables**: Set production environment variables
2. **Database**: Use production MySQL instance
3. **Secrets**: Configure Rails credentials and master key
4. **SSL**: Enable HTTPS with proper certificates
5. **OAuth2**: Configure secure redirect URIs and client secrets
6. **Monitoring**: Add health checks and logging

## 📚 Resources

- [Ruby on Rails Guides](https://guides.rubyonrails.org/)
- [Docker Documentation](https://docs.docker.com/)
- [MySQL Documentation](https://dev.mysql.com/doc/)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

**Happy coding! 🎉**
