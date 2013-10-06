#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

require_relative '../helpers/colorize'
require_relative 'tool'
require_relative 'gpty'

class Gladius < Tool
  def initialize(title)
    @title = title
    #@@path = "blah............................................"
    @@hosts = []
  end
  
  # Attempt a zone transfer and brute force records
  def brute
    header
    while line = gets
      @@hosts << line.chomp
    end
    if @@hosts.count == 0
      puts "No hosts were input.".red
      puts
      menu
    elsif @@hosts.count == 1
      @@hosts.each do |host|
        puts "Attempting a zone transfer and brute against " + host + "..."
        puts
        i = Gpty.new
        i.cmd = @@path + "fierce.pl --threads 2 -wordlist " + @@path + "stdn_hosts.txt -dns " + host
        i.shell
      end
      puts
      HTTP.new("HTTP(S)").menu
    else
      l = @@hosts.count
      puts "Attempting zone transfers and brutes against #{l} domains..."
        @@hosts.each do |host|
          puts
          i = Gpty.new
          i.cmd = @@path + "fierce.pl --threads 2 -wordlist " + @@path + "stdn_hosts.txt -dns " + host
          i.shell
        end
      puts
      HTTP.new("HTTP(S)").menu
    end
  end
end
