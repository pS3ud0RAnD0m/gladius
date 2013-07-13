#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.2

require_relative '../helpers/colorize'
require_relative 'tool'
require_relative 'gpty'

class DNSrecon < Tool
  def initialize(title)
    @title = title
    @@path = "dnsrecon"
    @@hosts = []
  end

  # Attempt a zone transfer:
  def transfer
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
        puts "Attempting a zone transfer against " + host + " ..."
        puts
        i = Gpty.new
        i.cmd = @@path + " --threads 2 -t axfr -d " + host
        i.shell
      end
      puts
      DNS.new("DNS").menu
    else
      l = @@hosts.count
      puts "Attempting zone transfers against #{l} domains ..."
        @@hosts.each do |host|
          puts
          i = Gpty.new
          i.cmd = @@path + " --threads 2 -t axfr -d " + host
          i.shell
        end
      puts
      DNS.new("DNS").menu
    end
  end
  
  # Attempt a zone transfer, then enum standard records:
  def standard
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
        puts "Attempting a zone transfer and standard enum against " + host + " ..."
        puts
        i = Gpty.new
        i.cmd = @@path + " --threads 2 -a -d " + host
        i.shell
      end
      puts
      DNS.new("DNS").menu
    else
      l = @@hosts.count
      puts "Attempting zone transfers and standard enums against #{l} domains ..."
        @@hosts.each do |host|
          puts
          i = Gpty.new
          i.cmd = @@path + " --threads 2 -a -d " + host
          i.shell
        end
      puts
      DNS.new("DNS").menu
    end
  end

  # Perform Google search for sub-domains and @@hosts:
  def google
    header
    instruct_input1
    example("cidr")
    while line = gets
      @@hosts << line.chomp
    end
    if @@hosts.count == 0
      puts "No hosts were input.".red
      DNS.new("DNS").menu
    elsif @@hosts.count == 1
      @@hosts.each do |host|
        puts "Performing Google search for sub-domains and hosts against " + host + " ..."
        puts
        i = Gpty.new
        i.cmd = @@path + " --threads 2 -t goo -d " + host
        i.shell
      end
      puts
      DNS.new("DNS").menu
    else
      l = @@hosts.count
      puts "Performing Google search for sub-domains and hosts against #{l} domains ..."
        @@hosts.each do |host|
          puts
          i = Gpty.new
          i.cmd = @@path + " --threads 2 -t goo -d " + host
          i.shell
        end
      puts
      DNS.new("DNS").menu
    end
  end
  
  # Reverse lookups for given block
  def reverse
    header
    instruct_input1
    example("iprl", "cidr")
    while line = gets
      @@hosts << line.chomp
    end
    if @@hosts.count == 0
      puts "No hosts were input.".red
      DNS.new("DNS").menu
    elsif @@hosts.count == 1
      @@hosts.each do |host|
        puts "Performing reverse lookups against " + host + " ..."
        puts
        i = Gpty.new
        i.cmd = @@path + " --threads 2 -t rvl -r " + host
        i.shell
      end
      puts
      DNS.new("DNS").menu
    else
      l = @@hosts.count
      puts "Performing reverse lookups against #{l} targets ..."
        @@hosts.each do |host|
          puts
          i = Gpty.new
          i.cmd = @@path + " --threads 2 -t rvl -r " + host
          i.shell
        end
      puts
      DNS.new("DNS").menu
    end
  end
end  
