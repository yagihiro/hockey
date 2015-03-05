# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hockeyhelper/version'

Gem::Specification.new do |spec|
  spec.name          = "hockeyhelper"
  spec.version       = Hockey::VERSION
  spec.authors       = ["Hiroki Yagita"]
  spec.email         = ["yagihiro@gmail.com"]
  spec.summary       = %q{Helper gem for HokceyApp API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "flay"
  spec.add_dependency "faraday"
end
