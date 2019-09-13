# frozen_string_literal: true

class MessagePack::RPC::Gateway
  class Service
    attr_reader :name, :host, :port, :uuid

    def initialize(name, host, port)
      @name = name.to_s
      @host = host
      @port = port
      @uuid = "#{name}:#{host}:#{port}".hash
      @client = MessagePack::RPC::Client.new(@host, @port)
    end

    def run(command, *args)
      @client.call(command, *args)
    end
  end
end
