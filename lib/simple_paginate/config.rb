require 'active_support/configurable'

module SimplePaginate
  def self.configure(&block)
    yield @config ||= SimplePaginate::Configuration.new
  end

  def self.config
    @config
  end

  class Configuration
    include ActiveSupport::Configurable

    config_accessor :default_per_page
  end

  configure do |config|
    config.default_per_page = 25
  end
end
