# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rocket_pants/rpm/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Darcy Laycock"]
  gem.email         = ["sutto@sutto.net"]
  gem.description   = %q{Integrates RocketPants and RPM for great success.}
  gem.summary       = %q{Provides rpm-instrumentation for RocketPants.}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "rocket_pants-rpm"
  gem.require_paths = ["lib"]
  gem.version       = RocketPants::RPM::VERSION
end
