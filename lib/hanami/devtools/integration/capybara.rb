# frozen_string_literal: true

require "capybara"
require "capybara/rspec"
require "capybara/dsl"
require "hanami/devtools/integration/platform"
require "capybara/poltergeist"

RSpec.configure do |config|
  config.include Capybara::DSL, type: :integration
end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {js_errors: false})
end

Capybara.configure do |config|
  config.run_server = false
  config.default_driver = :poltergeist
end
