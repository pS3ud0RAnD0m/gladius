#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.0.1

class Tool
  attr_accessor :title
  
  def initialize(title)
    @title = title
  end
  
  def header
    puts "------------------------------"
    puts @title
    puts "------------------------------"
  end
  
  def get_port
    puts "Input target port number: [443]".light_yellow
    port = gets.to_i
    a = port + 1
    puts a
    puts port 
    if port.nil? || port == 443
      puts "you selected 443"
    else
      puts "you selected #{port}"
    end
  end
  
  def instruct_input1
    puts "Input target(s), one per line.".light_yellow
    puts "When done, ensure the last line is blank and hit <CTRL> + <d>.".light_yellow
  end

  # Supply examples for tool input.
  # Call this with: example("fqdn", "ip", "ipr", "iprl", "iprf", "cidr")
  # Use any combination of the following
    # fqdn => www.victima.com
    # ip => 224.87.9.54
    # ipr = ipRange => 192.168.250.0-255
    # iprl = ipRangeLong => 192.168.10.15-192.168.10.20
    # iprf = ipRangeFlexible => 192.168.15-250.0-255
    # cidr => 10.87.9.0/24
  def example(*args)
    if args.count == 1
      puts "Example:".yellow
    else
      puts "Examples:".yellow
    end
    args.each do |a|
      if a == "fqdn"
        puts "www.victima.com".yellow
      end
      if a == "ip"
        puts "224.87.9.54".yellow
      end
      if a == "ipr"
        puts "192.168.250.0-255".yellow
      end
      if a == "iprl"
        puts "192.168.10.15-192.168.10.20".yellow
      end
      if a == "iprf"
        puts "192.168.15-250.0-255".yellow
      end
      if a == "cidr"
        puts "10.87.9.0/24".yellow
      end
    end
    puts
  end
end
