module SimplePaginate
  module ActionViewExtension
    def link_to_previous_page(scope, name = nil, options = nil, html_options = {})
      if scope.first_page?
        link_to name, '#', { disabled: true }.merge(html_options)
      else
        previous_page = scope.current_page - 1
        options = options ? options.merge(page: previous_page) : { page: previous_page }
        link_to name, url_for(options), html_options
      end
    end

    def link_to_next_page(scope, name = nil, options = nil, html_options = {})
      if scope.last_page?
        link_to name, '#', { disabled: true }.merge(html_options)
      else
        next_page = scope.current_page + 1
        options = options ? options.merge(page: next_page) : { page: next_page }
        link_to name, url_for(options), html_options
      end
    end
  end
end
