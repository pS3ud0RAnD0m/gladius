#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.0.1

require 'colorize'
require_relative 'tool'
require_relative '../shells/gpty'

class Fierce < Tool
  def initialize(title)
    @title = title
    @@path_tool = "/pentest/enumeration/dns/fierce/fierce.pl"
    @@path_hosts = "/pentest/enumeration/dns/fierce/hosts.txt"
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
        puts "Attempting a zone transfer and brute against " + host + "..."
        puts
        i = Gpty.new
        i.cmd = @@path_tool + " --threads 2 -wordlist " + @@path_hosts + " -dns " + host
        i.shell
      end
      puts
      DNS.new("DNS").menu
    else
      l = @@hosts.count
      puts "Attempting zone transfers and brutes against #{l} domains..."
        @@hosts.each do |host|
          puts
          i = Gpty.new
          i.cmd = @@path_tool + " --threads 2 -wordlist " + @@path_hosts + " -dns " + host
          i.shell
        end
      puts
      DNS.new("DNS").menu
    end
  end
end
