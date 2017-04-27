# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "slybroadcast/version"

Gem::Specification.new do |s|
  s.name        = "slybroadcast"
  s.version     = Slybroadcast::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Martin Aceto"]
  s.email       = ["martin.aceto@gmail.com"]
  s.homepage    = "https://github.com/maceto/slybroadcast.git"
  s.summary     = %q{Slybroadcast Ruby client}
  s.description = %q{A minimal Slybroadcast Ruby client implementation}
  s.license       = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
end
