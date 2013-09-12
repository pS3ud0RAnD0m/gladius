#!/usr/bin/env ruby

# Author:  P$3ud0R@nD0m
# Version: 0.0.2

require 'time'
require_relative 'tool'
require_relative 'gpty'

class Nikto < Tool
  def initialize(title)
    @title = title
    @path_tool = "nikto"
    @@hosts = "/usr/share/gladius/input/hosts.txt"
    @@time = Time.now
    @@t = @@time.year.to_s + "-" + @@time.mon.to_s + "-" + @@time.day.to_s + \
    "_" + @@time.hour.to_s + ":" + @@time.min.to_s + ":" + @@time.sec.to_s
    @@out_file = "/usr/share/gladius/output/nikto_" + @@t + ".html"
  end
  
  # Identify common vulns
  def common
    header_nikto
    a = File.open(@@hosts, "w")
    while line = gets
      a << line
    end
    a.close
    hosts = @@hosts
    line_count = `wc -l #{hosts} |awk '{print $1}'`.to_i
    if line_count == 0
      puts "No targets were input.".red
    else
      puts
      a = Gpty.new
      a.cmd =  @path_tool + " -C all -h " + @@hosts + " -output " + @@out_file
      a.shell
      puts
    end
    HTTP.new("HTTP(s)").menu
    # Catch interrupt
    rescue Interrupt
      puts
      puts "Scan stopped due to interrupt.".light_yellow
      puts
      HTTP.new("HTTP(s)").menu
  end
end
