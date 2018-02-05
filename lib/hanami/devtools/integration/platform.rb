# frozen_string_literal: true

# Matchers for current OS, Ruby engine.
#
# @since 0.2.0
module Platform
  require_relative "platform/os"
  require_relative "platform/engine"
  require_relative "platform/matcher"

  def self.ci?
    ENV["TRAVIS"] == "true"
  end

  def self.match(&blk)
    Matcher.match(&blk)
  end

  def self.match?(**args)
    Matcher.match?(**args)
  end
end
