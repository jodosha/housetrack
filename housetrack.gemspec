# -*- encoding: utf-8 -*-
require File.expand_path('../lib/house_track/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Luca Guidi"]
  gem.email         = ["guidi.luca@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "housetrack"
  gem.require_paths = ["lib"]
  gem.version       = HouseTrack::VERSION

  gem.add_dependency 'thor', '~> 0.14.6'

  gem.add_development_dependency 'rake',      '~> 0.9.2.2'
  gem.add_development_dependency 'minitest',  '~> 2.8.0'
  gem.add_development_dependency 'mocha',     '~> 0.10.0'
end
