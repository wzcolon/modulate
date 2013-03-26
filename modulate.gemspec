$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "modulate/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "modulate"
  s.version     = Modulate::VERSION
  s.authors     = ["Zach Colon"]
  s.email       = ["zach.colon@tma1.com"]
  s.homepage    = ""
  s.summary     = "Easily add the ability to upload documents to any ActiveRecord model"
  s.description = "Easily add the ability to upload documents to any ActiveRecord model"

  s.files = Dir["{app,config,db,lib}/**/*"] 
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "carrierwave-riak",             "~> 0.1.2"
  s.add_dependency "rails",                        "~> 3.2.13"
  s.add_dependency "riak-client" 
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "mysql2"
  s.add_development_dependency "rspec-rails",        "~> 2.13.0"
  s.add_development_dependency "capybara",           "~> 2.0.2"
  s.add_development_dependency "factory_girl_rails", "~> 4.2.1"
  s.add_development_dependency "launchy",             "~> 2.2.0"
  s.add_development_dependency "pry",                "~> 0.9.12"
end
