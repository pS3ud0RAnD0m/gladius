#!/usr/bin/env ruby

# Author: p$3ud0R@nD0m

require_relative 'menu'

class SMTP < Menu
  def menu
    header
    puts "Select an option:".light_yellow
    puts "1.  Discover open relays (Nmap)"
    puts "2.  User enum (NI)"
    puts "88. Back"
    puts "99. Exit Gladius"
    sel = gets.to_i
    puts
    case sel
    when 1 then GNmap.new("SMTP", "Nmap - Discover Open Relays").menu("script_smtp_open_relay")
    when 2 then puts "Not implemented yet.".red
      menu
    when 88 then GatherInfo.new("Information Gathering").menu
    when 99 then
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