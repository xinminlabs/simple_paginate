# encoding: utf-8

require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

task test: "spec:all"

namespace :spec do
  mappers = %w(
    active_record_42
    active_record_50
  )

  mappers.each do |gemfile|
    desc "Run Tests against #{gemfile}"
    task gemfile do
      sh "BUNDLE_GEMFILE='gemfiles/#{gemfile}.gemfile' bundle --quiet"
      sh "BUNDLE_GEMFILE='gemfiles/#{gemfile}.gemfile' bundle exec rake -t spec"
    end
  end

  desc "Run Tests against all ORMs"
  task :all do
    mappers.each do |gemfile|
      sh "BUNDLE_GEMFILE='gemfiles/#{gemfile}.gemfile' bundle --quiet"
      sh "BUNDLE_GEMFILE='gemfiles/#{gemfile}.gemfile' bundle exec rake spec"
    end
  end
end

begin
  require 'rdoc/task'

  Rake::RDocTask.new do |rdoc|
    require 'simple_paginate/version'

    rdoc.rdoc_dir = 'rdoc'
    rdoc.title = "simple_paginate #{SimplePaginate::VERSION}"
    rdoc.rdoc_files.include('README*')
    rdoc.rdoc_files.include('lib/**/*.rb')
  end
rescue LoadError
  puts 'RDocTask is not supported on this VM and platform combination.'
end
