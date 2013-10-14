#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

class GNmap < Tool
  def initialize(title)
    @title = title
    @path = "nmap"
    @hosts = "/usr/share/gladius/input/stdn_hosts.txt"
    @name = "nmap"
  end

  def header_nmap
    header
    instruct_input_targets("fqdn", "ip", "ipr", "iprl", "iprf", "cidr")
  end

  def menu(scan_type)
    header_nmap
    a = File.open(@hosts, "w")
    while line = gets
      a << line
    end
    a.close
    hosts = @hosts
    line_count = `wc -l #{hosts} |awk '{print $1}'`.to_i
    if line_count == 0
      puts "No hosts were input.".red
      get_hosts
    else
      case scan_type
        when "tcp_very_quick" then tcp_very_quick
        when "tcp_quick" then tcp_quick
        when "udp_quick" then udp_quick
        when "tcp_udp_quick" then tcp_udp_quick
        when "tcp_quick_scripts" then tcp_quick_scripts
        when "udp_quick_scripts" then udp_quick_scripts
        when "tcp_udp_quick_scripts" then tcp_udp_quick_scripts
        when "tcp_full" then tcp_full
        when "udp_full" then udp_full
        when "tcp_udp_full" then tcp_udp_full
        when "custom" then custom
      end
    end
# ttd: fix this interrupt
  rescue Interrupt
    resc
  end

  # Parse and display results
  def parse
    @out_xml_file = @out_file + ".xml"
    NmapParser.new(@out_xml_file).open_ports
    puts "Nmap output files are here:".light_yellow
    puts @out_file + ".gnmap"
    puts @out_file + ".nmap"
    puts @out_xml_file
    puts
    puts "Summary output has been parsed and put here:".light_yellow
    puts @out_xml_file + ".gladius"
  end

  def clean_exit
    if File.exists?(@pid_file)
      pid = File.read(@pid_file)
      `kill -9 #{pid}`
      File.delete(@pid_file)
    end
    puts
    DiscoverServices.new("Discover Services").menu
  rescue Interrupt
    puts
    puts "Exiting Gladius. Have a bloody day!".red
    begin
      Kernel.exit
    rescue Exception => e
    puts
    end
  end
  
  # Rescue interrupts
  def resc
    puts
    puts "Discovery stopped due to interrupt.".red
    clean_exit
  end

  # Scan top 25 tcp ports
  def tcp_very_quick
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T5 -Pn -sS --top-ports 25 --min-hostgroup 256 -iL " + @hosts + " -oA " + @out_file
    run(cmd)
  rescue Interrupt
    resc
  end
  
  # Scan top 1000 tcp ports
  def tcp_quick
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -sS -Pn --min-hostgroup 128 -iL " + @hosts + " -oA " + @out_file
    run(cmd)
  rescue Interrupt
    resc
  end
  
  # Scan top 1000 tcp ports with scripts
  def tcp_quick_scripts
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -sSV -Pn --script=all --min-hostgroup 128 -iL " + @hosts + " -oA " + @out_file
    run(cmd)
  rescue Interrupt
    resc
  end

  # Scan all tcp ports
  def tcp_full
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -sS -Pn --min-hostgroup 128 -p1-65535 -iL " + @hosts + " -oA " + @out_file
    run(cmd)
  rescue Interrupt
    resc
  end

  # Scan top 1000 udp ports
  def udp_quick
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -sU -Pn --min-hostgroup 128 -iL " + @hosts + " -oA " + @out_file
    run(cmd)
  rescue Interrupt
    resc
  end
  
  # Scan top 1000 udp ports with scripts
  def udp_quick_scripts
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -sUV -Pn --script=all --min-hostgroup 128 -iL " + @hosts + " -oA " + @out_file
    run(cmd)
  rescue Interrupt
    resc
  end

  # Scan all udp ports
  def udp_full
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -sU -Pn --min-hostgroup 128 -p1-65535 -iL " + @hosts + " -oA " + @out_file
    run(cmd)
  rescue Interrupt
    resc
  end
 
  # Scan top 1000 tcp/udp ports
  def tcp_udp_quick
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -sSU -Pn --min-hostgroup 128 -iL " + @hosts + " -oA " + @out_file
    run(cmd)
  rescue Interrupt
    resc
  end
  
  # Scan top 1000 tcp/udp ports with scripts
  def tcp_udp_quick_scripts
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -sSUV -Pn --script=all --min-hostgroup 128 -iL " + @hosts + " -oA " + @out_file
    run(cmd)
  rescue Interrupt
    resc
  end

  # Scan all tcp/udp ports
  def tcp_udp_full
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -sSU -Pn --min-hostgroup 128 -p1-65535 -iL " + @hosts + " -oA " + @out_file
    run(cmd)
  rescue Interrupt
    resc
  end
  
  # Custom scan
  def custom
    puts "Input your custom arguments and hit <Enter>:".light_yellow
    puts "Examples:".yellow
    puts "-v -sUV -Pn -p161".yellow
    puts "-v -A -T4 -sSV -Pn -p22".yellow
    puts
    args = gets.chomp
    @out_file = get_out_file(@name)
    cmd = @path + " #{args} -iL " + @hosts + " -oA " + @out_file
    run(cmd)
  rescue Interrupt
    resc
  end
end  
