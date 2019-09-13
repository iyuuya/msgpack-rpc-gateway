# frozen_string_literal: true

require 'msgpack/rpc'
require 'msgpack/rpc/gateway/service'

module MessagePack
  module RPC
    autoload :RandomBalancer, 'msgpack/rpc/gateway/random_balancer'

    class Gateway
      def initialize(balancer_class = RandomBalancer)
        @services_by_type = {}
        @balancer_class = balancer_class
      end

      def register(service_name, host, port)
        name = service_name.to_s
        @services_by_type[name] ||= @balancer_class.new
        service = Service.new(name, host, port)
        @services_by_type[name] << service
        service.uuid
      end

      def unregister(uuid)
        @services_by_type.each_value do |services|
          services.delete_if { |service| service.uuid == uuid }
        end
      end

      def run(service_name, command, *args)
        @services_by_type[service_name.to_s].decide.run(command, *args)
      end

      class << self
        def start(host, port)
          serv = MessagePack::RPC::Server.new
          gateway = new
          yield gateway if block_given?
          serv.listen(host, port, gateway)
          serv.run
        end
      end
    end
  end
end
