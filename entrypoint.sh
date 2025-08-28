#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# Check if all gems are installed, install if missing
echo "🔍 Checking for missing gems..."
bundle check || bundle install

# Wait for database to be ready
echo "⏳ Waiting for database to be ready..."
until bundle exec rails db:version > /dev/null 2>&1; do
  echo "Database not ready, waiting..."
  sleep 2
done

# Run pending migrations only (don't recreate database)
echo "🔄 Checking for pending migrations..."
bundle exec rails db:migrate

echo "✅ Database is ready and migrations are up to date!"

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
