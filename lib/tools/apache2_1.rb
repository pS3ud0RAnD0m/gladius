#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.0.1

require 'colorize'
require_relative 'tool'
require_relative 'gpty'
require_relative '../menus/http'

class Apache2_1 < Tool
  def initialize(title)
    @title = title
    @@path_tool = "/pentest/enumeration/web/apache-users/apache2.1.pl"
    @@path_names = "/pentest/enumeration/web/apache-users/names"
    @@hosts = []
  end
  
  # Enum Users
  def fingerprint
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
        puts "Attempting to enum users on " + host + "..."
        puts
        i = Gpty.new
        i.cmd = @@path_tool + " -s 0 -e 403 -p 80 -t 8 -l " + @@path_names + " -h " + host
        i.shell
      end
      puts
      HTTP.new("HTTP(S)").menu
    else
      l = @@hosts.count
      puts "Attempting to enum users on #{l} hosts ..."
        @@hosts.each do |host|
          puts
          i = Gpty.new
          i.cmd = @@path_tool + " -P0 -s " + @@path_names + " -h " + host
          i.shell
        end
      puts
      HTTP.new("HTTP(S)").menu
    end
  end
end
