#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.2

require_relative '../helpers/colorize'
require_relative 'menu'
require_relative 'gatherinfo'
require_relative '../tools/nmap'

class MultipleServices < Menu
  def menu
    header
    puts "Select a scanning option:".light_yellow
    puts "1.  TCP top 1000 ports (Nmap)"
    puts "2.  TCP top 1000 ports with scripts (Nmap)"
    puts "3.  TCP all ports (Nmap)"
    puts "4.  UDP top 1000 ports (Nmap)"
    puts "5.  UDP top 1000 ports with scripts (Nmap)"
    puts "6.  UDP all ports (Nmap)"
    puts "7.  TCP/UDP top 1000 ports (Nmap)"
    puts "8.  TCP/UDP top 1000 ports with scripts (Nmap)"
    puts "9.  TCP/UDP all ports (Nmap)"
    puts "88. Back"
    puts "99. Exit Gladius"

    sel = gets.to_i
    puts
    if sel == 1
      Nmap.new("Nmap - TCP top 1000 ports").tcpquick
    elsif sel == 2
      Nmap.new("Nmap - TCP top 1000 ports with scripts").tcpquickscripts
    elsif sel == 3
      Nmap.new("Nmap - TCP all ports").tcpfull
    elsif sel == 4
      Nmap.new("Nmap - UDP top 1000 ports").udpquick
    elsif sel == 5
      Nmap.new("Nmap - UDP top 1000 ports with scripts").udpquickscripts
    elsif sel == 6
      Nmap.new("Nmap - UDP all ports").udpfull
    elsif sel == 7
      Nmap.new("Nmap - TCP/UDP top 1000 ports").tcpudpquick
    elsif sel == 8
      Nmap.new("Nmap - TCP/UDP top 1000 ports with scripts").tcpudpquickscripts
    elsif sel == 9
      Nmap.new("Nmap - TCP/UDP all ports").tcpudpfull
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

