# -*- encoding: utf-8 -*-
require File.expand_path('../lib/pivotal_angel/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Rad Batnag","Cecille Manalang"]
  gem.email         = ["rad@aelogica.com","cecille@aelogica.com"]
  gem.description   = %q{Pivotal Tracker helpers for project and labels}
  gem.summary       = %q{Deep clone a project, add, remove and rename labels}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "pivotal_angel"
  gem.require_paths = ["lib"]
  gem.version       = PivotalAngel::VERSION

  gem.add_development_dependency "rspec", "~> 2.6"

  gem.add_dependency "pivotal-tracker"
end
