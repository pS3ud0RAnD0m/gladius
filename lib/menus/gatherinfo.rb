#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.2

require_relative '../helpers/colorize'
require_relative 'menu'
require_relative 'home'
require_relative 'dns'
require_relative 'ftp'
require_relative 'http'

class GatherInfo < Menu
  
  def menu
    header
    puts "Select a service to target:".light_yellow
    puts "1.  DNS"
    puts "2.  FTP"
    puts "3.  HTTP(S)"
    puts "4.  MSSQL (NI)"
    puts "5.  MySQL (NI)"
    puts "6.  Netbios-SMB (NI)"
    puts "7.  Oracle (NI)"
    puts "8.  RDP (NI)"
    puts "9.  SNMP (NI)"
    puts "10. SSH (NI)"
    puts "11. Telnet (NI)"
    puts "12. TFTP (NI)"
    puts "88. Back"
    puts "99. Exit Gladius"

    sel = gets.to_i
    puts
    if sel == 1
      DNS.new("DNS").menu
    elsif sel == 2
      FTP.new("FTP").menu
    elsif sel == 3
      HTTP.new("HTTP(S)").menu
    elsif sel == 4
      puts "Not implemented yet.".red
      menu
    elsif sel == 5
      puts "Not implemented yet.".red
      menu
    elsif sel == 6
      NetbiosSMB.new("Netbios-SMB").menu
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

