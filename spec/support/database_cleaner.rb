# frozen_string_literal: true

require 'database_cleaner/active_record'

# Temporarily disabled due to DATABASE_URL environment variable issues
# RSpec.configure do |config|
#   config.before(:suite) do
#     DatabaseCleaner.strategy = :transaction
#   end
# 
#   config.around(:each) do |example|
#     DatabaseCleaner.cleaning do
#       example.run
#     end
#   end
# end
