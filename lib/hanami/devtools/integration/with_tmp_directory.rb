# frozen_string_literal: true

require "hanami/utils/files"
require "hanami/devtools/integration/with_directory"

module RSpec
  module Support
    # Execute the given code inside a temporary directory.
    #
    # NOTE: this changes the current `Dir.pwd`
    #
    # @since 0.2.0
    module WithTmpDirectory
      private

      def with_tmp_directory(dir = Pathname.new("tmp").join("aruba"))
        with_directory(dir) do
          yield
        end
      ensure
        Hanami::Utils::Files.delete_directory(dir)
      end
    end
  end
end

RSpec.configure do |config|
  config.include RSpec::Support::WithTmpDirectory, type: :integration
end
