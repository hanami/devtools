# frozen_string_literal: true

require "fileutils"
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
        delete_tmp_directory(dir)
        create_tmp_directory(dir)

        with_directory(dir) do
          yield
        end
      ensure
        delete_tmp_directory(dir)
      end

      def create_tmp_directory(dir)
        FileUtils.mkdir_p(dir)
      end

      def delete_tmp_directory(dir)
        Hanami::Utils::Files.delete_directory(dir) if dir.exist?
      end
    end
  end
end

RSpec.configure do |config|
  config.include RSpec::Support::WithTmpDirectory, type: :integration
end
