#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# Check if all gems are installed, install if missing
echo "Checking for missing gems..."
bundle check || bundle install

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
