FROM ruby:3.2.2-slim

# Install system dependencies
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    default-libmysqlclient-dev \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Install yarn
RUN npm install -g yarn

# Set working directory
WORKDIR /app

# Copy Gemfile first for better caching
COPY Gemfile ./

# Install Ruby gems
RUN bundle install

# Copy the rest of the application
COPY . .

# Add a script to be executed every time the container starts
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Start the main process
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
