$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "active_record_visualizer/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "active_record_visualizer"
  s.version     = ActiveRecordVisualizer::VERSION
  s.authors     = ["wanabe"]
  s.email       = ["s.wanabe@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ActiveRecordVisualizer."
  s.description = "TODO: Description of ActiveRecordVisualizer."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.0"

  s.add_development_dependency "sqlite3"
end
