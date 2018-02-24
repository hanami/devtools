# frozen_string_literal: true

require "open3"
require "pathname"
require "hanami/devtools/integration/env"
require "hanami/devtools/integration/silently"
require "hanami/devtools/integration/files"

module RSpec
  module Support
    # Support for Bundler
    #
    # @since 0.2.0
    module Bundler
      HANAMI_GEMS_PREFIX = "hanami-"
      HANAMI_GEMS = %w[utils validations router helpers model view controller mailer assets cli webconsole].freeze

      def self.root
        @_root
      end

      def self.root=(value)
        @_root = Pathname.new(value).realpath
      end

      self.root = Dir.pwd

      def self.cache
        root.join("vendor", "cache")
      end

      def self.setup
        return unless setup?

        with_clean_env do
          RSpec::Support.silently(setup_script)
        end
      end

      def self.setup?
        # !cache.exist? ||
        #   !hanami_gems_packaged?
        false
      end

      def self.hanami_gems_packaged?
        packaged_gems = Dir.glob(cache.join("#{HANAMI_GEMS_PREFIX}*.gem"))
        packaged_gems.count == HANAMI_GEMS.count + 1 # hanami-utils, hanami-validations.. + hanami itself
      end

      def self.setup_script
        result = root.join("script", "setup")
        return result.to_s if result.exist?

        Pathname.new(__dir__).join("..", "..", "..", "..", "script", "setup").realpath.to_s
      end

      def self.with_clean_env(&blk)
        ::Bundler.with_clean_env(&blk)
      end

      private

      attr_reader :out, :err, :exitstatus

      def setup_gemfile(gems: [], exclude_gems: [], path: "Gemfile") # rubocop:disable Metrics/MethodLength
        content = ::File.readlines(path)
        content = inject_gemfile_sources(content, cache)

        unless gems.empty?
          gems = gems.map do |g|
            case g
            when String
              "gem '#{g}'\n"
            when Array
              "gem '#{g.first}', #{g.last}\n"
            end
          end

          content.concat(gems)
        end

        exclude_gems.each do |g|
          content.reject! { |line| line.include?(g) }
        end

        rewrite(path, content)
      end

      def bundle_install
        bundle "install --local --no-cache --retry 0 --no-color"
      end

      def bundle_exec(cmd, env: nil, &blk)
        bundle("exec #{cmd}", env: env, &blk)
      end

      def bundle(cmd, env: nil, &blk)
        # ruby_bin   = which("ruby")
        bundle_bin = which("bundle")
        hanami_env = "HANAMI_ENV=#{env} " unless env.nil?

        # system_exec("#{hanami_env}#{ruby_bin} -I#{load_paths} #{bundle_bin} #{cmd}", &blk)
        system_exec("#{hanami_env}#{bundle_bin} #{cmd}", &blk)
      end

      def inject_gemfile_sources(contents, _vendor_cache_path)
        # sources = ["source 'file://#{vendor_cache_path}'\n"]
        # sources.unshift("source 'http://gems.hanamirb.org:9292'\n") if Platform.ci?

        # sources + contents[1..-1]
        contents
      end

      # Adapted from Bundler source code
      #
      # Bundler is released under MIT license
      # https://github.com/bundler/bundler/blob/master/LICENSE.md
      #
      # A special "thank you" goes to Bundler maintainers and contributors.
      #
      # rubocop:disable Metrics/AbcSize
      # rubocop:disable Metrics/MethodLength
      def system_exec(cmd)
        Open3.popen3(RSpec::Support::Env.env, cmd) do |stdin, stdout, stderr, wait_thr|
          yield stdin, stdout, wait_thr if block_given?
          stdin.close

          @exitstatus = wait_thr&.value&.exitstatus
          @out = Thread.new { stdout.read }.value.strip
          @err = Thread.new { stderr.read }.value.strip
        end

        @all_output ||= ""
        @all_output += [
          "$ #{cmd.to_s.strip}",
          out,
          err,
          @exitstatus ? "# $? => #{@exitstatus}" : "",
          "\n"
        ].reject(&:empty?).join("\n")

        @out
      end
      # rubocop:enable Metrics/MethodLength
      # rubocop:enable Metrics/AbcSize

      def load_paths
        [root.join("lib"), root.join("spec")].join(":")
      end

      def root
        RSpec::Support::Bundler.root
      end

      def cache
        RSpec::Support::Bundler.cache
      end
    end
  end
end

RSpec.configure do |config|
  config.include RSpec::Support::Bundler, type: :integration

  config.before(:all, type: :integration) do
    RSpec::Support::Bundler.setup
  end
end
