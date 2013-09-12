#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

require_relative 'gatherinfo'
require_relative 'sniffspoof'
require_relative 'web'
require_relative 'wireless'
require_relative 'dictionary'
require_relative 'kaliservices'

class Home < Menu
  def menu
    header
    puts "Select a category:".light_yellow
    puts "1.  Gather information"
    puts "2.  Sniffing and Spoofing"
    puts "3.  Web attacks (NI)"
    puts "4.  Wireless attacks (NI)"
    puts "5.  Dictionary attacks"
    puts "6.  Configure Kali services"
    puts "99. Exit Gladius"
    
    sel = gets.to_i
    puts
    if sel == 1
      GatherInfo.new("Gather Information").menu
    elsif sel == 2
      SniffSpoof.new("Sniffing and Spoofing").menu
    elsif sel == 3
      puts "Not implemented yet.".red
      menu
    elsif sel == 4
      puts "Not implemented yet.".red
      menu
      #Wireless.new("Wireless Attacks").menu
    elsif sel == 5
      Dictionary.new("Dictionary Attacks").menu
    elsif sel == 6
      KaliServices.new("Configure Kali Services").menu
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

