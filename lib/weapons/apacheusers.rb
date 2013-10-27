#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

require_relative 'weapon'
require_relative 'gpty'

class ApacheUsers < Weapon
  def initialize(title)
    @title = title
    @@path_weapon = "apache-users"
    @@path_names = "/usr/share/gladius/input/apache_usernames.txt"
    @@hosts = []
  end
  
  # Enum Users
  def fingerprint
    header
    instruct_input_targets("fqdn", "ip")
    while line = gets
      @@hosts << line.chomp
    end
    if @@hosts.count == 0
      puts "No hosts were input.".red
      HTTP.new("HTTP(S)").menu
    elsif @@hosts.count == 1
      @@hosts.each do |host|
        puts "Attempting to enum users on " + host + " ..."
        puts
        i = Gpty.new
        i.cmd = @@path_weapon + " -s 0 -e 403 -p 80 -t 8 -l " + @@path_names + " -h " + host
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
          i.cmd = @@path_weapon + " -s 0 -e 403 -p 80 -t 8 -l " + @@path_names + " -h " + host
          i.shell
        end
      puts
      HTTP.new("HTTP(S)").menu
    end
  end
end
