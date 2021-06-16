# frozen_string_literal: true

require "hanami/devtools/integration/silently"

module RSpec
  # RSpec support utilities
  #
  # @since 0.2.0
  module Support
    # Git utilities
    #
    # @since 0.2.0
    module Git
      DEFAULT_BRANCH = "main"

      private

      def setup_default_git_branch
        silently "git config --global init.defaultBranch #{DEFAULT_BRANCH}"
      end
    end
  end
end

RSpec.configure do |config|
  config.include RSpec::Support::Git, type: :integration
end
