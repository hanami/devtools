# frozen_string_literal: true

require "pathname"

module RSpec
  module Support
    # Execute the given code inside a specified directory.
    #
    # NOTE: this changes the current `Dir.pwd`
    #
    # @since 0.2.0
    module WithDirectory
      private

      def with_directory(directory)
        current = Dir.pwd
        target  = Pathname.new(Dir.pwd).join(directory)

        Dir.chdir(target)
        yield
      ensure
        Dir.chdir(current)
      end
    end
  end
end

RSpec.configure do |config|
  config.include RSpec::Support::WithDirectory
end
