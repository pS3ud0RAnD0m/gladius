#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.0.1

require 'colorize'
require_relative 'menu'
require_relative 'gatherinfo'
require_relative '../tools/httprint'
require_relative '../tools/sslscan'
require_relative '../tools/gladius'

class HTTP < Menu
  def menu
    puts "Select an option:".light_yellow
    puts "1.  Fingerprint web servers (httprint)"
    puts "2.  Identify supported SSL/TLS protcols and ciphers (SSLScan)"
    puts "3.  Identify supported HTTP methods (Gladius) (NI)"
    puts "4.  ... (NI)"
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
      @title = "httprint - Fingerprint Web Servers"
      header
      puts "Note: This tool seems pretty flakey. It has problems resolving URLs and seems hit or miss for IPs.".light_yellow
      instruct_input1
      example_input4
      Httprint.new.fingerprint
    elsif sel == 2
      @title = "SSLScan - Identify Protcols and Ciphers"
      header
      instruct_input1
      example_input5
      SSLScan.new.scan
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
      @title = "Apache2.1 - Enum Users"
      header
      instruct_input1
      example_input5
      Apache2_1.new.scan
    elsif sel == 88
      @title = "Information Gathering"
      header
      GatherInfo.new.menu
    elsif sel == 99
      begin
      puts "Exiting Gladius. Have a bloody day!".red
      rescue Interrupt
      end
    else
      puts "Invalid selection.".red
      @title = "HTTP(S)"
      header
      menu
    end
  end
end
