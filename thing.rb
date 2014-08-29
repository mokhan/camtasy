require "av_capture"

session = AVCapture::Session.new
device = AVCapture.devices.find(&:video?)

session.run_with(device) do |connection|
  $stdout.write connection.capture
end
