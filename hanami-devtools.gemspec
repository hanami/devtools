
# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "hanami/devtools/version"

Gem::Specification.new do |spec|
  spec.name          = "hanami-devtools"
  spec.version       = Hanami::Devtools::VERSION
  spec.authors       = ["Luca Guidi"]
  spec.email         = ["me@lucaguidi.com"]

  spec.summary       = "Development tools for Hanami"
  spec.description   = "Development tools for Hanami. This gem is designed for the Hanami core team."
  spec.homepage      = "http://hanamirb.org"
  spec.license       = "MIT"

  spec.metadata["allowed_push_host"] = ""
  spec.required_ruby_version         = ">= 2.3.0"

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.add_dependency "rubocop", "0.50.0"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake",    "~> 12.0"
end
