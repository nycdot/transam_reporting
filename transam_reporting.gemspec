$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "transam_reporting/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "transam_reporting"
  s.version     = TransamReporting::VERSION
  s.authors     = ["W. Scott Meeks"]
  s.email       = ["smeeks@camsys.com"]
  s.homepage    = "http://www.camsys.com"
  s.summary     = "Reporting Engine for TransAM"
  s.description = "Overlays TransAM Core reporting providing additional functionality"
  s.license     = "MIT"

  # Controls the order that engines are loaded for dependencies. transam_core is 1.
  # 40 is a reasonable default for now.
  s.metadata = { "load_order" => "40" }

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  # Should be compatible with the transam_core value.
  s.add_dependency "rails", "~> 4.1.16"

  s.add_dependency 'rails-data-migrations'

  # PDF
  s.add_dependency "wicked_pdf"
  s.add_dependency "wkhtmltopdf-binary"
  
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "mysql2", "~> 0.3.13"
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "simplecov"
end
