# frozen_string_literal: true

require "digest"
require "hanami/utils/files"

module RSpec
  module Support
    # Gemfile utilities
    #
    # @since 0.2.0
    module Gemfile
      module_function

      def changed?
        return true unless gemfile.exist? && checksum.exist?

        calculate_checksum(gemfile) != checksum.read
      end

      def write_checksum
        Hanami::Utils::Files.write(checksum, calculate_checksum(gemfile))
      end

      def calculate_checksum(path)
        return unless path.exist?
        Digest::MD5.file(path).to_s
      end

      def gemfile
        Pathname.new("Gemfile.lock")
      end

      def checksum
        Pathname.new("tmp").join("gemfile")
      end
    end
  end
end
