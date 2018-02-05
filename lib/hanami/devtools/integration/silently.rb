# frozen_string_literal: true

require "tempfile"

module RSpec
  # RSpec support utilities
  #
  # @since 0.2.0
  module Support
    def self.silently(cmd)
      out    = Tempfile.new("hanami-out")
      result = system(cmd, out: out.path)

      return if result

      out.rewind
      fail "#{cmd} failed:\n#{out.read}" # rubocop:disable Style/SignalException
    end

    # Don't print unnecessary output during tests
    #
    # @since 0.2.0
    module Silently
      private

      def silently(cmd)
        Support.silently(cmd)
      end
    end
  end
end

RSpec.configure do |config|
  config.include RSpec::Support::Silently, type: :integration
end
