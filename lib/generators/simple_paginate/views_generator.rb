module SimplePaginate
  module Generators

    class ViewsGenerator < Rails::Generators::Base
      source_root File.expand_path('../../../../app/views/simple_paginate', __FILE__)

      class_option :template_engine, :type => :string, :aliases => '-e', :desc => 'Template engine for the views. Available options are "erb", "haml", and "slim".'

      def self.banner #:nodoc:
        <<-BANNER.chomp
rails g simple_paginate:views [options]

    Copies all paginator partial templates to your application.
BANNER
      end

      def copy_views
        filename_pattern = File.join self.class.source_root, "*.html.#{template_engine}"
        Dir.glob(filename_pattern).map {|f| File.basename f}.each do |f|
          copy_file f, "app/views/simple_paginate/#{f}"
        end
      end

      private

      def template_engine
        options[:template_engine].try(:to_s).try(:downcase) || 'erb'
      end
    end
  end
end
