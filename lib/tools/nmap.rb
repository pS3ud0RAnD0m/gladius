#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

require_relative 'tool'
require_relative 'gpty'
require_relative '../menus/dns'

class Nmap < Tool
  def initialize(title)
    @title = title
    # Path variables
    @@path = "nmap"
    @@hosts = "/usr/share/gladius/input/stdn_hosts.txt"
    # Variables for timestamping out files and child pid files
    @@time = Time.now
    @@out_file_tstamp = @@time.year.to_s + "-" + @@time.mon.to_s + "-" + @@time.day.to_s + \
                  "_" + @@time.hour.to_s + ":" + @@time.min.to_s + ":" + @@time.sec.to_s
    @@out_file = "/usr/share/gladius/output/nmap_" + @@out_file_tstamp
    @@pid_tstamp = "%10.10f" % @@time.to_f
    @@pid_file = "/usr/share/gladius/tmp/pids/" + @@pid_tstamp
  end

  def header_nmap
    header
    instruct_input_targets
    example("fqdn", "ip", "ipr", "iprl", "iprf", "cidr")
  end
  
  def clean_exit
    if File.exists?(@@pid_file)
      pid = File.read(@@pid_file)
      `kill -9 #{pid}`
      File.delete(@@pid_file)
    end
    puts
    DiscoverServices.new("Discover Services").menu
  rescue Interrupt
    puts
    puts "Exiting Gladius. Have a bloody day!".red
    begin
      Kernel.exit
    rescue Exception => e
    puts
    end
  end
  
  def resc
    puts
    puts "Discovery stopped due to interrupt.".red
    clean_exit
  end

  # Scan top 25 tcp ports
  def tcp_very_quick
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
      tcp_very_quick
    else
      puts
      x = Gpty.new
      x.time = @@pid_tstamp
      x.cmd = @@path + " -v -T5 -Pn -sS --top-ports 25 --min-hostgroup 256 -iL " + @@hosts + " -oA " + @@out_file
      x.shell
      clean_exit
    end
  rescue Interrupt
    resc
  end
  
  # Scan top 1000 tcp ports
  def tcp_quick
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
      tcp_quick
    else
      puts
      x = Gpty.new
      x.time = @@pid_tstamp
      x.cmd = @@path + " -v -T4 -sSV -Pn --min-hostgroup 256 -iL " + @@hosts + " -oA " + @@out_file
      x.shell
      clean_exit
    end
  rescue Interrupt
    resc
  end
  
  # Scan top 1000 tcp ports with scripts
  def tcp_quick_scripts
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
      tcp_quick_scripts
    else
      puts
      x = Gpty.new
      x.time = @@pid_tstamp
      x.cmd = @@path + " -v -T4 -sSV -Pn --script=all --min-hostgroup 256 -iL " + @@hosts + " -oA " + @@out_file
      x.shell
      clean_exit
    end
  rescue Interrupt
    resc
  end

  # Scan all tcp ports
  def tcp_full
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
      tcp_full
    else
      puts
      x = Gpty.new
      x.time = @@pid_tstamp
      x.cmd = @@path + " -v -T4 -sS -Pn --min-hostgroup 256 -p1-65535 -iL " + @@hosts + " -oA " + @@out_file
      x.shell
      clean_exit
    end
  rescue Interrupt
    resc
  end

  # Scan top 1000 udp ports
  def udp_quick
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
      udp_quick
    else
      puts
      x = Gpty.new
      x.time = @@pid_tstamp
      x.cmd = @@path + " -v -T4 -sU -Pn --min-hostgroup 256 -iL " + @@hosts + " -oA " + @@out_file
      x.shell
      clean_exit
    end
  rescue Interrupt
    resc
  end
  
  # Scan top 1000 udp ports with scripts
  def udp_quick_scripts
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
      udp_quick_scripts
    else
      puts
      x = Gpty.new
      x.time = @@pid_tstamp
      x.cmd = @@path + " -v -T4 -sUV -Pn --script=all --min-hostgroup 256 -iL " + @@hosts + " -oA " + @@out_file
      x.shell
      clean_exit
    end
  rescue Interrupt
    resc
  end

  # Scan all udp ports
  def udp_full
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
      udp_full
    else
      puts
      x = Gpty.new
      x.time = @@pid_tstamp
      x.cmd = @@path + " -v -T4 -sU -Pn --min-hostgroup 256 -p1-65535 -iL " + @@hosts + " -oA " + @@out_file
      x.shell
      clean_exit
    end
  rescue Interrupt
    resc
  end
 
  # Scan top 1000 tcp/udp ports
  def tcp_udp_quick
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
      tcp_udp_quick
    else
      puts
      x = Gpty.new
      x.time = @@pid_tstamp
      x.cmd = @@path + " -v -T4 -sSUV -Pn --min-hostgroup 256 -iL " + @@hosts + " -oA " + @@out_file
      x.shell
      clean_exit
    end
  rescue Interrupt
    resc
  end
  
  # Scan top 1000 tcp/udp ports with scripts
  def tcp_udp_quick_scripts
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
      tcp_udp_quick_scripts
    else
      puts
      x = Gpty.new
      x.time = @@pid_tstamp
      x.cmd = @@path + " -v -T4 -sSUV -Pn --script=all --min-hostgroup 256 -iL " + @@hosts + " -oA " + @@out_file
      x.shell
      clean_exit
    end
  rescue Interrupt
    resc
  end

  # Scan all tcp/udp ports
  def tcp_udp_full
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
      tcp_udp_full
    else
      puts
      x = Gpty.new
      x.time = @@pid_tstamp
      x.cmd = @@path + " -v -T4 -sSU -Pn --min-hostgroup 256 -p1-65535 -iL " + @@hosts + " -oA " + @@out_file
      x.shell
      clean_exit
    end
  rescue Interrupt
    resc
  end
end  
