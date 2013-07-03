#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.2

require_relative '../helpers/colorize'
require_relative 'menu'
require_relative 'dns'
require_relative 'ftp'

class Dictionary < Menu
  def menu
    header
    puts "Select a task:".light_yellow
    puts "1.  Create custom user/pass lists (NI)"
    puts "2.  Brute force authentication (Medusa) (NI)"
    puts "3.  ..."
    puts "88. Back"
    puts "99. Exit Gladius"

    sel = gets.to_i
    puts
    if sel == 1
      puts "Not implemented yet.".red
      menu
    elsif sel == 2
      puts "Not implemented yet.".red
      menu
    elsif sel == 3
      puts "Not implemented yet.".red
      menu
    elsif sel == 88
      Home.new("Home").menu
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

