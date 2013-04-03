#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.0.1

require 'colorize'
require_relative 'tool'
require_relative '../shells/gpty'

class Fierce < Tool
  def initialize
    @@path = "/pentest/enumeration/dns/fierce/"
    @@hosts = []
  end
  
  # Attempt a zone transfer and brute force records
  def brute
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
        brute = Gpty.new
        brute.cmd = @@path + "fierce.pl --threads 2 -wordlist " + @@path + "hosts.txt -dns " + host
        brute.shell
      end
      puts
      next_menu = Dns.new
      next_menu.menu
    else
      l = @@hosts.count
      puts "Attempting zone transfers and brutes against #{l} domains..."
        @@hosts.each do |host|
          puts
          brute = Gpty.new
          brute.cmd = @@path + "fierce.pl --threads 2 -wordlist " + @@path + "hosts.txt -dns " + host
          brute.shell
        end
      puts
      next_menu = Dns.new
      next_menu.menu
    end
  end
end
