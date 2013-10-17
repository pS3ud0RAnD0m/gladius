#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

require_relative 'menu'

class FTP < Menu
  def menu
    header
    puts "Select an option:".light_yellow
    puts "1.  Discover anonymous FTP read/write logins (Nmap)"
    puts "88. Back"
    puts "99. Exit Gladius"

    sel = gets.to_i
    puts
    if sel == 1
      GNmap.new("FTP", "Nmap - Anonymous FTP").menu("script_ftp_anon")
    elsif sel == 88
      GatherInfo.new("Information Gathering").menu
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
