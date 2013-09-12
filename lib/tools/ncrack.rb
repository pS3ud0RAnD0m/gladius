#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

require 'time'
require_relative '../helpers/colorize'
require_relative 'tool'
require_relative 'gpty'
require_relative '../menus/dictionary'

class Ncrack < Tool
  def initialize(title)
    @title = title
    @@path = "ncrack"
    @@hosts = "/usr/share/gladius/input/hosts.txt"
    @@sshulist = "/usr/share/gladius/input/ncrack_ssh_users.txt"
    @@sshplist = "/usr/share/gladius/input/ncrack_ssh_passwords.txt"
    @@time = Time.now
    @@t = @@time.year.to_s + "-" + @@time.mon.to_s + "-" + @@time.day.to_s + "_" + @@time.hour.to_s + ":" + @@time.min.to_s + ":" + @@time.sec.to_s
    @@out_file = "/usr/share/gladius/output/ncrack_" + @@t + ".txt"
  end

  # Brute force ssh
  def ssh
    header_ncrack
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
      i.cmd = @@path + " -H " + @@hosts + " -U " + @@sshulist + " -P " + @@sshplist + " -M ssh -n 7750 -e ns -O " + @@out_file
      i.shell
      puts
    end
    BruteForce.new("Brute Force Authentication").menu
    # Catch interrupt
    rescue Interrupt
      puts
      puts "Cracking stopped due to interrupt.".light_yellow
      puts
      BruteForce.new("Brute Force Authentication").menu
  end
end  
