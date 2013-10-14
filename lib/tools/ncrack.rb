#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

require_relative 'tool'
require_relative 'gpty'
require_relative '../menus/dictionaryonline'

class Ncrack < Tool
  def initialize(title)
    @title = title
    @@path = "ncrack"
    @@hosts = "/usr/share/gladius/input/stdn_hosts.txt"
#    @@sshulist = "/usr/share/gladius/input/ncrack_ssh_users.txt"
#    @@sshplist = "/usr/share/gladius/input/ncrack_ssh_passwords.txt"
    @@time = Time.now
    @@t = @@time.year.to_s + "-" + @@time.mon.to_s + "-" + @@time.day.to_s + "_" + @@time.hour.to_s + ":" + @@time.min.to_s + ":" + @@time.sec.to_s
    @@out_file = "/usr/share/gladius/output/ncrack_" + @@t + ".txt"
  end

  def header_ncrack
    header
    puts
    instruct_input_targets("fqdn", "ip", "ipr", "iprl", "iprf", "cidr")
  end
  
  # Brute force ssh
#  def ssh
#    header_ncrack
#    a = File.open(@@hosts, "w")
#    while line = gets
#      a << line
#    end
#    a.close
#    hosts = @@hosts
#    line_count = `wc -l #{hosts} |awk '{print $1}'`.to_i
#    if line_count == 0
#      puts "No hosts were input.".red
#    else
#      puts
#      i = Gpty.new
#      i.cmd = @@path + " -vv -U " + @@sshulist + " -P " + @@sshplist + " -p ssh -iL " + @@hosts + " -oA " + @@out_file
#      i.shell
#      puts
#    end
#    DictionaryOnline.new("Online Dictionary Attacks").menu
#    # Catch interrupt
#    rescue Interrupt
#      puts
#      puts "Cracking stopped due to interrupt.".light_yellow
#      puts
#      DictionaryOnline.new("Online Dictionary Attacks").menu
#  end
end  
