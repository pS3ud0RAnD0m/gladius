#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

require_relative 'menu'
require_relative '../tools/gnmap'

class DiscoverServices < Menu
  def menu
    header
    puts "Select a scanning option:".light_yellow
    puts "Quick Discovery:".yellow
    puts "1.  TCP top 25 ports (LAN)"
    puts "2.  TCP top 25 ports (WAN)"
    puts "Common Discovery:".yellow
    puts "3.  TCP top 1000 ports"
    puts "4.  UDP top 1000 ports"
    puts "5.  TCP/UDP top 1000 ports"
    puts "Detailed Discovery:".yellow
    puts "6.  TCP top 1000 ports with scripts"
    puts "7.  UDP top 1000 ports with scripts"
    puts "8.  TCP/UDP top 1000 ports with scripts"
    puts "Thorough Discovery:".yellow
    puts "9.  TCP all ports"
    puts "10. UDP all ports"
    puts "11. TCP/UDP all ports"
    puts "Other:".yellow
    puts "12. Custom scan"
    puts "88. Back"
    puts "99. Exit Gladius"

    sel = gets.to_i
    puts
    if sel == 1
      GNmap.new("DiscoverServices", "Nmap - TCP top 25 ports - LAN").menu("tcp_very_quick_lan")
    elsif sel == 2
      GNmap.new("DiscoverServices", "Nmap - TCP top 25 ports - WAN").menu("tcp_very_quick_wan")
    elsif sel == 3
      GNmap.new("DiscoverServices", "Nmap - TCP top 1000 ports").menu("tcp_quick")
    elsif sel == 4
      GNmap.new("DiscoverServices", "Nmap - UDP top 1000 ports").menu("udp_quick")
    elsif sel == 5
      GNmap.new("DiscoverServices", "Nmap - TCP/UDP top 1000 ports").menu("tcp_udp_quick")
    elsif sel == 6
      GNmap.new("DiscoverServices", "Nmap - TCP top 1000 ports with scripts").menu("tcp_quick_scripts")
    elsif sel == 7
      GNmap.new("DiscoverServices", "Nmap - UDP top 1000 ports with scripts").menu("udp_quick_scripts")
    elsif sel == 8
      GNmap.new("DiscoverServices", "Nmap - TCP/UDP top 1000 ports with scripts").menu("tcp_udp_quick_scripts")
    elsif sel == 9
      GNmap.new("DiscoverServices", "Nmap - TCP all ports").menu("tcp_full")
    elsif sel == 10
      GNmap.new("DiscoverServices", "Nmap - UDP all ports").menu("udp_full")
    elsif sel == 11
      GNmap.new("DiscoverServices", "Nmap - TCP/UDP all ports").menu("tcp_udp_full")
    elsif sel == 12
      GNmap.new("DiscoverServices", "Nmap - Custom").menu("custom")
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

