module SimplePaginate
  module ActionViewExtension
    # A helper that renders the pagination links
    def simple_paginate(scope, options = {})
      paginator = SimplePaginate::Helpers::Paginator.new self, options.reverse_merge(current_page: scope.current_page, per_page: scope.limit_value, length: scope.length)
      paginator.to_s
    end

    def link_to_previous_page(scope, name = nil, options = {})
      prev_page = SimplePaginate::Helpers::PrevPage.new self, options.reverse_merge(:current_page => scope.current_page)
      link_to_unless scope.first_page?, name, prev_page.url, options.except(:params, :param_name).reverse_merge(:rel => 'prev')
    end

    def link_to_next_page(scope, name = nil, options = {})
      next_page = SimplePaginate::Helpers::NextPage.new self, options.reverse_merge(:current_page => scope.current_page)
      link_to_unless scope.last_page?, name, next_page.url, options.except(:params, :param_name).reverse_merge(:rel => 'next')
    end
  end
end
