#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

require_relative '../helpers/colorize'
require_relative '../helpers/sysinfo'
require_relative 'tool'
require_relative 'gpty'

class DiG < Tool
  def initialize(title)
    @title = title
    @@path = "/usr/bin/dig"
    @@hosts = []
  end
  
  # Identify Domain Controllers, i.e., servers running kerb.
  def idcontrollers
    header
    # Get dns server
    dns_server = `nslookup server |grep Server |awk '{print $2}'`.chomp
    puts "Gladius identified the following DNS server for Kerberos enumeration: " + dns_server
    puts "Hit 'Enter' to continue or input another DNS server IP:".light_yellow
    dns_server_diff = gets.chomp

    # Get domain
    domain = `cat /etc/resolv.conf |grep domain |awk '{print $2}'`.chomp
    unless domain.empty?
      puts "Gladius identified the following domain for Kerberos enumeration: " + domain
      puts "Hit 'Enter' to continue or input another domain:".light_yellow
      domain_diff = gets.chomp
    else
      puts "Gladius was not able to identify your current domain. Input target domain:".light_yellow
      domain_diff = gets.chomp
    end
    
    # Identify kerb services via dig against DNS server
    unless dns_server_diff.empty?
      unless domain_diff.empty?
        i = Gpty.new
        i.cmd = @@path + " @" + dns_server_diff + " SRV _kerberos._tcp." + domain_diff
        i.shell
      else
        i = Gpty.new
        i.cmd = @@path + " @" + dns_server_diff + " SRV _kerberos._tcp." + domain
        i.shell
      end
    else
      unless domain_diff.empty?
        i = Gpty.new
        i.cmd = @@path + " @" + dns_server + " SRV _kerberos._tcp." + domain_diff
        i.shell
      else
        i = Gpty.new
        i.cmd = @@path + " @" + dns_server + " SRV _kerberos._tcp." + domain
        i.shell
      end
    end
    puts
    DNS.new("DNS").menu
  end
end
