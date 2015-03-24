# -*- encoding: utf-8 -*-
require 'net/ping'
module TtlAuto
  class Ping
    include Constant

    def initialize hash
      @host = hash[:server]
      @port = hash[:port]
    end

    def scan?
      tcp = Net::Ping::TCP.new(@host, @port)
      tcp.ping?
    end

  end
end
