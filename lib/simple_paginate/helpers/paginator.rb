require 'action_view'
require 'simple_paginate/helpers/tags'

module SimplePaginate
  module Helpers
    class Paginator < Tag
      include ActionView::Context

      def initialize(template, options)
        super template, options.merge(current_page: PageProxy.new(options))
        @output_buffer = ActionView::OutputBuffer.new
      end

      def render(&block)
        instance_eval(&block)
        @output_buffer
      end

      def prev_page_tag
        PrevPage.new @template, @options
      end

      def next_page_tag
        NextPage.new @template, @options
      end

      def to_s
        super @options.merge(paginator: self)
      end

      class PageProxy
        def initialize(options)
          @options = options
        end

        def number
          @options[:current_page]
        end

        def first?
          @options[:current_page] == 1
        end

        def last?
          @options[:length] < @options[:per_page]
        end

        def to_i
          number
        end

        def to_s
          number.to_s
        end

        def +(other)
          to_i + other.to_i
        end

        def -(other)
          to_i - other.to_i
        end

        def <=>(other)
          to_i <=> other.to_i
        end
      end
    end
  end
end
