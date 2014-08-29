module Camtasy
  class Client
    def initialize(server = DRbObject.new_with_uri('druby://localhost:8787'), stdout = $stdout)
      @server = server
      @stdout = stdout
    end

    def run
      @stdout.print server.take_photo
    end
  end
end
