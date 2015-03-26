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
      class << self
        def inherited_with_simple_paginate(kls)
          inherited_without_simple_paginate kls
          kls.send(:include, SimplePaginate::ActiveRecordModelExtension)
        end
        alias_method_chain :inherited, :simple_paginate
      end

      descendants.each do |kls|
        kls.send(:include, SimplePaginate::ActiveRecordModelExtension)
      end
    end
  end
end
