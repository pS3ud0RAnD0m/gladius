#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

require_relative '../helpers/colorize'
require_relative 'tool'
require_relative 'gpty'

class Fierce < Tool
  def initialize(title)
    @title = title
    @@path_tool = "fierce"
    @@path_hosts = "/usr/share/gladius/input/fierce-hosts.txt"
    @@hosts = []
  end
  
  # Attempt a zone transfer and brute force records
  def brute
    header
    instruct_input1
    example("fqdn")
    while line = gets
      @@hosts << line.chomp
    end
    if @@hosts.count == 0
      puts "No hosts were input.".red
      DNS.new("DNS").menu
    elsif @@hosts.count == 1
      @@hosts.each do |host|
        puts "Attempting a zone transfer and brute against " + host + " ..."
        puts
        a = Gpty.new
        a.cmd = @@path_tool + " --threads 2 -wordlist " + @@path_hosts + " -dns " + host
        a.shell
      end
      puts
      DNS.new("DNS").menu
      # Catch interrupt
      rescue Interrupt
        puts
        puts "Brute stopped due to interrupt.".light_yellow
        puts
        DNS.new("DNS").menu
    else
      l = @@hosts.count
      puts "Attempting zone transfers and brutes against #{l} domains ..."
        @@hosts.each do |host|
          puts
          a = Gpty.new
          a.cmd = @@path_tool + " --threads 2 -wordlist " + @@path_hosts + " -dns " + host
          a.shell
        end
      puts
      DNS.new("DNS").menu
      # Catch interrupt
      rescue Interrupt
        puts
        puts "Brute stopped due to interrupt.".light_yellow
        puts
        DNS.new("DNS").menu
    end
  end
end
