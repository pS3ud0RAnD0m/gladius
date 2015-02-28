#!/usr/bin/env ruby
#
# Very simple script to print out the open TCP ports for each host
#
# Kris Katterjohn 01/27/2009

require 'nmap/parser'

p = Nmap::Parser.parsescan("nmap", "-T4 192.168.10.0/24")

p.hosts("up") do |host|
	puts "#{host.addr}:"

	host.tcp_ports("open") do |port|
		puts "Got #{port.num}/#{port.proto}"
	end

	puts
end

