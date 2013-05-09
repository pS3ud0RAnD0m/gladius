#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.1

require 'colorize'
require_relative 'menu'
require_relative 'gatherinfo'
require_relative '../tools/dnsrecon'
require_relative '../tools/fierce'
require_relative '../tools/dig'

class DNS < Menu
  def menu
    header
    puts "Select an option:".light_yellow
    puts "1.  Identify Domain Controllers (DiG)"
    puts "2.  Attempt a zone transfer (DNSrecon)"
    puts "3.  Attempt a zone transfer and enum standard records (DNSrecon)"
    puts "4.  Attempt a zone transfer and brute force records (Fierce)"
    puts "5.  Perform Google search for sub-domains and hosts (DNSrecon)"
    puts "6.  Perform reverse lookups for an IP block (DNSrecon)"
    puts "88. Back"
    puts "99. Exit Gladius"

    sel = gets.to_i
    puts
    if sel == 1
      DiG.new("DiG - Identify Domain Controllers").idcontrollers
    elsif sel == 2
      DNSrecon.new("DNSrecon - Zone Transfer").transfer
    elsif sel == 3
      DNSrecon.new("DNSrecon - Zone Transfer and Standard Records").standard
    elsif sel == 4
      Fierce.new("Fierce - Zone Transfer and Brute Records").brute
    elsif sel == 5
      DNSrecon.new("DNSrecon - Google Search for Sub-domains and Hosts").google
    elsif sel == 6
      DNSrecon.new("DNSrecon - Reverse Lookups").reverse
    elsif sel == 88
      GatherInfo.new("Information Gathering").menu
    elsif sel == 99
      begin
      puts "Exiting Gladius. Have a bloody day!".red
      rescue Interrupt
      end
    else
      puts "Invalid selection.".red
      menu
    end
  end
end
