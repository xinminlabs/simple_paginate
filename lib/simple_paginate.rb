module SimplePaginate
end

if defined?(Rails::Railtie)
  require 'simple_paginate/railtie'
end

require 'simple_paginate/config'
