#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.2

require_relative '../helpers/colorize'
require_relative 'tool'
require_relative 'gpty'
require_relative '../menus/http'

class ApacheUsers < Tool
  def initialize(title)
    @title = title
    @@path_tool = "apache-users"
    @@path_names = Constant::PROJECT_ROOT + "/helpers/apache-usernames.txt"
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
          i.cmd = @@path_tool + " -s 0 -e 403 -p 80 -t 8 -l " + @@path_names + " -h " + host
          i.shell
        end
      puts
      HTTP.new("HTTP(S)").menu
    end
  end
end
