#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.0.1

require 'colorize'
require_relative 'menu'
require_relative 'gatherinfo'
require_relative '../tools/dnsrecon'
require_relative '../tools/fierce'
require_relative '../tools/dig'

class DNS < Menu
  def menu
    puts "Select an option:".light_yellow
    puts "1. Identify Domain Controllers (dig)"
    puts "2. Attempt a zone transfer (DNSrecon)"
    puts "3. Attempt a zone transfer and enum standard records (DNSrecon)"
    puts "4. Attempt a zone transfer and brute force records (Fierce)"
    puts "5. Perform Google search for sub-domains and hosts (DNSrecon)"
    puts "6. Perform reverse lookups for an IP block (DNSrecon)"
    puts "7. Back"
    puts "8. Exit Gladius"

    sel = gets.to_i
    puts
    if sel == 1
      @title = "Identify Domain Controllers"
      header
      Dig.new.idcontrollers
    elsif sel == 2
      @title = "Zone Transfer"
      header
      instruct_input1
      DNSrecon.new.transfer
    elsif sel == 3
      @title = "Zone Transfer and Standard Records"
      header
      instruct_input1
      DNSrecon.new.standard
    elsif sel == 4
      @title = "Zone Transfer and Brute Records"
      header
      instruct_input1
      Fierce.new.brute
    elsif sel == 5
      @title = "Google Search for Sub-domains and Hosts"
      header
      instruct_input1
      DNSrecon.new.google
    elsif sel == 6
      @title = "Reverse Lookups"
      header
      instruct_input1
      example_input1
      DNSrecon.new.reverse
    elsif sel == 7
      @title = "Information Gathering"
      header
      GatherInfo.new.menu
    elsif sel == 8
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
