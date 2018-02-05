# frozen_string_literal: true

require_relative "with_project"
require_relative "bundler"

module RSpec
  module Support
    # Generate a Hanami project with a Bundler clean environment.
    #
    # @since 0.2.0
    #
    # @see http://bundler.io/man/bundle-exec.1.html#Shelling-out
    module WithCleanEnvProject
      private

      def with_clean_env_project(project = "bookshelf", args = {})
        RSpec::Support::Bundler.with_clean_env do
          with_project(project, args) do
            yield
          end
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.include RSpec::Support::WithCleanEnvProject, type: :integration
end
