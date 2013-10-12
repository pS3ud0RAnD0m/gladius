#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

class SysInfo
  def initialize
  end

  # Get local IP address(es)
  def ip
    a = `ifconfig |grep "inet addr" |grep -v 127.0.0.1 |awk '{print $2}' |awk -F: '{print $2}'`.chomp
    puts a
  end
  
  # Get dns server(s)
  def dns
    a = `nslookup server |grep Server |awk '{print $2}'`.chomp
    puts a
  end
  
  # Get domain(s)
  def domain
    a = `cat /etc/resolv.conf |grep domain |awk '{print $2}'`.chomp
    puts a
  end
end

#SysInfo.new.ip
#SysInfo.new.dns
#SysInfo.new.domain
