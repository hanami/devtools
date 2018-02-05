# frozen_string_literal: true

require "hanami/devtools/integration/with_clean_env_project"

module RSpec
  module Support
    # Generate a project without `hanami-model`
    #
    # @since 0.2.0
    module ProjectWithoutHanamiModel
      private

      def project_without_hanami_model(project = "bookshelf", args = {})
        with_clean_env_project(project, args.merge(exclude_gems: ["hanami-model"])) do
          replace "config/environment.rb", "hanami/model", ""
          replace "Rakefile",              "hanami/rake_tasks", ""
          yield
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.include RSpec::Support::ProjectWithoutHanamiModel, type: :integration
end
