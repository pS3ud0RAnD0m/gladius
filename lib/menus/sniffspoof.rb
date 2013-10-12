#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

require_relative 'menu'
require_relative '../tools/dsniff'

class SniffSpoof < Menu
  def menu
    header
    puts "Select a task:".light_yellow
    puts "1.  Sniff for plaintext creds (Dsniff)"
    puts "2.  MiTM ARP poisoning (Ettercap) (NI)"
    puts "88. Back"
    puts "99. Exit Gladius"

    sel = gets.to_i
    puts
    if sel == 1
      Dsniff.new("Dsniff - Sniff for plaintext creds").all
    elsif sel == 2
      puts "Not implemented yet.".red
      menu
    elsif sel == 88
      Home.new("Home").menu
    elsif sel == 99
      begin
      puts "Exiting Gladius. Have a bloody day!".red
      puts
      rescue Interrupt
      end
    else
      puts "Invalid selection.".red
      menu
    end
  end
end

