require "socket"
require "timeout"

module RSpec
  module Support
    # Returns a random, non-sudo, free port
    #
    # @since 0.2.0
    module RandomPort
      HOST       = "localhost"
      PORT_RANGE = 1024..65_535
      TIMEOUT    = 1 # second

      def self.call
        result = -1

        loop do
          result = Kernel.rand(PORT_RANGE)
          break unless open?(result)
        end

        result
      end

      def self.open?(port) # rubocop:disable Metrics/MethodLength
        Timeout.timeout(TIMEOUT) do
          begin
            s = TCPSocket.new(HOST, port)
            s.close
            return true
          rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH, Errno::EADDRNOTAVAIL
            return false
          end
        end

        false
      rescue Timeout::Error
        false
      end

      private_class_method :open?
    end
  end
end
