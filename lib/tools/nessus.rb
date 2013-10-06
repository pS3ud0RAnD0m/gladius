#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

require_relative '../helpers/colorize'
require_relative 'tool'
require_relative 'gpty'

class Nessus < Tool
  def initialize(title)
    @title = title
    @@path = "/opt/nessus/bin/nasl"
    @@path_module = "/opt/nessus/lib/nessus/plugins/ftp_anonymous.nasl"
    @@target = []
  end

  # Discover anonymous FTP read/write logins:
  def ftp_anon
    header
    instruct_input_targets
    example("fqdn", "ip")
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
          i.cmd = @@path + " -a -t " + target + " " + @@path_module
          i.shell
        else
          i = Gpty.new
          i.cmd = @@path + " -a -t " + target + " " + @@path_module
          i.shell
        end
      end
      puts
      FTP.new("FTP").menu
    else
      l = @@target.count
      puts "Discovering anonymous FTP logins against #{l} targets..."
        @@target.each do |target|
          puts
          if target.include?("/") || target.include?("-")
            i = Gpty.new
            i.cmd = @@path + " -a -t " + target + " " + @@path_module
            i.shell
          else
            i = Gpty.new
            i.cmd = @@path + " -a -t " + target + " " + @@path_module
            i.shell
          end
        end
      puts
      FTP.new("FTP").menu
    end
    # Catch interrupt
    rescue Interrupt
      puts
      puts "Scan stopped due to interrupt.".light_yellow
      puts
      FTP.new("FTP").menu
  end
end  
