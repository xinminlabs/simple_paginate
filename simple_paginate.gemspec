lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_paginate/version'

Gem::Specification.new do |spec|
  spec.name          = 'simple_paginate'
  spec.version       = SimplePaginate::VERSION
  spec.authors       = ['Richard Huang']
  spec.email         = ['flyerhzm@gmail.com']
  spec.summary       = 'Simple pagination solution for previous and next page navigation.'
  spec.description   = 'Simple pagination solution for previous and next page navigation.'
  spec.homepage      = 'https://github.com/xinminlabs/simple_paginate'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'actionpack', ['>= 3.0.0']
  spec.add_dependency 'activerecord', ['>= 3.0.0']
  spec.add_dependency 'activesupport', ['>= 3.0.0']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'database_cleaner', ['~> 1.4.0']
  spec.add_development_dependency 'rails', '>= 3.0.0'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.6.0'
end
