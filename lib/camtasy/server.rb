require "av_capture"
require "drb"

class PhotoServer
  attr_reader :request, :response

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
end

server = PhotoServer.new
Thread.new do
  AVCapture::Session.new.run_with(AVCapture.devices.find(&:video?)) do |connection|
    while server.request.pop
      server.response.push(connection.capture)
    end
  end
end

DRb.start_service('druby://localhost:8787', server)
DRb.thread.join
