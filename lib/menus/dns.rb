#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.0.1

require 'colorize'
require_relative 'menu'
require_relative '../tools/dnsrecon'
require_relative '../tools/fierce'

class Dns < Menu
  def menu
    puts "Select an option:".yellow
    puts "1. Attempt a zone transfer (DNSrecon)"
    puts "2. Attempt a zone transfer and enum standard records (DNSrecon)"
    puts "3. Attempt a zone transfer and brute force records (Fierce)"
    puts "4. Perform Google search for sub-domains and hosts (DNSrecon)"
    puts "5. Perform reverse lookups for an IP block (DNSrecon)"
    puts "6. Back"
    puts "7. Exit"

    sel = gets.to_i
    puts
    if sel == 1
      @title = "DNSrecon"
      header
      instruct_input
      Dnsrecon.new.transfer
    elsif sel == 2
      @title = "DNSrecon"
      header
      instruct_input
      Dnsrecon.new.standard
    elsif sel == 3
      @title = "Fierce"
      header
      instruct_input
      Fierce.new.brute
    elsif sel == 4
      @title = "DNSrecon"
      header
      instruct_input
      Dnsrecon.new.google
    elsif sel == 5
      @title = "DNSrecon"
      header
      instruct_input
      Dnsrecon.new.reverse
    elsif sel == 6
      @title = "Home"
      header
      Home.new.menu
    elsif sel == 7
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
