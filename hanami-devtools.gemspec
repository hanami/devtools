# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "hanami/devtools/version"

Gem::Specification.new do |spec| # rubocop:disable Metrics/BlockLength
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

  spec.add_dependency "aruba", "~> 0.14"
  spec.add_dependency "bundler", ">= 1.6", "< 3"
  spec.add_dependency "dotenv", "~> 2.0"
  spec.add_dependency "capybara", "~> 3.2"
  spec.add_dependency "codecov", "~> 0.1"
  spec.add_dependency "excon", "~> 0.60"
  spec.add_dependency "poltergeist", "~> 1.17"
  spec.add_dependency "rack", "~> 2.0"
  spec.add_dependency "rspec", "~> 3.7"
  spec.add_dependency "rubocop", "~> 0.67.2"
  spec.add_dependency "hanami-utils"

  spec.add_development_dependency "rake", "~> 12.3"
end
