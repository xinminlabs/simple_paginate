module SimplePaginate
  module Helpers
    PARAM_KEY_BLACKLIST = :authenticity_token, :commit, :utf8, :_method
    PARAM_NAME = 'page'

    class Tag
      def initialize(template, options = {})
        @template, @options = template, options
        @views_prefix = @options.delete(:views_prefix)
        @params = template.params.except(*PARAM_KEY_BLACKLIST).merge(@options.delete(:params) || {})
      end

      def to_s(locals = {})
        @template.render partial: partial_path, locals: @options.merge(locals), formats: [:html]
      end

      def page_url_for(page) 
        @template.url_for params_for(page).merge(only_path: true)
      end

      private

      def params_for(page)
        page_params = Rack::Utils.parse_nested_query("#{PARAM_NAME}=#{page}")
        page_params = @params.with_indifferent_access.deep_merge(page_params)

        if page <= 1
          PARAM_NAME.to_s.scan(/\w+/)[0..-2].inject(page_params){|h, k| h[k] }[$&] = nil
        end

        page_params
      end

      def partial_path
        [@views_prefix,
         'simple_paginate',
         self.class.name.demodulize.underscore
        ].compact.join('/')
      end
    end

    module Link
      def page
        raise 'Override page with the actual page value to be a Page.'
      end

      def url
        page_url_for(page)
      end

      def to_s(locals = {})
        super locals.merge(url: url)
      end
    end

    class Page < Tag
      include Link
      
      def page
        @options[:page]
      end

      def to_s(locals = {})
        super locals.merge(page: page)
      end
    end

    class PrevPage < Tag
      include Link

      def page
        @options[:current_page] - 1
      end
    end

    class NextPage < Tag
      include Link

      def page
        @options[:current_page] + 1
      end
    end
  end
end
