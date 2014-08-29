module Camtasy
  class PhotoServer
    def initialize
      @request = Queue.new
      @response = Queue.new
      @mutex = Mutex.new
    end

    def take_photo
      @mutex.synchronize do
        @request << "x"
        @response.pop
      end
    end

    def run(uri)
      Thread.new do
        AVCapture::Session.new.run_with(AVCapture.devices.find(&:video?)) do |connection|
          while @request.pop
            @response.push(connection.capture)
          end
        end
      end

      DRb.start_service(uri, self)
      DRb.thread.join
    end
  end
end
