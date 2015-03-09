module SimplePaginate
  module Generators
    class ConfigGenerator < Rails::Generators::Base
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      desc <<DESC
Description:
    Copies SimplePaginate configuration file to your application's initializer directory.
DESC

      def copy_config_file
        template 'simple_paginate_config.rb', 'config/initializers/simple_paginate_config.rb'
      end
    end
  end
end
