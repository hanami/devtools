# frozen_string_literal: true

require_relative "with_tmp_directory"

module RSpec
  module Support
    # Execute the given code inside the system temporary directory (aka `/tmp`).
    #
    # NOTE: this changes the current `Dir.pwd`
    #
    # @since 0.2.0
    module WithSystemTmpDirectory
      private

      def with_system_tmp_directory(&blk)
        with_tmp_directory(Dir.mktmpdir, &blk)
      end
    end
  end
end

RSpec.configure do |config|
  config.include RSpec::Support::WithSystemTmpDirectory, type: :integration
end
