#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.0.1

require 'colorize'
require_relative 'menu'
require_relative 'dns'
require_relative 'ftp'

class LAN < Menu
  def menu
    puts "Select a task:".light_yellow
    puts "1.  MiTM ARP poisoning (Ettercap)"
    puts "2.  ..."
    puts "3.  ..."
    puts "88. Back"
    puts "99. Exit Gladius"

    sel = gets.to_i
    puts
    if sel == 1
      @title = "MiTM ARP Poisoning."
      header
      DNS.new.menu
    elsif sel == 2
      puts "Not implemented yet.".red
      menu
    elsif sel == 3
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
      menu
    end
  end
end

