# frozen_string_literal: true

# Matchers for current OS, Ruby engine.
#
# @since 0.2.0
module Platform
  require "hanami/devtools/integration/platform/os"
  require "hanami/devtools/integration/platform/engine"
  require "hanami/devtools/integration/platform/matcher"

  def self.ci?
    ENV.key?("CI")
  end

  def self.match(&blk)
    Matcher.match(&blk)
  end

  def self.match?(**args)
    Matcher.match?(**args)
  end
end
