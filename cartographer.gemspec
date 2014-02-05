# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cartographer/version'

Gem::Specification.new do |spec|
  spec.name          = "cartographer"
  spec.version       = Cartographer::VERSION
  spec.authors       = ["Chase McCarthy"]
  spec.email         = ["chase@code0100fun.com"]
  spec.summary       = %q{A Rust map generator.}
  spec.description   = %q{Creates a uniform grid of screenshots that can be combined into a panorama.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ["cart"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_runtime_dependency "win32screenshot"
  spec.add_runtime_dependency "rust"
  spec.add_runtime_dependency "rb-readline"
  spec.add_runtime_dependency "colorize"
end
