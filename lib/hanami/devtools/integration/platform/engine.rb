require "hanami/utils"

module Platform
  # Detect current Ruby engine: MRI or JRuby
  #
  # @since 0.2.0
  module Engine
    def self.engine?(name)
      current == name
    end

    def self.current
      if    ruby?  then :ruby
      elsif jruby? then :jruby
      end
    end

    class << self
      private

      def ruby?
        RUBY_ENGINE == "ruby"
      end

      def jruby?
        Hanami::Utils.jruby?
      end
    end
  end
end
