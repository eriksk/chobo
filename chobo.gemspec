# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chobo/version'

Gem::Specification.new do |gem|
  gem.name          = "chobo"
  gem.version       = Chobo::VERSION
  gem.authors       = ["Erik Skoglund"]
  gem.email         = ["erikskoglund88@gmail.com"]
  gem.description   = %q{Chobo is a simple way to start new game projects with gosu}
  gem.summary       = %q{The purpose of Chobo is to create boilerplate code for gosu projects}
  gem.homepage      = "https://github.com/eriksk/chobo"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
	gem.add_dependency 'gosu', '0.7.45'
end
