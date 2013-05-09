#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.1

require 'colorize'
require_relative 'tool'
require_relative 'gpty'
require_relative '../menus/http'

class Httprint < Tool
  def initialize(title)
    @title = title
    @@path_tool = "/pentest/enumeration/web/httprint/linux/httprint"
    @@path_sig = "/pentest/enumeration/web/httprint/linux/signatures.txt"
    @@hosts = []
  end
  
  # Fingerprint web servers
  def fingerprint
    header
    puts "Note: This tool seems pretty flakey. It has problems resolving URLs and seems hit or miss for IPs.".light_yellow
    puts
    instruct_input1
    example("ip")
    while line = gets
      @@hosts << line.chomp
    end
    if @@hosts.count == 0
      puts "No hosts were input.".red
      HTTP.new("HTTP(S)").menu
    elsif @@hosts.count == 1
      @@hosts.each do |host|
        puts "Attempting to fingerprint " + host + "..."
        puts
        i = Gpty.new
        i.cmd = @@path_tool + " -P0 -s " + @@path_sig + " -h " + host
        i.shell
      end
      puts
      HTTP.new("HTTP(S)").menu
    else
      l = @@hosts.count
      puts "Attempting to fingerprint #{l} hosts ..."
        @@hosts.each do |host|
          puts
          i = Gpty.new
          i.cmd = @@path_tool + " -P0 -s " + @@path_sig + " -h " + host
          i.shell
        end
      puts
      HTTP.new("HTTP(S)").menu
    end
  end
end
