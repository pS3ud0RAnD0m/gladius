#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

require_relative '../helpers/colorize'
require_relative 'menu'
require_relative '../tools/iptables'
require_relative '../tools/atftpd'

class KaliServices < Menu
  def menu
    header
    puts "Select a task:".light_yellow
    puts "1.  Server - Setup a TFTP server (atftpd)"
    puts "2.  Server - Setup an FTP server (NI)"
    puts "3.  Server - Setup an HTTP(S) server (NI)"
    puts "4.  Firewall - Configure (IPtables)"
    puts "5.  Firewall - List rules (IPtables)"
    puts "88. Back"
    puts "99. Exit Gladius"

    sel = gets.to_i
    puts
    if sel == 1
      Atftpd.new("Setup a TFTP server").setup
    elsif sel == 2
      puts "Not implemented yet.".red
      menu
    elsif sel == 3
      puts "Not implemented yet.".red
      menu
    elsif sel == 4
      IPtables.new("Configure IPtables Rules").status
    elsif sel == 5
      IPtables.new("List IPtables Rules").list
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


