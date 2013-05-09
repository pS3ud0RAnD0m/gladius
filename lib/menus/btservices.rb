#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.1

require 'colorize'
require_relative 'menu'
require_relative '../tools/iptables'
require_relative 'configsnort'

class BTServices < Menu
  def menu
    header
    puts "Select a task:".light_yellow
    puts "1.  Monitor LAN traffic (Snort/Snorby)"
    puts "2.  Setup a TFTP server (atftpd) (NI)"
    puts "3.  Setup an FTP server (NI)"
    puts "4.  Setup an HTTP(S) server (NI)"
    puts "5.  List current firewall rules (IPtables)"
    puts "6.  Setup awesome BT5 updates (bt5up) (NI)"
    puts "7.  ..."
    puts "8.  ..."
    puts "88. Back"
    puts "99. Exit Gladius"

    sel = gets.to_i
    puts
    if sel == 1
      ConfigSnort.new("Snort/Snorby - Configuration").menu
    elsif sel == 2
      puts "Not implemented yet.".red
      menu
    elsif sel == 3
      puts "Not implemented yet.".red
      menu
    elsif sel == 4
      puts "Not implemented yet.".red
      menu
    elsif sel == 5
      IPtables.new("List IPtables Rules").list
    elsif sel == 6
      puts "Not implemented yet.".red
      menu
    elsif sel == 7
      puts "Not implemented yet.".red
      menu
    elsif sel == 8
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


