module SimplePaginate
  class Railtie < Rails::Railtie
    initializer 'simple_paginate' do |app|
      ActiveSupport.on_load :active_record do
        require 'simple_paginate/models/active_record_extension'
        ::ActiveRecord::Base.send :include, SimplePaginate::ActiveRecordExtension
      end

      ActiveSupport.on_load :action_view do
        require 'simple_paginate/helpers/action_view_extension'
        require 'simple_paginate/helpers/paginator'
        ::ActionView::Base.send :include, SimplePaginate::ActionViewExtension
      end
    end
  end
end
