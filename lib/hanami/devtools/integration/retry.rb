# frozen_string_literal: true

module RSpec
  module Support
    # Implement retry logic.
    #
    # It may happen that the setup of a test is slower then expected.
    # Instead of let it to blow up, we can retry after a few seconds.
    #
    # @since 0.2.0
    module Retry
      private

      def retry_exec(exception) # rubocop:disable Metrics/MethodLength
        attempts           = 1
        max_retry_attempts = Platform.match do
          engine(:ruby)  { 10 }
          engine(:jruby) { 20 }
        end

        begin
          sleep 1
          yield
        rescue exception
          raise if attempts > max_retry_attempts
          attempts += 1
          retry
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.include RSpec::Support::Retry, type: :integration
end
