#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.2

require_relative '../helpers/colorize'
require_relative 'menu'
require_relative 'gatherinfo'
require_relative 'lan'
require_relative 'web'
require_relative 'wireless'
require_relative 'dictionary'
require_relative 'btservices'

class Home < Menu
  def menu
    header
    puts "Select a category:".light_yellow
    puts "1.  Gather information"
    puts "2.  LAN attacks (NI)"
    puts "3.  Web attacks (NI)"
    puts "4.  Wireless attacks"
    puts "5.  Dictionary attacks"
    puts "6.  Configure Back Track services"
    puts "99. Exit Gladius"
    
    sel = gets.to_i
    puts
    if sel == 1
      GatherInfo.new("Gather Information").menu
    elsif sel == 2
      LAN.new("LAN Attacks").menu
    elsif sel == 3
      puts "Not implemented yet.".red
      menu
    elsif sel == 4
      Wireless.new("Wireless Attacks").menu
    elsif sel == 5
      Dictionary.new("Dictionary Attacks").menu
    elsif sel == 6
      BTServices.new("Configure Back Track Services").menu
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
  
  def test
    puts "This is a test from home..."
  end
end

