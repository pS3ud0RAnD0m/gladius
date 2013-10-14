#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

require_relative 'tool'
require_relative 'gpty'

class Onesixtyone < Tool
  def initialize(title)
    @title = title
    # Path variables
    @@path = "onesixtyone"
    @@path_dict = "/usr/share/gladius/input/onesixtyone_dict.txt"
    @@hosts = "/usr/share/gladius/input/stdn_hosts.txt"
    # Variables for timestamping out files and child pid files
    @@time = Time.now
    @@out_file_tstamp = @@time.year.to_s + "-" + @@time.mon.to_s + "-" + @@time.day.to_s + \
                  "_" + @@time.hour.to_s + ":" + @@time.min.to_s + ":" + @@time.sec.to_s
    @@out_file = "/usr/share/gladius/output/onesixtyone_" + @@out_file_tstamp + ".txt"
    @@pid_tstamp = "%10.10f" % @@time.to_f
    @@pid_file = "/usr/share/gladius/tmp/pids/" + @@pid_tstamp
  end

  def header_onesixtyone
    header
    instruct_input_targets("ip")
  end
  
    # Ensure that tool's pid is killed, set int rescue and exit.
  def clean_exit
    if File.exists?(@@pid_file)
      pid = File.read(@@pid_file)
      `kill -9 #{pid}`
      File.delete(@@pid_file)
    end
    puts
    SNMP.new("SNMP").menu
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
    puts "Dictionary attack stopped due to interrupt.".red
    clean_exit
  end
  
  # Parse and display results
  def results(search_term)
    puts
    out_file = @@out_file
    line_count = `wc -l #{out_file}`.to_i
    if line_count == 0
      puts "Onesixtyone did not find valid credentials.".light_yellow
    else
      puts "Onesixtyone found the following credentials:".light_yellow
      a = `cat #{out_file}`
      puts a
    end
    puts
    puts "Raw output can be found here:".yellow
    puts out_file
  end
  
  # Discover common community strings:
  def discover
    header_onesixtyone
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
      x = Gpty.new
      x.time = @@pid_tstamp
      x.cmd = @@path + " -c " + @@path_dict + " -i #{hosts} -d -o " + @@out_file
      x.shell
      results("public")
    end
    clean_exit
    rescue Interrupt
    resc
  end
end  
