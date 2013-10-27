#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

class GetSysInfo
  def initialize
  end
  
  # Get the system's currrent DNS server(s)
  def dns_server
    # Get dns server
    dns_server = `nslookup server |grep Server |awk '{print $2}'`.chomp
    puts dns_server
  end

  # Get the system's currrent ip address(es)
  def ip
    ip = `ifconfig |grep Bcast |awk '{print $2}' |awk -F ":" '{print $2}'`.chomp
    puts ip
  end

  # Get the system's currrent domain
  def domain
    domain = `cat /etc/resolv.conf |grep domain |awk '{print $2}'`.chomp
    puts domain
  end
end
