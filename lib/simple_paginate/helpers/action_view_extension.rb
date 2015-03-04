module SimplePaginate
  module ActionViewExtension
    def link_to_previous_page(scope, name, options = {}, html_options = {})
      link_to_unless scope.first_page?, name, options, html_options
    end

    def link_to_next_page(scope, name, options = {}, html_options = {})
      link_to_unless !scope.last_page?, name, options, html_options
    end
  end
end
