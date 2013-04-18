#!/usr/bin/env ruby

require 'socket'

$host = 'www.google.com'
$port = 80

s = TCPSocket.open $host, $port
s.write "HEAD / HTTP/1.1\r\n\r\n"
while line = s.gets
  puts line.chop
end
s.close