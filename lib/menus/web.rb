#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.0.1

require 'colorize'
require_relative 'menu'
require_relative 'dns'
require_relative 'ftp'

class Web < Menu
  def menu
    puts "Select a service to target:".light_yellow
    puts "1.  DNS"
    puts "2.  FTP"
    puts "3.  HTTP(S) (Not implemented yet)"
    puts "4.  MSSQL (Not implemented yet)"
    puts "5.  MySQL (Not implemented yet)"
    puts "6.  Netbios (Not implemented yet)"
    puts "7.  Oracle (Not implemented yet)"
    puts "8.  RDP (Not implemented yet)"
    puts "9.  SNMP (Not implemented yet)"
    puts "10. SSH (Not implemented yet)"
    puts "11. Telnet (Not implemented yet)"
    puts "12. TFTP (Not implemented yet)"
    puts "13. Back"
    puts "14. Exit Gladius"

    sel = gets.to_i
    puts
    if sel == 1
      @title = "DNS"
      header
      DNS.new.menu
    elsif sel == 2
      @title = "FTP"
      header
      FTP.new.menu
    elsif sel == 3
      puts "Not implemented yet.".red
      menu
    elsif sel == 4
      puts "Not implemented yet.".red
      menu
    elsif sel == 5
      puts "Not implemented yet.".red
      menu
    elsif sel == 6
      puts "Not implemented yet.".red
      menu
    elsif sel == 7
      puts "Not implemented yet.".red
      menu
    elsif sel == 8
      puts "Not implemented yet.".red
      menu
    elsif sel == 9
      puts "Not implemented yet.".red
      menu
    elsif sel == 10
      puts "Not implemented yet.".red
      menu
    elsif sel == 11
      puts "Not implemented yet.".red
      menu
    elsif sel == 12
      puts "Not implemented yet.".red
      menu
    elsif sel == 13
      @title = "Home"
      header
      Home.new.menu
    elsif sel == 14
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

