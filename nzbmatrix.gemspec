# -*- encoding: utf-8 -*-
require File.expand_path('../lib/nzbmatrix/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Tim Sjoberg"]
  gem.email         = ["bedlamp@gmail.com"]
  gem.description   = %q{Interact with the nzbmatrix api}
  gem.summary       = %q{nzbmatrix api gem}
  gem.homepage      = "https://github.com/timsjoberg/nzbmatrix"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "nzbmatrix"
  gem.require_paths = ["lib"]
  gem.version       = Nzbmatrix::VERSION

  gem.add_runtime_dependency "rest-client"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec", ">= 2"
  gem.add_development_dependency "guard-rspec", ">= 2"
end
