require "drb"

server = DRbObject.new_with_uri('druby://localhost:8787')
print server.take_photo
