#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.0.1

require 'colorize'
require_relative 'menu'
require_relative '../tools/iptables'

class BTServices < Menu
  def menu
    puts "Select a task:".light_yellow
    puts "1.  Monitor LAN traffic (Snort/Snorby) (NI)"
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
      puts "Not implemented yet.".red
      menu
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
      @title = "List IPtables Rules"
      header
      IPtables.new.list
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
      @title = "Home"
      header
      Home.new.menu
    elsif sel == 99
      begin
      puts "Exiting Gladius. Have a bloody day!".red
      rescue Interrupt
      end
    else
      puts "Invalid selection.".red
      @title = "Configure Back Track Services"
      header
      menu
    end
  end
end

