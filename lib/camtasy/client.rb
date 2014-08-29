module Camtasy
  class Client
    def initialize(uri, stdout = $stdout)
      @server = DRbObject.new_with_uri(uri)
      @stdout = stdout
    end

    def run
      @stdout.print @server.take_photo
    end
  end
end
