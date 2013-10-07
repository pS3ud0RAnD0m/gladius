#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

require_relative '../helpers/colorize'
require_relative 'menu'
require_relative '../tools/nmap'

class DiscoverServices < Menu
  def menu
    header
    puts "Select a scanning option:".light_yellow
    puts "Insane Host Discovery:".yellow
    puts "1.  TCP top 25 ports"
    puts "Common Discovery:".yellow
    puts "2.  TCP top 1000 ports"
    puts "3.  UDP top 1000 ports"
    puts "4.  TCP/UDP top 1000 ports"
    puts "Detailed Discovery:".yellow
    puts "5.  TCP top 1000 ports with scripts"
    puts "6.  UDP top 1000 ports with scripts"
    puts "7.  TCP/UDP top 1000 ports with scripts"
    puts "Thorough Discovery:".yellow
    puts "8.  TCP all ports"
    puts "9.  UDP all ports"
    puts "10. TCP/UDP all ports"
    puts "Other:".yellow
    puts "88. Back"
    puts "99. Exit Gladius"

    sel = gets.to_i
    puts
    if sel == 1
      Nmap.new("Nmap - TCP top 25 ports").tcp_very_quick
    elsif sel == 2
      Nmap.new("Nmap - TCP top 1000 ports").tcp_quick
    elsif sel == 3
      Nmap.new("Nmap - UDP top 1000 ports").udp_quick
    elsif sel == 4
      Nmap.new("Nmap - TCP/UDP top 1000 ports").tcp_udp_quick
    elsif sel == 5
      Nmap.new("Nmap - TCP top 1000 ports with scripts").tcp_quick_scripts
    elsif sel == 6
      Nmap.new("Nmap - UDP top 1000 ports with scripts").udp_quick_scripts
    elsif sel == 7
      Nmap.new("Nmap - TCP/UDP top 1000 ports with scripts").tcp_udp_quick_scripts
    elsif sel == 8
      Nmap.new("Nmap - TCP all ports").tcp_full
    elsif sel == 9
      Nmap.new("Nmap - UDP all ports").udp_full
    elsif sel == 10
      Nmap.new("Nmap - TCP/UDP all ports").tcp_udp_full
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

