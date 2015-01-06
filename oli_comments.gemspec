$:.push File.expand_path("../lib", __FILE__)

require "oli_comments/version"

Gem::Specification.new do |s|
  s.name        = "oli_comments"
  s.version     = OliComments::VERSION
  s.authors     = ["Khrystle Rae"]
  s.email       = ["krae@opuslogica.com"]
  s.homepage    = "http://www.opuslogica.com"
  s.summary     = "Plug-N-Play Comments."
  s.description = "Plug-N-Play Comments."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.6"

  s.add_development_dependency "sqlite3"
end
