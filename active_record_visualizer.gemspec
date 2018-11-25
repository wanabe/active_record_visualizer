$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "active_record_visualizer/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "active_record_visualizer"
  s.version     = ActiveRecordVisualizer::VERSION
  s.authors     = ["wanabe"]
  s.email       = ["s.wanabe@gmail.com"]
  s.homepage    = ""
  s.summary     = "ActiveRecord relation Visualizer."
  s.description = "ActiveRecord relation Visualizer."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.0"
  s.add_dependency "webpacker", "~> 3.5"

  s.add_development_dependency "sqlite3"
end
