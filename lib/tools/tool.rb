#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

require 'time'

class Tool
  attr_accessor :title
  
  def initialize(title)
    @title = title
    @host = host
    @hosts = []
    @port = port
    @ports = []
    @hosts_ports = []
    @iopath = "/usr/share/gladius/"
  end
  
  def header
    puts "------------------------------"
    puts @title
    puts "------------------------------"
  end

  def header_medusa
    header
    puts "The target exhaustion time is ~7 hours per host, assuming ~26 attempts per minute.".light_yellow
    puts "If the exhaustion time needs modified, edit the appropriate input files w/in the /usr/share/gladius/input directory.".light_yellow
    puts
    instruct_input
    example("fqdn", "ip")
  end
  
  def header_nikto
    header
    instruct_input
    example("fqdnp", "ipp", "url")
  end

  def header_nmap
    header
    instruct_input
    example("fqdn", "ip", "ipr", "iprl", "iprf", "cidr")
  end
  
  def get_host
    puts "Input target port number: [localhost:)]".light_yellow
    @host = gets.chomp
    if @host.empty?
      @host = "localhost"
    end
  end
  
  def get_port
    puts "Input target port number: [443]".light_yellow
    @port = gets.chomp
    if @port.empty?
      @port = "443"
    end
  end
  
  def get_hosts_ports
    while line = gets
      @hosts_ports << line.chomp
    end
  end

  def instruct_input
    puts "Input target(s), one per line.".light_yellow
    puts "When done, ensure the last line is blank and hit <CTRL> + <d>.".light_yellow
  end
  
  def instruct_input1
    puts "Input target(s), one per line.".light_yellow
    puts "When done, ensure the last line is blank and hit <CTRL> + <d>.".light_yellow
  end

  # Supply examples for tool input.
  # Call this with: example("cidr", "fqdn", "fqdnp", "ip", "ipp", "ipr", "iprl", "iprf", "url")
  # Use any combination of the following:
    # cidr => 10.87.9.0/24
    # fqdn => www.victima.com
    # fqdnp = fqdnPort => www.victima.com:443
    # ip => 224.87.9.54
    # ipp = ipPort => 224.87.9.54:8080
    # ipr = ipRange => 192.168.250.0-255
    # iprl = ipRangeLong => 192.168.10.15-192.168.10.20
    # iprf = ipRangeFlexible => 192.168.15-250.0-255
    # url => https://www.victima.com/
  def example(*args)
    if args.count == 1
      puts "Example:".yellow
    else
      puts "Examples:".yellow
    end
    args.each do |a|
      if a == "cidr"
        puts "10.87.9.0/24".yellow
      end
      if a == "fqdn"
        puts "www.victima.com".yellow
      end
      if a == "fqdnp"
        puts "www.victima.com:443".yellow
      end
      if a == "ip"
        puts "224.87.9.54".yellow
      end
      if a == "ipp"
        puts "224.87.9.54:8080".yellow
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
      if a == "url"
        puts "https://www.victima.com/".yellow
      end
    end
    puts
  end
end
