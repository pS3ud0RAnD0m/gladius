#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

#require_relative '../helpers/colorize'
#require_relative 'menu'
#require_relative 'home'
require_relative 'dns'
require_relative 'ftp'
require_relative 'http'
require_relative 'snmp'
require_relative 'discoverservices'

class GatherInfo < Menu
  def menu
    header
    puts "Select a service to target:".light_yellow
    puts "1.  Discover services (Nmap)"
    puts "2.  DNS"
    puts "3.  FTP"
    puts "4.  HTTP(S)"
    puts "5.  MSSQL (NI)"
    puts "6.  MySQL (NI)"
    puts "7.  Netbios-SMB (NI)"
    puts "8.  Oracle (NI)"
    puts "9.  RDP (NI)"
    puts "10. SNMP"
    puts "11. SSH (NI)"
    puts "12. Telnet (NI)"
    puts "13. TFTP (NI)"
    puts "88. Back"
    puts "99. Exit Gladius"

    sel = gets.to_i
    puts
    if sel == 1
      DiscoverServices.new("Nmap - Discover Services").menu
    elsif sel == 2
      DNS.new("Gather Information - DNS").menu
    elsif sel == 3
      FTP.new("Gather Information - FTP").menu
    elsif sel == 4
      HTTP.new("Gather Information - HTTP(S)").menu
    elsif sel == 5
      puts "Not implemented yet.".red
      menu
    elsif sel == 6
      puts "Not implemented yet.".red
      menu
    elsif sel == 7
      NetbiosSMB.new("Gather Information - Netbios-SMB").menu
    elsif sel == 8
      puts "Not implemented yet.".red
      menu
    elsif sel == 9
      puts "Not implemented yet.".red
      menu
    elsif sel == 10
      SNMP.new("SNMP").menu
    elsif sel == 11
      puts "Not implemented yet.".red
      menu
    elsif sel == 12
      puts "Not implemented yet.".red
      menu
    elsif sel == 13
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

