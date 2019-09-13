# frozen_string_literal: true

class MessagePack::RPC::Gateway
  class RandomBalancer < Array
    alias decide sample
  end
end
