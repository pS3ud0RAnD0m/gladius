#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

require_relative '../helpers/colorize'
require_relative '../helpers/sysinfo'
require_relative 'tool'
require_relative 'gpty'

class Atftpd < Tool
  def initialize(title)
    @title = title
    @@path = "dsniff"
  end

  def header_atftpd
    header
  end

  # Setup a TFTP server
  def setup
    header_atftpd
    puts

    # ID if IPtables is configed to drop anything
    #puts "Checking IPtables' status."light_yellow
    a = `iptables -L INPUT -nv |grep DROP`.chomp
    unless a.empty?
      puts "IPtables' INPUT chain is dropping.".yellow
      b = `/sbin/iptables -C INPUT -p udp --dport 69 -j ACCEPT`
      unless b.empty?
        puts "b is not empty"
        # ...
      else
        puts "Inbound TFTP rule detected. The firewall looks good."
      end
    else
      puts "IPtables is not dropping. Consider configuring IPtables soon.".yellow
      #atftpd --daemon --port 69 --bind-address 10.0.12.103 --logfile /var/log/atftpd.log /tmp/tftp
    end
    puts
    KaliServices.new("Configure Kali Services").menu
  end
end  
