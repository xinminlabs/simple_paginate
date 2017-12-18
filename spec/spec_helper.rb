begin
  require 'rails'
rescue LoadError
end

require 'bundler/setup'
Bundler.require

require 'database_cleaner'
require 'fake_app/rails_app'
require 'rspec/rails'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end
