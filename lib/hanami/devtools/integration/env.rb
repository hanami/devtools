# frozen_string_literal: true

require "singleton"
module RSpec
  module Support
    # Environment variables wrapper for:
    #
    #   * CLI commands
    #   * Isolate `ENV` global state
    #
    # @since 0.2.0
    #
    # @see https://lucaguidi.com/2016/12/27/isolate-global-state/
    class Env
      include Singleton

      def self.setup
        instance.__send__(:setup)
      end

      def self.reset
        instance.__send__(:setup)
      end

      def self.env
        instance.to_h
      end

      def self.[](key)
        instance[key]
      end

      def self.[]=(key, value)
        instance[key] = value
      end

      def self.fetch_from_original(key)
        instance.__send__(:original).fetch(key)
      end

      def initialize
        @original = ENV.to_hash
        @mutex    = Mutex.new
        setup
      end

      def [](key)
        synchronize do
          env[key]
        end
      end

      def []=(key, value)
        synchronize do
          env[key] = value
        end
      end

      def to_h
        env.dup
      end

      private

      attr_reader :original, :env

      ENV_VARS = %w[RUBYOPT RUBYLIB RUBY_ROOT RUBY_ENGINE RUBY_VERSION GEM_ROOT GEM_HOME GEM_PATH BUNDLE_GEMFILE].freeze

      def setup
        synchronize do
          @env = {}
        end

        ENV_VARS.each do |var|
          original_value = original.fetch(var, nil)
          next if original_value.nil?

          self[var] = original_value
        end
      end

      def synchronize(&blk)
        @mutex.synchronize(&blk)
      end
    end
  end
end

RSpec.configure do |config|
  config.before(:suite) do
    RSpec::Support::Env.setup
  end

  config.after do
    RSpec::Support::Env.reset
  end
end
