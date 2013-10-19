#!/usr/bin/env ruby

# Author: p$3ud0R@nD0m

require_relative 'menu'

class HTTP < Menu
  def menu
    header
    puts "Select an option:".light_yellow
    puts "1.  ID supported SSL/TLS protcols and ciphers (SSLScan)"
    puts "2.  ID supported HTTP methods (Gladius) (NI)"
    puts "3.  ID common vulns (Nikto)"
    puts "4.  Apache - Enum users (Apache-users)"
    puts "88. Back"
    puts "99. Exit Gladius"

    sel = gets.to_i
    puts
    if sel == 1
      SSLScan.new("SSLScan - ID Protcols and Ciphers").scan
    elsif sel == 2
      puts "Not implemented yet.".red
      menu
    elsif sel == 3
      Nikto.new("HTTP", "Nikto - ID Common Web Vulns").menu("common")
    elsif sel == 4
      ApacheUsers.new("Apache-users - Enum Users").fingerprint
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
