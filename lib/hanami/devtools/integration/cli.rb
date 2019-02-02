# frozen_string_literal: true

require "aruba"
require "aruba/api"
require "pathname"

module RSpec
  module Support
    # Run Command Line Interface (CLI) programs
    #
    # @since 0.2.0
    module CLI
      def self.included(spec)
        spec.before do
          aruba = Pathname.new(Dir.pwd).join("tmp", "aruba")
          aruba.rmtree if aruba.exist?

          setup_aruba
        end
      end

      private

      def run_command(cmd, output = nil, exit_status: 0)
        run_command_and_stop "bundle exec #{cmd}", fail_on_error: false

        match_output(output)
        expect(last_command_started).to have_exit_status(exit_status)
      end

      def run_command_with_clean_env(cmd, successful: true)
        result = ::Bundler.clean_system(cmd, out: File::NULL)
        expect(result).to be(successful)
      end

      def match_output(output)
        case output
        when String
          expect(all_output).to include(output)
        when Regexp
          expect(all_output).to match(output)
        when Array
          output.each { |o| match_output(o) }
        end
      end

      def all_output
        all_commands.map(&:output).join("\n")
      end
    end
  end
end

RSpec.configure do |config|
  config.include Aruba::Api,          type: :integration
  config.include RSpec::Support::CLI, type: :integration
end
