#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.0.1

require 'colorize'
require_relative 'tool'
require_relative 'gpty'

class Nessus < Tool
  def initialize(title)
    @title = title
    @@path = "/opt/nessus/bin/nasl"
    @@target = []
  end

  # Discover anonymous FTP read/write logins:
  def ftp_anon
    header
    while line = gets
      @@target << line.chomp
    end
    if @@target.count == 0
      puts "No targets were input.".red
      puts
      menu
    elsif @@target.count == 1
      @@target.each do |target|
        puts "Discovering anonymous FTP logins against " + target + "..."
        puts
        if target.include?("/") || target.include?("-")
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
      FTP.new.menu
    else
      l = @@target.count
      puts "Discovering anonymous FTP logins against #{l} targets..."
        @@target.each do |target|
          puts
          if target.include?("/") || target.include?("-")
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
    end
  end
end  
