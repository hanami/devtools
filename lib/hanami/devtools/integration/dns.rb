require "resolv-replace"

module RSpec
  module Support
    # DNS stub utilities
    module Dns
      private

      def stub_dns_hosts(hosts)
        file = Pathname.new(Dir.pwd).join("tmp", "hosts-#{SecureRandom.uuid}")
        write(file, hosts)

        hosts_resolver = Resolv::Hosts.new(file.to_s)
        dns_resolver = Resolv::DNS.new

        Resolv::DefaultResolver.replace_resolvers([hosts_resolver, dns_resolver])
      end
    end
  end
end

RSpec.configure do |config|
  config.include RSpec::Support::Dns, type: :integration
end
