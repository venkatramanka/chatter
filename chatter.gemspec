$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "chatter/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "chatter"
  s.version     = Chatter::VERSION
  s.authors     = ["Your name"]
  s.email       = ["Your email"]
  s.homepage    = "http://chatter_uri.com"
  s.summary     = "Summary of Chatter."
  s.description = "Description of Chatter."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.15"
  s.add_dependency "redis"
  s.add_dependency "thin"
  s.add_dependency "faye"
  s.add_dependency "private_pub"
  s.add_dependency "websocket-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "debugger"
end
