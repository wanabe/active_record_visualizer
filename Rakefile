begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'ActiveRecordVisualizer'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.md')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

APP_RAKEFILE = File.expand_path("test/dummy/Rakefile", __dir__)
load 'rails/tasks/engine.rake'

load 'rails/tasks/statistics.rake'
load 'rails/tasks/framework.rake'

require 'bundler/gem_tasks'

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task default: :test

require "webpacker"
load 'tasks/webpacker.rake'
load 'tasks/installers.rake'
load 'tasks/webpacker/check_node.rake'
load 'tasks/webpacker/check_yarn.rake'
load 'tasks/webpacker/check_binstubs.rake'
load 'tasks/webpacker/install.rake'
load 'tasks/webpacker/verify_install.rake'

require "active_support/core_ext/string/inquiry"
Rails.application.config.root = Dir.pwd
