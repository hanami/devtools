require "rbconfig"

module Platform
  # Detect current Operating System (OS): MacOS or Linux
  #
  # @since 0.2.0
  module Os
    def self.os?(name)
      current == name
    end

    def self.current
      case RbConfig::CONFIG["host_os"]
      when /linux/  then :linux
      when /darwin/ then :macos
      end
    end
  end
end
