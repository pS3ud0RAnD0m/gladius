#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

require_relative '../helpers/colorize'
require_relative 'tool'
require_relative 'gpty'

class MSF < Tool
  def initialize(title)
    @title = title
    @@path = "/usr/local/bin/msfcli"
    @@target = []
  end

  # Discover anonymous FTP read/write logins:
  def ftp_anon
    header
    instruct_input1
    example("fqdn", "ip", "iprf", "cidr")
    while line = gets
      @@target << line.chomp
    end
    if @@target.count == 0
      puts "No hosts were input.".red
      FTP.new("FTP").menu
    elsif @@target.count == 1
      @@target.each do |target|
        puts "Discovering anonymous FTP logins against " + target + " ..."
        puts
        if target.include?("/") || target.include?("-") || target =~ /[a-zA-Z]+/
          i = Gpty.new
          i.cmd = @@path + " auxiliary/scanner/ftp/anonymous RHOSTS=" + target + " E"
          i.shell
        else
          i = Gpty.new
          i.cmd = @@path + " auxiliary/scanner/ftp/anonymous RHOSTS=" + target + "/32 E"
          i.shell
        end
      end
      puts
      FTP.new("FTP").menu
      # Catch interrupt
      rescue Interrupt
        puts
        puts "Crack stopped due to interrupt.".light_yellow
        puts
        FTP.new("FTP").menu
    else
      l = @@target.count
      puts "Discovering anonymous FTP logins against #{l} targets ..."
        @@target.each do |target|
          puts
          if target.include?("/") || target.include?("-") || target =~ /[a-zA-Z]+/
            i = Gpty.new
            i.cmd = @@path + " auxiliary/scanner/ftp/anonymous RHOSTS=" + target + " E"
            i.shell
          else
            i = Gpty.new
            i.cmd = @@path + " auxiliary/scanner/ftp/anonymous RHOSTS=" + target + "/32 E"
            i.shell
          end
        end
      puts
      FTP.new("FTP").menu
      # Catch interrupt
      rescue Interrupt
        puts
        puts "Crack stopped due to interrupt.".light_yellow
        puts
        FTP.new("FTP").menu
    end
  end
end  
