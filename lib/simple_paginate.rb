module SimplePaginate
end

if defined?(Rails::Railtie)
  require 'simple_paginate/railtie'
  require 'simple_paginate/engine'
end

require 'simple_paginate/config'
