#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.2

require_relative '../helpers/colorize'
require_relative 'menu'
require_relative '../tools/iptables'
require_relative 'configsnort'

class KaliServices < Menu
  def menu
    header
    puts "Select a task:".light_yellow
    puts "1.  Monitor LAN traffic (Snort/Snorby) (NI)"
    puts "2.  Setup a TFTP server (atftpd) (NI)"
    puts "3.  Setup an FTP server (NI)"
    puts "4.  Setup an HTTP(S) server (NI)"
    puts "5.  Configure firewall rules (IPtables)"
    puts "6.  List current firewall rules (IPtables)"
    puts "88. Back"
    puts "99. Exit Gladius"

    sel = gets.to_i
    puts
    if sel == 1
      #ConfigSnort.new("Snort/Snorby - Configuration").menu
      puts "Not implemented yet.".red
      menu
    elsif sel == 2
      puts "Not implemented yet.".red
      menu
    elsif sel == 3
      puts "Not implemented yet.".red
      menu
    elsif sel == 4
      puts "Not implemented yet.".red
      menu
    elsif sel == 5
      IPtables.new("Configure IPtables Rules").status
    elsif sel == 6
      IPtables.new("List IPtables Rules").list
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


