require "thor"

module Camtasy
  class CLI < Thor
    DEFAULT_URI='druby://localhost:8787'

    desc 'server', 'starts a server.'
    method_options uri: :string
    def server
      PhotoServer.new.run(options[:uri] || DEFAULT_URI)
    end

    desc 'client', 'connect to a server'
    method_options uri: :string
    def client
      Client.new(options[:uri] || DEFAULT_URI).run
    end
  end
end
