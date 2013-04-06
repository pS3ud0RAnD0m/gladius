#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.0.1

require 'colorize'
require_relative 'tool'
require_relative '../shells/gpty'

class DNSrecon < Tool
  def initialize
  @@path = "/pentest/enumeration/dns/dnsrecon/dnsrecon.py"
  @@hosts = []
  end

  # Attempt a zone transfer:
  def transfer
    while line = gets
      @@hosts << line.chomp
    end
    if @@hosts.count == 0
      puts "No hosts were input.".red
      puts
      menu
    elsif @@hosts.count == 1
      @@hosts.each do |host|
        puts "Attempting a zone transfer against " + host + "..."
        puts
        i = Gpty.new
        i.cmd = @@path + " --threads 2 -t axfr -d " + host
        i.shell
      end
      puts
      @title = "DNS"
      header
      DNS.new.menu
    else
      l = @@hosts.count
      puts "Attempting zone transfers against #{l} domains..."
        @@hosts.each do |host|
          puts
          i = Gpty.new
          i.cmd = @@path + " --threads 2 -t axfr -d " + host
          i.shell
        end
      puts
      @title = "DNS"
      header
      DNS.new.menu
    end
  end
  
  # Attempt a zone transfer, then enum standard records:
  def standard
    while line = gets
      @@hosts << line.chomp
    end
    if @@hosts.count == 0
      puts "No hosts were input.".red
      puts
      menu
    elsif @@hosts.count == 1
      @@hosts.each do |host|
        puts "Attempting a zone transfer and standard enum against " + host + "..."
        puts
        i = Gpty.new
        i.cmd = @@path + " --threads 2 -a -d " + host
        i.shell
      end
      puts
      @title = "DNS"
      header
      DNS.new.menu
    else
      l = @@hosts.count
      puts "Attempting zone transfers and standard enums against #{l} domains..."
        @@hosts.each do |host|
          puts
          i = Gpty.new
          i.cmd = @@path + " --threads 2 -a -d " + host
          i.shell
        end
      puts
      @title = "DNS"
      header
      DNS.new.menu
    end
  end

  # Perform Google search for sub-domains and @@hosts:
  def google
    while line = gets
      @@hosts << line.chomp
    end
    if @@hosts.count == 0
      puts "No hosts were input.".red
      puts
      menu
    elsif @@hosts.count == 1
      @@hosts.each do |host|
        puts "Performing Google search for sub-domains and hosts against " + host + "..."
        puts
        i = Gpty.new
        i.cmd = @@path + " --threads 2 -t goo -d " + host
        i.shell
      end
      puts
      @title = "DNS"
      header
      DNS.new.menu
    else
      l = @@hosts.count
      puts "Performing Google search for sub-domains and hosts against #{l} domains..."
        @@hosts.each do |host|
          puts
          i = Gpty.new
          i.cmd = @@path + " --threads 2 -t goo -d " + host
          i.shell
        end
      puts
      @title = "DNS"
      header
      DNS.new.menu
    end
  end
  
  # Reverse lookups for given block
  def reverse
    while line = gets
      @@hosts << line.chomp
    end
    if @@hosts.count == 0
      puts "No hosts were input.".red
      puts
      menu
    elsif @@hosts.count == 1
      @@hosts.each do |host|
        puts "Performing reverse lookups against " + host + "..."
        puts
        i = Gpty.new
        i.cmd = @@path + " --threads 2 -t rvl -r " + host
        i.shell
      end
      puts
      @title = "DNS"
      header
      DNS.new.menu
    else
      l = @@hosts.count
      puts "Performing reverse lookups against #{l} domains..."
        @@hosts.each do |host|
          puts
          i = Gpty.new
          i.cmd = @@path + " --threads 2 -t rvl -r " + host
          i.shell
        end
      puts
      @title = "DNS"
      header
      DNS.new.menu
    end
  end
end  
