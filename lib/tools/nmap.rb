#!/usr/bin/env ruby

# Author:  P$3ud0R@nD0m
# Version: 0.0.2

require 'time'
require_relative '../helpers/colorize'
require_relative 'tool'
require_relative 'gpty'
require_relative '../menus/dns'

class Nmap < Tool
  def initialize(title)
    @title = title
    @@path = "nmap"
    @@hosts = "/usr/share/gladius/input/hosts.txt"
    @@time = Time.now
    @@t = @@time.year.to_s + "-" + @@time.mon.to_s + "-" + @@time.day.to_s + \
    "_" + @@time.hour.to_s + ":" + @@time.min.to_s + ":" + @@time.sec.to_s
    @@out_file = "/usr/share/gladius/output/nmap_" + @@t
  end

  # Scan top 1000 tcp ports:
  def tcpquick
    header_nmap
    a = File.open(@@hosts, "w")
    while line = gets
      a << line
    end
    a.close
    hosts = @@hosts
    line_count = `wc -l #{hosts} |awk '{print $1}'`.to_i
    if line_count == 0
      puts "No hosts were input.".red
    else
      puts
      i = Gpty.new
      i.cmd = @@path + " -v -A -T4 -sSV -Pn --min-hostgroup 256 -iL " + @@hosts + " -oA " + @@out_file
      i.shell
      puts
    end
    MultipleServices.new("Gather Information - Multiple Services").menu
    # Catch interrupt
    rescue Interrupt
      puts
      puts "Scan stopped due to interrupt.".light_yellow
      puts
      MultipleServices.new("Gather Information - Multiple Services").menu
  end
  
  # Scan top 1000 tcp ports with scripts:
  def tcpquickscripts
    header_nmap
    a = File.open(@@hosts, "w")
    while line = gets
      a << line
    end
    a.close
    hosts = @@hosts
    line_count = `wc -l #{hosts} |awk '{print $1}'`.to_i
    if line_count == 0
      puts "No hosts were input.".red
    else
      puts
      i = Gpty.new
      i.cmd = @@path + " -v -A -T4 -sSV -Pn --script=all --min-hostgroup 256 -iL " + @@hosts + " -oA " + @@out_file
      i.shell
      puts
    end
    MultipleServices.new("Gather Information - Multiple Services").menu
    # Catch interrupt
    rescue Interrupt
      puts
      puts "Scan stopped due to interrupt.".light_yellow
      puts
      MultipleServices.new("Gather Information - Multiple Services").menu
  end

  # Scan all tcp ports:
  def tcpfull
    header_nmap
    a = File.open(@@hosts, "w")
    while line = gets
      a << line
    end
    a.close
    hosts = @@hosts
    line_count = `wc -l #{hosts} |awk '{print $1}'`.to_i
    if line_count == 0
      puts "No hosts were input.".red
    else
      puts
      i = Gpty.new
      i.cmd = @@path + " -v -T4 -sS -Pn --min-hostgroup 256 -p1-65535 -iL " + @@hosts + " -oA " + @@out_file
      i.shell
      puts
    end
    MultipleServices.new("Gather Information - Multiple Services").menu
    # Catch interrupt
    rescue Interrupt
      puts
      puts "Scan stopped due to interrupt.".light_yellow
      puts
      MultipleServices.new("Gather Information - Multiple Services").menu
  end

  # Scan top 1000 udp ports:
  def udpquick
    header_nmap
    a = File.open(@@hosts, "w")
    while line = gets
      a << line
    end
    a.close
    hosts = @@hosts
    line_count = `wc -l #{hosts} |awk '{print $1}'`.to_i
    if line_count == 0
      puts "No hosts were input.".red
    else
      puts
      i = Gpty.new
      i.cmd = @@path + " -v -T4 -sU -Pn --min-hostgroup 256 -iL " + @@hosts + " -oA " + @@out_file
      i.shell
      puts
    end
    MultipleServices.new("Gather Information - Multiple Services").menu
    # Catch interrupt
    rescue Interrupt
      puts
      puts "Scan stopped due to interrupt.".light_yellow
      puts
      MultipleServices.new("Gather Information - Multiple Services").menu
  end
  
  # Scan top 1000 udp ports with scripts:
  def udpquickscripts
    header_nmap
    a = File.open(@@hosts, "w")
    while line = gets
      a << line
    end
    a.close
    hosts = @@hosts
    line_count = `wc -l #{hosts} |awk '{print $1}'`.to_i
    if line_count == 0
      puts "No hosts were input.".red
    else
      puts
      i = Gpty.new
      i.cmd = @@path + " -v -A -T4 -sUV -Pn --script=all --min-hostgroup 256 -iL " + @@hosts + " -oA " + @@out_file
      i.shell
      puts
    end
    MultipleServices.new("Gather Information - Multiple Services").menu
    # Catch interrupt
    rescue Interrupt
      puts
      puts "Scan stopped due to interrupt.".light_yellow
      puts
      MultipleServices.new("Gather Information - Multiple Services").menu
  end

  # Scan all udp ports:
  def udpfull
    header_nmap
    a = File.open(@@hosts, "w")
    while line = gets
      a << line
    end
    a.close
    hosts = @@hosts
    line_count = `wc -l #{hosts} |awk '{print $1}'`.to_i
    if line_count == 0
      puts "No hosts were input.".red
    else
      puts
      i = Gpty.new
      i.cmd = @@path + " -v -T4 -sU -Pn --min-hostgroup 256 -p1-65535 -iL " + @@hosts + " -oA " + @@out_file
      i.shell
      puts
    end
    MultipleServices.new("Gather Information - Multiple Services").menu
    # Catch interrupt
    rescue Interrupt
      puts
      puts "Scan stopped due to interrupt.".light_yellow
      puts
      MultipleServices.new("Gather Information - Multiple Services").menu
  end
 
  # Scan top 1000 tcp/udp ports:
  def tcpudpquick
    header_nmap
    a = File.open(@@hosts, "w")
    while line = gets
      a << line
    end
    a.close
    hosts = @@hosts
    line_count = `wc -l #{hosts} |awk '{print $1}'`.to_i
    if line_count == 0
      puts "No hosts were input.".red
    else
      puts
      i = Gpty.new
      i.cmd = @@path + " -v -A -T4 -sSUV -Pn --min-hostgroup 256 -iL " + @@hosts + " -oA " + @@out_file
      i.shell
      puts
    end
    MultipleServices.new("Gather Information - Multiple Services").menu
    # Catch interrupt
    rescue Interrupt
      puts
      puts "Scan stopped due to interrupt.".light_yellow
      puts
      MultipleServices.new("Gather Information - Multiple Services").menu
  end
  
  # Scan top 1000 tcp/udp ports with scripts:
  def tcpudpquickscripts
    header_nmap
    a = File.open(@@hosts, "w")
    while line = gets
      a << line
    end
    a.close
    hosts = @@hosts
    line_count = `wc -l #{hosts} |awk '{print $1}'`.to_i
    if line_count == 0
      puts "No hosts were input.".red
    else
      puts
      i = Gpty.new
      i.cmd = @@path + " -v -A -T4 -sSUV -Pn --script=all --min-hostgroup 256 -iL " + @@hosts + " -oA " + @@out_file
      i.shell
      puts
    end
    MultipleServices.new("Gather Information - Multiple Services").menu
    # Catch interrupt
    rescue Interrupt
      puts
      puts "Scan stopped due to interrupt.".light_yellow
      puts
      MultipleServices.new("Gather Information - Multiple Services").menu
  end

  # Scan all tcp/udp ports:
  def tcpudpfull
    header_nmap
    a = File.open(@@hosts, "w")
    while line = gets
      a << line
    end
    a.close
    hosts = @@hosts
    line_count = `wc -l #{hosts} |awk '{print $1}'`.to_i
    if line_count == 0
      puts "No hosts were input.".red
    else
      puts
      i = Gpty.new
      i.cmd = @@path + " -v -T4 -sSU -Pn --min-hostgroup 256 -p1-65535 -iL " + @@hosts + " -oA " + @@out_file
      i.shell
      puts
    end
    MultipleServices.new("Gather Information - Multiple Services").menu
    # Catch interrupt
    rescue Interrupt
      puts
      puts "Scan stopped due to interrupt.".light_yellow
      puts
      MultipleServices.new("Gather Information - Multiple Services").menu
  end
end  
