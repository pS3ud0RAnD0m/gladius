#!/usr/bin/env ruby

# Author:  P$3ud0R@nD0m
# Version: 0.0.2

require_relative '../helpers/colorize'
require_relative 'menu'
require_relative '../tools/nessus'

class FTP < Menu
  def menu
    header
    puts "Select an option:".light_yellow
    puts "1.  Discover anonymous FTP read/write logins (Nessus)"
    puts "88. Back"
    puts "99. Exit Gladius"

    sel = gets.to_i
    puts
    if sel == 1
      Nessus.new("Nessus - Anonymous FTP").ftp_anon
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
