#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.2

require_relative '../helpers/colorize'
require_relative 'tool'
require_relative 'gpty'
require_relative '../menus/dns'

class DNSrecon < Tool
  def initialize(title)
    @title = title
    @@path = "dnsrecon"
    @@hosts = []
  end

  # Scan top 1000 tcp ports:
  def tcpquick
    header
    instruct_input1
    example("fqdn", "ip", "ipr", "iprl", "iprf", "cidr")
    while line = gets
      @@hosts << line.chomp
    end
    if @@hosts.count == 0
      puts "No hosts were input.".red
      DNS.new("DNS").menu
    elsif @@hosts.count == 1
      @@hosts.each do |host|
        puts "Attempting a zone transfer against " + host + " ..."
        puts
        i = Gpty.new
        i.cmd = @@path + " --threads 2 -t axfr -d " + host
        i.shell
      end
      puts
      DNS.new("DNS").menu
    else
      l = @@hosts.count
      puts "Attempting zone transfers against #{l} domains ..."
        @@hosts.each do |host|
          puts
          i = Gpty.new
          i.cmd = @@path + " --threads 2 -t axfr -d " + host
          i.shell
        end
      puts
      DNS.new("DNS").menu
    end
  end
  


end  
