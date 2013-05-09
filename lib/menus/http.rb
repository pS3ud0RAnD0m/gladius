#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.1

require 'colorize'
require_relative 'menu'
require_relative 'gatherinfo'
require_relative '../tools/httprint'
require_relative '../tools/sslscan'
require_relative '../tools/nikto'
require_relative '../tools/gladius'
require_relative '../tools/apache2_1'

class HTTP < Menu
  def menu
    header
    puts "Select an option:".light_yellow
    puts "1.  Fingerprint web servers (httprint)"
    puts "2.  Identify supported SSL/TLS protcols and ciphers (SSLScan)"
    puts "3.  Identify supported HTTP methods (Gladius) (NI)"
    puts "4.  Identify common vulns (Nikto)"
    puts "5.  ... (NI)"
    puts "6.  ... (NI)"
    puts "7.  ... (NI)"
    puts "8.  ... (NI)"
    puts "9.  Apache - Enum users (Apache2.1)"
    puts "88. Back"
    puts "99. Exit Gladius"

    sel = gets.to_i
    puts
    if sel == 1
      Httprint.new("httprint - Fingerprint Web Servers").fingerprint
    elsif sel == 2
      SSLScan.new("SSLScan - Identify Protcols and Ciphers").scan
    elsif sel == 3
      puts "Not implemented yet.".red
      menu
    elsif sel == 4
      Nikto.new("Nikto - Identify Common Vulns").common
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
      Apache2_1.new("Apache2.1 - Enum Users").fingerprint
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
