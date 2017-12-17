require 'simple_paginate/models/active_record_model_extension'

module SimplePaginate
  module ActiveRecordExtension
    extend ActiveSupport::Concern

    module ClassMethods
      def inherited(kls)
        super
        kls.send(:include, SimplePaginate::ActiveRecordModelExtension)
      end
    end

    included do
      descendants.each do |kls|
        kls.send(:include, SimplePaginate::ActiveRecordModelExtension)
      end
    end
  end
end
