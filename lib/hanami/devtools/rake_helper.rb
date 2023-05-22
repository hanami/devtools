require "rake"

module Hanami
  module Devtools
    # Distribute Rake tasks
    class RakeHelper
      include Rake::DSL

      def self.install_tasks
        new.install
      end

      def install # rubocop:disable Metrics/MethodLength
        namespace :codecov do
          desc "Uploads the latest simplecov result set to codecov.io"
          task :upload do
            if ENV["CI"]
              require "simplecov"
              require "codecov"

              formatter = SimpleCov::Formatter::Codecov.new
              formatter.format(SimpleCov::ResultMerger.merged_result)
            end
          end
        end
      end
    end
  end
end
