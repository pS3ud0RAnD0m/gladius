#!/usr/bin/env ruby

# Author: p$3ud0R@nD0m

require_relative 'menu'

class KaliServices < Menu
  def menu
    header
    puts "Select a task:".light_yellow
    puts "1.  Firewall - Configure (IPtables)"
    puts "2.  Firewall - List rules (IPtables)"
    puts "3.  Server - Setup a TFTP server (atftpd)"
    puts "4.  Server - Setup an FTP server (NI)"
    puts "5.  Server - Setup an HTTP(S) server (NI)"
    puts "88. Back"
    puts "99. Exit Gladius"

    sel = gets.to_i
    puts
    case sel
      when 1 then IPtables.new("KaliServices", "Configure IPtables Rules").menu("status")
      when 2 then IPtables.new("KaliServices", "List IPtables Rules").menu("list")
      when 3 then Atftpd.new("KaliServices", "Setup a TFTP server").menu("setup")
      when 4 then puts "Not implemented yet.".red
        menu
      when 5 then puts "Not implemented yet.".red
        menu 
      when 88 then Home.new.menu
      when 99 then
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


