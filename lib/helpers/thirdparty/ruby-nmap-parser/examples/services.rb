#!/usr/bin/env ruby
#
# A simple script which prints out service information for the open TCP and
# UDP ports found by scanning a host
#
# Kris Katterjohn 02/16/2009

require 'nmap/parser'

p = Nmap::Parser.parsescan("sudo nmap", "-T4 -sSUV 192.168.10.0/24")

p.hosts("up") do |host|
	puts "#{host.addr}:"

	[:tcp, :udp].each do |type|
		host.getports(type, "open") do |port|
			srv = port.service
			puts "Port ##{port.num}/#{port.proto} is open (#{port.reason})"
			puts "\tService: #{srv.name}" if srv.name
			puts "\tProduct: #{srv.product}" if srv.product
			puts "\tVersion: #{srv.version}" if srv.version
			puts
		end
	end

	puts
end

