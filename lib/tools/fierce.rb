#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

require_relative 'tool'
require_relative 'gpty'

class Fierce < Tool
  def initialize(title)
    @title = title
    # Path variables
    @@path_tool = "fierce"
    @@path_hosts = "/usr/share/gladius/input/fierce_hosts.txt"
    @@hosts = []
    # Variables for timestamping out files and child pid files
    @@time = Time.now
    @@out_file_tstamp = @@time.year.to_s + "-" + @@time.mon.to_s + "-" + @@time.day.to_s + \
                  "_" + @@time.hour.to_s + ":" + @@time.min.to_s + ":" + @@time.sec.to_s
    @@out_file = "/usr/share/gladius/output/fierce_" + @@out_file_tstamp + ".txt"
    @@pid_tstamp = "%10.10f" % @@time.to_f
    @@pid_file = "/usr/share/gladius/tmp/pids/" + @@pid_tstamp
  end
  
  # Ensure that tool's pid is killed, set int rescue and exit.
  def clean_exit
    if File.exists?(@@pid_file)
      pid = File.read(@@pid_file)
      `kill -9 #{pid}`
      File.delete(@@pid_file)
    end
    puts
    DNS.new("DNS").menu
  rescue Interrupt
    puts
    puts "Exiting Gladius. Have a bloody day!".red
    begin
      Kernel.exit
    rescue Exception => e
    puts
    end
  end
  
  # Rescue mid-attack 
  def resc
    puts
    puts "Brute force stopped due to interrupt.".red
    clean_exit
  end

  # Display result file
  def results
    out_file = @@out_file
    puts
    puts "Raw output can be found here:".yellow
    puts out_file
  end
  
  # Attempt a zone transfer and dictionary attack records
  def brute
    header
    instruct_input_targets("domain")
    while line = gets
      @@hosts << line.chomp
    end
    if @@hosts.count == 0
      puts "No hosts were input.".red
      DNS.new("DNS").menu
    elsif @@hosts.count == 1
      @@hosts.each do |host|
        puts
        puts "Attempting a zone transfer and brute force against " + host + " ..."
        puts
        x = Gpty.new
        x.time = @@pid_tstamp
        x.cmd = @@path_tool + " --threads 2 -wordlist " + @@path_hosts + " -dns " + host + " -file " + @@out_file
        x.shell
      end
      results
      clean_exit
    else
      l = @@hosts.count
      puts
      puts "Attempting zone transfers and brute force attacks against #{l} domains ..."
      @@hosts.each do |host|
        puts
        x = Gpty.new
        x.time = @@pid_tstamp
        x.cmd = @@path_tool + " --threads 2 -wordlist " + @@path_hosts + " -dns " + host + " -file " + @@out_file
        x.shell
      end
      results
      clean_exit
    end
    rescue Interrupt
      resc
  end
end
