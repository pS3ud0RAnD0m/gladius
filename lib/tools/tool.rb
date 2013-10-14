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

  def get_out_file(tool)
    time = Time.now
    out_file = time.strftime("/usr/share/gladius/output/" + tool + "_%F_%T")
  end
  
  def get_out_file_txt(tool)
    time = Time.now
    out_file = time.strftime("/usr/share/gladius/output/" + tool + "_%F_%T.txt")
  end

  def get_pid_file
    time = Time.now
    pid_tstamp = "%10.10f" % time.to_f
    pid_file = time.strftime(usr_tp + pid_tstamp + ".pid")
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

  # Supply examples for tool input.
  # Call this with: example("cidr", "domain", "fqdn", "fqdnp", "ip", "ipp", "ipr", "iprl", "iprf", "url")
  # Use any combination of the following:
    # cidr => 10.87.9.0/24
    # domain => victima.com
    # fqdn => www.victima.com
    # fqdnp = fqdnPort => www.victima.com:443
    # ip => 224.87.9.54
    # ipp = ipPort => 224.87.9.54:8080
    # ipr = ipRange => 192.168.250.0-255
    # iprl = ipRangeLong => 192.168.10.15-192.168.10.20
    # iprf = ipRangeFlexible => 192.168.15-250.0-255
    # url => https://www.victima.com/
  def instruct_input_targets(*args)
    puts "Input target(s), one per line:".light_yellow
    puts "When done, ensure the last line is blank and press <Ctrl+d>.".yellow
    if args.count == 1
      puts "Example:".yellow
    else
      puts "Examples:".yellow
    end
    args.each do |a|
      if a == "cidr"
        puts "10.87.9.0/24".yellow
      end
      if a == "domain"
        puts "victima.com".yellow
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
  
  def instruct_input_usrs
    puts "Input user(s), one per line:".light_yellow
    puts "When done, ensure the last line is blank and press <Ctrl+d>.".yellow
  end
  
  def instruct_input_pswds
    puts "Input password(s), one per line:".light_yellow
    puts "When done, ensure the last line is blank and press <Ctrl+d>.".yellow
  end
  
  def run(cmd)
    puts
    @pid_file = get_pid_file
    x = Gpty.new
    x.pid_file = @pid_file
    x.cmd = cmd
    x.shell
    parse
    clean_exit
  end
end
