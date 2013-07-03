#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.2

#require_relative '../helpers/colorize'
require_relative 'tool'
require_relative 'gpty'

class Nikto < Tool
  def initialize(title)
    @title = title
    @path_tool = "nikto"
    #@path_conf = "/pentest/web/nikto/nikto.conf"
    @hosts_ports = []
  end
  
  # Identify common vulns
  def common
    header
    instruct_input1
    example("fqdnp", "ipp")
    while line = gets
      @hosts_ports << line.chomp
    end
    if @hosts_ports.count == 0
      puts "No targets were input.".red
      HTTP.new("HTTP(s)").menu
    elsif @hosts_ports.count == 1
      @hosts_ports.each do |target|
        puts "Identifying common web vulns against " + target + " ..."
        puts
        a = Gpty.new
        a.cmd =  @path_tool + " -h " + target + " -C all"
        a.shell
      end
      puts
      HTTP.new("HTTP(s)").menu
    else
      a = @hosts_ports.count
      puts "Identifying common web vulns against #{a} targets ..."
        @hosts_ports.each do |target|
          puts
          b = Gpty.new
          b.cmd = @path_tool + " -h " + target + " -C all"
          b.shell
        end
      puts
      HTTP.new("HTTP(s)").menu
    end
  end
end
