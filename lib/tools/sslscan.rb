#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.0.1

require 'colorize'
require_relative 'tool'
require_relative '../shells/gpty'

class SSLScan < Tool
  def initialize(title)
    @title = title
    @@path = "/usr/bin/sslscan"
    @@hosts = []
  end
  
  # Identify supported SSL/TLS protcols and ciphers
  def scan
    header
    instruct_input1
    example("fqdn", "ip")
    while line = gets
      @@hosts << line.chomp
    end
    if @@hosts.count == 0
      puts "No hosts were input.".red
      HTTP.new("HTTP(S)").menu
    elsif @@hosts.count == 1
      @@hosts.each do |host|
        puts "Identifing supported protcols and ciphers on " + host + " ..."
        puts
        i = Gpty.new
        i.cmd = @@path + " --no-failed " + host
        i.shell
      end
      puts
      HTTP.new("HTTP(S)").menu
    else
      l = @@hosts.count
      puts "Identifing supported protcols and ciphers on #{l} targets ..."
        @@hosts.each do |host|
          puts
          i = Gpty.new
          i.cmd = @@path + " --no-failed " + host
          i.shell
        end
      puts
      HTTP.new("HTTP(S)").menu
    end
  end
end
